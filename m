From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 12/15] mmc: sdhci: Flag re-tuning is needed on CRC or
 End-Bit errors
Date: Wed, 6 May 2015 13:40:58 +0200
Message-ID: <CAPDyKFqZsfAJKr9UOj2d2ZoS1vB3OYFO+it8KHnutSkH-xhSQA@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<1429531796-21987-13-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFry+QwUGc4yYDPV1fC9LQYit41uh+s0du7dpxSM0te=Bg@mail.gmail.com>
	<5549F659.4030909@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34185 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbbEFLk7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 07:40:59 -0400
Received: by qkgx75 with SMTP id x75so3535742qkg.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2015 04:40:58 -0700 (PDT)
In-Reply-To: <5549F659.4030909@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 6 May 2015 at 13:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 04/05/15 16:55, Ulf Hansson wrote:
>> On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> CRC or End-Bit errors could possibly be alleviated by
>>> re-tuning so flag re-tuning needed in those cases.
>>> Note this has no effect if re-tuning has not been
>>> enabled.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 14 +++++++++-----
>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index b345844..d11fae7 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2307,8 +2307,10 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
>>>         if (intmask & SDHCI_INT_TIMEOUT)
>>>                 host->cmd->error = -ETIMEDOUT;
>>>         else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
>>> -                       SDHCI_INT_INDEX))
>>> +                       SDHCI_INT_INDEX)) {
>>>                 host->cmd->error = -EILSEQ;
>>> +               mmc_retune_needed(host->mmc);
>>
>> I would rather see this to be handled by the mmc core, to have all
>> hosts benefit from it.
>
> Now that the core is enabling re-tuning, that will cause re-tuning to happen
> on platforms where it has never been used before (or more specifically where
> tuning has been used only during initialization)
>
> I have no idea if that is the right thing for all host controllers and
> platforms.
>
> Are you sure you want to do that?

This is required by the specs, so at least I think we should give it a try.

If we see issues with it, we could have it as an opt-in/out MMC_CAP.

Kind regards
Uffe
