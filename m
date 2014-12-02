From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci: Disable re-tuning for HS400
Date: Tue, 2 Dec 2014 12:20:45 +0100
Message-ID: <CAPDyKFq=TxzGmQws6RmtchfxN9FBqUryirA306AW0wANZzn0-g@mail.gmail.com>
References: <1417439766-5063-1-git-send-email-adrian.hunter@intel.com>
	<1417439766-5063-4-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFq30Qkx8rW1ixavv=UdBjcQfsz6kDvcfmcTq4A4ziptUQ@mail.gmail.com>
	<547D8FB2.1020400@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:55002 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbaLBLUq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Dec 2014 06:20:46 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so8757940qae.27
        for <linux-mmc@vger.kernel.org>; Tue, 02 Dec 2014 03:20:45 -0800 (PST)
In-Reply-To: <547D8FB2.1020400@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 2 December 2014 at 11:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 02/12/14 11:35, Ulf Hansson wrote:
>> On 1 December 2014 at 14:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Re-tuning for HS400 mode must be done in HS200
>>> mode. Currently there is no support for that.
>>> That needs to be reflected in the code.
>>> Specifically, if tuning is executed in HS400 mode
>>> then return an error, and if the re-tuning timer
>>> is running when switching to HS400 mode, then
>>> disable the timer.
>>>
>>> Note that periodic re-tuning is not expected
>>> to be needed for HS400 but re-tuning is still
>>> needed after the host controller has lost power.
>>
>> Why can't the old values be restored instead of trigger a re-tuning?
>
> The "values" (not sure what you mean by that) are not available to the
> driver. Even if they were the operating conditions may have changed, (i.e.
> temperature change) so the old "values" could still be wrong.

The "values" I refer to is those which we "calculated" during the
tuning process.

What I had in mind, was that we should save these values at runtime PM
suspend. And restore them at runtime PM resume. For some mmc
controllers the "values" are typically just a some bits in a
controller register, but that might not be true for all cases.

Regarding the temperature change, etc. I think that is what the
periodic retuning should be taken care off.

Could you elaborate on why the "values" is not available to the driver?

>
> Jedec spec. says:
>
>         It is recommended to perform tuning procedure while Device wakes
>         up, after sleep.
>
> SDHCI spec. says:
>
>         If the Host System goes into power down mode, the Host Driver
>         should stop the re-tuning timer and set the expiration flag
>         to 1 when the Host System resumes from power down mode.

I am not sure how to interpret this. Is the context about system PM or
runtime PM?

>
>>
>>> In the case of suspend/resume that is not necessary
>>> because the card is fully re-initialised. That
>>> just leaves runtime suspend/resume with no support
>>> for HS400 re-tuning.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 2efa7fe..a7c9e67 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1476,8 +1476,18 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>>>         else if ((timing == MMC_TIMING_UHS_DDR50) ||
>>>                  (timing == MMC_TIMING_MMC_DDR52))
>>>                 ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>>> -       else if (timing == MMC_TIMING_MMC_HS400)
>>> +       else if (timing == MMC_TIMING_MMC_HS400) {
>>>                 ctrl_2 |= SDHCI_CTRL_HS400; /* Non-standard */
>>> +               /*
>>> +                * Periodic re-tuning for HS400 is not expected to be needed, so
>>> +                * disable it here.
>>
>> Urgh, I don't like that the periodic tuning is handled by the host. We
>> should never had merged that.
>>
>> How about trying to move the periodic tuning to be handled by the mmc
>> core instead?
>
> I have patches for that. I hope to send them today.

Great! Looking forward to review them!

Kind regards
Uffe
