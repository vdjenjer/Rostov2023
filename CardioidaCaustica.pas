uses GraphWPF;

procedure Cardioid(n: integer; col: color := colors.YellowGreen);
begin
  Window.Maximize;
  font.Size := 20;
  var DotColor := colors.Red;
  var DotRadius := 3;
  var x := new real[n];
  var y := new real[n];
  pen.Color := colors.Gold;
  pen.Width := 5;
  var (Hu, Hv) := (Window.Width / 2, Window.Height / 2);
  var r0 := min(Hu, Hv) * 0.9;
  DrawCircle(Hu, Hv, r0);
  // размещаем n равноотстоящих точек на окружности
  var (phi, start) := (-2 * pi / n, 0);
  pen.Color := DotColor;
  Font.Size := 18;
  for var i := 0 to n - 1 do
  begin
    x[i] := r0 * cos(i * phi + start) + Hu;
    y[i] := r0 * sin(i * phi + start) + Hv;
    circle(x[i], y[i], DotRadius, DotColor);
    var u := r0 * 1.07 * cos(i * phi + start) + Hu - Font.Size / 2;
    var v := r0 * 1.07 * sin(i * phi + start) + Hv - Font.Size / 2;
    DrawText(u, v, 20, 20, $'{i}', DotColor, rightTop);
  end;
  // Линии между точками i -- times * i  (times = 2)
  pen.Color := col;
  pen.Width := 2;
  for var i := 0 to n - 1 do
  begin
    Line(x[i], y[i], x[2 * i mod n], y[2 * i mod n]);
  end;  
end;

begin
//  Cardioid(10);
//  {
  BeginFrameBasedAnimation((i: integer)->
  begin
    Cardioid(i);
    i += 1;
//    Sleep(1000);
    if i > 100 then
      EndFrameBasedAnimation;
  end);
//  }
end.