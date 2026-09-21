# Ideas for future talks

1. **Animate `autoDeps`.** Start with a small theorem and show the dependency
   graph changing as its Lean statement and proof change. Generate each state
   from the actual Blueprint data so the animation reflects extracted edges.
2. **Show how Verso is extended.** Walk through a small role or directive, its
   Lean elaboration and traversal, and the corresponding HTML renderer. Connect
   that mechanism to a Blueprint node rather than showing only the final page.
3. **Support multiple preview manifests in a slide deck.** The current generator
   uses the FLT manifest for native Blueprint nodes, while the small teaching
   example is embedded as a separate page. Multiple manifest/cache inputs would
   let both examples use the native slide renderer. Define how labels, URLs,
   assets, and preview runtimes are scoped when manifests coexist.
