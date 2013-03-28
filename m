From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Thu, 28 Mar 2013 09:43:22 +0800
Message-ID: <CADz5_g+TB9rg0_dwgzsOe7UL2F9gYuO17A=5iAca5N1jPkPj2g@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDED3BFE1@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:58615 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab3C1BnX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Mar 2013 21:43:23 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so9604760oag.11
        for <linux-mmc@vger.kernel.org>; Wed, 27 Mar 2013 18:43:22 -0700 (PDT)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0BDED3BFE1@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Maya Erez <merez@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kevin Liu <kliu5@marvell.com>

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, March 27, 2013 9:32 PM
> To: Ulf Hansson
> Cc: linux-mmc@vger.kernel.org; Johan Rudholm; Ulf Hansson; Maya Erez; Kevin Liu; Seungwon Jeon; jh80.chung@samsung.com
> Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
>
> Hi Maya, Kevin, Seungwon, Jaehoon,
>
> On Fri, Mar 01 2013, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> SDIO has been using runtime pm for a while to handle runtime power save
>> operations. This patchset is enabling the option to make the sd/mmc
>> blockdevices to use runtime pm as well.
>>
>> The runtime pm implementation for the block device will make use of
>> autosuspend to defer power save operation to after request inactivty for
>> a certain time.
>>
>> To actually perform some power save operations the corresponding bus ops
>> for mmc and sd shall be implemented. Typically it could make sense to do
>> BKOPS for eMMC in here.
>>
>> Ulf Hansson (3):
>>   mmc: core: Remove power_restore bus_ops for mmc and sd
>>   mmc: core: Add bus_ops for runtime pm callbacks
>>   mmc: block: Enable runtime pm for mmc blkdevice
>>
>>  drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>  drivers/mmc/core/bus.c   |   14 ++++++++++++--
>>  drivers/mmc/core/core.h  |    2 ++
>>  drivers/mmc/core/mmc.c   |   14 --------------
>>  drivers/mmc/core/sd.c    |   14 --------------
>>  drivers/mmc/core/sdio.c  |   20 ++++++++++++++++++++
>>  6 files changed, 60 insertions(+), 32 deletions(-)
>
> This looks good to me, but I'd like to make sure the design works for
> you before we decide to merge it.  Any concerns?
>

Chris,

This patchset is ok for me.
We can discuss/review how sd/mmc runtime callback function implemented later.

Thanks
Kevin
