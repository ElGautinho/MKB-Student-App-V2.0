document.addEventListener("DOMContentLoaded", function () {
  function getAjaxRoot() {
    return document.querySelector("main.lms-main");
  }

  function loadAjaxPage(url, updateHistory) {
    var currentRoot = getAjaxRoot();
    if (!currentRoot) return Promise.resolve(false);

    return fetch(url, {
      credentials: "same-origin",
      headers: { "X-Requested-With": "XMLHttpRequest" },
    })
      .then(function (response) {
        if (!response.ok) throw new Error("Unable to load page");
        return response.text();
      })
      .then(function (html) {
        var documentParser = new DOMParser();
        var nextDocument = documentParser.parseFromString(html, "text/html");
        var nextRoot = nextDocument.querySelector("main.lms-main");
        if (!nextRoot) throw new Error("Navigation target not found");
        currentRoot.outerHTML = nextRoot.outerHTML;
        var currentTools = document.querySelector(".lms-header-tools");
        var nextTools = nextDocument.querySelector(".lms-header-tools");
        if (currentTools && nextTools)
          currentTools.outerHTML = nextTools.outerHTML;
        var nextNotification = document.querySelector(".lms-notifications");
        if (nextNotification && url.searchParams.has("sslms_notification_id"))
          nextNotification.setAttribute("open", "open");
        if (nextDocument.title) document.title = nextDocument.title;
        if (updateHistory) window.history.pushState({}, "", url);
        return true;
      })
      .catch(function () {
        window.location.href = url;
        return false;
      });
  }

  document.addEventListener("click", function (event) {
    var link = event.target.closest("a");
    var currentRoot = getAjaxRoot();
    if (
      !link ||
      link.target ||
      link.hasAttribute("download") ||
      link.getAttribute("href") === "#"
    )
      return;
    var url = new URL(link.href, window.location.href);
    if (
      url.origin !== window.location.origin ||
      url.pathname.indexOf("/wp-admin") === 0 ||
      (url.pathname === window.location.pathname &&
        url.search === window.location.search)
    )
      return;
    if (
      !currentRoot ||
      (url.hash &&
        url.pathname === window.location.pathname &&
        url.search === window.location.search)
    )
      return;

    var notificationPanel = link.closest(".lms-notifications");
    if (notificationPanel) notificationPanel.removeAttribute("open");
    event.preventDefault();
    loadAjaxPage(url.href, true);
  });

  window.addEventListener("popstate", function () {
    loadAjaxPage(window.location.href, false);
  });

  var menuToggle = document.querySelector(".lms-menu-toggle");
  var headerNav = document.getElementById("site-main-menu");
  if (menuToggle && headerNav) {
    menuToggle.addEventListener("click", function () {
      var open = headerNav.classList.toggle("is-open");
      menuToggle.setAttribute("aria-expanded", open ? "true" : "false");
      document.body.classList.toggle("mobile-menu-open", open);
    });
    headerNav.addEventListener("click", function (event) {
      if (
        window.innerWidth <= 760 &&
        event.target.closest("a") &&
        !event.target.closest(".dynamic-menu-dropdown > a")
      ) {
        headerNav.classList.remove("is-open");
        menuToggle.setAttribute("aria-expanded", "false");
        document.body.classList.remove("mobile-menu-open");
      }
    });
    window.addEventListener("resize", function () {
      if (window.innerWidth > 760) {
        headerNav.classList.remove("is-open");
        menuToggle.setAttribute("aria-expanded", "false");
        document.body.classList.remove("mobile-menu-open");
      }
    });
  }

  var form = document.getElementById("survey-form");
  if (!form) return;

  var questions = Array.prototype.slice.call(
    form.querySelectorAll(".survey-question"),
  );
  var fill = document.getElementById("survey-progress-fill");

  function updateProgress() {
    if (!fill || !questions.length) return;
    var answered = 0;
    questions.forEach(function (q) {
      var fields = q.querySelectorAll(
        'input:not([type="hidden"]), select, textarea',
      );
      var complete = false;
      fields.forEach(function (field) {
        if (field.type === "checkbox" || field.type === "radio") {
          if (field.checked) complete = true;
        } else if (String(field.value || "").trim() !== "") {
          complete = true;
        }
      });
      if (complete) answered++;
    });
    fill.style.width = Math.round((answered / questions.length) * 100) + "%";
  }

  form.addEventListener("input", updateProgress);
  form.addEventListener("change", updateProgress);
  updateProgress();

  form.addEventListener("submit", function (event) {
    var groups = form.querySelectorAll(".survey-question.required-group");
    for (var i = 0; i < groups.length; i++) {
      var checked = groups[i].querySelectorAll(
        'input[type="checkbox"]:checked',
      ).length;
      if (!checked) {
        event.preventDefault();
        groups[i].style.outline = "3px solid rgba(201,75,101,.25)";
        groups[i].scrollIntoView({ behavior: "smooth", block: "center" });
        window.setTimeout(function () {
          alert("Please select at least one option for the required question.");
        }, 150);
        return;
      }
      groups[i].style.outline = "";
    }
  });
});

// v3.6 — reveal archived completed survey responses (keeps the first four visible).
document.addEventListener("DOMContentLoaded", function () {
  const toggle = document.getElementById("survey-archive-toggle");
  if (!toggle) return;
  const items = document.querySelectorAll(".survey-list-item--archived");
  toggle.addEventListener("click", function () {
    const open = toggle.getAttribute("aria-expanded") === "true";
    items.forEach(function (item) {
      item.classList.toggle("hidden", open);
    });
    toggle.setAttribute("aria-expanded", open ? "false" : "true");
    toggle.innerHTML = open
      ? "Show archived responses <span>+" + items.length + "</span>"
      : "Hide archived responses <span>−</span>";
  });
});
