From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] MMC/omap_hsmmc: handle failure of regulator_get better.
Date: Mon, 30 Jul 2012 12:07:09 +0530
Message-ID: <50162B95.3070502@ti.com>
References: <20120730101245.7dbe72b0@notabene.brown>	<501619A4.50906@ti.com> <20120730162414.3818bded@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:58225 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751355Ab2G3GhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jul 2012 02:37:15 -0400
Received: by obbtb18 with SMTP id tb18so8224550obb.7
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jul 2012 23:37:14 -0700 (PDT)
In-Reply-To: <20120730162414.3818bded@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 30 July 2012 11:54 AM, NeilBrown wrote:
> On Mon, 30 Jul 2012 10:50:36 +0530 Rajendra Nayak<rnayak@ti.com>  wrote:
>
>> On Monday 30 July 2012 05:42 AM, NeilBrown wrote:
>>>
>>> 1/ if regulator_get fails, return an error.  This is important
>>>      if it failed with EPROBE_DEFER, as the probe needs to be
>>>      deferred.
>>>
>>> 2/ Don't set .set_power until the regulator has been found, or
>>>      the deferred probe will not bother calling omap_hsmmc_reg_get().
>>
>> I am not very sure, but aren't the data structures re-allocated on a
>> re-probe (after it was deferred) causing .set_power to be lost anyway?
>>
>
> Apparently not - as I needed to make that change before the re-probe would
> work.
>
> Looking at the code to remind myself:
>
> #define mmc_slot(host)		(host->pdata->slots[host->slot_id])
>
> so the slot is inside the platform data which is allocated in
> omap_hsmmc_init_one, called from omap_hsmmc_init.
> This is all prior to the probing of the device.
>
> So no: once set_power is set, it stays set.

Thanks for the explanation, makes sense.

Acked-by: Rajendra Nayak <rnayak@ti.com>

Btw, is the support for re-probe/deferred probe already merged
now? or are you testing this with some out of tree patches.

>
> Thanks,
> NeilBrown
>
>>>
>>> Signed-off-by: NeilBrown<neilb@suse.de>
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index 389a3ee..f052c29 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -299,12 +299,12 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>>>    	struct regulator *reg;
>>>    	int ocr_value = 0;
>>>
>>> -	mmc_slot(host).set_power = omap_hsmmc_set_power;
>>> -
>>>    	reg = regulator_get(host->dev, "vmmc");
>>>    	if (IS_ERR(reg)) {
>>>    		dev_dbg(host->dev, "vmmc regulator missing\n");
>>> +		return PTR_ERR(reg);
>>>    	} else {
>>> +		mmc_slot(host).set_power = omap_hsmmc_set_power;
>>>    		host->vcc = reg;
>>>    		ocr_value = mmc_regulator_get_ocrmask(reg);
>>>    		if (!mmc_slot(host).ocr_mask) {
>

