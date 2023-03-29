uses GraphWPF, Controls;

var
  // Размер экрана
  xk := 100;
  // Размещение точки на колесе. р = 1 - на расстоянии радиуса
  // р < 1 - меньше, p > 1 - больше радиуса
  p := 1.1; 
  PanelSize := 150;
  // Радиус колеса
  r := 5;
procedure Wheel(x, y, r, phi: real; dr: real := 0.3; c: color := colors.Gold; dc: color := colors.Red);
begin
  pen.Width := 0.5;
  DrawCircle(x, y, r, c); // колесо
  var xe := p * r * cos(phi) + x;  //x-координата точки на ободе
  var ye := p * r * sin(phi) + y; //y-координата точки на ободе
  pen.Width := 0.2;
  Line(x, y, xe, ye, dc);  // радиус к точке на ободе
  pen.Color := dc;
  Circle(xe, ye, dr, dc);  // точка на ободе
end;

procedure Trace(a: list<Point>; c: color; r: real := 0.2);
begin
  foreach var p in a do
    FillCircle(p, r, c);
end;

procedure Cycloid(r: real; col: color := colors.Gold);
begin
  var DotColor := colors.Red;
  pen.Width := 0.5;
  var (xc, yc) := (r, r); 
  var phi := -pi / 2; // точка внизу обода
  var (xc0, yc0, phi0) := (xc, yc, phi);
  var dphi := 0.04 * 5 / r ; // Больше колесо - меньше шаг
  var l := new List<Point>;
  BeginFrameBasedAnimation(()->
  begin
    Wheel(xc0, yc0, r, phi0);
    var x := p * r * cos(phi) + xc;
    var y := p * r * sin(phi) + yc;
    l.Add(Pnt(x, y));
    xc += dphi * r;
    phi -= dphi;
    Wheel(xc, yc, r, phi);
    Trace(l, DotColor, 0.3);
    if xc + r  > xk - PanelSize * xk / Window.Width then
      EndFrameBasedAnimation;
  end);
end;

begin
  Window.Title := 'Циклоида';
  Window.Maximize;
  var Panel := LeftPanel(PanelSize, Colors.LemonChiffon);
  SetMathematicCoords(0, xk, -20, false);
  var tb := TextBlock('Сдвиг точки вдоль радиуса. 1.0 -- радиус.');
  tb.Wrapping := True;
  var s := SliderReal('Сдвиг:', 0.1, 2.0, p, 0.1);
  s.ValueChanged := procedure -> p := s.Value;
  var rinp := new IntegerBoxWPF('Радиус колеса: ',1, 10);
  rinp.Value := 5;
  rinp.Tooltip := 'Можно менять колёсиком';
  rinp.ValueChanged := procedure -> r := rinp.Value;
  Button('Старт').Click := () -> Cycloid(r);
  TextBlock('');
  TextBlock('');
  TextBlock('');
  Button('Выход').Click := procedure -> Window.Close;
end.