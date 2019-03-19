From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
Date: Tue, 19 Mar 2019 17:15:29 +0530
Message-ID: <b52277dd-39aa-b6ea-313e-55ed65afba1e@ti.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
 <20190319063533.12171-3-faiz_abbas@ti.com>
 <8261c01f-fd8e-0930-fee5-793b02071542@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8261c01f-fd8e-0930-fee5-793b02071542@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi Kishon,

On 19/03/19 1:37 PM, Kishon Vijay Abraham I wrote:
> Hi Faiz,
> 
> On 19/03/19 12:05 PM, Faiz Abbas wrote:
>> commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
>> callback") skips data resets during tuning operation. Because of this,
>> a data error or data finish interrupt might still arrive after a command
>> error has been handled and the mrq ended. This ends up with a "mmc0: Got
>> data interrupt 0x00000002 even though no data operation was in progress"
>> error message.
>>
>> Fix this by adding a platform specific callback for sdhci_irq. Mark the
>> mrq as a failure but wait for a data interrupt instead of calling
>> finish_mrq().
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/mmc/host/sdhci-omap.c | 36 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>> index b1a66ca3821a..765873dff7ca 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -797,6 +797,41 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
>>  	sdhci_reset(host, mask);
>>  }
>>  
>> +#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
>> +#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
>> +
>> +static irqreturn_t sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	if (omap_host->is_tuning && (intmask & CMD_ERR_MASK)) {
>> +
>> +		/*
>> +		 * Since we are not resetting data lines during tuning
>> +		 * operation, data error or data complete interrupts
>> +		 * might still arrive. Mark this request as a failure
>> +		 * but still wait for the data interrupt
>> +		 */
>> +		if (intmask & SDHCI_INT_TIMEOUT)
> 
> CMD_ERR_MASK doesn't have SDHCI_INT_TIMEOUT. So this will never be true.
> 

Yeah, need to SDHCI_INT_TIMEOUT to CMD_ERR_MASK.

Thanks,
Faiz
