From: "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
Date: Tue, 12 Mar 2019 23:04:47 +0530
Message-ID: <eb76397b-aa02-f1b8-ef0d-df7569275144@ti.com>
References: <20190301083824.23918-1-faiz_abbas@ti.com>
 <20190301083824.23918-3-faiz_abbas@ti.com>
 <0283e92e-9e01-227d-0987-7801dd88cf78@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0283e92e-9e01-227d-0987-7801dd88cf78@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 3/6/2019 5:39 PM, Adrian Hunter wrote:
> On 1/03/19 10:38 AM, Faiz Abbas wrote:
>> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
>> callback") skips data resets during tuning operation. Because of this,
>> a data error or data finish interrupt might still arrive after a command
>> error has been handled and the mrq ended. This ends up with a "mmc0: Got
>> data interrupt 0x00000002 even though no data operation was in progress"
>> error message.
>>
>> Fix this by adding a platform specific callback for command errors. Mark
>> the mrq as a failure but wait for a data interrupt instead of calling
>> finish_mrq().
>>
>> Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
>> callback")
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci-omap.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>> index b1a66ca3821a..67b361a403bc 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -797,6 +797,29 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>>  	sdhci_reset(host, mask);
>>  }
>>  
>> +void sdhci_omap_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	if (omap_host->is_tuning) {
>> +		/*
>> +		 * Since we are not resetting data lines during tuning
>> +		 * operation, data error or data complete interrupts
>> +		 * might still arrive. Mark this request as a failure
>> +		 * but still wait for the data interrupt
>> +		 */
>> +		if (intmask & SDHCI_INT_TIMEOUT)
>> +			host->cmd->error = -ETIMEDOUT;
>> +		else
>> +			host->cmd->error = -EILSEQ;
>> +
>> +		sdhci_finish_command(host);
>> +	} else {
>> +		sdhci_cmd_err(host, intmask, intmask_p);
>> +	}
>> +}
> 
> Could this be done by the existing ->irq() callback? i.e. mask the error
> bits in intmask (have to write them back to SDHCI_INT_STATUS also) but set
> cmd->error.
> 

It is possible but I really don't want the callback to be unnecessarily
called for every single interrupt that happens. I think we should only
use the callback in the case of an actual error interrupt :-)

Thanks,
Faiz
