import { createPreview } from "./-verso-data/api/preview.mjs";
// Use the same generated-page behaviors as the canonical Blueprint site:
// relation panels and nested declaration/source previews need these hydrators.
import "./-verso-data/blueprint-page-runtime.mjs";

if (new URLSearchParams(location.search).get("slide") === "1") {
  document.body.classList.add("slide-mode");
}

const api = createPreview({
  dataBaseUrl: new URL("./-verso-data/", location.href).href,
  canonicalBaseUrl: new URL("./", location.href).href
});

try {
  for (const facet of ["statement", "proof"]) {
    const result = await api.renderNode(document.getElementById(facet), {
      label: "left_inverse_injective", facet
    });
    if (!result.ok) throw new Error(result.reason);
  }
  document.body.dataset.demoReady = "true";
} catch (error) {
  document.getElementById("failure").textContent = "Could not load the demo: " + error.message;
  console.error(error);
}
