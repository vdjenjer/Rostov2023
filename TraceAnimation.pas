uses GraphWPF;

var
  //r - радиус точки; f - угол в формуле для фигур Лиссажу
  (x, y, r, f) := (Window.Center.X, Window.Center.Y / 2, 5, 0.0);
  a := new Queue<Point>; // Очередь для хранения нарисованных точек
  len := 150; // Максимальная длина очереди (и хвоста кометы)

procedure РисованиеКадра();
begin
  foreach var p in a index i do
    FillCircle(p, i / len * r, colors.Red);
  FillCircle(x, y, r, colors.DarkMagenta);
  a.Enqueue(Pnt(x, y));
  f += 0.01;
  x += 4 * cos(2 * f);
  y += 4 * sin(3 * f);
  if a.Count > len then
    a.Dequeue;
end;

begin
  BeginFrameBasedAnimation(РисованиеКадра)
end.