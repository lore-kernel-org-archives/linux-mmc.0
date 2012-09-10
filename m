From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] mmc: mxs-mmc: implement broken-cd
Date: Mon, 10 Sep 2012 09:58:52 -0500
Message-ID: <CAKGA1bm990BXJuZ=sQFgaciJxeP_ytPV2tfm1rHi=s=w7b-OYg@mail.gmail.com>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20120910060840.GT26709@S2101-09.ap.freescale.net> <504DBB10.9030702@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54676 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab2IJO7O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Sep 2012 10:59:14 -0400
Received: by qcro28 with SMTP id o28so1064327qcr.19
        for <linux-mmc@vger.kernel.org>; Mon, 10 Sep 2012 07:59:13 -0700 (PDT)
In-Reply-To: <504DBB10.9030702@bluegiga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, veli-pekka.peltola@bluegiga.com, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

I think this describes three use cases which are different, as Shawn
said we have here;

* missing card detect support (card detect is not wired so it's
impossible to tell, and the controller doesn't support the SD standard
card detection)
* non-removable device
* broken card detect support

The third one is what the property sounds like it describes, but this
is not the use case you are describing at all. This kind of property
naming is more like describing "card detect doesn't operate reliably"
which is true of i.MX devices with certain versions of the eSDHC and
uSDHC controllers, where non-GPIO card detection interferes with SDIO
interrupts, but in this case a board designer should add a real card
detect pin to the board (most more expensive push-push SD card slots
come with a pin you can wire for CD). In cases where errata is
published after boards are shipped, broken-cd is a meaningful
description when described in the absense of a gpio cd description, or
presence of some cd-handled-internally style property (forgive me for
not cross-referencing the FSL definition for this property, we don't
use it here at Genesi since all our boards have GPIO CD)

It seems your device is a combination of the top two in the list, it
is not down to a broken feature at all, but one that should be
possible to not implement for devices which are permanently connected.
A non-removable device should be able to be powered down, at least
using runtime PM or clock gating (if this works, remember to whitelist
the card for clock gating!) but card detect shouldn't be used in this
case to detect if the card is powered or not (this is a problem for
your card controller and card driver state tracker. The MMC subsystem
already tracks this state fairly well for power management).

I would refrain from calling a feature "broken card detect" if there
is actually no breakage involved especially if it would be more
prudent instead look into how to figure out how to track power
management state properly without cluttering the device tree.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.


On Mon, Sep 10, 2012 at 5:04 AM, Lauri Hintsala
<lauri.hintsala@bluegiga.com> wrote:
> Hi Shawn,
>
>
> On 09/10/2012 09:08 AM, Shawn Guo wrote:
>>
>> On Fri, Sep 07, 2012 at 02:45:17PM +0300, Lauri Hintsala wrote:
>>>
>>> This feature allows to use SDIO bus without wiring card detect
>>> signal.
>>
>>
>> This looks like a case of "broken-cd" ...
>>
>>> This is relevant in cases where SDIO device is connected to
>>> SDIO bus and there is no way to disconnect device from bus (device
>>> is always present).
>>>
>> ... while this sounds like a case of "non-removable".
>
>
> Right, I'll remove this comment.
>
> In our case the SDIO device is always physically connected to SDIO bus but
> the power of the device can be controller. So in SW point of view the device
> can be removed by switching the power off.
>
>
>
>>> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
>>> ---
>>>   drivers/mmc/host/mxs-mmc.c |    7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
>>> index ad3fcea..992760e 100644
>>> --- a/drivers/mmc/host/mxs-mmc.c
>>> +++ b/drivers/mmc/host/mxs-mmc.c
>>> @@ -165,6 +165,7 @@ struct mxs_mmc_host {
>>>         int                             sdio_irq_en;
>>>         int                             wp_gpio;
>>>         bool                            wp_inverted;
>>> +       bool                            broken_cd;
>>>   };
>>>
>>>   static int mxs_mmc_get_ro(struct mmc_host *mmc)
>>> @@ -187,6 +188,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>>>   {
>>>         struct mxs_mmc_host *host = mmc_priv(mmc);
>>>
>>> +       if (host->broken_cd)
>>> +               return -ENOSYS;
>>> +
>>
>>
>> The .get_cd caller does not check for error.  This change makes no
>> sense to me.
>
>
> In our case we don't want to read card detect bit and we have to continue
> MMC probing because card detect pin is routed nowhere.
>
> Could it be better to return zero instead of error? ENOSYS is used to
> indicate "unreachable card detect" in other drivers (e.g. atmel-mci,
> omap_hsmmc) and I followed them.
>
>
>
>> Instead, the driver needs to set MMC_CAP_NEEDS_POLL in
>> case of "broken-cd".
>
>
> MMC_CAP_NEEDS_POLL is always set in mxs-mmc.
>
>
> Best regards,
> Lauri
>
>
>>
>> Regards,
>> Shawn
>>
>>>         return !(readl(host->base + HW_SSP_STATUS(host)) &
>>>                  BM_SSP_STATUS_CARD_DETECT);
>>>   }
>>> @@ -808,6 +812,9 @@ static int mxs_mmc_probe(struct platform_device
>>> *pdev)
>>>                                                         &flags);
>>>                 if (flags & OF_GPIO_ACTIVE_LOW)
>>>                         host->wp_inverted = 1;
>>> +
>>> +               if (of_get_property(np, "broken-cd", NULL))
>>> +                       host->broken_cd = 1;
>>>         } else {
>>>                 if (pdata->flags & SLOTF_8_BIT_CAPABLE)
>>>                         mmc->caps |= MMC_CAP_4_BIT_DATA |
>>> MMC_CAP_8_BIT_DATA;
>>> --
>>> 1.7.9.5
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
