// Jarvis Phase 05B: icon and encoding repair overlay.
// This file repairs known mojibake artifacts in the rendered UI without removing features.
(function () {
  "use strict";

  if (window.__JARVIS_ICON_REPAIR_VERSION__) {
    return;
  }

  window.__JARVIS_ICON_REPAIR_VERSION__ = "05B.1";

  const REPLACEMENTS = [
    ["â–â–‚â–ƒ", "▁▂▃"],
    ["â–¼", "▾"],
    ["â–¸", "▸"],
    ["âœ–", "×"],
    ["âœ—", "×"],
    ["âœ“", "✓"],
    ["âœ…", "✓"],
    ["â‡’", "→"],
    ["â†’", "→"],
    ["â†", "←"],
    ["â†‘", "↑"],
    ["â†“", "↓"],
    ["â†º", "↺"],
    ["â€”", "—"],
    ["â€“", "–"],
    ["â€œ", "“"],
    ["â€", "”"],
    ["â€˜", "‘"],
    ["â€™", "’"],
    ["â‰¤", "≤"],
    ["â‰¥", "≥"],
    ["â—", "●"],
    ["â—‹", "○"],
    ["â‹®", "⋮"],
    ["â‹¯", "⋯"],
    ["Â·", "·"],
    ["Â", ""]
  ];

  const SYMBOL_ONLY = new Set([
    "×", "✓", "▾", "▸", "←", "→", "↑", "↓", "↺", "●", "○", "⋮", "⋯", "+", "-", "?"
  ]);

  function repairString(value) {
    if (!value || typeof value !== "string") {
      return value;
    }

    let output = value;
    for (const [broken, fixed] of REPLACEMENTS) {
      output = output.split(broken).join(fixed);
    }
    return output;
  }

  function repairTextNode(node) {
    const before = node.nodeValue;
    const after = repairString(before);
    if (after !== before) {
      node.nodeValue = after;
      if (node.parentElement) {
        node.parentElement.classList.add("jarvis-glyph-repaired");
      }
      return true;
    }
    return false;
  }

  function repairAttributes(element) {
    if (!element || !element.getAttributeNames) {
      return;
    }

    for (const name of element.getAttributeNames()) {
      if (!/^(title|aria-label|placeholder|alt|value)$/i.test(name)) {
        continue;
      }
      const before = element.getAttribute(name);
      const after = repairString(before);
      if (after !== before) {
        element.setAttribute(name, after);
      }
    }
  }

  function enhanceSymbolControl(element) {
    if (!element || element.nodeType !== Node.ELEMENT_NODE) {
      return;
    }

    const tagName = element.tagName ? element.tagName.toLowerCase() : "";
    const role = element.getAttribute ? element.getAttribute("role") : "";
    const isControl = tagName === "button" || tagName === "a" || role === "button";
    if (!isControl) {
      return;
    }

    const text = (element.textContent || "").trim();
    if (text.length <= 2 && SYMBOL_ONLY.has(text)) {
      element.classList.add("jarvis-symbol-control");
      element.classList.add("jarvis-glyph-repaired");
      if (!element.getAttribute("aria-label")) {
        const labelMap = {
          "×": "Close",
          "✓": "Confirm",
          "▾": "Expand",
          "▸": "Open",
          "←": "Back",
          "→": "Next",
          "↑": "Move up",
          "↓": "Move down",
          "↺": "Reset",
          "●": "Selected",
          "○": "Not selected",
          "⋮": "More options",
          "⋯": "More options",
          "+": "Add",
          "-": "Collapse",
          "?": "Help"
        };
        element.setAttribute("aria-label", labelMap[text] || "Control");
      }
    }
  }

  function repairElementTree(root) {
    if (!root) {
      return;
    }

    if (root.nodeType === Node.TEXT_NODE) {
      repairTextNode(root);
      return;
    }

    if (root.nodeType !== Node.ELEMENT_NODE && root.nodeType !== Node.DOCUMENT_NODE && root.nodeType !== Node.DOCUMENT_FRAGMENT_NODE) {
      return;
    }

    if (root.nodeType === Node.ELEMENT_NODE) {
      repairAttributes(root);
      enhanceSymbolControl(root);
    }

    const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT | NodeFilter.SHOW_ELEMENT);
    let node = walker.currentNode;

    while (node) {
      if (node.nodeType === Node.TEXT_NODE) {
        repairTextNode(node);
      } else if (node.nodeType === Node.ELEMENT_NODE) {
        repairAttributes(node);
        enhanceSymbolControl(node);
      }
      node = walker.nextNode();
    }
  }

  function boot() {
    document.documentElement.classList.add("jarvis-glyph-repair-ready");
    repairElementTree(document.body || document.documentElement);

    const observer = new MutationObserver((mutations) => {
      for (const mutation of mutations) {
        for (const node of mutation.addedNodes) {
          repairElementTree(node);
        }
        if (mutation.type === "characterData" && mutation.target) {
          repairElementTree(mutation.target);
        }
        if (mutation.type === "attributes" && mutation.target) {
          repairAttributes(mutation.target);
          enhanceSymbolControl(mutation.target);
        }
      }
    });

    observer.observe(document.documentElement, {
      childList: true,
      subtree: true,
      characterData: true,
      attributes: true,
      attributeFilter: ["title", "aria-label", "placeholder", "alt", "value"]
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot, { once: true });
  } else {
    boot();
  }
})();
