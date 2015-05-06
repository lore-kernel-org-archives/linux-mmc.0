From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 12/15] mmc: sdhci: Flag re-tuning is needed on CRC
 or End-Bit errors
Date: Wed, 06 May 2015 14:09:13 +0300
Message-ID: <5549F659.4030909@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>	<1429531796-21987-13-git-send-email-adrian.hunter@intel.com> <CAPDyKFry+QwUGc4yYDPV1fC9LQYit41uh+s0du7dpxSM0te=Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60709 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbbEFLL0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 May 2015 07:11:26 -0400
In-Reply-To: <CAPDyKFry+QwUGc4yYDPV1fC9LQYit41uh+s0du7dpxSM0te=Bg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 04/05/15 16:55, Ulf Hansson wrote:
> On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> CRC or End-Bit errors could possibly be alleviated by
>> re-tuning so flag re-tuning needed in those cases.
>> Note this has no effect if re-tuning has not been
>> enabled.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index b345844..d11fae7 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2307,8 +2307,10 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
>>         if (intmask & SDHCI_INT_TIMEOUT)
>>                 host->cmd->error = -ETIMEDOUT;
>>         else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
>> -                       SDHCI_INT_INDEX))
>> +                       SDHCI_INT_INDEX)) {
>>                 host->cmd->error = -EILSEQ;
>> +               mmc_retune_needed(host->mmc);
> 
> I would rather see this to be handled by the mmc core, to have all
> hosts benefit from it.

Now that the core is enabling re-tuning, that will cause re-tuning to happen
on platforms where it has never been used before (or more specifically where
tuning has been used only during initialization)

I have no idea if that is the right thing for all host controllers and
platforms.

Are you sure you want to do that?

> 
>> +       }
>>
>>         if (host->cmd->error) {
>>                 tasklet_schedule(&host->finish_tasklet);
>> @@ -2433,13 +2435,15 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>
>>         if (intmask & SDHCI_INT_DATA_TIMEOUT)
>>                 host->data->error = -ETIMEDOUT;
>> -       else if (intmask & SDHCI_INT_DATA_END_BIT)
>> +       else if (intmask & SDHCI_INT_DATA_END_BIT) {
>>                 host->data->error = -EILSEQ;
>> -       else if ((intmask & SDHCI_INT_DATA_CRC) &&
>> +               mmc_retune_needed(host->mmc);
>> +       } else if ((intmask & SDHCI_INT_DATA_CRC) &&
>>                 SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
>> -                       != MMC_BUS_TEST_R)
>> +                       != MMC_BUS_TEST_R) {
>>                 host->data->error = -EILSEQ;
>> -       else if (intmask & SDHCI_INT_ADMA_ERROR) {
>> +               mmc_retune_needed(host->mmc);
>> +       } else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>                 pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
>>                 sdhci_adma_show_error(host);
>>                 host->data->error = -EIO;
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 
> 

