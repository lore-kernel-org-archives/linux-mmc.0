From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/4] mmc: sdhci: Clear also HS400 1.2V capability if 1.2V
 is not supported
Date: Wed, 5 Nov 2014 15:00:27 +0100
Message-ID: <CAPDyKFoSussZHcwFCeBvYnkWyk+fACFd=9c5BZGDtUwEKrGMVg@mail.gmail.com>
References: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
	<1414758171-1244-4-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpr=0xFvgt3kW+WF0N=pqQz1Dk7bBNcUZjjKT-0AFx8og@mail.gmail.com>
	<545A2B18.6000200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:61067 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbaKEOA3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 09:00:29 -0500
Received: by mail-qc0-f172.google.com with SMTP id i17so546699qcy.31
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 06:00:28 -0800 (PST)
In-Reply-To: <545A2B18.6000200@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 5 November 2014 14:50, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 05/11/14 15:36, Ulf Hansson wrote:
>> On 31 October 2014 13:22, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> 1.2V HS200 mode capability is cleared if there is not a voltage
>>> regulator that supports 1.2V.  Do the same for 1.2V HS400 mode.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 13 +++++++------
>>>  include/linux/mmc/host.h |  1 +
>>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 7736a2c..91e888c 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3110,16 +3110,17 @@ int sdhci_add_host(struct sdhci_host *host)
>>>                 /* SD3.0: SDR104 is supported so (for eMMC) the caps2
>>>                  * field can be promoted to support HS200.
>>>                  */
>>> -               if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)) {
>>> +               if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
>>>                         mmc->caps2 |= MMC_CAP2_HS200;
>>> -                       if (IS_ERR(mmc->supply.vqmmc) ||
>>> -                                       !regulator_is_supported_voltage
>>> -                                       (mmc->supply.vqmmc, 1100000, 1300000))
>>> -                               mmc->caps2 &= ~MMC_CAP2_HS200_1_2V_SDR;
>>> -               }
>>>         } else if (caps[1] & SDHCI_SUPPORT_SDR50)
>>>                 mmc->caps |= MMC_CAP_UHS_SDR50;
>>>
>>> +       if ((mmc->caps2 & MMC_CAPS2_1_2V) &&
>>> +           (IS_ERR(mmc->supply.vqmmc) ||
>>> +            !regulator_is_supported_voltage(mmc->supply.vqmmc, 1100000,
>>> +                                            1300000)))
>>> +               mmc->caps2 &= ~MMC_CAPS2_1_2V;
>>> +
>>>         if ((caps[1] & SDHCI_SUPPORT_DDR50) &&
>>>                 !(host->quirks2 & SDHCI_QUIRK2_BROKEN_DDR50))
>>>                 mmc->caps |= MMC_CAP_UHS_DDR50;
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index df0c153..e48c1bf 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -289,6 +289,7 @@ struct mmc_host {
>>>  #define MMC_CAP2_HS400_1_2V    (1 << 16)       /* Can support HS400 1.2V */
>>>  #define MMC_CAP2_HS400         (MMC_CAP2_HS400_1_8V | \
>>>                                  MMC_CAP2_HS400_1_2V)
>>> +#define MMC_CAPS2_1_2V         (MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
>>
>> Nitpick: Could you please rename "MMC_CAPS2_1_2V" to
>> "MMC_CAP2_HSx00_1_2V". I think that name will describe its use better.
>
> checkpatch won't like it if uppercase ad lowercase are mixed so it will have
> to be MMC_CAP2_HSX00_1_2V

That's fine as well!

Kind regards
Uffe
