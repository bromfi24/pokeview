// To parse this JSON data, do
//
//     final listPokemonResponse = listPokemonResponseFromJson(jsonString);

import 'dart:convert';

ListPokemonResponse listPokemonResponseFromJson(String str) => ListPokemonResponse.fromJson(json.decode(str));

String listPokemonResponseToJson(ListPokemonResponse data) => json.encode(data.toJson());

class ListPokemonResponse {
    final int count;
    final String next;
    final dynamic previous;
    final List<Result> results;

    ListPokemonResponse({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory ListPokemonResponse.fromJson(Map<String, dynamic> json) => ListPokemonResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    final String name;
    final String url;

    Result({
        required this.name,
        required this.url,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
