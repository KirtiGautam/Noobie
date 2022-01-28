import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function selectPlace;

  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  Future<void> _getUserLocation() => Location().getLocation().then((locData) {
        setState(() => _previewImageURL =
            'https://tnpgndec.com/images/gndecMap.png?2c902a68a8ea94658e0c242e48ac66f7');
        widget.selectPlace(locData.latitude, locData.longitude);
      });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.grey,
            )),
            child: _previewImageURL == null
                ? const Text(
                    'No Image selected',
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageURL!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.location_on),
                label: const Text('Current Location'),
                onPressed: _getUserLocation,
              ),
              // TextButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(Icons.map),
              //   label: const Text('Select on map'),
              // ),
            ],
          ),
        ],
      );
}
