// function removeSplashFromWeb() {
//   document.getElementById("splash")?.remove();
//   document.getElementById("splash-branding")?.remove();
//   // document.body.style.background = "transparent";
// }

function removeSplashFromWeb() {
  const splash = document.getElementById("splash");
  if (splash) {
    splash.classList.add('remove-splash');
    setTimeout(() => {
      splash?.remove();
      document.getElementById("splash-branding")?.remove();
    }, 500);
  }
}
