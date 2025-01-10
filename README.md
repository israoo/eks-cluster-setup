# Recursos Terraform para implementar un clúster de EKS

Este repositorio contiene los recursos necesarios para implementar un **clúster de EKS** en AWS. Esto incluye la infraestructura de red, los roles y políticas de IAM, el clúster de EKS en sí, los nodos y otros recursos necesarios para que el clúster funcione correctamente.

---

## Estructura del repositorio

```plaintext
.
├── 1.xx-*.tf                 # Recursos de red
├── 2.xx-*.tf                 # Roles y políticas de IAM
├── 3.xx-*.tf                 # Recursos de EKS y nodos
├── eks_user_data.sh          # Script de inicio para los nodos
├── outputs.tf                # Salidas de Terraform
├── providers.tf              # Configuración del provider de AWS
├── variables.auto.tfvars     # Variables por defecto
├── variables.tf              # Declaración de variables
└── versions.tf               # Versiones de Terraform y providers
```

---

## Requisitos

- Tener [Terraform](https://developer.hashicorp.com/terraform/downloads) instalado.
- Tener [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) instalado.
- Tener [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) instalado.

Además, necesitarás tener una cuenta de AWS con permisos suficientes para crear los recursos necesarios y configurar tus credenciales en tu máquina. Puedes hacer esto ejecutando el siguiente comando:

```bash
aws configure
```

O configurando las variables de entorno `AWS_ACCESS_KEY_ID` y `AWS_SECRET_ACCESS_KEY`.

---

## Instrucciones de uso

1. Clona este repositorio en tu máquina:

    ```bash
    git clone https://github.com/israoo/eks-cluster-setup.git
    cd eks-cluster-setup
    ```

2. Ajusta los valores de las variables en el archivo `variables.auto.tfvars` según tus necesidades.
3. Inicializa Terraform:

    ```bash
    terraform init
    ```

4. Crea el plan de ejecución:

    ```bash
    terraform plan -out=eks-cluster-setup.tfplan
    ```

5. Aplica el plan de ejecución:

    ```bash
    terraform apply eks-cluster-setup.tfplan
    ```

    Este proceso puede tardar varios minutos en completarse. Una vez finalizado, se mostrarán las salidas de Terraform, incluyendo la URL de acceso al clúster de EKS.

6. Configura `kubectl` para que pueda acceder al clúster de EKS:

    ```bash
    aws eks update-kubeconfig --name $(terraform output -raw eks_cluster_name)
    ```

7. Verifica que puedes acceder al clúster de EKS:

    ```bash
    kubectl get nodes
    ```

8. Cuando termines de usar el clúster, puedes destruir todos los recursos creados con Terraform:

    ```bash
    terraform destroy
    ```

---

## Pruebas

1. Despliega una aplicación de prueba en el clúster de EKS:

    ```bash
    kubectl create deployment nginx --image=nginx
    kubectl expose deployment nginx --port=80 --type=LoadBalancer
    ```

2. Verifica que el servicio se ha creado correctamente:

    ```bash
    kubectl get svc nginx
    ```

    El servicio `nginx` tendrá un FQDN público en la propiedad `EXTERNAL-IP` que puedes usar para acceder a la aplicación. Este FQDN es asignado automáticamente por AWS a los servicios de tipo `LoadBalancer` que se crean en una subred pública, si quieres usar un dominio personalizado, puedes configurar Alias en Route 53 apuntando a este DNS.

---

## Tecnologías utilizadas

- **Terraform**: Para la gestión de la infraestructura como código.
- **AWS**: Para la implementación de los recursos en la nube.
- **kubectl**: Para la gestión del clúster de EKS.
