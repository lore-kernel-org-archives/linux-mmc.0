From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH] mmc: sdhci: Remove ->platform_init() callback as it's no
 longer used
Date: Tue, 30 Aug 2016 19:51:57 +0530
Message-ID: <52ca6c7b-c69f-3a73-5e9f-257e7e049a1c@codeaurora.org>
References: <1472551338-20019-1-git-send-email-ulf.hansson@linaro.org>
 <d8094057-53d9-81a1-620d-f54e01e6b717@intel.com>
 <CAPDyKFraAAQgSCaunmWe1ok-qCvh_1yRfZbKpCgniuBEbfu-0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55015 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbcH3OWC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 10:22:02 -0400
In-Reply-To: <CAPDyKFraAAQgSCaunmWe1ok-qCvh_1yRfZbKpCgniuBEbfu-0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Ulf & Adrian,


On 8/30/2016 4:10 PM, Ulf Hansson wrote:
> On 30 August 2016 at 12:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 30/08/16 13:02, Ulf Hansson wrote:
>>> The commit 1ef5e49e46b9 ("mmc: sdhci-of-esdhc: add/remove some quirks
>>> according to vendor version") moved sdhci-of-esdhc away from using the
>>> ->platform_init() callback.
>>>
>>> As it was the only user of it and that it seems reasonable to believe that
>>> it won't be needed again, let's remove just remove it.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Have been meaning to do that, but didn't have time:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> However if you have spare time ;-) you could take a look at the Software
>> Command Queue patches, at least the support for sending commands during data
>> transfer:
>
> Yes, I have briefly started. I postponed some of the more heavy
> reviews to be able to catch up with all the simpler changes.
>
> Allow me to get few more days, then I will respond to them!
>
> BTW, I was also hoping Ritesh could help to review the changes.
> Perhaps you can ping him as well.
Yes, I had started looking at those patches till sending commands during 
data transfer.
I will get back on those, once I am completed with the current patches 
on my name. Sorry about the delay.

Regards
Ritesh


>
> Thanks and kind regards
> Uffe
>
>>
>>         http://marc.info/?l=linux-mmc&m=147134458618542
>>
>>> ---
>>>  drivers/mmc/host/sdhci-pltfm.c | 7 -------
>>>  drivers/mmc/host/sdhci.h       | 1 -
>>>  2 files changed, 8 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>>> index 1d17dcf..ad49bfa 100644
>>> --- a/drivers/mmc/host/sdhci-pltfm.c
>>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>>> @@ -156,13 +156,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>>>               host->quirks2 = pdata->quirks2;
>>>       }
>>>
>>> -     /*
>>> -      * Some platforms need to probe the controller to be able to
>>> -      * determine which caps should be used.
>>> -      */
>>> -     if (host->ops && host->ops->platform_init)
>>> -             host->ops->platform_init(host);
>>> -
>>>       platform_set_drvdata(pdev, host);
>>>
>>>       return host;
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 0411c9f..a2bc9e1 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -555,7 +555,6 @@ struct sdhci_ops {
>>>       void    (*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
>>>       void    (*hw_reset)(struct sdhci_host *host);
>>>       void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>>> -     void    (*platform_init)(struct sdhci_host *host);
>>>       void    (*card_event)(struct sdhci_host *host);
>>>       void    (*voltage_switch)(struct sdhci_host *host);
>>>       int     (*select_drive_strength)(struct sdhci_host *host,
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
