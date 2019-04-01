From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add Quirk for enabling HISPD under
 special conditions
Date: Mon, 1 Apr 2019 12:12:02 +0300
Message-ID: <6d8f9b8c-dd5c-a091-7a82-10e5f6606b4e@intel.com>
References: <20190329142202.15000-1-faiz_abbas@ti.com>
 <20190329142202.15000-2-faiz_abbas@ti.com>
 <f1417015-0e78-6df5-7917-a33e235fa1a9@intel.com>
 <350cd133-302f-4002-4b54-d95e7e5d3500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <350cd133-302f-4002-4b54-d95e7e5d3500@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 1/04/19 12:01 PM, Faiz Abbas wrote:
> Hi Adrian,
> 
> On 01/04/19 2:21 PM, Adrian Hunter wrote:
>> On 29/03/19 4:22 PM, Faiz Abbas wrote:
>>> Some controllers on TI devices requires the HISPD bit to be cleared
>>> even in some high speed modes. Add a quirk that facilitates this
>>> requirement.
>>
>> Could you use sdhci I/O accessors for this?
> 
> Can you elaborate? Not sure how this would be solved with
> CONFIG_MMC_SDHCI_IO_ACCESSORS.

In ->writeb()

if (reg == SDHCI_HOST_CONTROL) {
	if (host->mmc->ios->timing == whatever)
		val &= ~SDHCI_CTRL_HISPD;
}

writeb(val, host->ioaddr + reg);


> 
> Thanks,
> Faiz
> 
>>
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++------------
>>>  drivers/mmc/host/sdhci.h |  2 ++
>>>  2 files changed, 26 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index a8141ff9be03..ed4ed6054ddf 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1916,18 +1916,30 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>>  
>>>  	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
>>> -		if (ios->timing == MMC_TIMING_SD_HS ||
>>> -		     ios->timing == MMC_TIMING_MMC_HS ||
>>> -		     ios->timing == MMC_TIMING_MMC_HS400 ||
>>> -		     ios->timing == MMC_TIMING_MMC_HS200 ||
>>> -		     ios->timing == MMC_TIMING_MMC_DDR52 ||
>>> -		     ios->timing == MMC_TIMING_UHS_SDR50 ||
>>> -		     ios->timing == MMC_TIMING_UHS_SDR104 ||
>>> -		     ios->timing == MMC_TIMING_UHS_DDR50 ||
>>> -		     ios->timing == MMC_TIMING_UHS_SDR25)
>>> -			ctrl |= SDHCI_CTRL_HISPD;
>>> -		else
>>> -			ctrl &= ~SDHCI_CTRL_HISPD;
>>> +		if ((host->quirks2 & SDHCI_QUIRK2_TI_HISPD_BIT)) {
>>> +			if (ios->timing == MMC_TIMING_MMC_HS400 ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
>>> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
>>> +			    ios->timing == MMC_TIMING_UHS_DDR50)
>>> +				ctrl |= SDHCI_CTRL_HISPD;
>>> +			else
>>> +				ctrl &= ~SDHCI_CTRL_HISPD;
>>> +		} else {
>>> +			if (ios->timing == MMC_TIMING_SD_HS ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS400 ||
>>> +			    ios->timing == MMC_TIMING_MMC_HS200 ||
>>> +			    ios->timing == MMC_TIMING_MMC_DDR52 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR50 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR104 ||
>>> +			    ios->timing == MMC_TIMING_UHS_DDR50 ||
>>> +			    ios->timing == MMC_TIMING_UHS_SDR25)
>>> +				ctrl |= SDHCI_CTRL_HISPD;
>>> +			else
>>> +				ctrl &= ~SDHCI_CTRL_HISPD;
>>> +		}
>>>  	}
>>>  
>>>  	if (host->version >= SDHCI_SPEC_300) {
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 01002cba1359..aac026c5e184 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -485,6 +485,8 @@ struct sdhci_host {
>>>   * block count.
>>>   */
>>>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
>>> +/* Some TI devices need the high speed bit disabled even in high speed modes */
>>> +#define SDHCI_QUIRK2_TI_HISPD_BIT			(1<<19)
>>>  
>>>  	int irq;		/* Device IRQ */
>>>  	void __iomem *ioaddr;	/* Mapped address */
>>>
>>
> 
