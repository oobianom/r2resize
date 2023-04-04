// Expanding accordions
$(".option").click(function(){
   $(".option").removeClass("active");
   $(this).addClass("active");

});


body {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  height: 100vh;
  font-family: "Roboto", sans-serif;
  transition: 0.25s;
}
body.dark {
  background: #232223;
  color: white;
}
@media (prefers-color-scheme: dark) {
  body:not(.light) {
    background: #232223;
    color: white;
  }
}
body .credit {
  position: absolute;
  bottom: 20px;
  left: 20px;
  color: inherit;
}
body .options {
  display: flex;
  flex-direction: row;
  align-items: stretch;
  overflow: hidden;
  min-width: 600px;
  max-width: 900px;
  width: calc(100% - 100px);
  height: 400px;
}
@media screen and (max-width: 718px) {
  body .options {
    min-width: 520px;
  }
  body .options .option:nth-child(5) {
    display: none;
  }
}
@media screen and (max-width: 638px) {
  body .options {
    min-width: 440px;
  }
  body .options .option:nth-child(4) {
    display: none;
  }
}
@media screen and (max-width: 558px) {
  body .options {
    min-width: 360px;
  }
  body .options .option:nth-child(3) {
    display: none;
  }
}
@media screen and (max-width: 478px) {
  body .options {
    min-width: 280px;
  }
  body .options .option:nth-child(2) {
    display: none;
  }
}
body .options .option {
  position: relative;
  overflow: hidden;
  min-width: 60px;
  margin: 10px;
  background: var(--optionBackground, var(--defaultBackground, #E6E9ED));
  background-size: auto 120%;
  background-position: center;
  cursor: pointer;
  transition: 0.5s cubic-bezier(0.05, 0.61, 0.41, 0.95);
}
body .options .option:nth-child(1) {
  --defaultBackground:#ED5565;
}
body .options .option:nth-child(2) {
  --defaultBackground:#FC6E51;
}
body .options .option:nth-child(3) {
  --defaultBackground:#FFCE54;
}
body .options .option:nth-child(4) {
  --defaultBackground:#2ECC71;
}
body .options .option:nth-child(5) {
  --defaultBackground:#5D9CEC;
}
body .options .option:nth-child(6) {
  --defaultBackground:#AC92EC;
}
body .options .option.active {
  flex-grow: 10000;
  transform: scale(1);
  max-width: 600px;
  margin: 0px;
  border-radius: 40px;
  background-size: auto 100%;
  /*&:active {
     transform:scale(0.9);
  }*/
}
body .options .option.active .shadow {
  box-shadow: inset 0 -120px 120px -120px black, inset 0 -120px 120px -100px black;
}
body .options .option.active .label {
  bottom: 20px;
  left: 20px;
}
body .options .option.active .label .info > div {
  left: 0px;
  opacity: 1;
}
body .options .option:not(.active) {
  flex-grow: 1;
  border-radius: 30px;
}
body .options .option:not(.active) .shadow {
  bottom: -40px;
  box-shadow: inset 0 -120px 0px -120px black, inset 0 -120px 0px -100px black;
}
body .options .option:not(.active) .label {
  bottom: 10px;
  left: 10px;
}
body .options .option:not(.active) .label .info > div {
  left: 20px;
  opacity: 0;
}
body .options .option .shadow {
  position: absolute;
  bottom: 0px;
  left: 0px;
  right: 0px;
  height: 120px;
  transition: 0.5s cubic-bezier(0.05, 0.61, 0.41, 0.95);
}
body .options .option .label {
  display: flex;
  position: absolute;
  right: 0px;
  height: 40px;
  transition: 0.5s cubic-bezier(0.05, 0.61, 0.41, 0.95);
}
body .options .option .label .icon {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  min-width: 40px;
  max-width: 40px;
  height: 40px;
  border-radius: 100%;
  background-color: white;
  color: var(--defaultBackground);
}
body .options .option .label .info {
  display: flex;
  flex-direction: column;
  justify-content: center;
  margin-left: 10px;
  color: white;
  white-space: pre;
}
body .options .option .label .info > div {
  position: relative;
  transition: 0.5s cubic-bezier(0.05, 0.61, 0.41, 0.95), opacity 0.5s ease-out;
}
body .options .option .label .info .main {
  font-weight: bold;
  font-size: 1.2rem;
}
body .options .option .label .info .sub {
  transition-delay: 0.1s;
}
