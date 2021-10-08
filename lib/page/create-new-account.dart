import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/page/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';



class CreateNewAccount extends StatefulWidget {

  static String tag = 'CreateNewAccount-page';
  @override
  _CreateNewAccountState createState() => new _CreateNewAccountState();
}
class _CreateNewAccountState extends State<CreateNewAccount> {

  final _formKey = GlobalKey<FormState>();


  Future save() async {
    // final byteData = await rootBundle.load('assets/images/alucard.jpg');
    // var value;
    // var user_id;
    var res = await http.post("http://202.28.34.197:9000/authen/register",
        headers: <String, String>{
          'Content-Type': 'application/json;charSet=UTF-8'
        },
        body: jsonEncode({
          'email' : user.email,
          'username': user.username,
          'password': user.password,
          'Image': 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAH0AfQDASIAAhEBAxEB/8QAGwAAAgMBAQEAAAAAAAAAAAAAAgMAAQQFBgf/xAA/EAACAgECBQMCBQIFAgUDBQAAAQIDEQQhBRIxQVETImEycQYUQoGRI1IVM2KhsSRyQ1OCwdEHc5I0Y+Hw8f/EABkBAQEBAQEBAAAAAAAAAAAAAAABAgMEBf/EACERAQEBAQACAgMBAQEAAAAAAAABEQIhMQMSMkFRIhNx/9oADAMBAAIRAxEAPwDwaQaREhkYlZtSMRsY/BIxGxiVi1IxGxiSMRsYlZ1IxGxiSMRsYlZ1UYjIxCjEbGJWdBGIyMQlENRApRCUUEkRICJF4LIBCEIBCEN2h4ZfrZZiuWHeTFuLJvpjhCU5KME5N+DraPgllmJXbLwdnSaHT6KCUYqU/LHTtSW7wjnenbn4/wCs9Oho00fpQN2o5ViqKXyJ1OvjHKizmW69567nK9O05xqs9Sx5nMD2x6s589XZN7MkYai3psvLMNtdmoUVszM9bh4W/wBiLTRX1yc34XQPlUFtFR/YClqbJdIS/cCeqae6Lfu7OX3BcP8A9sgW9U+yLWrkX6b7Qf8ABXpS/sYF/my1qU2LcP8ASU614aCtdd1b7miMovpg5Trf6WA/Vj+plR2+RMGVL7I5MNVfW9pv9zZRxNp/1IbeUUNdbT6EW2zRqq1NFy2aDlRGa9oxHPtrcVzLdC4ywzY4Srk1JbMz204e3QmB1VmR6ynlHPinFmyizyFbKZeDbXLujJBRksodXLDwbjFaNXp4avTSrmsqSPAa/QPSamUGts7H0Ot7HnfxFRGXv2ydZXLuPMRgMUQuUJI24aFIvBeCyoohGUwiMpkIwKZRCFwCwcB4JggDBMDMEUQoOUgzBAry0YjYxJGI2KMOtqRiNjEqKGRRWLVxQ2KKihkUVkcUMjEqCGxRUFFDIoqKDSAtIJJvomadDorNZaoxXsX1M3aq2vRzjRp64ykurayTWpz+3KUZZxysuUXHqjsu5V1J6qMXnxHdHL1aj6nNXLMH0KWYSQiLDKgoRcpYSyy665WSUYpvJ6LhfCVUldet+qiS3Gueb0Rwzgqli7U/T2j5OzKca4qEEkkVdcorC2RztRq8Zwceunp55kabdQoLdnL1euznD2EXW2WZfYyxhKc/cznbrpJip2zse2Q6tJKfum+WPyaq61H6Ipvyx0aXJ5k3J/BlSa66q/ojzS8saq5z6rH3NEa4x64X2JO3045SUV5ZrDQR0zSzOSSFzlpa/NjMt+tjN4jzWP4Eenqr37YKC+eoRrlreX6Kox+4izXy/VYl8IuPCZy3uvx+4a4fo6t5TUn9yYuskuILOzkwXrZPpCbNjlpYfTBfwC9RBfTGK/YDL+as/wDIkR6mz/yJGn8z9v4K9ZvuieBlepfeiSK/MVvqpR+6NLnnqLcPMU/2HhQxdVj6pjqqK09+4mVEZLPIk/guuMo9JvPhhGiejlD3VvK+B1V92nSc05Q7+ULp1DreJ9H/AAbIzi45SUovqjUSxojKvU1KUWmn3FOl/S/2M+Pylnq1P+lJ+6Pg3xasSaKjFKn4BjFxkdB17/cTKnDGGjpk1gu+30pwlnZvAVdYOt087o6eMFvzpt+EVHQjL2/scHiK1GsudNFUpPz2O4o4k3J4jjAyuSSxXHHyblZs15iP4c1zWWq18cwnUcE12njzOrniv7Hk9e4zf62ivTl3lk19qx/zjwLTTaaaa7FNnsOJcEq1kHOvELvPn7nkdRRZp7ZV2xcZLybl1x65vIGUQhphGUyFlQJAsF4AHBeAsFpEUOC0gsFpEUOCB4IFeZig4oiQaRlrVxQxIpIOKKzRRQ2KBihkUVkyKGxQuI2IBI0aWiWp1EKoLeTwJR6P8O6Tkj+Ykt30Jbkb552t/oV6HSuFaxhZb8nP0ejzN6q5ZcnmKZ1rq/VlKL6Ng4Vl3Il7UsHPXovLkcTr5oc05qMf+Ti4+Trccdk9QuVPkisbHLjFvomdJ6efr2FDtPRK+xQgm2zRpuG6i+SxBxT7s9FoOH16KGes+7JesXni0HD+G16SKnNKVn/A/UX8sWFZPfCMt9ldS5rJLPg5W69MmES57Xl7IzaidVW0nl+CW6m698ung0vIWn4TbN81ssGG2KUp2vpiPhGinSyfSJ1KtHptOsy3fyBZxCEMxpr5mPr/AE3+Ew0dnhJBzjTQv6liz4Rmu1lslmy1RXiJkd63cV/6pDwnlrnqm9qakl/dIRKp3PN03L46IRK+Xbd+X0K5bLX7m2vjZEXDnZp6NlhvxFAS1lmPZBVx89y1VGC2wvliLeT/AFSf32AVZqJt7zb/AHFOxvuEqm+kWX6E32Ipbl8lcw2VDgszlGP3Ylzrj+rP2ALJakxbsX9sgXdFdYyGDQpjI2GRW1Pq8fcfWoS7832YwaIy+C3Hm3S3F+hJ71S/ZlwtlGXLNcsv+SYo8c/tftn28MGq51Wcj2fhjk4XLGyl/wC4rUVOcGpbTj3LEafUi4tP6WtytFqXXN0yecfS/g58L5Sg01iyPVeSOzDjYusWVHp62pxyhvpp9jBw23mfK3s1sdSKxFHSMUCgkMSwi8AWT5INgE+XqyvXS2WDLzuX1MKLguzZNXGlWJ/qDjKL/UIjKP8AaGprwUaIs5vHOFrX6fmrS9aG6+fg2xx2Y5dNiys2a+c2QlVZKE4uMovDTKPY8b4PDXVu6pKN8V/+XweQnCVc3CacZReGmdpdeTrm80JeC0gkjTIUi8BJBJE1QqJeA+UmCAcECBbCqIC5ECuAkMSBSDSICiHFFRDSKg4oZFARQ2KCDiNis9EFpqHZl9kdP8l+W0bsnH3Ndw1Jawaet2Wxh5Z7LTQVcIQj0ijzPCYc2si35PSQnuzn3fLt8U8NOPc/sY+H3wt5t/6kZNNGqM08M89xLTWafUztqbXM85Rztx2kegnpYNuS79ULr00IS5oVwfxg5PDOMyh/T1Esrs32O5C+qxZi0/sWXWbzgozUf0NP7FS5pfCD54+UT1I+UUZ512S2ht8i48NrzzWtyfyapXwit5L+TFqOJ1V5WV/JPC+WrFFC25V+xk1GvhFPDOffr1anyfyc+cfUlmc3L4iZt/jUjVqOJRk3luXwjO9RfYvYuSIUKkvpio/PVh8laeZyyzOtYRGvL3bnIctPJ4c2ooZGaS9qwFGFtj9sX92QCoV19Fl+WRycug9aaEN7Z7+EXzJbU1pfMi4azqmc93sivTqh1eX8DbHFf5k3OX9q2MtkLLV7nyw/tiE0Nmrqg+WCy/CEuWos7quP+41VRrXtWCml3YCo00J5nzTfyy5Sri/ZBIqc4R7ozWXwXR5YVp9VL9K/gv1a39VcTBLUPwD+Yl2QG+VVE+ia/wBxEtK081v+GIWokuqGQ1a77DyDjqLqZYmba769THks2l2ZmVldscPDEzrdW9bzHwBvnVOMlviX6ZLpL7jq5K6HLNYmtn8mLT61cvLZvHujXhbSi8rs/IwYb06rm/1R2fygU8pryatdHnqjauq9sjHB4xkUdThV2JQi+vQ9JF+08jpLFC6L+T0dV8XWm3sa5YrbnbJkvk5zXaKGwtVsXy5a89goenXvNqTLfKTwzRrb7DFXhdDQ74dolq1PohkXSEmuiCeV1jj5Q1zT6xB5vCYwVCfncfHK3XQQ1GT8MbTL9LLEpy+O5xOPcI/MRepoX9WK9yX6kdxJEZqeGbNmPnajgJROxx7Qfl9T61cf6dnVeGctI6y681mXA4CwXgsMhwUy2BJhUkxbZcmLbIqm9yAsgHKig4goNFBRQyKAiNigyKKGRQMUNiijscKqUlWsdZbnT43Hl0jx5MfAUpxafWL2OzxPT+vo5qPXBzt8u/M/w4HC3yWqXhncTw2zhaNck3B9TrU2c0cPqZ7a+L1jRG3DxkC2yNicLkt+jMdtrqm0+nZleunHD3Rz12xi1mh5JOUOhnq1Go079ljXxk22XShtF5j4M0+W1+1pPwyf+KYuLanGJJP9y3xO5/p/3Mkq5x6xeAOZLqTTGizWXWfH7i1By3lIBSj5L5l2ZFOUYRXXISsx9KwI5gk8gM55PvgZWk3vlgxiu41SjH5A01KKWcIY7uVYTwvgwS1CXcTLVxQ1MdCV8RU9TDo2/wBjnS1Tl0QmU5PqwuOjLWQj9EUhE9Y2YnLBXLJ7vZFQ+erfkU7bJfCLqolZLlqg5s6EeH06eCs110Yr+xPcYOXGudssQTk2aFwyzl5rWoodbxiupenoaFFf3Pqc+3UajUPNljeexcQ2dOnr+qeX8GeTr/Rn9yo1thqrzkKU3kmGN5IrqmT04vo2mApSae2w+FzksPqJlFxe/wDIOcMB0uuxs0mobr5W91szApZ2YyiXLal2lswOrKanXYu0o/7mBheo1iL8sXN4ILjZys6Ol10E4q2Xt8HHy29gox8lHqXxel4jFqMV0SGQ11ElvYl92earrsf0QTDlG6H1VR/gamPTx1NUl7bIv9y/zHLumeVU0muaHL8o1VW2L6LH9mNXHo4avyPhdFnn6dTPOJxx8o212sTpMdlOMlui/S7xZgqvZrhbno8M3PLONEXth9QgIS5lv1GGkZeJaVavRzr74zH7njnFxbUlhrZo9zk8xxzTqnXOSWI2LP79zXLn8k8a5jBZo00PUvUWs5E3R5LJR+TbjhTYEmFICQAtgMJgMgohRAOahiAiMiVBRGxQCQ2CLEHFDYoGKGxiB1+CZg3JeT0ldiksfyea4M/6rh5O7GThe4vo1scevb1fH55Z9dwvM/W0/wBXdeTJFyhPE4uL7po6E9f+Ws5Ldovoxy1Gm1Ed+VkvWzF+uXXPupV1ee5z51yg2md5wrW0HsZ79LGxZOd5dZXBnleRTeep1btPGHcxWQi+xnKrNzTX0yf2YLnY+sUwpwx0bEucl8gHz+YMp2RX6H/AHqTfYpqb6gF6y/tLWpS7C+Rd2Eq0+zYBPVvsB61sumRkasdkNhBAIVdsurx+4a0+OrNC5Y/cpylLaEcfICZVqK3ePuKact1svLNteknOWyc35fRGpcMrhH1NXbyxXYqa5VVUrJYqi5S8nRr4ZXTH1dbYorrjIGo4xTp06tDUs9OZmBw1Oslz6mcseMl9DXqOLxinVw+vlX92NzmWK22XPdNt/LyaeWMFy1xwvPdjatJn3T/ZEtMY4U52iv5HRowstGxqFUdluJ5pSfTfsiaoHBRW7x8A8ja3xBBXNVR5pPMjl6nUzs2TaRqI2XXaenZT5pfczy1lb/VgxqmMur6hS00q1zRSlH4Lg2V6iM3ie6D1FDpkmnzQkspnPUFOOa2011Rt0ep56/y1/VfTIAcYLi8NNdUXOPLt3TKRBpskmlIDPNuC968Bwg+iArBEoLqmzXVonNZm8fCNC0FeM7/uyaMVd0K3lVf7mqGuqksSjKP33G/k60ui/kXZpal1i19iYosU27xaGU6dKXVGT8pn/Ks38MkbrqHiyO3kDrQpjgdy4OfTqlLo8G+m5S2kWAlLA6q5prcNURkslfk98xZpnXRonzRWTQmYKMwfJLbwbISzsblZomtjkcfo9TSKxfVW/wDZnYM+shGdMoS6S2LGbNjy3C1zcQrXyL4rBV8QtiuiZv4NpZLiUs9KzDxh54ld9ze7XGzOWBgMNgM0wFgMNgsASF4IBzUMigIjIhDIodBC4IdBFiGQQ1ICKGII6/A607ZT7xO1PFq54/VF7nG4DNK6dfdrY26iUtJqPUWeSfVHDvxXr+P8Tr64W18lscxf+xxNVo79LLmqk5Q7NHchqYyj5KcqvPLnqn0MWa6vPLXXw2bZf+JW92zr38Pou3hJJvwYbeDXLLrakjOVfDFPWub3kwHqM/I+XC9THrUD/h966wx9weGd2NgvL8Gr8o4/XKKKddcf18z+EFZuWWPqL9Nd22NlF9o/yDysgpRS6INYIo46hLL+lZApJvosfcOMVnGXJ+EHXpp2P3dPCNkKYUrfBQivTOX1bLwjXXp64rMsYX8GTUa6FS2/g5eo19+p9ucR8IqOvq+L1adcmnSlPz2RxbLr9bb/AFJyk/HZAwqbeFu/J0tFpUnj+WDCtPolWuZrMvLNHpZWMG6utTlhL2oG3DnhdDKs1eninnH2Kt2RsUcRyYmvWuUV0yMCXXKSz1bBnKOnpc5dTbqGoxUY7HnOLar1LPSi9o9SyBGq1krZvD2/5ERrnN7toOhQUstZNsbK3sk0a9IyKiUVmMpfuhlUW3jPLL46GxZRHFZzggyWUTX9SP1LrjuLsWY+pHZxeTpTjjEl0Zmtp5OfHRiUNUlbp4WLrjDFJlcPmlpLYPs8oGUs4wBrqSe/YZ6yg/av3ERlzJRj0Q6KhH6lkAvzE5dZSX2YcLo9JOX8hVrTzeHFIKelr/TJxfbO6AZBQs6WNDHVdBZhLmXwYLK7KJe5befI2nVTg+oGj13H64J/tuFCdd2ye/8Aawo3QvWJpZBlp45zB4YzQyvRpy29ptr0dkF5FabVOGI3RUkdbTuuyOapfsJC0iiyVWI2LY2wSkk4sv087SiSNXJ9H8GozTMKaxJDIxwuufkCLfdBe5GkMi8o5vG9Q6KqsbNzTN+/2M+p0kNXZXK36YPOPIQOhpUFZc1h2bnk9fZ6mtun2cmev19y02isn0xHCPESbk231Zvly+S/oLBYTBaNuIWVgPBMABggfKQK5MRkRUR0AHQHQEwHxLGTYhoCLCW+yKjZooXeqrKtuVnp+SOqo9OzHO1uJ4boo1aKLkt2sgVzxfNxedjj3der45jBfpdRpZPCbj5Efm5L2z9r+TtQ19cpOq7CfyFbo9NfHPLGWTjn8dt/rgylKS9k+V/AqVmtr+mzP2OrbwatNuEpR/czy4W1/wCNJDKeGFcU10Os2/ugLOKX2L3pGufCs/8AjP8Aczz4eovHM2FY5ahye+CK2T6J/sjdXw/D3aX7Dvy9cFvMg58Yzk+n8mujSSlvJ4LdtNXTdgy4hhbIK1rS0x3b3Ast0tCzKWcdjlajXWPvgwTslN7sqOzdxlfTTHC8mSzWzmm2+phjHu+g6qmVz8RXVgV77pbZY70lXHGfd4QbkoLkrWPkGtc1iX8ijTRVywW27OjXHkrUF1lvIzUpZy+iNMc8ue8iRWinauUv2ERXNMbJ4oUV3ZVKwpSCA1MuWvC6i9LDljKx9tkDc3ZZjshtjVVMY+E5MT2fpzuIaj067J5+lYX3PLOUpzb6tvLOpxe2TVWnTzKXukZ6NMoL3bs0SaTVKMfrTf2NunVNsklmL+Qo1x/tRapjnK2ZLWvrW2OmTWU9wJVNPD7A0SnB9Wxzdk7Pp2IZQSg1TnHRgautpST7I2xbwlKCaE6zNlbUYe57EMcbT5VN0s4Sf8jNNU5LMi9XWtNXCrt9UvliI6myW1cUkjbLoxhgYo1tdXkwUa3E1G7bPc6lcYWww0k+zXczfAVyY3i9zRTZzx5ZdRE4yrlhhwWJJgMnJwi4S3g/JlksS2Ntq54Z7mOSAKEmmaq7JeTLDEuuw6EXHuBrjZzbNGivnr90HhGOEnnsa6psaOjpuJTXtmsnQhqoS7YONWoyeVHDNEObokalZsdb1Y46op6iC7nNcZtAqmbfU1pjfLVJvERlXNjmkzPRp8YbNFs1Cpvwizyl8OF+I9W58lEXiKeX8nBZ0+Mbzrl/csnNwdOfMebv2EvASRaiaYBgtINRL5QF4IMwQK4ER0BUB0CFOgOiKghsSsmI6XCNIr7lZZ9EWv3ZzD0XC48uh08l3tyydXI3xNru6j26afL2iec4RqnZN1S6p9T00488HF90ea0uldGo1FbXuTyjnvh2s/1HQ1WhhqFnpLs0YfyWuof9OxuP3NGl18+ZwnHODerE98HLxXb05a/xHo5/yg1DVP65nQlbhbYM85SZQizFUczkYLdck8Rjk1XVTt+wNXDot+5ogwfmLrdoobHTWyjzTeEb7p6TQQzPeXZdzi63ilt7aguSHhDDUvhXFvmn+xksuSXsQpOU33ZJxcepMUqTbeXuSMd8stLO42imV9qhFff4KD0umeom2/bXHqzRZNKHLBYgunyOsUYwVNW0I/U/LMsvdPC6ICmuWKb6sZp/rbF2vM8eNg6HhkWNkZb4Ns9tvCOdCXvX3N1ksya+RErQvpS8f/BM8umbFwnmLfz/AOxJyzU4+CoVXHGZMVr7OkO82l+wyyWXGMe7QjWtPWxj/bkkVxdRHn1llj+y+wUUR72SflhxiV1k8IkPqqc30Do0/M8vodGmlRwRSKtN5NUaEl0HwrGKJUZXSvAPop9jY4lcoHM1fCq9Ssv6uxzruGfl6sRhKcuu3Q9Klgq2tSiwlmvB6hYbTjyvwdLh13Ppk294dSca0bjOc1nPXfuL4TH/AKeee7F9Of7di2CsqTW4hLCwHppNVYZU1uYjQ63tgz2rDY6H1AanZmohEXhmrTxlY8Re/gyxjzdAkp1vKygNrhOL3i0WrJR7iq+I2wWJYkvlD1xKtr3Uxz9gCjqpx6SNNWqunjDX8Gb8/T2pjn7EfEJ9K4Rj9kEdilzcczePuPjZDOIyyzgQt1Nry5NI3aKE3Lq/3NRK7KnsJ1ljjp5R/U1uPqiowy+xztTJ7KzaU5ZfwkbYrlcXf9WqK/TEwJGjV2evqZSXTohaidZ4jy9XapRLUQkgsFQPKUwwGALIU+pAOHBDoICER8ERqjihiBigisrPQ8Ln6nCGo7yqlnB543cK1z0WpzL/AC57SRnqbGvjudPaV2KdUJrdNGXV6T1LI6il4sjt/wByL0klCOIPmqlvFrsacpLY5vVjjW6RWScop12d0ZrI6up4WZI7s0mJlhGbyuuH6+oT3ix1X5u36K39zp5S3wv4BldY1hS5V8ExdJ/J2JJ3Xcq7pGTV61URdejjmXectzXKDafNJsz+gpZbWIruVHGlRbdJzsk5Pu2Z7a1zckN2b9dqVKfoUL7tDdLo1CKclmT3IrFXQqaXOZgtk7LXj9jpcWt5Wq47GTTUe1zkSqS4ckd92+h09PR+XoSX+ZPq/CEaOpX6lzkvZWbLbMOUvAGW5qL5F0XUXCOyl5ZU22v9UmFN8qwu0SBEpLn+7Cg8NMx32cmrpXZ5NTe32ZQ9S9qfyaVY5LL6mNfQPhL2oyrXTJ8kt+jLhZ9ayKrlhteULjJ8zaKGRnm2LfZibp8+uk14ZM7CYP8A6pfKEGXG7+5q09XM8sUoZta+ToVR5YorqZXFLBqrj0M8DVUA6IRSCQRMEwWWEC0U+gZTQVzeJ0Rt0001nC2PO8PfJGcT118OeuS8o8jj0NU4td8Bjp0q8qL+5b3wXH6CkZQyuPRitZ9a+xrqhlGbXR9xUZoNp5RrrlGaxJGSDxIY00uaHRdSLDZ1Qb2KjXFdVkqFifUYpRAuNVfg0011rG2WZedDK7uV5GmOnVS542wjpURhCOF1OPTq5Swsm+uz2rfdm5WbG9WKUlFfucXjrktRDD2aOvp4tRy+rOJxmfPreVfoWDrz7cfk9OckGkWkEkdHnUkQtgtgU2KkwpMVJhFN7kAb3IBggh0UDFDERq1aLKIVlZZSCSA6HD+IXaeSgnmPg9PprnbUpNbni4bPJ63hNsL9MpR6x2aOfXOeY7/H3b4rU2LayPcWnsilFv8ASYdmZx8E9JmvlS7BKKWG1v2Ax+jnLeyRw+NcRUf+nof3aOvxXVqqqUIvGFueV0tMtXqnLdtszVdDhOi536k/u2zpzaipS8LYbGpafT8q7IzWZnp213KOBOLv1UpvomM1UuSlQj9UnhDFHllhfdiq4+vrv9MDDbVTBabSxj+qW7M9kstrx1HXWc1k5/pjsjFOXtx3kAdUedzsfRbIC17s01x5dM0Y75cik32RIOXrJ88YWx/RNo6FM1ZWpLujmUYsjbTn6vdH7juH2tRdcusWbHSreYNd0MreYtd0JWz5l0fUYnytPyZDlPGAobyf2FPAyp4sXyQG17V9jDZLk1SfhI6KW32OdrY8uoT8oRqNSh/X5l0luakjJpJ80En1XQ1o03DK1lmuC2M9KNcVsRBINAoJFFkIQIhRZQFNHl+NU+lqZNL5PUnM4xpfWp5kt11CWOZo7FbQvKH1rc5fDrfTtdcvsdaG0zN9st9Fexh4jFqWcHT0/wBKEa+rnrbXVGmXGxsmg4OS3iyscsnF9C1mD+CNLajJ/wBjDjBv9SZE4vtktRjn27fBBbgl+pESLUfkfp+SMszwwL01c5S9qOzpKeXGd2ZKrot8sInX0teIqUzcZtMnJUadzl2R5a2TttlN9ZPJ6LXT548vY4uojy7Qjsd+Y83yX9M6RGToUaclNi5MKTFyYQMmKkw2AygCBYIBliGgIhEURZSZYRaCRSCXQAkb+Ga2Wit5t3CX1IwINMLLnl62nimnsSatSfiRrrujYsxaa+DyWh00tXeoR6d34PWUUwoqjCKwkY6kjvx1ejUl1aF3z5ISm+qWwU54i2zLq23SvDOddY85xu98qhn3Te/2N/AdGqNK9Tat39JyZ1y4hxlUxWVnf4R6u6MY1xqjtGKxgzGnOlZKdV05d+hcF/0afwyP312RQyqOdGl+wHDftjKT+4vRLkola+sssPXv065rzsKb5dNGPlIw0C6eIRgu+7EKSdsU/Jd0v6nwkYZX41ijn6V/uUdb1Vzul9ZR5l/Ji1uVXb9icUt9CWl1MN1ui9S43Vc0HmM4iDjcsoNSjs10GSliyOogtv1JDXXmItQlB7bp9UaasdLT2qWO6Zo5fHQ5lLUWksx+DfVctot4fYzWTsZQcH0fguMOdZj/AAUk4tpkDoXxWqdMtm0nH5FcSq5oxml9IjXRearY9Vtk10XLUVck9pY3+SZnlqMuje50ImKNMqLcNPl7G2HRGm41Uo0LoZ6jQioNMJAoMCEIQIhCmRAQC2HPFp9BhMAeJ11MtNrppdnlHS0lyurjLv3HfiPTcvp6iK6PDOZBy001OG9ctxWP29FTYuT7Fqak8S6PYwae9N5T2Y/n92UNZwjWaV1yyvpfRmaL5XiR2YyhfXySxk5+p0rreH07MYsLUE17QcMqMZReOprpq9TqmmZVl3DrhKcklk6FfDHPdySXyb9Pp9Jpse9SkWQ1XDtB6cVZb1fRHR+lb7fBnlrK4r+mss53FOKf4bo3qr3vLaEfLNz+MXxG66fNLHZAxhF9Ujx8Pxlu3OjO/Y1Vfi/SyxzRlF/KPRLI8nUt8vR2aSuxdNzBqNFZVlxWUZ6fxJp7OlkToafitF23Mty+HPK5UhbO5doqdSuap4kcu/S20vE4vHkGsrRXKM5QlAKTyEH8nwQDkoIBMJMijQSAQSCDRaYJYUaYSBiNrjmSXyEel4FplVpvUa909zdZavzNdK6vdhaeKr0sEu0UYNPJ2cZbfRRwjj1ba9fMkjXrZtQwvIvWtV6XOekQdVZ/Vx8k4um+HNR6tYMtuX+GdP8A5+usW8m1FvwdRTdtUrMNb9PBVFUdNw6FUf7cMKqOdNL7sueE3yw0PNtkPKH6N5jZW+zM1ft1OfI+P9HU83aRiNOHxtck0vLM9z3gu3Kjo/iOn+nXaunNhnLtf0PzBEsUix7t/JxZTk75T75ydS+WP3TOd6TfYsajoaScNdpZaO54nnNbYvSxs0tj096aXbwIhVJNSTw10aNMrbbkvU3a7hcHKCjJ43T6FxqT7ETytx1RG4VKjbZAquWMNZSNyWUF6ax0BjJXqLaP9S/3NVfEdPbiNqcJeWtgZVJ9hctNGS6DIn1blXC2txTUovuhcaHW8P8AZoz6eE6XiL9rOgptrdZJ5JMC5TUe0l8hU5b3RaSyMrSTKrVVDYckLrawhvMiotFgcxOcBhWQeYrmXdhBlpGeeohH9SQP5vb2vm/bAT7RrLSMdWt5niUUv3NdVkLOjQXSOI6dX6OcGs7ZPMaX6Z6exbwe2fB7Jrbc8rxfTvR671YLbr+wZpMoT08lKP0mmm9TS33CqlC6vD3i1sxL0zhLMWZRurk87PDN9dlWoh6V3tl2ZzKMtYl1RoypLlls/JZUsBqNNbpbN480ezRcdVJLCSTG06ydTVdq54eGanpdLqVzU2KEvDH/AIMLvvs/XsHXVdN7PJoXDbYy/S4/DOno4VUNRntJ9MiS02E6Hh0sqdr28Hi/x7r1fxOOkrf9OhdF5Po/q1NtKcW12TPkH4jnzcd1baa9/c7cyRy6rmEIQ0wKMpR6No00a+6qSamzIQqPXcJ/Ebi1GyR6mjXUauGHh5PlUZOLymdLQcVt08knLYsrHXEr3mo0KXvq3XgyqvDw0VwrjEb4pSksnUtphdHnhszTnljnchB7rxsyEHl0EmLTCQUxMIBBJZANBpFQiOhDIEjE0UQ/qQ+6KhD4NNVeJJ/II9RJ40/7HN0O3EJPzk2zlmlY6OJhqk671PBz/r0X1F6nP5lfc22R9fRYW7TM+qhzONi8jtDYuadMuuco55ldfZdr9qj4H6Zf0WKvUHKbT3T3Q3Sf5LNz8XK/k59lXLc/uTUNOvrujXfFczZz9RFt4OVdidXJavhs4frj2+x5+MnKHK+sTs3QlVHmW25x9RFV6vmj9LW/wPasepnyyj8piY2wC4jBzrjOL2T3MK8ZX/Jfay46MJxfQNYOfHmi9nj4fQbDUedn3TJjX2jYNqe5lVu3M+nkfFtNZ77huWN0dw10FVyTQ1dCKmCLqWRAWkhkQExkXsAaLTwApbiL9ZXQ2nu8dAjoRswiS1EYr3SS/c89bxO2xvkeI+TFPWTk2otyflsuMXt6WziVMHhScn8ALiq6tpfHVnl3dKT3k8Lx0Dg7Z+2uP7lZ+1r0VnF0u5g1HGcv6m/hGWrQ829zcvjsa6qK6vprS+cE8LlrM+Iam3/Lqml9jXRqdTyJPTzk/wDU8I0VzhB5ccmmGog3tEafRjV+vk/bRBL4Rrq1GrrxzUSXyka65RazFYC5/kL9YPSa53Zi08rq8YFcUp/MU5X1RGKSTzjfyTm5tmFxwaoy0000m6ZP/wDFm6M0niXR9GDPFGqlXP6Jlzpdft6xe8WRgTTree3kYmrI47gVttOEl+zKVaUsczj/AOwwMVcls90MjRno+UkXOK9y5vldyndh45Wn9ghyUq1hWTlL7i6dQ6ZWW2SeOiy8mPU6xQXLKbWey2Mep1ErKeSqPtKsmuvRx6hXYW3zg4X480tTnRxCrGbfbPBkaae+zN3Fc6n8KNy3dU00zXN8p3PDyCIVFlnV50IQgEIQgGzQ6yentTTeD3nBuIx1FMd9z5wup1+D696a1JvY3GOo+iuMZPJDHp9XCymMs9SGscseSQaKisjIxMtLihsItlwh8Giuv4AqFZorrCrrNNdYMDXWPhDAcKx0YBTdPc4JxlvFknZWp8reM9ClH4LcU1hpNGcanX6p9VkeRxl0QvMZXQurlvHZ/IH2AUVGTlF4z1RPqv3b7q1bB2V7vui9MmtPh7NsyU3TjPEX17G6MX38EsyY1zftdLnhywYbY+/BpvtVc456yeBV8cWnKu8LtqThlrKx0PIca5rU7tJPaDcLIY3R7hxzSeC45Gej4jY4NxjZu/kYsYK9b/RlVdHMX47GPmw8c2Y/IqyznnL3KMV3FSnUn1lIuGtanjZSwEp7b/yYvVq/tYcbau0mhg21Xyg8SWxuoujKPK3t2OTGxtbNTQULY5wm0/DGDu13cssc2cHQqknBM8xXbKMk3J7He0dvNRF56mbG+emtogTKwR0DkLm2KBlLlQQN2oVUG327HBvtldY2902a9dNy2XyZY1SktlhLqzUcurvgqcm/at8dvACa/XJL4RLpKK3lyw/3Zleof01RS+erKzmOhC2uCyqnJ9uboXLXzX6oQ/g5c5WbepJpPyJc49stjF+2OtLiL76iX/pQH+JrvO9/+vByeffoa9Jw7W63T3ajT089VKzOWVt3L9U+9bo8WjFddRn/AO4v/gr/ABy+D9k5Y/1JMy8K0T4jqJVOfI1HKK1+hnor5VSalhJ5Qw+1dzRfiaX03UqT8p4Otp+KS1Mkq9PLL+TzHCdA5tW2LC7fJ63h1HJHKWDNdOdbFF4Weoca2NhXnqN5UkRpzuJaR2088V74b48oxaXVLl9K7p2Z2ZywcbXadRm7IfS+vwGbP2fKmXWElKPZhx/qLlsjh9mc+jVWUd8x8G+rUVXLwzPplXoXVybqk8HP1eqnKbrn6kO2Ym3V6qrT1Nu3ll2POLWTlfl2ys3zh9CwxpWnxak5OTb6vqdSuuMI8qRyqdZzXcso4Z1anmGWV1kc3iEVG+PKup0eJ0eh+EbcrdxTf8meymV+uqglnMv/AHOn+MlHSfht1N+6bUTXPty7vh82TwFkAtPc6OAiyiFRZCiwiDIScWnkWWWI7ml4rOulR5nsQ4mX5Ia1Pq9TGBorrCrr+DTXWRgNdRprqChXg0QgAMKzRGBIxGxQEjEPGERIvsBaKbKTKbKI2C2U5DKaJWvL2iGfZmiq5puyX0xNvNiLk9kSNa5VBbRXUwcQ1HM/Rre36mcurbfD0cyczyx3XPU6rnT9kXsdDU4fLJeDNpdMnu9o/wDJotWcJecDrjIcfJ9uj6cOGJd+h5P8a8MnZpfWhFuVbzt3idj8RcQ/wrR0Wr/zFlfHc3Qt0/E9DGyOJwnH/wDqMOr43iOMtM06PRS1cZyi1GMGk/3Oz+Ifw/PRaiVlC/pyecHN4bqZ6C5y5cxltKEtk/s/JTGbW6ZaWUVly5kI5ZcuVHY9VOWn1Fb1Fddc5RX0Wx2OfLU6fVQda0tVD8xW7N8+bjPVvM1w1JfZ/A2Nufq3+RsuHWuft5eXy2M4jCqunT111xjZCOJyj+pi8WJO4WpyW6eUdPQazlUU3jfocehyz/pZorTUngxXWPZVy9SKl5DksCuHwb0tbfg0yjzM5u0pHcRqZdEaZRwzJf8AWBnsWewmx+zlWxomtheoomtMpw3kypXEvrlZqeTO72+x1NBw6rl5sZw+rM1dbhW16LlbzZ5+Y36TUTrhyzql+zRrXGw7jP4fjZGi/wDMRqh9Nlkvph4b/wCDJD8LaNtN8c0mH4a/+Tqf4240uqWlndBrlcZLZo83fw7nvc9PTZVF78recGpYz9avivAlpJQej1K1kZdeSP0lVQ1Og4fbVz3Rd/WEHtj5Nen018I4cpP/ALpD1pLbPqlyrxHY3e+J6Znx932wcIUtBZK+yPLJxxGL3f8ABo9CzX6j1Lk1DOcPqzo0cPit8Zfl7s6On0WcbHG9PRz8eM+j0bk4pRwl2O9TTGuKSRVFMao7Lcbky6YJYSBnPYpyFyY0wu2RkteVg0WMyWPcGMVsOWWY9DO208xymbp7mS5cqbXYrF5c7XSUU3JtyfkzaVLLbQOpsdtrbGULYqSDnFxujNeTvabenJxow52kduqKhSkRqNvB1F8Qi2s4POfjziy1nEFpKpZro647s6luvXDtNdqM+7l5Y/dnhLbJW2ysm8yk8tm+HH5L5AQhDbkJdCykQqLLKIBZCmykwgyFEKPoNdRohWFCGB0YlclRiNjEpINAEtg0AmXkA8lNg5BbAJyKUln3dAGwWysWtKt09a5nBywaqNVTOPO8RS6JnLKF51ufJn6b9TrnJONTa8sVp9O5+6a2/wCStNp3PE5rEey8m5bIs5kZvV69qwlhLsFGHNv8g98hymqtPKb6Lcnfp0+P8ni//qFqVKFVKfSX/sJ/BnErK9LOnPMoyzj4OR+KtU9TxDGc8qK/C9/pa1wb+pHDP8vRPye34jbp9Xpnvhrs0eR1VMIyfKj0U+5g1FMZZyjGu/1cBJ1t8uY/9rwLnCM95LfzjDOpZp45Ey08S6z9WH001jmbX3YM6U1hpfwb40RQXpRL9qk5jlKiS2jHA2uhqSybJVkhHM0vkmrj0+hhjR1/9o6EcsrSxxpa18D6o7kb/TJdDLZiuqyzp2pc4iytN5IRgdWwUIZjySWU+nwafTCVIVht4fn3RAjpJp7RZ2aoYWGPiorsimOLHQWy6QY+HCrXu0kdmLWA+YLjlQ4VJfVJGiHDqodd2bWwGyLIVHTwj2Q1JRWyKyU2RqQXMU5A5IDEbKZAZMBVr2MdnU02syze4ZDgTdDMGOQjWW+lS2urKjzdq5bGvDH0PKFWpym2OohhGq5xr0yzajrNtqKRztNBrfudzTUKGms1Vq9tcGyZrVuR5P8AE2ofrQ0qe0d5fc4I/W3vU6u25vPNJsQdZMeW3ahCFlRCyiIAiFF9ioqRRGygoskKIQfVEgkQmTbiIiYGScwQzmwTmF8xXMAzmKbA5iZKzaLJRRG8bvoaZWatLp+bE5r29l5B0umc2rLViPZG8KhRUpKK3EWamMe5RpW5i45qo0aPk5sZ3Zk1XGKtPFtyWTxvHuOz1k5Vwl7Xs2cfk8+Ho+KZ5rja296jVWWv9T2D4dZ6Osrn8mUZU8STJZ4al8veqxTrjLyjPa8ieH3eppI77pBTe556908wmcciZRZoYDQMZ+XcrA5xAkjTFhM+hNLHmuh9yWdBugjzamtfIpHqKliuK+A4vGSlskVkzK3Z4Jm/dkGW6LkA8lYFDfZmiMUZo7bj4S2Cm8pYKkXkjci08BKQGSZC4ZkpsHJYEyQhRFQhCFKpgSewbFT6BCLX1M8uo21iGVlaMGvfNsbexlsgp2b9glYFpnhPlyOqok3ujW9tkadLXHmUphPR3D+HubUpLCA/F2vhoOEPR1v+pbthdkdaeso0eklbNpRij5nxbiE+Ja6eom9m/avCOnMcO+t8MRCENuaFlFoIhEQsIhGyFMqoyiEIIQhAPqrZTYLkC5G3AXMTmFtkyAeS8gJhIrOiLKLS5mkupU9+lpNvCF3xdK55z93VQG6nU16Grs7H/sea13ErLrNpfuc+uv49Px/F48vYcP1a1NW7xNdUaZzUU2eQ4Zr5KSnF4nHqvKOnxLisY0c0XjK6GuemO+Mpuv4lCtPc85reNtZ5WcriHEp2SeJHJstlLqyWk5atXr7LpNuT/kxOTb6lZIZdFhReAUWVHoeCX5g4NnSk9zzXCr/S1Ec9Geknukzh1PL1/HdislMHJMmXRGhUxoE1sVLGW17mrhC5tZBeNzFdL3G/gGHqpvwsFZnt6RAyaQT2QpvLMOtvhXcrBZDbmF7IqE98Fz+ky8/LNAb1INPJnhLKHwZmukoiy8EwRpEXgiLKVRCymE1CiFBFMVYxjewiyQRnsFMZLdgY3KgX9Jlm3HLNNjxky2PIRVdr5sscruX3SeEjJOyFUXKclFeTh8S4nLUZqqbjV3fk1zNc++pDeN8Xs1tjphJqmDxt+o5DIUzpHnQhRCgi0CWgLRZRAiFEIBCEIBCEIB9NcimwMkybcBZCQCDRWaJBIFBRWXhFQcK52PEFkrU6qvQ1tL3WtdfBz/xFxv8AwzTrT6d4ul1a7HlVx/Vc3vakvk5Xq16uOJz5dLW62zU2NtvBzrJvm2DhrIaqWy5ZeBVixIw7G6bUSptUk/ua+I2+vpeeD+6OaOps2cJfSy+mbNjkWTzJix2qqdVrXYSac1FkIBC8lEKDrk4TTTPV6G1ajSRkuqW55E7HAtWoXelN7S6GOo6fHcrry2ByMvXLIQ2cnp0xSBm9gM4Kk9hiax3P3nT4BtHn/ukcy5Pc28HuUK+VPePYrM9vV2rYXVHmtSLq1NV1SeUngbVbp6U5TnFP5JI1b4K1cFW2ZY27iddxT1ZtxilHycq3jEK5b2R+xWXfTUkzDe+WRhp4z60G4tYWwUL5aizYLrq0S5oJmmD3M2mhhJGpLcjUp66EJFe0vBHTVFl4JgJapg5LYJUQpsjBbAGTM83ljZsU1kIXgmElljOUXa/awlrn8Q1VdKjnbPU5eo4tRWmo5nL4FcZu5rXFdjiPqbnOuPXdnpo1est1UsyeI9oozZIyjo422oUQgEIQgELKLQFkIiBEIQgEIQgEIQgH0fISAQaOjziXUNAIvJUFkbp3m37LJncjRw551GPgX0c+3gOPWzt4rdKedpYOdjJ0vxCl/i+oS6c5zm+WJxexITlXJOLw0dGFyvhzfqXU5mcjKbHXNPt3BK3smcE2aTXRlMNK1kVbp1P9UepzToNvDj2aME1iTRWOoohCBlCEIBAqpuuxST3TyCQK9RTqVqdPGWd11Kzk4/DdRyS5W9mdbJysx35uwRTZCMjZc1kzpSrt563v3RpkLkVD6tf8uLHS1Ln1lkw4jLaSyRe3CXQgvURsu9qlyozrRQj1Tk/k6MKZTxhdTXVo4rebyy6Zrn6bRSeEkoxR2NJp41RxFb+S4QS2Roh2SIsmNFSwjRXHLE1vYfBpBTsbEwVkmRi6hGWUwaBgsJsBsiqbFyYUmLkwAe7CUS4xGJYWQFT2WDDr7VVS2bJy6s87xzVfoTLGOq490vVssm/k5zN0XnbyYprEmvDOkcOgsoshphRCEAhCEAhZRYFohCBEIQgEIQgEIWQD6Mi8i8l8x0eUfMRyFOYLmaZtMcjVwyWdS/hHOczbwl/9TL/tF9Lxf9R4njS5+Kah/wCtnNs6nR4m86+9/wCtnNn9Rwj20KDxtkAtMqRt0c+aLg+q6D2jnVzdc1JdjpSfNWpruRuETM1y3yaJMVNZQKzFkfUormshCgLKLIBcJcsk0dnS3K2peUcU0aO705rwZsb5uV24SGroZYyzhroPhLY5u4msi5QTDnNRWW9gVOL35lgKCNEnPCDdE0sOL+4Uba4vPMm/uNjrovZ/yhq4fp24KKa3NiUu6x9zmS13L9LSfnuJlq3J72N/uNWR3IxX9yGRwjz8dU10s/3H18QnB7yTXyQx3oTGxmcWHFa/1LH7miHEKH/4iQR1lYEpnJXE9Mnh2x/k106iFqzCSaKNylkjYqLYaWQqMBjGgJIilSKSCaIkBcYg2S7ByeEZrrVCMpS6IrNZOI6mOnok29zx+qvd1jk/Js4vrnqLXFP2o5bZqRy6plcvchGoWLpfO4cH7iX/AFJ/Bqe2L6Z8YIG1kA0xFEIQKhCECIi0RF4AhCECIQhaWXsBQ2qidr9q28j6NJtz27Lx5NXOox5YrCXZE1qclw0VSjiTyyFufyQjWPWuRTkKcweY9D59pjmC5C3ImSsjybuFS5bZv/QzAjdofZXfPxBk69N/FP8AUeJ1ss6q5/6mYZfUzVe+a2b8syS6nCPbVFlEKys3aC3mUqpdH0MIVcnXNSXVEbla7YuMmhTNN7VkY2R7mYNFWRw8izRNc0RBXOqIQgRCyiAWRPDIUFdTQ3865JPfsbYvDwcKqx1zTR1qbVZBSOfUdeK02QVtbi+5ilpLIt77eTbCXYKcW0R0jnqr+S1TLOU2PlHD3RaxjqTWsJ9D5YcdPHxn7jVgvm+QuKhp4NfSM/Jx/tY2hrq9zXK2EI5aRBz3ooP9MjXpOAq/3Scq4eWPo57mpcijE6UXZOKi3suyKjm3/h3RvH5e+affO50eH8PhpI8sW38s01UpdjVCGCpJgYwGcoaiRoiltASiNYuctg0VLYHOCSkIstSWWyM2rtsWG2zzfGuJ8zdVb+4zi/FuVOqp7nnJyc5OUnls1IxaqUs9eoDZbKNOYq1mSJf9SRFLk+4ttt5fVmoz1UFvqM7AS6mqxAkIQjSELIEWiEIEQhYymmVstlt5ChhBzlyxWTdVVDTrmkuaf/BFyULEd5eRTm28sy1IbKxyeWA54QtzwLcirpjnuQRzELia9i5FZ+ReQkd3zhINIGKGxQMXFGvT7aXU/wDYzMkMhPl0+q/+2Y7vh2+Kf6eJt+pmZ9TTZ1ZmfU5R6qohCFZWQhOwWNWmnzQcH+wMtmJrlyTTNNqzhruRuAT3E2x5ZvwNJauatPuglZyEIVhCEIBZCEAo16O705pN7MyFptErUuO8vI1S2MGhvVkeST3Rswc3eXVyafVGeUZZ2NCi2Pqo5nuRWJQsI4TXY7FelWBi0UX2C+XFrnapJczSOppa6ptN+5/I18Pi30wadNo1W9gHVVLbCwa66+mxK6zTCIVcIoYkRIsIsFkbFzswgJOWDNOZVlncw6nVRgnuFNuvUM5ZweKcVwnCD3M/EeJ5zGDONKbm8yeWWRztSc3OTcnlsEhRplCs5eI7sizLZdPIe1ccLqakYvX8DKKit92AvkuTyDk05rzkGSyXksBZRb6lEaWiIhaAhZDZpdKnH1btodl5BJodNpHNc9nth/yOnaorkrWEVfqHN4Wy8GcjeCbBbI2BKQLVNg5IQ1IxahCyFZesSGRRUUMijo8mLihiQKDjFt7Imri0LtsUdJq/PIPdM8ZUWzFxGi6nRXWWR5VJbGO/Tt8Xt5WzozO+pos6MzMy71CEIGULRRYF9zTB89PyjKP0z3cfJG4gUd04+SpLDKi8NBohrDwyh1692V3Elc0IQgRCEIBCEIFHVOVc1KLxg7lFitrUu/c4B0dBbiO5nqN8Xy60EaqtsGOqSbya4M5uzdS10N1cFg5dM8SR16JKUAoXBIOEUHKOSR2CmwQ1CosPm2AZkpywLc0KnaEMnYZbbkk8sVfqFBbs4vEOJqCeHuC3GvWa6MIvc85ruIyubjB4Rn1OrnfJ5bwZjWMWrby8sogddcrJYijUmsW57AHGmUt5dPB0aeHSUeZxyy7KY1LNjR0nOON+TfEYHDlXtQizYbfqE21DoZZSyyUim9yiEI0tBN4RSBbyVE7kKLIqLcJFI06Wj1Jc0toLqwD0mmTXq27QX+4d1zse20ey8Evu5/bHaC2SEEbiEIBKRUtxJSAJkhWNQiIWiohCEA9kkHgdHS2PohkeH3S7pfLNvMTVW7JYR1NPpYwWZdQdNp1p1u035MfEuKw08XFSXMD36btXxDS8OolZa1t0j5PJ63i9/FKrpz9ta+mKMPEtXLUtuUslaR50Fy8YMdV3+PmRjs+lmZ9TRPozOzLrUIQgZQhCAWg6ZctiFhLZkajVasMWOn7q4yQkNJYuav7Gc1RWU15M0lhtFZqiEIGUIQgEIQgBQg5ySRvhpnU+VSzlZMlKwsnQ0dnqaquL+xbJ9V529j012HyyeGdKmeVg5ut07qnzxQWm1HZvc4vR6dmHU6WkswsM5NFqkdCndZTI06SlsRSwZY2NBO1sDUpoqVuDHK7l6szX66EFvLAG+d6Xcw6rXwrTzI4+s4v1UHk41+qsueZSZcZvTpa3i0ptqDOTZZKyWZPIL3KNYxahaWQ6qpWSSimdrQ8IWVK1fsb55tc+/knLnaTQWaiSwnjyeg0fC4UxTa38s1xjRo6uayUYRS6HB4rx+VuatJ7Yf3eTtk5ea9dd1q4nxKnSRddWJTPNX6my+TlN/sLlKUm3Jttgs53rXXnmRGUQoy2stFE7AW2CQgECRQUIuUkl1YDKa3ZLC6d2aZyUY8kdootKNNSiur6sS2RuKZCZBbBbipMBsj3Iac7dURFlYAssEsqLIQgH1JyhBdkZ7OIU19ZI89quJ2WN4k8HNuvsfWTO2PLI7nEOOxjFxq3Z5jVauzUWc0myrJNvdiWssxY7SSKbbNui30eoXwY+U16F/wBDUL/SY6mR04vlls+lmY0z+lmYxG+kIQhWUIQgELKLCxsofNS13Qt7Mmklibj5CtWJEbDHZoXcsTYZL1mKkglZyEIVhCEIBCELAfD6EO0M+TWxbM9b9pbbhZCS8l6mw4udPQ6uKlDJxrM1zyjq0Xxv06y911MOqq3Zwnh6uvPlKNc4Pc6mn4rFLdnnnFplZaNWMa9dHiUJrqiT4hCKzzI8mrZrpJkds5dZNk+q/Z3NTxeKyoPJyr9ZZc3l7GbPkmS4mrbBIT47lZWP02mldNJJhabSSteWsI7Faq0teW0sHXnj91x7+TPEM0ejroS2y/LL1fFatHFqOJTOTreLTm3Ch4Xk5rzJ5k22+7N3r9RynG+ej9Zr79ZPNkny+DIwgWYrpFAsspmW1FlFgWCWQCiELAtI2U1qqPNL6mDpaNvUmtuyDtnlkakBOWWA2W2C2FU2CWQ1I5WqJgLBOUuJocEaD5SsDDQNFBtAtEa1CFEKO40ItNAi49VePlkl1BZcupRxrtFNjtI8V3/MRDGaZ7W/9pjv06cewPozO+o99GIfUw6dKIQgZQhCAQsosA6pctkX8mq5Z3XcxdzbD30J+CNwkJrmqaKaLre+PIVmKCmuWbXyCVzQhCAWQhQB1ySluNmsxx/ApRzDIyqWfbLqaiX+naa5wWU/ubo2xuj8nMknVLONn1DhNxeUzn1zlduO9h86/cxUqvBohYp9eoc4bZMt5rD6eCsD5LAqTSKzQYKJJ7ZbGU0Stab2iWTaz11ICEZWSxBfudHTaFQXPP8AfIyiqqiPNLGEZNZxF2Nwr2idpzOfbz9d3u5Gm7W16dOMN38HNv1NmolmTePAjOXuEjNurOcWkWyIFsopgstlGa0oovBRGlFkJ2AjKLIBB+lp9WeX9KExi5SSXVnRjFU0qPd9SVqRVs8e1dEZ28lye5UVlpLuGlPpkB9RluE+VdhXc1HPqrQSRSCNOaERC0UXgmCyFQOAXEbjIyFWd2PrpuMnK/BDa6iD6J923sIu6Duwq1bHe+nDn2xT6lF2LcDJxd4jGafpb/2imN0vWz/tMdN8+y30EPqPfQRLqc46VRCEKysosgXEJgstRbIuBNekfNGUTO44QzSy5bl8hYbKOGLW0jTZHcRNYDROoWJ58oUPu3gn4EFc6hCFhE7FF9igGx/ywZfAcfowCzVZaabI2x9Oz6uzKennF+3dGTo9jpaG9W/05v3dizOvFS7z5jPnH3GR1LSwzVfpozg5JYkupzmsM59c/Wu3HyfaGTtcugpy/dkybdLpOWPqWLMuqXgvPNqd9zkrT6X9dvXsjRKyNccvZA33KCeWc622Vj36eDrbOfTz5e7tMv1UrdlshBRDnbrrJJ6WFFgBIAslNkyCyiFFkIqiPoWUwKRGWhul009VfGqC69X4RFP0mgttolqeX+lB4+7MtsOSxo95wuil6Z6PC5cY/wD5PMcX0EtPrHBrGH/sRWTR0/rkg7pZY1+ytJGabyRoPVhx9lbn+yAisvAeqklJQXSK/wByl8M7eSkWRG3ESLKLNIhaKLAIhQUFllQyqGXk1JbC4LCDTOvMxx6q8EJkhpNGnkqfQXGaCck0NTGWxbiZI0WMRJnKu3IGM07x6n/aKGULaz7HPr06c+wPuJl1HS6CWc3SoTBaWRsKG1mWyBhISg2OcIrogQ1gVBIMhQFS6AQeJp/IcugvuErpy33E2IZW+amLAmGiGswkjMa8YkZZLEmhGOlFlFlZTsRbsgUFmQBgSZbYL6mqzFdwoTcJqUeqAZZlp6KSU64WxW00crVR5bXhYOtoHnhtee2Tm8Qwrdjr8k8a5fFc6wOipV1vM/ph/wAmrW6hUV4X1Mrh8eTScz7vJztZb6t8n2WyL+PKfn35KnNzlmTyAWUcXZCEIBZCEAhCEKIWQj2Kim9gV1I92WjLQoRc5KMVlt4SPS8N0S0dG+HbLeT8fBm4RoFVFai1e9/Sn2Xk60Y8zyBentdN8ZfJp/EmlWo0UdXWsyjjOPBllDZtdjpaGxajTS08901jcg8VZLKyZups4hRLTamymXWEsGRBuG6ZL1U/Bmsk3Jt+TTTtbH+DLYmpNPyWM9KRaBRaNOZiICmWVFplgllBIZX1EpjYPcsStCeCOQDZXVlvcjM40fOQbXorrI80YSa+xDP/AErf/OM3MyOxgZBbN654uU8i28kYOTGtxYdTxCfzsLyFB+x/LM9em+VTeEDCDnLCQzk59jTCKhHCMOgIVRrW+7JJlyYuTCqYBbkA2AWSsgZJuDRNi29wuwEupcZ3W7SyzTjwwn1EaSXVD2Roua7me5Yn9zTJCblsmEvoghCFYWHV0bAGxWIFkSgYLDfUBikUWii4rLIrv6KWNBWvk52vlm6WDoU+zR1r4ycxr1dUo+ZHXv1I5fH7tbrP6OhS/wBJxm8s63FJ4pUV3ZyCfJ7xfi9ahCEObohCEAsosoCFkIigugEnkuUuwIIh1eF6HnkrrV7V9Kfc5aO1wbUymnRPdpZi/giuvCOTTy8sBVXkZY9iBcpe1ryXpL3RepdslYzFMfw/QvWahR6RW7AwfirS/wBWvVQXtsWJM830Z7f8U2aSrQLTSnzXR+lLseIn1DUFB75L1VfMvUiuvUVF4HRs/wD8C1kWxaG31L6odO68CU8GnOwWS0wSysryFFN9FkOmEHDme7z0HfC/2GrhUau8n+wxLGyRs0vDrr2m1yR8s7Gl4bTRu480vLM2rjjafh997Xt5Y+WdjScKooxKa55fJuUEuwaRFXGTisLZeEQJRIB4MjIQ7uJb6gkIZrSBw/yyEMVvkyvqOkQhl0hUmKfUhAKAZCBFpFkIbjFUwJEISkM03+YbX0IQw6Qtibfof3IQpWdkIQrmtDl9KIQ1yz0BgPqQhKsQKHUhBFrtT2pil2iYdLvrIZ+SEOnXuOXHqj4s94I5pCGfk/Jr4/xQhCGG0IQgFlEIBZT6EIFUWQgBI6HB/wD9fD7P/ghC/pn9vRw7EubwQhlpf6UdPgknGGpkuqjsQgI8XqbZ3X2TsfNJye5ksRCBsnO4cWQgQeWugu6KT22IQsSloshDTH7Fpm/VSzs3ueo0ujoSUuTL+SEMtOjBJLZBEIQHEZFIhACIQgH/2Q==',
        }));
    print('email'+': '+ user.email);
    print('username'+': '+ user.username);
    print('password'+': '+ user.password);
    print(res.body);
    //
    // value = jsonDecode(res.body);
    // print(value);
    // if(value["status"] != 'error'){
    //   Navigator.push(
    //       context, new MaterialPageRoute(builder: (context) => LoginPage()));
    // }
  }

