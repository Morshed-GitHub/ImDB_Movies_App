import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learning_mvvm/data/response/status.dart';
import 'package:learning_mvvm/model/movies_ilst_model.dart';
import 'package:learning_mvvm/res/colors.dart';
import 'package:learning_mvvm/res/components/star_rating_bar.dart';
import 'package:learning_mvvm/utils/routes/routes_name.dart';
import 'package:learning_mvvm/utils/utils.dart';
import 'package:learning_mvvm/view%20model/home_view_model.dart';
import 'package:learning_mvvm/view%20model/user_view_model.dart';
import 'package:learning_mvvm/view/movie_info.dart';
import 'package:provider/provider.dart';
import '../res/components/shimmer_loading_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel _homeViewModel = HomeViewModel();
  UserViewModel _userViewModel = UserViewModel();
  late Items movie;
  double _width = 0;

  @override
  void initState() {
    super.initState();
    _homeViewModel.fetchMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: homeAppBar(),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) =>
            _homeViewModel, // Create that object of HomeViewModel, that we want to use
        child: Consumer<HomeViewModel>(builder: (context, value, _) {
          debugPrint(value.apiResponse.status.toString());
          switch (value.apiResponse.status) {
            case Status.LOADING:
              return shimmerLoadingGridView();
            case Status.ERROR:
              return Utils.toastMessage(value.apiResponse.message.toString());
            case Status.COMPLETED:
              return moviesGridView(value);
            default:
              return Container();
          }
        }),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      title: Text("Top 250 imDb Movies"),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.logout_outlined))
      ],
    );
  }

  Widget moviesGridView(HomeViewModel value) {
    bool _isWeb = _width > 450;

    return Align(
      heightFactor: 1.0,
      child: SizedBox(
        width: _isWeb ? 1000 : null,
        child: Center(
          child: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: value.apiResponse.data!.items!.length,
            itemBuilder: (context, index) {
              final moviesList = value.apiResponse.data!.items!;
              movie = moviesList[index];
              return moviesMansoryGrid(movie: movie);
            },
          ),
        ),
      ),
    );
  }

  Padding moviesMansoryGrid({required Items movie}) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieInfoView(movie: movie),
              ));
        },
        child: MouseRegion(
          cursor: SystemMouseCursors
              .click, // Icon changed when user hover over the Stack

          child: Stack(children: [
            moviesImage(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: movieInfo(),
            ),
          ]),
        ),
      ),
    );
  }

  Container movieInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: movieInfoDecoration(),
      child: Column(
        children: [
          movieTitleAndYear(),
          SizedBox(height: 6),
          StarRatingBar(rating: movie.imDbRating),
        ],
      ),
    );
  }

  BoxDecoration movieInfoDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [
        Colors.black12.withOpacity(0),
        Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    );
  }

  RichText movieTitleAndYear() {
    return RichText(
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,

      // Title
      text: TextSpan(
        text: movie.title.toString(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        children: [
          // Year
          TextSpan(
            text: " (${movie.year.toString()})",
            style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget moviesImage() {
    final double? _height = Utils.getRandomHeight();
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Hero(
          tag: movie.title.toString(),
          child: Image.network(
            movie.image!.replaceFirst(
              RegExp(r'_V1_.+'), // Match everything after "_V1_"
              '_V1_Ratio0.6716_AL.jpg', // Replacement string
            ),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  /* 
  Note: These are UI logic Functions, which responsible for rendering the user interface and handling user interactions
  they can be present in the View part in MVVM Architecture. Exp:  
  (i) Deciding how to layout the UI elements on the screen (Indicates which widgets to use, where to place them, etc.)
 (ii) Changing the appearance of UI elements based on user interactions (Changing the color of a button when it's pressed)
 (iii) Animating UI elements (Sliding a widget into view)
 (iv) Validating user input (Checking if a text field is empty before allowing a form to be submitted) 
  */

  void logout() {
    _userViewModel.removeUser();
    Navigator.pushReplacementNamed(context, RoutesName.login);
  }
}
