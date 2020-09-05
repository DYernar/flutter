abstract class SuperClass {
  func() {
    print('hello');
  }
}

class ExtendedClass with SuperClass {
  final int count;

  ExtendedClass(this.count);
}

List<ExtendedClass> l = List.generate(10, (index) => ExtendedClass(index));

func() {
  int sum = 0;
  l.map((e) {
    if (e.count > 5) {
      sum += e.count;
    }
  });

  int sum2 = l.fold(0, (previousValue, element) {
    if (element.count > 5) {
      previousValue += element.count;
    }
    return previousValue;
  });
}

//mixins
