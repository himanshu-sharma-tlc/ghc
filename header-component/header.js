class Header extends HTMLElement {
  constructor() {
    super();
  }
  connectedCallback() {
    this.innerHTML = `
    <header>
      <nav class="navbar">
        <div class="navbar-container container">
          <div class="logo">
            <a href="https://stage.globalhospitalityconclave.com/index.html">
              <img src="assets/GHC-Logo.png" alt="Logo" />
            </a>
          </div>
          <ul class="header__nav dsktop">
            <li>
              <a href="index.html">Home</a>
            </li>
            <li>
              <a href="ghc-2024.html">GHC 2024</a>
            </li>
            <li>
              <a href="organizing-committee.html">Organizing Committee</a>
            </li>
            <li>
              <a href="photo-gallery.html">Photo Gallery</a>
            </li>
            <li>
              <a href="memorabilia.html">Memorabilia</a>
            </li>
            <li class="last">
              <a href="contactus.aspx">Contact Us</a>
            </li>
          </ul>
          <span class="navbar-text">
            <div class="menu-btn">
              <a class="btn-open" href="javascript:void(0)"></a>
            </div>
          </span>
        </div>
      </nav>
    </header>    
    <div class="overlay">
      <div class="menu">
        <div class="container">
          <ul class="header__nav mbl">
            <li>
              <a href="index.html" >Home</a>
            </li>
            <li>
              <a href="ghc-2024.html">GHC 2024</a>
            </li>
            <li>
              <a href="organizing-committee.html">Organizing Committee</a>
            </li>
            <li>
              <a href="photo-gallery.html">Photo Gallery</a>
            </li>
            <li>
              <a href="memorabilia.html">Memorabilia</a>
            </li>
            <li>
              <a href="contactus.aspx">Contact Us</a>
            </li>
          </ul>
        </div>
      </div>
    </div>  
    `;
    const currentPage = window.location.pathname;
    const navLinksDsktop = this.querySelectorAll(
      ".header__nav.dsktop li a[href]"
    );
    const navLinksMbl = this.querySelectorAll(".header__nav.mbl li a[href]");
    function addActiveClass(navArray) {
      navArray.forEach((element) => {
        const elementWithoutHTML = element.getAttribute("href").slice(0,-5);
        if (currentPage.includes(elementWithoutHTML)) {
          element.classList.add("active");
        } else {
          element.classList.remove("active");
        }
      });
    }
    if (currentPage === "/") {
      navLinksDsktop[0].classList.add("active");
      navLinksMbl[0].classList.add("active");
    } else {
      addActiveClass(navLinksDsktop);
      addActiveClass(navLinksMbl);
    }

    
    // navLinksMbl.forEach((element) => {
    //   if (currentPage.includes(element.getAttribute("href"))) {
    //     console.log(element.getAttribute("href"));
    //     element.classList.add("active");
    //   } else {
    //     element.classList.remove("active");
    //   }
    // });
  }
}
customElements.define("header-component", Header);
