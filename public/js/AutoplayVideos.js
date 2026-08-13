(function () {
  const initializedVideos = new WeakSet();

  function initializeVideo(video) {
    if (!(video instanceof HTMLVideoElement) || initializedVideos.has(video)) return;
    initializedVideos.add(video);

    const fallback = video.id
      ? document.querySelector(`[data-autoplay-fallback-for="${video.id}"]`)
      : null;
    let isVisible = true;
    let failedAttempts = 0;

    const hideFallback = function () {
      if (fallback instanceof HTMLElement) fallback.hidden = true;
    };

    const showFallback = function () {
      if (fallback instanceof HTMLElement) fallback.hidden = false;
    };

    const prepareVideo = function () {
      video.muted = true;
      video.defaultMuted = true;
      video.playsInline = true;
      video.setAttribute("muted", "");
      video.setAttribute("playsinline", "");
      video.setAttribute("webkit-playsinline", "true");
    };

    const attemptPlayback = function () {
      if (!isVisible || document.visibilityState === "hidden") return;
      prepareVideo();

      const attempt = video.play();
      if (!attempt) return;

      attempt.then(function () {
        failedAttempts = 0;
        hideFallback();
      }).catch(function () {
        failedAttempts += 1;
        if (failedAttempts >= 3) showFallback();
      });
    };

    prepareVideo();
    hideFallback();
    video.addEventListener("playing", hideFallback);
    video.addEventListener("loadeddata", attemptPlayback);
    video.addEventListener("canplay", attemptPlayback);
    video.addEventListener("error", showFallback);
    if (fallback) fallback.addEventListener("click", attemptPlayback);

    if ("IntersectionObserver" in window) {
      const observer = new IntersectionObserver(function (entries) {
        const entry = entries[0];
        isVisible = Boolean(entry && entry.isIntersecting);
        if (isVisible) attemptPlayback();
        else video.pause();
      }, { rootMargin: "20% 0px", threshold: 0.01 });
      observer.observe(video);
    }

    window.addEventListener("pageshow", attemptPlayback);
    window.addEventListener("focus", attemptPlayback);
    document.addEventListener("visibilitychange", function () {
      if (document.visibilityState === "visible") attemptPlayback();
    });
    document.addEventListener("WeixinJSBridgeReady", attemptPlayback);
    document.addEventListener("touchstart", attemptPlayback, { once: true, capture: true });

    requestAnimationFrame(attemptPlayback);
    window.setTimeout(attemptPlayback, 250);
    window.setTimeout(attemptPlayback, 1000);
  }

  function initializeAutoplayVideos() {
    document.querySelectorAll("video[data-autoplay-video]").forEach(initializeVideo);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeAutoplayVideos, { once: true });
  } else {
    initializeAutoplayVideos();
  }
})();
