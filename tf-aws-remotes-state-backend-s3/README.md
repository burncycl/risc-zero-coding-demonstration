### 2020/10 Michael Grate

Reference: 
- [terraform-aws-remote-state](https://github.com/terra-mod/terraform-aws-remote-state.git)

We're not going to reinvet the wheel here folks. Remote state original code borrowed from the above repo. Modified to use newer Terraform Resources.

## Create Remote State

Push button magic with 
```
make remotestate
```

## Create Backup, since no remote state.

Because the remote state doesn't have a remote state of it's own (Inception, ikr?), only local. It should be backed-up once created for good measure.
```
make backup
```

## Destroy Remote State
Destroy requires terraform.tfstate 

Destroy
```
make destroy
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_remotestate
``` 
