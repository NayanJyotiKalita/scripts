# Script to automate the process of listing all the resources in an AWS account

So as defined by this block of the script: 

```bash
# Check if the required number of arguments are passed
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_list.sh  <aws_region> <aws_service>"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
    exit 1
fi
```

If we don't provide sufficient number of arguments, we should get this as output:

```bash
Usage: ./aws_resource_list.sh  <aws_region> <aws_service>
Example: ./aws_resource_list.sh us-east-1 ec2
```

<img width="687" height="80" alt="Image" src="https://github.com/user-attachments/assets/d888b612-cea9-40fc-8814-ca722dcbf878" />

---

<img width="720" height="75" alt="Image" src="https://github.com/user-attachments/assets/8bccb5c6-115b-4cbe-8af3-5c9e23dffd71" />

---

so we can install aws cli from this link i.e. from AWS Documentation as per your system:
`https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html`

<img width="788" height="94" alt="Image" src="https://github.com/user-attachments/assets/48fb6ca5-735b-486d-8149-ab8b41d6e8e9" />

So our next job is to validate whether /.aws folder exists or nor:

<img width="750" height="116" alt="Image" src="https://github.com/user-attachments/assets/d5b19365-8aeb-4639-9535-b149b4d7dfa3" />

So we configure and it runs successfully:

<img width="1109" height="113" alt="Image" src="https://github.com/user-attachments/assets/c3e476ab-8934-4a74-81bf-2c39abab8cef" />

<img width="940" height="464" alt="Image" src="https://github.com/user-attachments/assets/7f6a365e-0a22-4912-9626-7ac0d4ea667f" />

<img width="859" height="594" alt="Image" src="https://github.com/user-attachments/assets/f10cc7b0-0856-4d83-a98c-8814459ac10e" />

<img width="874" height="302" alt="Image" src="https://github.com/user-attachments/assets/2b3969e8-8ff6-487b-87a7-2400b0475e74" />












