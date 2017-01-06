From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: Re: [PATCH RESEND] sdhci: Only handle CARD_INT for SDIO cards
Date: Fri, 06 Jan 2017 13:49:54 -0200
Message-ID: <87y3yo89y5.fsf@dilma.collabora.co.uk>
References: <20170102182350.14326-1-krisman@collabora.co.uk>
        <39099b85-e55c-ac70-8e0f-889638a68418@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40401 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936477AbdAFPuG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jan 2017 10:50:06 -0500
In-Reply-To: <39099b85-e55c-ac70-8e0f-889638a68418@intel.com> (Adrian Hunter's
        message of "Thu, 5 Jan 2017 11:36:49 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

Adrian Hunter <adrian.hunter@intel.com> writes:

> On 02/01/17 20:23, Gabriel Krisman Bertazi wrote:
>> One of our kernelCI boxes hanged at boot because a faulty eSDHC device
>> was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
>> reads, which are not allowed for SD devices.  This adds a sanity check
>> to the interruption path, preventing that illegal command from getting
>> sent to SD devices.
>> 
>> This quirk allows that particular machine to resume boot despite the
>> faulty hardware, instead of getting hung dealing with thousands of
>> mishandled interrupts.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
>> CC: Adrian Hunter <adrian.hunter@intel.com>
>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>> CC: linux-mmc@vger.kernel.org
>> ---
>>  drivers/mmc/host/sdhci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 23909804ffb8..43913876581e 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2665,6 +2665,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>>  {
>>  	irqreturn_t result = IRQ_NONE;
>>  	struct sdhci_host *host = dev_id;
>> +	struct mmc_host *mmc = host->mmc;
>>  	u32 intmask, mask, unexpected = 0;
>>  	int max_loops = 16;
>>  
>> @@ -2733,7 +2734,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>>  		if (intmask & SDHCI_INT_RETUNE)
>>  			mmc_retune_needed(host->mmc);
>>  
>> -		if (intmask & SDHCI_INT_CARD_INT) {
>> +		if (intmask & SDHCI_INT_CARD_INT && mmc->card &&
>> +		    (mmc->card->type == MMC_TYPE_SDIO ||
>> +		     mmc->card->type == MMC_TYPE_SD_COMBO)) {
>
> We shouldn't have to look at the card type.  But if the interrupt is not
> enabled, then we shouldn't process it.  What about:

Hi Adrian,

Thanks for your review.  I think this way is ok too, I also ran it
against the faulty hardware and it prevented the hang as well.  I
just submitted a v2.

-- 
Gabriel Krisman Bertazi
