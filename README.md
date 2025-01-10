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

3. Accede a la aplicación a través del `EXTERNAL-IP` del servicio:

    ```bash
    curl http://<EXTERNAL-IP>
    ```

El servicio `nginx` tendrá un FQDN público en la propiedad `EXTERNAL-IP` que puedes usar para acceder a la aplicación. Este FQDN es asignado automáticamente por AWS a los servicios de tipo `LoadBalancer` que se crean en una subred pública, si quieres usar un dominio personalizado, puedes configurar un Alias en Route 53 apuntando a este DNS.

Un mejor enfoque sería configurar un **Ingress Controller** o un **Service Mesh** en el clúster de EKS, esto permitirá tener un único punto de entrada para todas las aplicaciones desplegadas en el clúster y gestionar el tráfico de red de forma más eficiente.

---

## Puntos de mejora

La implementación actual es una configuración básica de un clúster de EKS que contempla solo los recursos mínimos necesarios para que el clúster funcione correctamente. A continuación, se presentan algunas mejoras que se pueden implementar para hacer el clúster más seguro:

### Seguridad

- Restringir el acceso al clúster de EKS a través de una IP específica o de un rango de IPs o a través de una VPN.
- Configurar un ACL en las subredes de EKS para controlar de forma más granular el tráfico de red.
- Habilitar el cifrado de los datos en el control plane y en los nodos de EKS con una clave de KMS.
- Deshabilitar el access entry configurado con la política `AmazonEKSClusterAdminPolicy` y crear roles de IAM específicos para los usuarios que necesiten acceso al clúster.

### Tráfico de red

- Configurar un api gateway para gestionar las peticiones HTTP.
- Configurar un CDN para acelerar la entrega de contenido estático.
- Configurar un WAF para proteger las aplicaciones desplegadas en el clúster de EKS.

Ya dentro del cluster de EKS puedes configurar diferentes servicios para mejorar la escalabilidad, resiliencia, observabilidad y seguridad de las aplicaciones desplegadas en el clúster.

---

## Tecnologías utilizadas

- **Terraform**: Para la gestión de la infraestructura como código.
- **AWS**: Para la implementación de los recursos en la nube.
- **kubectl**: Para la gestión del clúster de EKS.
