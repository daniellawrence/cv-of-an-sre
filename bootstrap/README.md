# bootstrap

This contains the environment setup, in order to avoid a recursive problem of what infra builds he infra, this is self-contained and will setup "AWS" and "k8s".

The k8s is not ideal, as I am not using the paid tier of localstack, so I am unable to call into `eks`. 



## getting started

```sh
make up
```

Once this is really, then its time to move into [infra/terraform](../infra/terraform/)