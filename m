From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 3/7] mmc: omap: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Thu, 16 Jan 2014 16:37:55 +0530
Message-ID: <52D7BD8B.4060300@ti.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org> <002101cf11fb$bf5c6280$3e152780$%jun@samsung.com> <CAPDyKFp3vKwZa5Y2cXdQ035M3Tm+LT8yD7_B2xvb6ZxOKNSz7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbaAPLIN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jan 2014 06:08:13 -0500
In-Reply-To: <CAPDyKFp3vKwZa5Y2cXdQ035M3Tm+LT8yD7_B2xvb6ZxOKNSz7g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On Thursday 16 January 2014 04:19 PM, Ulf Hansson wrote:
> On 15 January 2014 15:11, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> Replaced UHS_DDR50 with MMC_DDR52.
>>
>> CC: Balaji T K <balajitk@ti.com>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index dbd32ad..cca397e 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -540,7 +540,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>>           *      - MMC/SD clock coming out of controller > 25MHz
>>           */
>>          if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
>> -           (ios->timing != MMC_TIMING_UHS_DDR50) &&
>> +           (ios->timing != MMC_TIMING_MMC_DDR52) &&
>
> Even if I can't find anywhere that OMAP has enabled the corresponding
> host caps for UHS SD cards, it still might be the case that OMAP
> actually is able to handle the 1.8V I/O voltage switches and thus you
> should like keep that.
>
Hi,

Actually the ios->timing check currently there is for eMMC DDR,
So this change is needed.

> You find the omap specific hack in omap_hsmmc_switch_opcond(). Ideally

switch_opcond is for 1.8V MMC (MMC mobile) cards.

> the driver should be updated to implement the
> host_ops->start_signal_voltage_switch and host_ops->card_busy instead.
>

uhs support for sd card is not yet in mainline. voltage_switch and card_busy
ops will be get implemented for UHS sd card support.

Thanks and Regards,
Balaji T K

> Maybe some the OMAP guys can tell use more to be sure.
>
> Kind regards
> Ulf Hansson
>
>
>>              ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
>>                  regval = OMAP_HSMMC_READ(host->base, HCTL);
>>                  if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
>> @@ -560,7 +560,7 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
>>          u32 con;
>>
>>          con = OMAP_HSMMC_READ(host->base, CON);
>> -       if (ios->timing == MMC_TIMING_UHS_DDR50)
>> +       if (ios->timing == MMC_TIMING_MMC_DDR52)
>>                  con |= DDR;     /* configure in DDR mode */
>>          else
>>                  con &= ~DDR;
>> --
>> 1.7.0.4
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

