import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final void Function() handleTryAgainPressed;

  const FailureWidget({
    Key? key,
    required this.handleTryAgainPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background1.png',
            fit: BoxFit.fill,
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100,
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Erro ao tentar obter os dados, tente novamente'),
              const SizedBox(
                height: 8,
              ),
              IconButton(
                onPressed: handleTryAgainPressed,
                icon: const Icon(Icons.error),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
