From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RESEND RFC 3/3] mmc: sdhci: Add more debug info in case of data
 error
Date: Fri, 20 Jan 2017 11:56:43 +0530
Message-ID: <c4caacf6-fd06-8cfd-0698-b9e45a938ba2@codeaurora.org>
References: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
 <1484030515-16722-4-git-send-email-riteshh@codeaurora.org>
 <74840dea-18b6-3b51-67ae-e1ce3bb7fb58@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdATG0w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 01:26:52 -0500
In-Reply-To: <74840dea-18b6-3b51-67ae-e1ce3bb7fb58@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com

Hi Adrian,

Thanks for reviewing.

On 1/19/2017 5:24 PM, Adrian Hunter wrote:
> On 10/01/17 08:41, Ritesh Harjani wrote:
>> print error log message and dump sdhc registers for debugging
>> purpose in case of data errors (except when tuning commands
>> generate CRC/timeout/end bit errors).
>
> It is a bit ugly and probably only useful during driver development, so I am
> not at all enthusiastic about this.
Ok, since this patch was anyway for debugging, I will drop this patch 
for now. I will revisit in case if the need really arises, since this 
could be useful in debugging data txfr error and avoid re-test cycle to 
get sdhci register dumps.



Also,
Do you think we should have this below change added? Could you please 
give your thoughts on this. Jeremy and I feel that even below info can 
be helpful along with sdhci_dumpregs -
He requested me to take below diff as another patch in my next revision 
of this series which he has submitted here -

https://patchwork.kernel.org/patch/9442449/


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 71654b9..5911f98 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,6 +47,27 @@  static void sdhci_finish_data(struct sdhci_host *);

  static void sdhci_enable_preset_value(struct sdhci_host *host, bool 
enable);

+static void sdhci_dump_rpm_info(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	pr_info("%s: 
rpmstatus[pltfm](runtime-suspend:usage_count:disable_depth)(%d:%d:%d)\n",
+		mmc_hostname(mmc), mmc->parent->power.runtime_status,
+		atomic_read(&mmc->parent->power.usage_count),
+		mmc->parent->power.disable_depth);
+}
+
+
+static void sdhci_dump_state(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	pr_info("%s: clk: %d claimer: %s pwr: %d\n",
+		mmc_hostname(mmc), host->clock,
+		mmc->claimer->comm, host->pwr);
+		sdhci_dump_rpm_info(host);
+}
+
  static void sdhci_dumpregs(struct sdhci_host *host)
  {
  	pr_err(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
@@ -100,6 +121,10 @@  static void sdhci_dumpregs(struct sdhci_host *host)
  			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
  	}

+	if (host->ops->dump_vendor_regs)
+		host->ops->dump_vendor_regs(host);
+
+	sdhci_dump_state(host);
  	pr_err(DRIVER_NAME ": ===========================================\n");
  }

Regards
Ritesh

>
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 73a8918..2e51e49 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2616,9 +2616,26 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>  			host->ops->adma_workaround(host, intmask);
>>  	}
>>
>> -	if (host->data->error)
>> +	if (host->data->error) {
>> +		bool pr_msg = true;
>> +
>> +		if (intmask & (SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
>> +		    SDHCI_INT_DATA_END_BIT)) {
>> +			command = SDHCI_GET_CMD(sdhci_readw(host,
>> +							    SDHCI_COMMAND));
>> +			if (command == MMC_SEND_TUNING_BLOCK_HS200 ||
>> +			    command == MMC_SEND_TUNING_BLOCK)
>> +				pr_msg = false;
>> +		}
>> +		if (pr_msg) {
>> +			pr_err("%s: data txfr (0x%08x) error: %d\n",
>> +			       mmc_hostname(host->mmc), intmask,
>> +			       host->data->error);
>> +			sdhci_dumpregs(host);
>> +		}
>> +
>>  		sdhci_finish_data(host);
>> -	else {
>> +	} else {
>>  		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
>>  			sdhci_transfer_pio(host);
>>
>>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
