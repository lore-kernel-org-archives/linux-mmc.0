From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
Date: Mon, 2 Feb 2015 15:57:37 +0100
Message-ID: <CAPDyKFo6G+PpV7QpxBEOS_xUxXTQ14v=qVLGpBjT_z6T0vP85A@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
	<CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
	<CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
	<20150131092715.566fa33c@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:42149 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbbBBO5j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 09:57:39 -0500
Received: by mail-qc0-f173.google.com with SMTP id m20so30253191qcx.4
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2015 06:57:38 -0800 (PST)
In-Reply-To: <20150131092715.566fa33c@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org
	<linux-arm-kernel@lists.infradead.org>," <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

+Russell King

On 30 January 2015 at 23:27, NeilBrown <neilb@suse.de> wrote:
>
> On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index d5c176e87951..1be7055548cb 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -40,6 +40,7 @@
>>  #include "bus.h"
>>  #include "host.h"
>>  #include "sdio_bus.h"
>> +#include "pwrseq.h"
>>
>>  #include "mmc_ops.h"
>>  #include "sd_ops.h"
>> @@ -1615,6 +1616,8 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>>
>>       mmc_host_clk_hold(host);
>>
>> +     mmc_pwrseq_pre_power_on(host);
>> +
>>       host->ios.vdd = fls(ocr) - 1;
>>       host->ios.power_mode = MMC_POWER_UP;
>>       /* Set initial state and call mmc_set_ios */
>> @@ -1645,6 +1648,8 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>>        */
>>       mmc_delay(10);
>>
>> +     mmc_pwrseq_post_power_on(host);
>> +
>>       mmc_host_clk_release(host);
>>  }
>
> Hi Ulf,
>  I think this may be too late for the _post_power_on() call.
>
> This is exactly where I release the reset line in my patch, and I've just discovered
> that it is causing one of my problems.
>
> Shortly before this call is
>
>         host->ios.power_mode = MMC_POWER_ON;
>         mmc_set_ios(host);
>
> and omap_hsmmc_set_ios() contains:
>
>                 switch (ios->power_mode) {
>                 ....
>                 case MMC_POWER_ON:
>                         do_send_init_stream = 1;
>                         break;
>
>
>         if (do_send_init_stream)
>                 send_init_stream(host);
>
> Which sends the "init stream" to the card.
> If the card is still being reset at this time, the stream may not be effective.
>
> I find that about 10%-20% of the time when I release the reset line *after* the
> sequence is sent, my card fails to initialised.  When I release *before* the sequence
> is sent, it never fails.

Okay, thanks for providing these details.

>
> I note that other drivers handle the init stream differently.
> atmel-mci just sets a flag in set_ios, and the actually sends the stream in
> atmci_start_request()
>
> dw_mmc, jz4740_mmc, mxcmmc, pxamci do much the same
>
> mmc_spi does it during set_ios like omap_hsmmc.
>
> The others I am not able to interpret easily.
>
> So it might make sense to change omap_hsmmc and mmc_spi to delay the init
> stream until later, but I think it is probably safest to move the post_power_on call
> to before the set_ios call.

Well, the problem is that there are host drivers that don't consider
MMC_POWER_UP and delays initialization/power_up to MMC_POWER_ON. So we
might fix the issue for some, but breaks it for another.

I had a discussion around inconsistent host driver behaviours from
->set_ios() callbacks with Russell, for the first version of this
patchset.

That's why I converted to mmc_pwrseq_post_power_on() instead of
mmc_pwrseq_power_on() as it was in v1. At that point I didn't realize
that the "initstream" sequence is an important factor to consider here
as well.

Additionally, those host drivers that ignores MMC_POWER_UP definitely
behaves wrong. I did a research about this earlier and decided to go
for a deeper look one more time. Actually I found only three drivers
that needs some attention and surely those are easy to fix.

au1xmmc
cb710-mmc
toshsd

To have something working for 3.20, I suggest we follow your proposal
about moving the call to mmc_pwrseq_post_power_on() to before the call
to ->set_ios() with MMC_POWER_ON . I send a patch we can test.

For reference, I still agree with Russell's proposal that the proper
solution, long-term wise, should be to replace/extend
MMC_POWER_UP|ON|OFF with new host callbacks. That will enable each
host to perform its own optimized power up/off sequence.

Kind regards
Uffe
