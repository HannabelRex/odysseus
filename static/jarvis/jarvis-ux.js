/* ============================================================
   Jarvis Universal UX Enhancer
   Phase 02 - safe client-side branding and universal mode cue
   ============================================================ */
(function () {
  const STATUS_STORAGE_KEY = 'jarvisUniversalStatusHidden';

  function onReady(callback) {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', callback, { once: true });
    } else {
      callback();
    }
  }

  function replaceExactTextNodes(root) {
    if (!root || !document.body) return;

    const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
      acceptNode(node) {
        const text = (node.nodeValue || '').trim();
        if (text === 'Odysseus' || text === 'Odysseus Chat') {
          return NodeFilter.FILTER_ACCEPT;
        }
        return NodeFilter.FILTER_REJECT;
      },
    });

    const nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);

    nodes.forEach((node) => {
      const text = (node.nodeValue || '').trim();
      if (text === 'Odysseus') node.nodeValue = node.nodeValue.replace('Odysseus', 'Jarvis');
      if (text === 'Odysseus Chat') node.nodeValue = node.nodeValue.replace('Odysseus Chat', 'Jarvis Workspace');
    });
  }

  function addStatusPanel() {
    if (document.getElementById('jarvis-universal-status')) return;

    if (localStorage.getItem(STATUS_STORAGE_KEY) === '1') {
      document.body.classList.add('jarvis-status-hidden');
    }

    const panel = document.createElement('aside');
    panel.id = 'jarvis-universal-status';
    panel.setAttribute('aria-label', 'Jarvis universal mode status');
    panel.innerHTML = `
      <button class="jarvis-status-close" type="button" aria-label="Hide Jarvis status">×</button>
      <div class="jarvis-status-title"><span class="jarvis-status-dot"></span><span>Jarvis Universal Mode</span></div>
      <div class="jarvis-status-subtitle">General assistant first. Specialist modes only when needed.</div>
      <div class="jarvis-scope-row" aria-label="Jarvis scope">
        <span class="jarvis-scope-chip">Chat</span>
        <span class="jarvis-scope-chip">Research</span>
        <span class="jarvis-scope-chip">Code</span>
        <span class="jarvis-scope-chip">Files</span>
        <span class="jarvis-scope-chip">Tasks</span>
        <span class="jarvis-scope-chip">Email</span>
        <span class="jarvis-scope-chip">Calendar</span>
        <span class="jarvis-scope-chip">Automation</span>
      </div>
    `;

    panel.querySelector('.jarvis-status-close')?.addEventListener('click', () => {
      localStorage.setItem(STATUS_STORAGE_KEY, '1');
      document.body.classList.add('jarvis-status-hidden');
    });

    document.body.appendChild(panel);
  }

  function applyJarvisShell() {
    document.body.classList.add('jarvis-universal-ui');
    document.documentElement.classList.add('jarvis-universal-root');
    document.title = 'Jarvis Workspace';
    replaceExactTextNodes(document.body);
    addStatusPanel();
  }

  onReady(() => {
    applyJarvisShell();

    const observer = new MutationObserver((mutations) => {
      for (const mutation of mutations) {
        mutation.addedNodes.forEach((node) => {
          if (node.nodeType === Node.ELEMENT_NODE) replaceExactTextNodes(node);
          if (node.nodeType === Node.TEXT_NODE && (node.nodeValue || '').includes('Odysseus')) {
            replaceExactTextNodes(node.parentNode || document.body);
          }
        });
      }
    });

    observer.observe(document.body, { childList: true, subtree: true });
  });
})();
