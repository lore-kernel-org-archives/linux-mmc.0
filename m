From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH V5] mmc:host:sdhci-pci:Addition of Arasan PCI Controller
 with integrated phy.
Date: Tue, 19 Dec 2017 17:00:51 +0100
Message-ID: <CAOFm3uHr5he9fbjMQ0jch-Zs3dCtrni8ZHUOajheA=f8+P2LVQ@mail.gmail.com>
References: <1513098128-4776-1-git-send-email-agarg@arasan.com> <1f026a6e-aabc-66b3-2753-00c23bf61a27@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1f026a6e-aabc-66b3-2753-00c23bf61a27@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atul Garg <agarg@arasan.com>
Cc: linux-mmc@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, rk@ti.com, nm@ti.com, nsekhar@ti.com, Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Atul,

On Tue, Dec 19, 2017 at 1:18 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 12/12/17 19:02, Atul Garg wrote:
>> The Arasan Controller is based on a FPGA platform and has integrated phy
>> with specific registers used during initialization and
>> management of different modes. The phy and the controller are integrated
>> and registers are very specific to Arasan.
>>
>> Arasan being an IP provider, licenses these IPs to various companies for
>> integration of IP in custom SOCs. The custom SOCs define own register
>> map depending on how bits are tied inside the SOC for phy registers,
>> depending on SOC memory plan and hence will require own platform drivers.
>>

<snip>


>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-pci-arasan.c
>> @@ -0,0 +1,341 @@
>> +/*
>> + * Copyright (C) 2017 Arasan Chip Systems Inc.
>> + *
>> + * Author: Atul Garg <agarg@arasan.com>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */

Could you consider using the new SPDX tags documented in Thomas patch set
[1] rather than this fine but longer legalese?

Thank you!

[1] https://lkml.org/lkml/2017/12/4/934

-- 
Cordially
Philippe Ombredanne
