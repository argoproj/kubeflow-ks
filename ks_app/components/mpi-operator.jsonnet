local env = std.extVar("__ksonnet/environments");
local params = std.extVar("__ksonnet/params").components["mpi-operator"];

local k = import "k.libsonnet";
local operator = import "kubeflow/mpi-job/mpi-operator.libsonnet";

local namespace = env.namespace;  // namespace is inherited from the environment
local name = params.name;
local image = params.image;
local kubectlDeliveryImage = params.kubectlDeliveryImage;
local gpusPerNode = params.gpusPerNode;

std.prune(k.core.v1.list.new([
  operator.parts.crd,
  operator.parts.clusterRole(name),
  operator.parts.serviceAccount(namespace, name),
  operator.parts.clusterRoleBinding(namespace, name),
  operator.parts.deploy(namespace, name, image, kubectlDeliveryImage, gpusPerNode),
]))
