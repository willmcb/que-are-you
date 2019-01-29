function getLocation() {
    var coords = {lat: null, long: null};
    navigator.geolocation.getCurrentPosition(
        function success(position) {
            console.log("lat:" + position.coords.latitude);
            console.log("long:" + position.coords.longitude);
            coords.lat =  position.coords.latitude;
            coords.long = position.coords.longitude;
        },
        function error(error_message) {
            console.error('An error has occured while retrieving location', error_message);
        }
    );
    return coords
}

function locationNotSupported(){
    console.log('geolocation is not enabled on this browser');
};



function qrscanner() {
  var coords = null;
  if ("geolocation" in navigator) {
      coords = getLocation();
  } else {
      locationNotSupported();
  }

  var video = document.createElement("video");
  var canvasElement = document.getElementById("canvas");
  var canvas = canvasElement.getContext("2d");
  var flag = true;

  function drawLine(begin, end, color) {
    canvas.beginPath();
    canvas.moveTo(begin.x, begin.y);
    canvas.lineTo(end.x, end.y);
    canvas.lineWidth = 4;
    canvas.strokeStyle = color;
    canvas.stroke();
  }
  // Use facingMode: environment to attemt to get the front camera on phones
  navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } }).then(function(stream) {
    video.srcObject = stream;
    video.setAttribute("playsinline", true); // required to tell iOS safari we don't want fullscreen
    video.play();
    globalID = requestAnimationFrame(tick);
  });

  function tick() {
      if (video.readyState === video.HAVE_ENOUGH_DATA) {
        var videoProportion = ((window.innerWidth) / 100) * 75;
        canvasElement.hidden = false;
        canvasElement.height = videoProportion;
        canvasElement.width =  videoProportion;
        canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
        var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
        var code = jsQR(imageData.data, imageData.width, imageData.height, {
          inversionAttempts: "dontInvert",
        });
        if (code) {
          cancelAnimationFrame(globalID);
          video.srcObject.getTracks()[0].stop();

          drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF3B58");
          drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF3B58");
          drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF3B58");
          drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF3B58");

          if(coords.lat && coords.long){
            var postdata = "associate_id=" + code.data + "&lat=" + coords.lat + "&long=" + coords.long;
          } else {
            var postdata = "associate_id=" + code.data;
          }

          if (flag) {
            Rails.ajax({
              url: "/associations",
              type: "POST",
              data: postdata,
              success: function(data) {
                console.log('Successfully added association');
                video.srcObject.getTracks()[0].stop();
              }
            });
          flag = false;
          }
        }
      }

      if (window.location.pathname == '/associations/new') {
      globalID = requestAnimationFrame(tick);
      } else {
        video.srcObject.getTracks()[0].stop();
      }
    }

}
