From: David Woods <dwoods@mellanox.com>
Subject: Re: [PATCH] Use device_property_read instead of of_property_read in
 the dw_mmc driver
Date: Wed, 17 May 2017 18:07:24 -0400
Message-ID: <7a18520a-34c8-2225-d4cd-b6d2522a2fe5@mellanox.com>
References: <1493134767-19170-1-git-send-email-dwoods@mellanox.com>
 <CAPDyKFpRsHGkS9hH9c_SGMNNU8ZC-=9Kk8-iVDnKrMUXbACNag@mail.gmail.com>
 <CAHp75VdqV35EDUo3m19_9M7cYzvZnsJ7Ou1+ks9_S-8qDhDLZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:30105
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754220AbdEQWHf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 May 2017 18:07:35 -0400
In-Reply-To: <CAHp75VdqV35EDUo3m19_9M7cYzvZnsJ7Ou1+ks9_S-8qDhDLZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiner Kallweit <hkallweit1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, cmetcalf@mellanox.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/15/2017 09:30 AM, Andy Shevchenko wrote:
> On Mon, May 15, 2017 at 12:36 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 25 April 2017 at 17:39, David Woods <dwoods@mellanox.com> wrote:
>>> Using the device_property interfaces allows the dw_mmc driver to work
>>> on platforms which run on either device tree or ACPI.
>> Can you please split this to two separate changes. One for dw_mmc with
>> a proper prefix (mmc: dw_mmc:) and one for the mmc core (prefix "mmc:
>> core:").

Yes, I will do that.

> Btw, for the core part of change I would recommend to check other API
> functions which might go slightly different in case of ACPI vs DT vs
> built-in device properties.
>
> For example, if any code is using of_gpio header and of_ related stuff
> it should be rethought as well (not sure if we would change there
> anything, though worth to double check).
>
I have not purged all references to of_ APIs from the core code. 
However, the ones which remain are specific to hardware I don't have, so 
I wouldn't be able to test those code paths.  Btw, there is no good 
reason I can see to include of_gpio.h here, none of those interfaces 
seem to be used.

-David Woods


