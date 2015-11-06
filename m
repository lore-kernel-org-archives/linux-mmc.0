From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 1/4] mmc: Add quirk to disable SDR50 mode
Date: Fri, 6 Nov 2015 15:55:59 -0800
Message-ID: <563D3E0F.70906@broadcom.com>
References: <1446763200-10234-1-git-send-email-alcooperx@gmail.com>
 <CAPDyKFrhtoDwe82Zg4YP4eU=xO6zE1pZTcRSnzSeHGRCzgu+5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:11031 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbbKFX4R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 18:56:17 -0500
In-Reply-To: <CAPDyKFrhtoDwe82Zg4YP4eU=xO6zE1pZTcRSnzSeHGRCzgu+5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Al Cooper <alcooperx@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

Hi Ulf,

On 15-11-06 12:14 AM, Ulf Hansson wrote:
> On 5 November 2015 at 23:39, Al Cooper <alcooperx@gmail.com> wrote:
>> Add quirk to disable SDR50 mode for controllers/boards that have
>> problems with this mode.
>
> No thanks! No more quirks please!
>

I'm fine with not having this quirk added (I don't need this one but use 
multiple of the other quirks in the driver)  But, what if I also needed 
it in my driver?  When do we determine when a quirk should be added to 
sdhci.c or not.  What about existing quirks - should the current ones be 
moved to multiple existing drivers?
> Kind regards
> Uffe
>
>>
>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>> ---
>>   drivers/mmc/host/sdhci.c | 3 +++
>>   drivers/mmc/host/sdhci.h | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index b48565e..71067c7 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3176,6 +3176,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>          } else if (caps[1] & SDHCI_SUPPORT_SDR50)
>>                  mmc->caps |= MMC_CAP_UHS_SDR50;
>>
>> +       if (host->quirks2 & SDHCI_QUIRK2_BROKEN_SDR50)
>> +               mmc->caps &= ~MMC_CAP_UHS_SDR50;
>> +
Perhaps a lot of these quirks can be solved by having a generic 
mechanism to override any of the values in the caps registers rather 
than adding all these quirks?

>>          if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
>>              (caps[1] & SDHCI_SUPPORT_HS400))
>>                  mmc->caps2 |= MMC_CAP2_HS400;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 9d4aa31..0941c94 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -412,6 +412,8 @@ struct sdhci_host {
>>   #define SDHCI_QUIRK2_ACMD23_BROKEN                     (1<<14)
>>   /* Broken Clock divider zero in controller */
>>   #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN             (1<<15)
>> +/* Controller does not support SDR50 */
>> +#define SDHCI_QUIRK2_BROKEN_SDR50                      (1<<16)
>>   /*
>>    * When internal clock is disabled, a delay is needed before modifying the
>>    * SD clock frequency or enabling back the internal clock.
>> --
>> 1.9.0.138.g2de3478
>>

Regards,
  Scott
