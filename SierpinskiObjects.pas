uses GraphWPF, WPFObjects;

var
  Hu, Hv, rx, Sx, Sy: real;

procedure Init();
begin
  rx := 1.05;
  Sx := Window.Width / rx;
  Sy := Sx;
  Hu := 2;
  Hv := Window.Height - 2;
end;

procedure TriangleObj(p1, p2, p3: GPoint; c: color; fill: boolean := true);
begin
  var u1 := p1.X * Sx + Hu;
  var v1 := -p1.Y * Sy + Hv;
  var u2 := p2.X * Sx + Hu;
  var v2 := -p2.Y * Sy + Hv;
  var u3 := p3.X * Sx + Hu;
  var v3 := -p3.Y * Sy + Hv;
  if fill then
    new PolygonWPF(Arr(new GPoint(u1, v1), 
                       new GPoint(u2, v2), 
                       new GPoint(u3, v3)), c)
  else
    new PolygonWPF(Arr(new GPoint(u1, v1), 
                       new GPoint(u2, v2), 
                       new GPoint(u3, v3)), 
                       colors.White, 3, c)
end;


procedure Draw(p1, p2, p3: GPoint; n: integer := 1; fill: boolean := true);
begin
  if n = 0 then
    TriangleObj(p1, p2, p3, colors.Red, fill)
  else
  begin
    var c12 := new GPoint((p1.X + p2.X) / 2, (p1.Y + p2.Y) / 2);
    var c23 := new GPoint((p3.X + p2.X) / 2, (p3.Y + p2.Y) / 2);
    var c13 := new GPoint((p1.X + p3.X) / 2, (p1.Y + p3.Y) / 2);
    Draw(p1, c12, c13, n - 1, fill);
    Draw(c12, p2, c23, n - 1, fill);
    Draw(c13, c23, p3, n - 1, fill);
  end;
end;

procedure Moovie();
begin
  foreach var x in Objects do
    x.AnimRotate(360, 2);
  sleep(3000);
  foreach var x in Objects do
  begin
    x.AnimMoveOn(30, -30);
    sleep(10);
  end; 
  foreach var x in Objects do
    x.AnimRotate(0, 2);
  sleep(3000);
  foreach var x in Objects do
    x.AnimScale(2, 2);
  sleep(3000);
  foreach var x in Objects do
    x.AnimRotate(360, 2);
  foreach var x in Objects do
    x.AnimScale(1, 2);
  sleep(3000);
  foreach var x in Objects do
    x.AnimMoveTo(Random(0, Window.Width),Random(0, Window.Height));
end;

begin
  Init();
  var p1 := Pnt(0, 0); // new GPoint(0, 0)
  var p3 := Pnt(0.8, 0);
  var p2 := Pnt((p1.x + p3.x) / 2, p1.y + (p3.x - p1.x) * sqrt(3) / 2); 
  Draw(p1, p2, p3, 4);
  Sleep(2000);
  Moovie();
end.