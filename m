From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: Disable re-tuning for HS400
Date: Tue, 02 Dec 2014 12:08:50 +0200
Message-ID: <547D8FB2.1020400@intel.com>
References: <1417439766-5063-1-git-send-email-adrian.hunter@intel.com>	<1417439766-5063-4-git-send-email-adrian.hunter@intel.com> <CAPDyKFq30Qkx8rW1ixavv=UdBjcQfsz6kDvcfmcTq4A4ziptUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1344 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521AbaLBKVk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Dec 2014 05:21:40 -0500
In-Reply-To: <CAPDyKFq30Qkx8rW1ixavv=UdBjcQfsz6kDvcfmcTq4A4ziptUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 02/12/14 11:35, Ulf Hansson wrote:
> On 1 December 2014 at 14:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Re-tuning for HS400 mode must be done in HS200
>> mode. Currently there is no support for that.
>> That needs to be reflected in the code.
>> Specifically, if tuning is executed in HS400 mode
>> then return an error, and if the re-tuning timer
>> is running when switching to HS400 mode, then
>> disable the timer.
>>
>> Note that periodic re-tuning is not expected
>> to be needed for HS400 but re-tuning is still
>> needed after the host controller has lost power.
> 
> Why can't the old values be restored instead of trigger a re-tuning?

The "values" (not sure what you mean by that) are not available to the
driver. Even if they were the operating conditions may have changed, (i.e.
temperature change) so the old "values" could still be wrong.

Jedec spec. says:

	It is recommended to perform tuning procedure while Device wakes
	up, after sleep.

SDHCI spec. says:

	If the Host System goes into power down mode, the Host Driver
	should stop the re-tuning timer and set the expiration flag
	to 1 when the Host System resumes from power down mode.

> 
>> In the case of suspend/resume that is not necessary
>> because the card is fully re-initialised. That
>> just leaves runtime suspend/resume with no support
>> for HS400 re-tuning.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2efa7fe..a7c9e67 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1476,8 +1476,18 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>>         else if ((timing == MMC_TIMING_UHS_DDR50) ||
>>                  (timing == MMC_TIMING_MMC_DDR52))
>>                 ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>> -       else if (timing == MMC_TIMING_MMC_HS400)
>> +       else if (timing == MMC_TIMING_MMC_HS400) {
>>                 ctrl_2 |= SDHCI_CTRL_HS400; /* Non-standard */
>> +               /*
>> +                * Periodic re-tuning for HS400 is not expected to be needed, so
>> +                * disable it here.
> 
> Urgh, I don't like that the periodic tuning is handled by the host. We
> should never had merged that.
> 
> How about trying to move the periodic tuning to be handled by the mmc
> core instead?

I have patches for that. I hope to send them today.

> 
>> +                */
>> +               if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>> +                       host->flags &= ~SDHCI_USING_RETUNING_TIMER;
>> +                       del_timer_sync(&host->tuning_timer);
>> +                       host->flags &= ~SDHCI_NEEDS_RETUNING;
>> +               }
>> +       }
>>         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>  }
>>  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
>> @@ -1897,7 +1907,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>          * tuning function has to be executed.
>>          */
>>         switch (host->timing) {
>> +       /* HS400 tuning is done in HS200 mode */
>>         case MMC_TIMING_MMC_HS400:
>> +               err = -EINVAL;
>> +               goto out_unlock;
>> +
>>         case MMC_TIMING_MMC_HS200:
>>         case MMC_TIMING_UHS_SDR104:
>>                 break;
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 
> 

