From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
 compliant with UHS-1
Date: Mon, 28 Apr 2014 12:50:54 +0200
Message-ID: <CAPDyKFpja-dGwsEL6YP=Nn=YSRRgMzTTz6WVQ8DiUOMrkLJpBQ@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk>
	<20140425123820.GA15179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:54650 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbaD1Kuz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 06:50:55 -0400
Received: by mail-qc0-f173.google.com with SMTP id r5so6696445qcx.32
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2014 03:50:54 -0700 (PDT)
In-Reply-To: <20140425123820.GA15179@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 25 April 2014 14:38, Markus Pargmann <mpa@pengutronix.de> wrote:
> Hi,
>
> On Wed, Apr 23, 2014 at 08:07:57PM +0100, Russell King wrote:
>> Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
>> additional clock start/stop cycles during the transition to 1.8V
>> signalling mode.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> I tested the series on imx6s with a RIoT board. With this patch applied
> the RIoT board emmc does not work. Here is the output of the board:

Hi Markus,

Thanks for helping out testing!

Does that mean patch 1->20 works fine for you? May I add your tested-by tag?

Kind regards
Ulf Hansson

>
> # dmesg | grep mmc2
> mmc2: no vqmmc regulator found
> mmc2: no vmmc regulator found
> mmc2: SDHCI controller on 219c000.usdhc [219c000.usdhc] using ADMA
> mmc2: BKOPS_EN bit is not set
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: error -110 whilst initialising MMC card
> mmc2: BKOPS_EN bit is not set
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: Timeout waiting for hardware interrupt.
> mmc2: error -110 whilst initialising MMC card
> mmc2: BKOPS_EN bit is not set
>
> Any ideas?
>
> Regards,
>
> Markus
>
>> ---
>>  drivers/mmc/host/sdhci.c | 12 ------------
>>  1 file changed, 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 748333ba6e96..0bcef2d42da4 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1507,12 +1507,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>                       host->ops->set_clock(host, host->clock);
>>               }
>>
>> -
>> -             /* Reset SD Clock Enable */
>> -             clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> -             clk &= ~SDHCI_CLOCK_CARD_EN;
>> -             sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> -
>>               if (host->ops->set_uhs_signaling)
>>                       host->ops->set_uhs_signaling(host, ios->timing);
>>               else {
>> @@ -1546,9 +1540,6 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>>                       ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
>>                               >> SDHCI_PRESET_DRV_SHIFT;
>>               }
>> -
>> -             /* Re-enable SD Clock */
>> -             host->ops->set_clock(host, host->clock);
>>       } else
>>               sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>
>> @@ -1757,9 +1748,6 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>>               ctrl |= SDHCI_CTRL_VDD_180;
>>               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>> -             /* Wait for 5ms */
>> -             usleep_range(5000, 5500);
>> -
>>               /* 1.8V regulator output should be stable within 5 ms */
>>               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>               if (ctrl & SDHCI_CTRL_VDD_180)
>> --
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
