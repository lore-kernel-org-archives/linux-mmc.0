From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 3/3] mmc: do not attempt UHS 1.8v support if board does
 not support it
Date: Fri, 1 Jun 2012 08:26:22 -0700
Message-ID: <7A2ECBD8-D81C-497B-B641-1803BC5F928D@marvell.com>
References: <prakity@marvell.com>
 <1338168970-2052-1-git-send-email-prakity@marvell.com>
 <CAOGqxeXt5CSnWoq5F++F=2++bXys9uRvLuL0doOm6e+JLYxgFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42829 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861Ab2FAP3y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jun 2012 11:29:54 -0400
In-Reply-To: <CAOGqxeXt5CSnWoq5F++F=2++bXys9uRvLuL0doOm6e+JLYxgFA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Alan,

I have your patch in my mmc-next.  Our controller indicates it SUPPORTS UHS modes.
The regulators do NOT.  Cannot switch to 1.8v.  

Not the same problem as you saw.

Philip


On Jun 1, 2012, at 6:55 AM, Alan Cooper wrote:

> I recently added a patch that prevents the switch to 1.8v if the host
> capabilities register does not indicate support for any of the UHS
> speeds (SDR50, DDR50, SDR104). This allowed our controller to work
> with UHS cards in HS mode (50MHz, 3.3v).
> 
> Al
> 
> On Sun, May 27, 2012 at 9:36 PM,  <philipspatches@gmail.com> wrote:
>> From: Philip Rakity <prakity@marvell.com>
>> 
>> We have h/w that does not support 1.8v signaling even though the
>> controller does support this.  If we enable 1.8v support UHS
>> cards are recognised but recovery to 3.3v is not possible
>> depending on the SD card.
>> 
>> Ensure that when we do not support 1.8v UHS mode cards can
>> work (in non UHS mode).
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci.c  |   71 +++++++++++++++++++++++---------------------
>>  include/linux/mmc/sdhci.h |    3 ++
>>  2 files changed, 40 insertions(+), 34 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 8d8dff0..f9b37c4 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2782,27 +2782,45 @@ int sdhci_add_host(struct sdhci_host *host)
>>            mmc_card_is_removable(mmc))
>>                mmc->caps |= MMC_CAP_NEEDS_POLL;
>> 
>> -       /* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
>> -       if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>> -                      SDHCI_SUPPORT_DDR50))
>> -               mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>> +       if (!(host->quirks2 & SDHCI_QUIRK2_HOST_NO_UHS_1_8V_SUPPORT)) {
>> +               /* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
>> +               if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
>> +                              SDHCI_SUPPORT_DDR50))
>> +                       mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>> +
>> +               /* SDR104 supports also implies SDR50 support */
>> +               if (caps[1] & SDHCI_SUPPORT_SDR104)
>> +                       mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
>> +               else if (caps[1] & SDHCI_SUPPORT_SDR50)
>> +                       mmc->caps |= MMC_CAP_UHS_SDR50;
>> +
>> +               if (caps[1] & SDHCI_SUPPORT_DDR50)
>> +                       mmc->caps |= MMC_CAP_UHS_DDR50;
>> +
>> +               /* Does the host need tuning for SDR50? */
>> +               if (caps[1] & SDHCI_USE_SDR50_TUNING)
>> +                       host->flags |= SDHCI_SDR50_NEEDS_TUNING;
>> +
>> +               /* Does the host need tuning for HS200? */
>> +               if (mmc->caps2 & MMC_CAP2_HS200)
>> +                       host->flags |= SDHCI_HS200_NEEDS_TUNING;
>> +
>> +               /* Initial value for re-tuning timer count */
>> +               host->tuning_count =
>> +                       (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
>> +                               SDHCI_RETUNING_TIMER_COUNT_SHIFT;
>> 
>> -       /* SDR104 supports also implies SDR50 support */
>> -       if (caps[1] & SDHCI_SUPPORT_SDR104)
>> -               mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
>> -       else if (caps[1] & SDHCI_SUPPORT_SDR50)
>> -               mmc->caps |= MMC_CAP_UHS_SDR50;
>> -
>> -       if (caps[1] & SDHCI_SUPPORT_DDR50)
>> -               mmc->caps |= MMC_CAP_UHS_DDR50;
>> -
>> -       /* Does the host need tuning for SDR50? */
>> -       if (caps[1] & SDHCI_USE_SDR50_TUNING)
>> -               host->flags |= SDHCI_SDR50_NEEDS_TUNING;
>> +               /*
>> +                * In case Re-tuning Timer is not disabled, the actual value of
>> +                * re-tuning timer will be 2 ^ (n - 1).
>> +                */
>> +               if (host->tuning_count)
>> +                       host->tuning_count = 1 << (host->tuning_count - 1);
>> 
>> -       /* Does the host need tuning for HS200? */
>> -       if (mmc->caps2 & MMC_CAP2_HS200)
>> -               host->flags |= SDHCI_HS200_NEEDS_TUNING;
>> +               /* Re-tuning mode supported by the Host Controller */
>> +               host->tuning_mode = (caps[1] & SDHCI_RETUNING_MODE_MASK) >>
>> +                                    SDHCI_RETUNING_MODE_SHIFT;
>> +       }
>> 
>>        /* Driver Type(s) (A, C, D) supported by the host */
>>        if (caps[1] & SDHCI_DRIVER_TYPE_A)
>> @@ -2821,21 +2839,6 @@ int sdhci_add_host(struct sdhci_host *host)
>>        else
>>                mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
>> 
>> -       /* Initial value for re-tuning timer count */
>> -       host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
>> -                             SDHCI_RETUNING_TIMER_COUNT_SHIFT;
>> -
>> -       /*
>> -        * In case Re-tuning Timer is not disabled, the actual value of
>> -        * re-tuning timer will be 2 ^ (n - 1).
>> -        */
>> -       if (host->tuning_count)
>> -               host->tuning_count = 1 << (host->tuning_count - 1);
>> -
>> -       /* Re-tuning mode supported by the Host Controller */
>> -       host->tuning_mode = (caps[1] & SDHCI_RETUNING_MODE_MASK) >>
>> -                            SDHCI_RETUNING_MODE_SHIFT;
>> -
>>        ocr_avail = 0;
>> 
>>        host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index e9051e1..2367939 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -92,6 +92,9 @@ struct sdhci_host {
>> 
>>  #define SDHCI_QUIRK2_HOST_OFF_CARD_ON                  (1<<0)
>> 
>> +/* host or board design does support 1.8v signaling */
>> +#define SDHCI_QUIRK2_HOST_NO_UHS_1_8V_SUPPORT          (1<<1)
>> +
>>        int irq;                /* Device IRQ */
>>        void __iomem *ioaddr;   /* Mapped address */
>> 
>> --
>> 1.7.0.4
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

