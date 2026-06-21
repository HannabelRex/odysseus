/* ============================================================
   Jarvis Phase 05E - Chat Mission Console Redesign
   Safe DOM enhancement layer for the central chat experience.
   ============================================================ */
(function () {
  'use strict';

  const PHASE_CLASS = 'jarvis-chat-console-v1';
  const READY_CLASS = 'jarvis-chat-console-ready';
  const CHAT_ROOT_CLASS = 'jarvis-chat-root';
  const RAIL_ID = 'jarvis-mission-context-rail';
  const HINT_ID = 'jarvis-composer-hint';

  function textOf(node) {
    return (node && node.textContent ? node.textContent : '').replace(/\s+/g, ' ').trim();
  }

  function escapeHtml(value) {
    return String(value || '')
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  function scoreChatCandidate(node) {
    if (!node || node === document.body || node === document.documentElement) return 0;
    const text = textOf(node).toLowerCase();
    const rect = node.getBoundingClientRect ? node.getBoundingClientRect() : { width: 0, height: 0, left: 0 };
    let score = 0;

    ['odysseus chat', 'select model', 'attach files', 'agent chat', 'welcome', 'prompt', 'rag', 'research'].forEach((word) => {
      if (text.includes(word)) score += 1;
    });

    if (rect.width > 420 && rect.height > 260) score += 2;
    if (rect.left > 120) score += 1;
    if (node.querySelector && node.querySelector('textarea, input[type="text"], [contenteditable="true"]')) score += 2;

    return score;
  }

  function findChatRoot() {
    const selectors = [
      'main',
      '#chat',
      '#chat-container',
      '#chatArea',
      '.chat',
      '.chat-container',
      '.messages',
      '[id*="chat" i]',
      '[class*="chat" i]',
      '[class*="message" i]'
    ];

    const candidates = [];
    selectors.forEach((selector) => {
      document.querySelectorAll(selector).forEach((node) => {
        if (!candidates.includes(node)) candidates.push(node);
      });
    });

    const scored = candidates
      .map((node) => ({ node, score: scoreChatCandidate(node) }))
      .sort((a, b) => b.score - a.score);

    return scored.length && scored[0].score >= 3 ? scored[0].node : null;
  }

  function findComposerControl() {
    const controls = Array.from(document.querySelectorAll('textarea, input[type="text"], [contenteditable="true"]'));
    if (!controls.length) return null;

    const scored = controls
      .map((node) => {
        const rect = node.getBoundingClientRect ? node.getBoundingClientRect() : { top: 0, width: 0, height: 0 };
        const placeholder = (node.getAttribute('placeholder') || '').toLowerCase();
        let score = 0;
        if (placeholder.includes('message') || placeholder.includes('prompt') || placeholder.includes('ask')) score += 3;
        if (rect.top > window.innerHeight * 0.45) score += 2;
        if (rect.width > 240) score += 2;
        if (rect.height > 28) score += 1;
        return { node, score };
      })
      .sort((a, b) => b.score - a.score);

    return scored.length ? scored[0].node : null;
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

    return 'Local-first model';
  }

  function ensureMissionRail() {
    if (document.getElementById(RAIL_ID)) return;

    const rail = document.createElement('aside');
    rail.id = RAIL_ID;
    rail.setAttribute('aria-label', 'Jarvis mission context rail');
    rail.innerHTML = [
      '<div class="jarvis-rail-eyebrow">Mission Context</div>',
      '<div class="jarvis-rail-title">Universal Jarvis</div>',
      '<div class="jarvis-rail-copy">Chat, research, code, files, tasks, email, calendar, and automation remain available. The console now focuses the active mission without removing Odysseus features.</div>',
      '<div class="jarvis-rail-section">',
      '  <div class="jarvis-rail-label">Runtime</div>',
      '  <div class="jarvis-rail-status">',
      '    <div class="jarvis-rail-status-row"><strong>Model</strong><span>' + escapeHtml(detectModelHint()) + '</span></div>',
      '    <div class="jarvis-rail-status-row"><strong>Tools</strong><span>Permissioned</span></div>',
      '    <div class="jarvis-rail-status-row"><strong>Mode</strong><span>Safe local-first</span></div>',
      '  </div>',
      '</div>',
      '<div class="jarvis-rail-section">',
      '  <div class="jarvis-rail-label">Capabilities</div>',
      '  <div class="jarvis-rail-chip-grid">',
      '    <span class="jarvis-rail-chip">Chat</span>',
      '    <span class="jarvis-rail-chip">Research</span>',
      '    <span class="jarvis-rail-chip">Code</span>',
      '    <span class="jarvis-rail-chip">Files</span>',
      '    <span class="jarvis-rail-chip">Tasks</span>',
      '    <span class="jarvis-rail-chip">Email</span>',
      '    <span class="jarvis-rail-chip">Calendar</span>',
      '    <span class="jarvis-rail-chip">Automation</span>',
      '  </div>',
      '</div>',
      '<div class="jarvis-rail-section">',
      '  <div class="jarvis-rail-label">Next</div>',
      '  <div class="jarvis-rail-copy">Use the chat composer for natural language, slash commands, files, research, and agent workflows. Risky actions still require approval.</div>',
      '</div>'
    ].join('');

    document.body.appendChild(rail);
  }

  function ensureComposerHint(control) {
    if (!control || document.getElementById(HINT_ID)) return;

    const hint = document.createElement('div');
    hint.id = HINT_ID;
    hint.className = 'jarvis-composer-hint';
    hint.textContent = 'Mission input: ask, research, code, attach files, or plan work';

    const wrapper = control.closest('form, div, section, footer') || control.parentElement;
    if (wrapper && wrapper.parentElement) {
      wrapper.parentElement.insertBefore(hint, wrapper);
    }
  }

  function enhance() {
    document.body.classList.add(PHASE_CLASS);

    const chatRoot = findChatRoot();
    if (chatRoot) {
      chatRoot.classList.add(CHAT_ROOT_CLASS);
      document.body.classList.add(READY_CLASS);
    }

    ensureMissionRail();
    ensureComposerHint(findComposerControl());
  }

  function scheduleEnhance() {
    if (scheduleEnhance.timer) window.clearTimeout(scheduleEnhance.timer);
    scheduleEnhance.timer = window.setTimeout(enhance, 120);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', enhance);
  } else {
    enhance();
  }

  const observer = new MutationObserver(scheduleEnhance);
  observer.observe(document.documentElement, { childList: true, subtree: true });
})();
