# Copyright 2012 United States Government as represented by the
# Administrator of the National Aeronautics and Space Administration.
# All Rights Reserved.
#
# Copyright 2012 Nebula, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

from django.utils.translation import ugettext_lazy as _

import horizon

from openstack_dashboard.dashboards.identity import dashboard


class Tenants(horizon.Panel):
    name = _("Projects")
    slug = 'projects'
    icon_class = 'fa fa-lg fa-fw fa-group'
    visible = False
    policy_rules = (("identity", "identity:list_projects"),
                    ("identity", "identity:list_user_projects"))


dashboard.Identity.register(Tenants)
