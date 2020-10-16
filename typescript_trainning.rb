
  markers.forEach(marker => {
    <%=@locations%>.forEach(location => {
      marker.addListener("click", () => {
        infowindow.setContent(location.values[2]);
        infowindow.open(map, marker);
      });
};

markers.forEach(function (marker) {
  marker.addListener("click", () => {
    infowindow.setContent(location.values[2]);
    infowindow.open(map, marker);
  });
});
