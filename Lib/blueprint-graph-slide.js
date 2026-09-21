(function () {
  "use strict";

  var DEFAULT_BLUEPRINT_BASE = "blueprint/";

  function absoluteUrl(raw, base) {
    return new URL(raw, base || document.baseURI).href;
  }

  function readBool(value) {
    if (value === null || typeof value === "undefined") return null;
    return /^(1|true|yes|on)$/i.test(String(value));
  }

  function shouldRebaseUrl(value) {
    if (typeof value !== "string" || !value.trim()) return false;
    var lower = value.trim().toLowerCase();
    return !(
      lower.startsWith("#") ||
      lower.startsWith("javascript:") ||
      lower.startsWith("mailto:") ||
      lower.startsWith("tel:") ||
      lower.startsWith("data:")
    );
  }

  function rebaseUrl(value, baseUrl) {
    if (!shouldRebaseUrl(value)) return value;
    try {
      return new URL(value, baseUrl).href;
    } catch (_) {
      return value;
    }
  }

  function escapeDotString(value) {
    return String(value).replace(/\\/g, "\\\\").replace(/"/g, "\\\"");
  }

  function rebaseDot(dot, baseUrl) {
    if (typeof dot !== "string" || !dot) return dot;
    return dot.replace(/((?:URL|href)\s*=\s*")([^"]*)(")/gi, function (_, before, raw, after) {
      return before + escapeDotString(rebaseUrl(raw, baseUrl)) + after;
    });
  }

  function rebaseGraphData(graph, baseUrl) {
    var copy = JSON.parse(JSON.stringify(graph));
    function visit(value) {
      if (Array.isArray(value)) {
        value.forEach(visit);
      } else if (value && typeof value === "object") {
        Object.keys(value).forEach(function (key) {
          if (key === "href" && typeof value[key] === "string") {
            value[key] = rebaseUrl(value[key], baseUrl);
          } else {
            visit(value[key]);
          }
        });
      }
    }
    visit(copy);
    if (Array.isArray(copy.variants)) {
      copy.variants.forEach(function (variant) {
        if (variant && typeof variant === "object" && typeof variant.dot === "string") {
          variant.dot = rebaseDot(variant.dot, baseUrl);
        }
      });
    }
    return copy;
  }

  function graphHostIsCurrent(host) {
    var section = host.closest(".reveal section");
    if (!section || !window.Reveal) return true;
    return section.classList.contains("present");
  }

  function graphHostOptions(host) {
    var blueprintBase = absoluteUrl(host.dataset.bpBlueprintBase || DEFAULT_BLUEPRINT_BASE);
    return {
      blueprintBase: blueprintBase,
      dataBaseUrl: absoluteUrl("-verso-data/", blueprintBase),
      previewApiUrl: host.dataset.bpPreviewApi
        ? absoluteUrl(host.dataset.bpPreviewApi)
        : absoluteUrl("-verso-data/api/preview.mjs", blueprintBase),
      key: (host.dataset.bpGraphKey || "").trim(),
      view: (host.dataset.bpGraphView || "").trim(),
      direction: (host.dataset.bpGraphDirection || "").trim(),
      pack: readBool(host.dataset.bpGraphPack),
      layout: (host.dataset.bpGraphLayout || "fill").trim() || "fill"
    };
  }

  function selectGraph(graphs, key) {
    if (!Array.isArray(graphs) || graphs.length === 0) return null;
    if (!key) return graphs[0];
    return graphs.find(function (graph) {
      return graph && (graph.key === key || graph.label === key || graph.title === key);
    }) || null;
  }

  function applyControllerOptions(controller, options) {
    if (!controller) return;
    if (options.view && typeof controller.setView === "function") controller.setView(options.view);
    if (options.direction && typeof controller.setDirection === "function") {
      controller.setDirection(options.direction);
    }
    if (options.pack !== null && typeof controller.setPack === "function") {
      controller.setPack(options.pack);
    }
    if (typeof controller.layout === "function") controller.layout({ layout: options.layout });
  }

  async function renderGraphHost(host) {
    if (host.__vbpGraphRenderPromise) return host.__vbpGraphRenderPromise;
    var options = graphHostOptions(host);
    host.dataset.bpGraphStatus = "loading";
    host.__vbpGraphRenderPromise = import(options.previewApiUrl)
      .then(async function (previewModule) {
        if (!previewModule || typeof previewModule.createPreview !== "function") {
          throw new Error("Blueprint preview API is unavailable");
        }
        var api = previewModule.createPreview({
          dataBaseUrl: options.dataBaseUrl,
          canonicalBaseUrl: options.blueprintBase
        });
        var graphModule = await import(api.graphApiModuleUrl());
        if (!graphModule || typeof graphModule.loadGraphs !== "function" ||
            typeof graphModule.renderGraphData !== "function") {
          throw new Error("Blueprint graph data renderer is unavailable");
        }
        var graph = selectGraph(await graphModule.loadGraphs(), options.key);
        if (!graph) throw new Error("Blueprint graph data is unavailable");
        var graphData = rebaseGraphData(graph, options.blueprintBase);
        var graphOptions = {};
        if (options.direction) graphOptions.direction = options.direction;
        if (options.pack !== null) graphOptions.pack = options.pack;
        var controller = await graphModule.renderGraphData(host, graphData, {
          previewUtils: api,
          layout: options.layout,
          graphOptions: graphOptions,
          refresh: false
        });
        host.__vbpGraphController = controller;
        host.dataset.bpGraphStatus = "ready";
        applyControllerOptions(controller, options);
        return controller;
      })
      .catch(function (err) {
        host.dataset.bpGraphStatus = "error";
        host.textContent = "Unable to load Blueprint graph.";
        if (window.console && typeof window.console.error === "function") {
          window.console.error(err);
        }
        throw err;
      });
    return host.__vbpGraphRenderPromise;
  }

  function renderCurrentGraphs() {
    document.querySelectorAll("[data-bp-slide-graph]").forEach(function (host) {
      if (!graphHostIsCurrent(host)) return;
      if (host.__vbpGraphController) {
        applyControllerOptions(host.__vbpGraphController, graphHostOptions(host));
      } else {
        renderGraphHost(host).catch(function () {});
      }
    });
  }

  function bindReveal() {
    if (!window.Reveal || typeof window.Reveal.on !== "function") return;
    window.Reveal.on("ready", renderCurrentGraphs);
    window.Reveal.on("slidechanged", renderCurrentGraphs);
    window.Reveal.on("resize", renderCurrentGraphs);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", function () {
      bindReveal();
      renderCurrentGraphs();
      window.setTimeout(renderCurrentGraphs, 500);
    });
  } else {
    bindReveal();
    renderCurrentGraphs();
    window.setTimeout(renderCurrentGraphs, 500);
  }
})();
