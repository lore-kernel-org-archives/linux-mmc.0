From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-at91: fix wake-up issue when using
 runtime pm
Date: Thu, 17 Mar 2016 16:15:29 +0200
Message-ID: <56EABC01.60903@intel.com>
References: <1458222874-23765-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFqD3htacEkv02D+37rcS1DxtOQFBxvVAvtWn9hpR_z_0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:13169 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966264AbcCQOTH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2016 10:19:07 -0400
In-Reply-To: <CAPDyKFqD3htacEkv02D+37rcS1DxtOQFBxvVAvtWn9hpR_z_0Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

On 17/03/16 16:00, Ulf Hansson wrote:
> On 17 March 2016 at 14:54, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
>> It is impossible to wake-up on card detect event because when sdhci
>> controller is runtime suspended, it is assumed that all clocks are
>> disabled so we can't get irqs.
>> If the device is removable and there is no gpio to manage the card
>> detection then polling is used. It doesn't mean card detection is broken.
>> It is curently we only way to wake-up on card event if using runtime pm.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> I have applied this for next (4.6) so to get it tested in linux-next.
> 
> Adrian, please tell me if you have any objections then I will drop it
> (or add your ack).

It is fine by me.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Thanks and kind regards
> Uffe
> 
>> ---
>>
>> Changes:
>> - v2:
>>   - remove SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk if set by the broken-cd
>>   property.
>>
>>  drivers/mmc/host/sdhci-of-at91.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>> index 35c02fc..2703aa9 100644
>> --- a/drivers/mmc/host/sdhci-of-at91.c
>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/err.h>
>>  #include <linux/io.h>
>>  #include <linux/mmc/host.h>
>> +#include <linux/mmc/slot-gpio.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> @@ -204,6 +205,25 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>>         if (ret)
>>                 goto pm_runtime_disable;
>>
>> +       /*
>> +        * When calling sdhci_runtime_suspend_host(), the sdhci layer makes
>> +        * the assumption that all the clocks of the controller are disabled.
>> +        * It means we can't get irq from it when it is runtime suspended.
>> +        * For that reason, it is not planned to wake-up on a card detect irq
>> +        * from the controller.
>> +        * If we want to use runtime PM and to be able to wake-up on card
>> +        * insertion, we have to use a GPIO for the card detection or we can
>> +        * use polling. Be aware that using polling will resume/suspend the
>> +        * controller between each attempt.
>> +        * Disable SDHCI_QUIRK_BROKEN_CARD_DETECTION to be sure nobody tries
>> +        * to enable polling via device tree with broken-cd property.
>> +        */
>> +       if (!(host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
>> +           IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc))) {
>> +               host->mmc->caps |= MMC_CAP_NEEDS_POLL;
>> +               host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> +       }
>> +
>>         pm_runtime_put_autosuspend(&pdev->dev);
>>
>>         return 0;
>> --
>> 2.5.0
>>
> 

