From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 07/12] mmc: sd: set current limit for uhs cards
Date: Wed, 16 Mar 2011 08:34:46 -0700
Message-ID: <1C115B4E-77BD-46BC-9584-BC4350446A9F@marvell.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-8-git-send-email-arindam.nath@amd.com>
 <A1C4E0A8-BE9D-4B3B-93AB-BE23C068AEFE@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300E3D225F7@SAUSEXMBP01.amd.com>
 <150C4EA5-04B7-42C9-A301-89EA5180EE05@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300E3D2264A@SAUSEXMBP01.amd.com>
 <180E7DEA-321F-4489-8F01-3F2B1C990625@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300E3D2269F@SAUSEXMBP01.amd.com>
 <77C31337-74A6-4F62-BFC9-4DB71BCD3259@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300E3D226BB@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36165 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752834Ab1CPPey convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Mar 2011 11:34:54 -0400
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300E3D226BB@SAUSEXMBP01.amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>


On Mar 16, 2011, at 8:33 AM, Nath, Arindam wrote:

> Hi Philip,
> 
> 
>> -----Original Message-----
>> From: Philip Rakity [mailto:prakity@marvell.com]
>> Sent: Wednesday, March 16, 2011 9:01 PM
>> To: Nath, Arindam
>> Cc: cjb@laptop.org; zhangfei.gao@gmail.com; subhashj@codeaurora.org;
>> linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
>> Subject: Re: [PATCH v2 07/12] mmc: sd: set current limit for uhs cards
>> 
>> 
>> Arindam,
>> 
>> Thanks,
>> 
>> There are a few other functions in the same file that should also be
>> changed for the same reason.
> 
> I hope you mean by setting default bus speed mode and driver type for the card. If so, I will take care of them.