  User user = User('','','','');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.black, Colors.transparent],
          ).createShader(rect),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backG.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 3,
                            sigmaY: 3,
                          ),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.pink[100].withOpacity(0.4),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.09,
                      left: size.width * 0.55,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: Colors.blueAccent,
                          size: size.width * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: size.height * 0.09,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                controller: TextEditingController(text: user.email),
                                onChanged: (value) {
                                  user.email = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty){
                                    return 'Email is required';
                                  } else if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return null;
                                  }else{
                                    return 'Enter valid email';
                                  }
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                    ),
                                  hintText: 'Enter Email',
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.white)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(color: Colors.red))
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: size.height * 0.09,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                controller: TextEditingController(text: user.username),
                                onChanged: (value) {
                                  user.username = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty){
                                    return 'Username is required';
                                  } else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Icon(
                                        FontAwesomeIcons.userAlt,
                                        color: Colors.white,
                                      ),
                                    ),
                                    hintText: 'Enter Username',
                                    hintStyle: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.white)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.white)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color: Colors.red))),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: size.height * 0.09,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: TextEditingController(text: user.password),
                              onChanged: (value) {
                                user.password = value;
                              },
                              validator: (value) {
                                if (value.isEmpty){
                                  return 'Password is required';
                                } else{
                                  return null;
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Icon(
                                      Icons.vpn_key,
                                      color: Colors.white,
                                    ),
                                  ),
                                  hintText: 'Enter Password',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.white)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide(color: Colors.red))),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            height: 55,
                            width: 340,
                            child: FlatButton(
                                color: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print("ok");
                                    save();
                                  } else {
                                    print("not ok");
                                  }
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 1.5,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
        // image: AssetImage('assets/images/backG.jpg'
      ],
    );
  }
}
