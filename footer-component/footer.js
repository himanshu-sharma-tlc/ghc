class Footer extends HTMLElement{
constructor(){
    super();
}
connectedCallback(){
this.innerHTML=`
<section class="footer-section mt-5">
<footer>
  <p>
    <a href="mailto:contactus@globalhospitalityconclave.com" style="color: #fff;">
      <span style="padding: 10px;">
        <img src="assets/email-icon-global-hospitality-conclave-2023.svg" loading="lazy">
      </span>contactus@globalhospitalityconclave.com </a>
  </p>
  <p>@ 2024 All Rights Reserved</p>
  <p>Website managed by <a href="https://tlcgroup.com/" target="blank"> www.tlcgroup.com</a>
  </p>
</footer>
</section>


`
}
}
customElements.define('footer-component',Footer);