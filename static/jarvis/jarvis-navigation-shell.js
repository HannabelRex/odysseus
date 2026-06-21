/* ============================================================
   Jarvis Phase 05D - Sidebar and Top Command Bar Redesign
   Safe DOM enhancement layer.
   ============================================================ */
(function () {
  'use strict';

  const PHASE_CLASS = 'jarvis-nav-shell-v1';
  const READY_CLASS = 'jarvis-nav-ready';
  const CREST_ID = 'jarvis-sidebar-crest';
  const BAR_ID = 'jarvis-command-bar';

  const likelySidebarSelectors = [
    'aside',
    '#sidebar',
    '#side-bar',
    '.sidebar',
    '.side-bar',
    '[class*="sidebar"]',
    '[id*="sidebar"]',
    'nav'
  ];

  function textOf(node) {
    return (node && node.textContent ? node.textContent : '').replace(/\s+/g, ' ').trim();
  }

  function findSidebar() {
    const candidates = [];
    likelySidebarSelectors.forEach((selector) => {
      document.querySelectorAll(selector).forEach((node) => {
        if (!candidates.includes(node)) candidates.push(node);
      });
    });

    const scored = candidates
      .map((node) => {
        const text = textOf(node).toLowerCase();
        let score = 0;
        ['new chat', 'search', 'chats', 'email', 'tools', 'brain', 'calendar', 'tasks', 'theme', 'settings'].forEach((word) => {
          if (text.includes(word)) score += 1;
        });
        const rect = node.getBoundingClientRect();
        if (rect.width > 120 && rect.width < 420 && rect.height > window.innerHeight * 0.45) score += 2;
        if (rect.left < 80) score += 2;
        return { node, score };
      })
      .sort((a, b) => b.score - a.score);

    return scored.length && scored[0].score >= 3 ? scored[0].node : null;
  }

  function ensureSidebarCrest(sidebar) {
    if (!sidebar || document.getElementById(CREST_ID)) return;

    const crest = document.createElement('section');
    crest.id = CREST_ID;
    crest.setAttribute('aria-label', 'Jarvis command center status');
    crest.innerHTML = [
      '<div class="jarvis-crest-kicker">Universal AI Workspace</div>',
      '<div class="jarvis-crest-title">Jarvis Command Center</div>',
      '<div class="jarvis-crest-subtitle">Chat, research, code, files, tasks, calendar, email, and automation.</div>'
    ].join('');

    const insertTarget = sidebar.firstElementChild || sidebar;
    if (insertTarget && insertTarget !== sidebar && insertTarget.children.length) {
      insertTarget.insertBefore(crest, insertTarget.firstElementChild);
    } else {
      sidebar.insertBefore(crest, sidebar.firstChild);
    }
  }

  function detectModelHint() {
    const bodyText = textOf(document.body);
    const modelPatterns = [
      /llama\d(?:\.\d+)?(?::[\w.-]+)?/i,
      /qwen[\w.-]*(?::[\w.-]+)?/i,
      /mistral(?::[\w.-]+)?/i,
      /nomic-embed-text(?::[\w.-]+)?/i
    ];

    for (const pattern of modelPatterns) {
      const match = bodyText.match(pattern);
      if (match && match[0]) return match[0];
    }

    return 'Local model ready';
  }

  function ensureCommandBar() {
    if (document.getElementById(BAR_ID)) return;

    const bar = document.createElement('section');
    bar.id = BAR_ID;
    bar.setAttribute('aria-label', 'Jarvis command status bar');
    bar.innerHTML = [
      '<div class="jarvis-command-left">',
      '  <span class="jarvis-orb" aria-hidden="true"></span>',
      '  <div class="jarvis-command-title">',
      '    <strong>Jarvis</strong>',
      '    <span>Universal command center · features intact · local-first runtime</span>',
      '  </div>',
      '</div>',
      '<div class="jarvis-command-right">',
      '  <span class="jarvis-command-chip" data-tone="model" id="jarvis-model-chip">Model: ' + escapeHtml(detectModelHint()) + '</span>',
      '  <span class="jarvis-command-chip" data-tone="safe">Safe Mode</span>',
      '</div>'
    ].join('');

    document.body.appendChild(bar);
  }

  function escapeHtml(value) {
    return String(value)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  function refreshModelChip() {
    const chip = document.getElementById('jarvis-model-chip');
    if (!chip) return;
    chip.textContent = 'Model: ' + detectModelHint();
  }

  function apply() {
    document.body.classList.add(PHASE_CLASS);

    const sidebar = findSidebar();
    if (sidebar) {
      sidebar.classList.add('jarvis-sidebar-shell');
      ensureSidebarCrest(sidebar);
    }

    ensureCommandBar();
    refreshModelChip();
    document.body.classList.add(READY_CLASS);
  }

  function scheduleApply() {
    window.requestAnimationFrame(() => {
      apply();
      setTimeout(apply, 350);
      setTimeout(refreshModelChip, 1200);
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', scheduleApply, { once: true });
  } else {
    scheduleApply();
  }

  const observer = new MutationObserver(() => {
    if (!document.body) return;
    window.clearTimeout(observer.__jarvisTimer);
    observer.__jarvisTimer = window.setTimeout(apply, 250);
  });

  if (document.documentElement) {
    observer.observe(document.documentElement, { childList: true, subtree: true });
  }
})();
