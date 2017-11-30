From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH V4] mmc:host:sdhci-pci:Addition of Arasan PCI Controller
 with integrated phy.
Date: Thu, 30 Nov 2017 17:14:32 +0100
Message-ID: <CAOFm3uFvY0DQjs0wMWfMFSn=gDLA-Awm3sRo+K6G4HefHt25sw@mail.gmail.com>
References: <1511910201-6095-1-git-send-email-agarg@arasan.com> <4616254b-d58b-53f3-eb51-a6ed3c210139@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4616254b-d58b-53f3-eb51-a6ed3c210139@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Atul Garg <agarg@arasan.com>, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, nm@ti.com, nsekhar@ti.com, ulf.hansson@linaro.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 30, 2017 at 3:29 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 29/11/17 01:03, Atul Garg wrote:
[]
>> diff --git a/drivers/mmc/host/sdhci-pci-arasan.c b/drivers/mmc/host/sdhci-pci-arasan.c
>> new file mode 100644
>> index 0000000..6529f30
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-pci-arasan.c
>> @@ -0,0 +1,314 @@
>> +/*
>> + * Copyright (C) 2017 Arasan Chip Systems Inc.,
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
>> + *
>> + */

Would it make sense to use the new SPDX ids here?
e.g something like this instead?

>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2017 Arasan Chip Systems Inc.
>> + *
>> + * Author: Atul Garg <agarg@arasan.com>
>> + */

Shorter and cleaner!

In any case you likely do not want a trailing comma after Arasan Chip
Systems Inc.

--
Cordially
Philippe Ombredanne