yes !  -- thank you.
> 
> Thanks,
> Arindam
> 
>> 
>> Philip
>> 
>> On Mar 16, 2011, at 8:24 AM, Nath, Arindam wrote:
>> 
>>> Hi Philip,
>>> 
>>> 
>>>> -----Original Message-----
>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>> Sent: Wednesday, March 16, 2011 8:48 PM
>>>> To: Nath, Arindam
>>>> Cc: cjb@laptop.org; zhangfei.gao@gmail.com; subhashj@codeaurora.org;
>>>> linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
>>>> Subject: Re: [PATCH v2 07/12] mmc: sd: set current limit for uhs
>> cards
>>>> 
>>>> 
>>>> On Mar 16, 2011, at 8:00 AM, Nath, Arindam wrote:
>>>> 
>>>>> Hi Philip,
>>>>> 
>>>>> 
>>>>>> -----Original Message-----
>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>> Sent: Wednesday, March 16, 2011 8:22 PM
>>>>>> To: Nath, Arindam
>>>>>> Cc: cjb@laptop.org; zhangfei.gao@gmail.com;
>> subhashj@codeaurora.org;
>>>>>> linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
>> anath.amd@gmail.com
>>>>>> Subject: Re: [PATCH v2 07/12] mmc: sd: set current limit for uhs
>>>> cards
>>>>>> 
>>>>>> 
>>>>>> On Mar 16, 2011, at 7:32 AM, Nath, Arindam wrote:
>>>>>> 
>>>>>>> Hi Philip,
>>>>>>> 
>>>>>>> 
>>>>>>>> -----Original Message-----
>>>>>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>>>>>> Sent: Wednesday, March 16, 2011 7:56 PM
>>>>>>>> To: Nath, Arindam
>>>>>>>> Cc: cjb@laptop.org; zhangfei.gao@gmail.com;
>>>> subhashj@codeaurora.org;
>>>>>>>> linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
>>>> anath.amd@gmail.com
>>>>>>>> Subject: Re: [PATCH v2 07/12] mmc: sd: set current limit for uhs
>>>>>> cards
>>>>>>>> 
>>>>>>>> 
>>>>>>>> On Mar 4, 2011, at 3:32 AM, Arindam Nath wrote:
>>>>>>>> 
>>>>>>>>> We decide on the current limit to be set for the card based on
>>>> the
>>>>>>>>> Capability of Host Controller to provide current at 1.8V
>>>>>> signalling,
>>>>>>>>> and the maximum current limit of the card as indicated by CMD6
>>>>>>>>> mode 0. We then set the current limit for the card using CMD6
>>>> mode
>>>>>> 1.
>>>>>>>>> 
>>>>>>>>> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
>>>>>>>>> ---
>>>>>>>>> drivers/mmc/core/sd.c    |   45
>>>>>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>> drivers/mmc/host/sdhci.c |   24 ++++++++++++++++++++++++
>>>>>>>>> include/linux/mmc/card.h |    9 +++++++++
>>>>>>>>> include/linux/mmc/host.h |    1 +
>>>>>>>>> 4 files changed, 79 insertions(+), 0 deletions(-)
>>>>>>>>> 
>>>>>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>>>>>>> index ec0d8e6..df98a2c 100644
>>>>>>>>> --- a/drivers/mmc/core/sd.c
>>>>>>>>> +++ b/drivers/mmc/core/sd.c
>>>>>>>>> @@ -550,6 +550,46 @@ static int sd_set_bus_speed_mode(struct
>>>>>> mmc_card
>>>>>>>> *card, u8 *status)
>>>>>>>>>      return 0;
>>>>>>>>> }
>>>>>>>>> 
>>>>>>>>> +static int sd_set_current_limit(struct mmc_card *card, u8
>>>> *status)
>>>>>>>>> +{
>>>>>>>>> +     struct mmc_host *host = card->host;
>>>>>>>>> +     int mmc_host_max_current_180, current_limit;
>>>>>>>>> +     int err;
>>>>>>>>> +
>>>>>>>>> +     /* sanity check */
>>>>>>>>> +     if (!host->ops->get_max_current_180)
>>>>>>>>> +             return 0;
>>>>>>>> 
>>>>>>>> a better name would be get_max_current rather than
>>>>>> get_max_current_180
>>>>>>> 
>>>>>>> The Max Current Capabilities register reports maximum currents
>> for
>>>>>> 1.8V, 3.0V and 3.3V. Since we are only interested in the maximum
>>>>>> current at 1.8V, so I have added *_180 to the variable names to
>> make
>>>> it
>>>>>> explicit.
>>>>>> 
>>>>>> understand but that is the usage now and if we need to extend the
>>>> code
>>>>>> the name becomes misleading.
>>>>> 
>>>>> Okay. I will remove *_180 in next version.
>>>>> 
>>>>>>> 
>>>>>>>> 
>>>>>>>> do you want a test for get_max_current_180 < 400 ? and return 0
>>>>>> have
>>>>>>>> it do the switch
>>>>>>>> by setting the value ?
>>>>>>> 
>>>>>>> As mentioned in the Physical Layer spec v3.01, <400mA falls under
>>>> the
>>>>>> default current limit, so we don't need to set it in case any or
>> all
>>>> of
>>>>>> the above conditions fail.
>>>>>> 
>>>>>> if future cards have memory or power is not removed they will they
>>>>>> retain the old setting ?  if so better to explicitly initialize.
>>>>> 
>>>>> Can you please elaborate this a little further?
>>>> 
>>>> Power to the sd slot is supplied via a regulator.  This is turned on
>> at
>>>> power on.
>>>> sometime in the future a reboot is done.  power is NOT removed.  The
>>>> device does not reset
>>>> into the default state.   Have seen this on some boards.
>>> 
>>> Thanks for the explanation. I will modify code to set the default
>> current limit for the card.
>>> 
>>> Regards,
>>> Arindam
>>> 
>>>> 
>>>>> 
>>>>> Thanks,
>>>>> Arindam
>>>>> 
>>>>>> 
>>>>>>> 
>>>>>>> Thanks,
>>>>>>> Arindam
>>>>>>> 
>>>>>>>>> +
>>>>>>>>> +     /* Maximum current supported by host at 1.8V */
>>>>>>>>> +     mmc_host_max_current_180 = host->ops-
>>>>> get_max_current_180(host);
>>>>>>>>> +
>>>>>>>>> +     if (mmc_host_max_current_180 >= 800) {
>>>>>>>>> +             if (card->sw_caps.uhs_curr_limit &
>>>> SD_MAX_CURRENT_800)
>>>>>>>>> +                     current_limit = SD_SET_CURRENT_LIMIT_800;
>>>>>>>>> +             else if (card->sw_caps.uhs_curr_limit &
>>>> SD_MAX_CURRENT_600)
>>>>>>>>> +                     current_limit = SD_SET_CURRENT_LIMIT_600;
>>>>>>>>> +             else if (card->sw_caps.uhs_curr_limit &
>>>> SD_MAX_CURRENT_400)
>>>>>>>>> +                     current_limit = SD_SET_CURRENT_LIMIT_400;
>>>>>>>>> +     } else if (mmc_host_max_current_180 >= 600) {
>>>>>>>>> +             if (card->sw_caps.uhs_curr_limit &
>>>> SD_MAX_CURRENT_600)
>>>>>>>>> +                     current_limit = SD_SET_CURRENT_LIMIT_600;
>>>>>>>>> +             else if (card->sw_caps.uhs_curr_limit &
>>>> SD_MAX_CURRENT_400)
>>>>>>>>> +                     current_limit = SD_SET_CURRENT_LIMIT_400;
>>>>>>>>> +     } else if (mmc_host_max_current_180 >= 400)
>>>>>>>>> +             if (card->sw_caps.uhs_curr_limit &
>>>> SD_MAX_CURRENT_400)
>>>>>>>>> +                     current_limit = SD_SET_CURRENT_LIMIT_400;
>>>>>>>> 
>>>>>>>> or
>>>>>>>>     else
>>>>>>>>            current_limit = SD_SET_CURRENT_LIMIT_200;
>>>>>>>>> +
>>>>>>>>> +     err = mmc_sd_switch(card, 1, 3, current_limit, status);
>>>>>>>>> +     if (err)
>>>>>>>>> +             return err;
>>>>>>>>> +
>>>>>>>>> +     if (((status[15] >> 4) & 0x0F) != current_limit)
>>>>>>>>> +             printk(KERN_WARNING "%s: Problem setting current
>>>> limit!\n",
>>>>>>>>> +                     mmc_hostname(card->host));
>>>>>>>>> +
>>>>>>>>> +     return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> /*
>>>>>>>>> * UHS-I specific initialization procedure
>>>>>>>>> */
>>>>>>>>> @@ -590,6 +630,11 @@ static int mmc_sd_init_uhs_card(struct
>>>>>> mmc_card
>>>>>>>> *card)
>>>>>>>>> 
>>>>>>>>>      /* Set bus speed mode of the card */
>>>>>>>>>      err = sd_set_bus_speed_mode(card, status);
>>>>>>>>> +     if (err)
>>>>>>>>> +             goto out;
>>>>>>>>> +
>>>>>>>>> +     /* Set current limit for the card */
>>>>>>>>> +     err = sd_set_current_limit(card, status);
>>>>>>>>> 
>>>>>>>>> out:
>>>>>>>>>      kfree(status);
>>>>>>>>> diff --git a/drivers/mmc/host/sdhci.c
>> b/drivers/mmc/host/sdhci.c
>>>>>>>>> index f127fa2..245cc39 100644
>>>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>>>> @@ -1462,12 +1462,36 @@ static int
>>>>>>>> sdhci_start_signal_voltage_switch(struct mmc_host *mmc)
>>>>>>>>>      return -EAGAIN;
>>>>>>>>> }
>>>>>>>>> 
>>>>>>>> 
>>>>>>>> better name is sdhci_get_max_current
>>>>>>>> 
>>>>>>>>> +static int sdhci_get_max_current_180(struct mmc_host *mmc)
>>>>>>>>> +{
>>>>>>>>> +     struct sdhci_host *host;
>>>>>>>>> +     u32 max_current_caps;
>>>>>>>>> +     unsigned long flags;
>>>>>>>>> +     int max_current_180;
>>>>>>>>> +
>>>>>>>>> +     host = mmc_priv(mmc);
>>>>>>>>> +
>>>>>>>>> +     spin_lock_irqsave(&host->lock, flags);
>>>>>>>>> +
>>>>>>>>> +     max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
>>>>>>>>> +
>>>>>>>>> +     spin_unlock_irqrestore(&host->lock, flags);
>>>>>>>>> +
>>>>>>>>> +     /* Maximum current is 4 times the register value for 1.8V
>>>> */
>>>>>>>>> +     max_current_180 = ((max_current_caps &
>>>>>>>> SDHCI_MAX_CURRENT_180_MASK) >>
>>>>>>>>> +                        SDHCI_MAX_CURRENT_180_SHIFT) *
>>>>>>>>> +                        SDHCI_MAX_CURRENT_MULTIPLIER;
>>>>>>>> 
>>>>>>>> SDHCI_MAX_CURRENT_SHIFT is better name.
>>>>>>>> 
>>>>>>>>> +
>>>>>>>>> +     return max_current_180;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> static const struct mmc_host_ops sdhci_ops = {
>>>>>>>>>      .request        = sdhci_request,
>>>>>>>>>      .set_ios        = sdhci_set_ios,
>>>>>>>>>      .get_ro         = sdhci_get_ro,
>>>>>>>>>      .enable_sdio_irq = sdhci_enable_sdio_irq,
>>>>>>>>>      .start_signal_voltage_switch    =
>>>>>>>> sdhci_start_signal_voltage_switch,
>>>>>>>>> +     .get_max_current_180            = sdhci_get_max_current_180,
>>>>>>>> 
>>>>>>>> .get_max_current = sdhci_get_max_current;
>>>>>>>>> };
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>> 
>>>>>> 
>>>> 
>> /**********************************************************************
>>>>>>>> *******\
>>>>>>>>> diff --git a/include/linux/mmc/card.h
>> b/include/linux/mmc/card.h
>>>>>>>>> index 0b24c41..a6811ae 100644
>>>>>>>>> --- a/include/linux/mmc/card.h
>>>>>>>>> +++ b/include/linux/mmc/card.h
>>>>>>>>> @@ -98,6 +98,15 @@ struct sd_switch_caps {
>>>>>>>>> #define SD_DRIVER_TYPE_C      0x04
>>>>>>>>> #define SD_DRIVER_TYPE_D      0x08
>>>>>>>>>      unsigned int            uhs_curr_limit;
>>>>>>>>> +#define SD_SET_CURRENT_LIMIT_200     0
>>>>>>>>> +#define SD_SET_CURRENT_LIMIT_400     1
>>>>>>>>> +#define SD_SET_CURRENT_LIMIT_600     2
>>>>>>>>> +#define SD_SET_CURRENT_LIMIT_800     3
>>>>>>>>> +
>>>>>>>>> +#define SD_MAX_CURRENT_200   (1 << SD_SET_CURRENT_LIMIT_200)
>>>>>>>>> +#define SD_MAX_CURRENT_400   (1 << SD_SET_CURRENT_LIMIT_400)
>>>>>>>>> +#define SD_MAX_CURRENT_600   (1 << SD_SET_CURRENT_LIMIT_600)
>>>>>>>>> +#define SD_MAX_CURRENT_800   (1 << SD_SET_CURRENT_LIMIT_800)
>>>>>>>>> };
>>>>>>>>> 
>>>>>>>>> struct sdio_cccr {
>>>>>>>>> diff --git a/include/linux/mmc/host.h
>> b/include/linux/mmc/host.h
>>>>>>>>> index 4dfff6d..e84cd05 100644
>>>>>>>>> --- a/include/linux/mmc/host.h
>>>>>>>>> +++ b/include/linux/mmc/host.h
>>>>>>>>> @@ -128,6 +128,7 @@ struct mmc_host_ops {
>>>>>>>>>      void    (*init_card)(struct mmc_host *host, struct mmc_card
>>>> *card);
>>>>>>>>> 
>>>>>>>>>      int     (*start_signal_voltage_switch)(struct mmc_host
>>>> *host);
>>>>>>>>> +     int     (*get_max_current_180)(struct mmc_host *mmc);
>>>>>>>>> };
>>>>>>>>> 
>>>>>>>>> struct mmc_card;
>>>>>>>>> --
>>>>>>>>> 1.7.1
>>>>>>>>> 
>>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>> 
>>>>> 
>>>>> 
>>>> 
>>> 
>>> 
>> 
> 
> 

