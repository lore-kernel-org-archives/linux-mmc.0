From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/4] mmc: Add quirk to disable SDR50 mode
Date: Fri, 06 Nov 2015 16:09:21 -0800
Message-ID: <563D4131.80207@gmail.com>
References: <1446763200-10234-1-git-send-email-alcooperx@gmail.com> <CAPDyKFrhtoDwe82Zg4YP4eU=xO6zE1pZTcRSnzSeHGRCzgu+5w@mail.gmail.com> <563D3E0F.70906@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34450 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbbKGAKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 19:10:10 -0500
Received: by padhx2 with SMTP id hx2so129071216pad.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2015 16:10:10 -0800 (PST)
In-Reply-To: <563D3E0F.70906@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Al Cooper <alcooperx@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On 06/11/15 15:55, Scott Branden wrote:
> Hi Ulf,
> 
> On 15-11-06 12:14 AM, Ulf Hansson wrote:
>> On 5 November 2015 at 23:39, Al Cooper <alcooperx@gmail.com> wrote:
>>> Add quirk to disable SDR50 mode for controllers/boards that have
>>> problems with this mode.
>>
>> No thanks! No more quirks please!
>>
> 
> I'm fine with not having this quirk added (I don't need this one but use
> multiple of the other quirks in the driver)  But, what if I also needed
> it in my driver?  When do we determine when a quirk should be added to
> sdhci.c or not.  What about existing quirks - should the current ones be
> moved to multiple existing drivers?
>> Kind regards
>> Uffe
>>
>>>
>>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>>> ---
>>>   drivers/mmc/host/sdhci.c | 3 +++
>>>   drivers/mmc/host/sdhci.h | 2 ++
>>>   2 files changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index b48565e..71067c7 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3176,6 +3176,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>>          } else if (caps[1] & SDHCI_SUPPORT_SDR50)
>>>                  mmc->caps |= MMC_CAP_UHS_SDR50;
>>>
>>> +       if (host->quirks2 & SDHCI_QUIRK2_BROKEN_SDR50)
>>> +               mmc->caps &= ~MMC_CAP_UHS_SDR50;
>>> +
> Perhaps a lot of these quirks can be solved by having a generic
> mechanism to override any of the values in the caps registers rather
> than adding all these quirks?

Are the capabilities register override specific to the Arasan controller
or is there a generic and well define SDIO configuration register for
these registers? The register information I am looking at seems to
suggest this is part of how you glue your SDIO controller to your SoC.

The entire purpose of Al's changes were precisely so we do not have to
fiddle with these capabilities register like we are currently doing in
some versions of our downstream kernel.
-- 
Florian
