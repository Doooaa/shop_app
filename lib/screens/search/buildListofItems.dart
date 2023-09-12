import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


Widget SearchBuilder(list) {
  return ConditionalBuilder(
      condition: list.length > 0,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.all(5),
                    ),
                itemBuilder: (context, index) {
                  return buildsearchItems(list[index],context);
                },
                itemCount:list.length),
          ));
}





Widget buildsearchItems(searches, context) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                       'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'
              )),
              borderRadius: const BorderRadius.all(Radius.circular(15)))),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                "ssssss",

                  style: Theme.of(context).textTheme.bodyMedium,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis, //
                ),
              ),
              Expanded(
                child: Text(
                  "",

                  style: const TextStyle(
                    color: Color.fromARGB(255, 137, 148, 153),
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ), //
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);