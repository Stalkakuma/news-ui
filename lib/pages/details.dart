import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_ui/components/article.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final NewsArticle article;
  const DetailsPage({
    Key? key,
    required this.article,
  }) : super(key: key);

  Future<void> _launchURLBrowser() async {
    final Uri url = Uri.parse(article.url);
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
  }

  String dateFormat() {
    DateTime timePublished = DateTime.parse(article.publishedAt!);
    String formattedDate = DateFormat.yMd().format(timePublished);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 251, 251, 248),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Column(children: [
              SizedBox(
                height: 250,
                child: Stack(fit: StackFit.expand, children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black.withAlpha(50),
                          Colors.black54
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      width: double.infinity,
                      child: Text(
                        article.title ?? 'No title...',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  article.imageUrl != null
                      ? Ink.image(
                          image: NetworkImage(article.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : Ink.image(
                          fit: BoxFit.fitHeight,
                          image: const AssetImage('assets/image-not-found.png'))
                ]),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Author:',
                        style: TextStyle(color: Colors.black38, fontSize: 10),
                      ),
                      Text(
                        'Publish date:',
                        style: TextStyle(color: Colors.black38, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          article.author ?? 'Not listed...',
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        dateFormat(),
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 20, right: 15, left: 15),
                  child: Text(
                    article.description ?? 'No article...',
                    style:
                        const TextStyle(fontSize: 20.0, color: Colors.black87),
                  ),
                ),
              ]),
            ])),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(58, 66, 86, 1.0)),
                  ),
                  onPressed: _launchURLBrowser,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Read more',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55.0,
        child: BottomAppBar(
          color: const Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
