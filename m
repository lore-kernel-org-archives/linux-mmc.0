From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v2 1/3] mmc: sdhci-pxav3: Fix tabbing issue
Date: Mon, 7 Sep 2015 18:22:59 +0530
Message-ID: <55ED88AB.2080102@linaro.org>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441625471-16315-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150907195623.479382b2@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150907195623.479382b2@xhacker>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On Monday 07 September 2015 05:26 PM, Jisheng Zhang wrote:
> On Mon, 7 Sep 2015 17:01:09 +0530
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> There were some coding style issues where spaces have been used instead
>> of tabs, for example, in macro definitions, alignment of function
>> declarations/definitions, etc...
>>
>> This patch fixes all such occurrences in the code.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   drivers/mmc/host/sdhci-pxav3.c | 46 +++++++++++++++++++++---------------------
>>   1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index 946d37f..7a07177 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -39,24 +39,24 @@
>>   #include "sdhci.h"
>>   #include "sdhci-pltfm.h"
>>
>> -#define PXAV3_RPM_DELAY_MS     50
>> +#define PXAV3_RPM_DELAY_MS		50
>>
>> -#define SD_CLOCK_BURST_SIZE_SETUP		0x10A
>> -#define SDCLK_SEL	0x100
>> -#define SDCLK_DELAY_SHIFT	9
>> -#define SDCLK_DELAY_MASK	0x1f
>> +#define SD_CLOCK_BURST_SIZE_SETUP	0x10A
>> +#define SDCLK_SEL			0x100
>> +#define  SDCLK_DELAY_SHIFT		9
>> +#define  SDCLK_DELAY_MASK		0x1f
>>
>> -#define SD_CFG_FIFO_PARAM       0x100
>> -#define SDCFG_GEN_PAD_CLK_ON	(1<<6)
>> -#define SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
>> -#define SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
>> +#define SD_CFG_FIFO_PARAM		0x100
>> +#define  SDCFG_GEN_PAD_CLK_ON		(1<<6)
>> +#define  SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
>> +#define  SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
>>
>> -#define SD_SPI_MODE          0x108
>> -#define SD_CE_ATA_1          0x10C
>> +#define SD_SPI_MODE			0x108
>> +#define SD_CE_ATA_1			0x10C
>>
>> -#define SD_CE_ATA_2          0x10E
>> -#define SDCE_MISC_INT		(1<<2)
>> -#define SDCE_MISC_INT_EN	(1<<1)
>> +#define SD_CE_ATA_2			0x10E
>> +#define  SDCE_MISC_INT			(1<<2)
>> +#define  SDCE_MISC_INT_EN		(1<<1)
>>
>>   struct sdhci_pxa {
>>   	struct clk *clk_core;
>> @@ -284,7 +284,7 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>   	 * FE-2946959
>>   	 */
>>   	if (pxa->sdio3_conf_reg) {
>> -		u8 reg_val  = readb(pxa->sdio3_conf_reg);
>> +		u8 reg_val = readb(pxa->sdio3_conf_reg);
>>
>>   		if (uhs == MMC_TIMING_UHS_SDR50 ||
>>   		    uhs == MMC_TIMING_UHS_DDR50) {
>> @@ -304,20 +304,20 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>   }
>>
>>   static const struct sdhci_ops pxav3_sdhci_ops = {
>> -	.set_clock = sdhci_set_clock,
>> -	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
>> -	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> -	.set_bus_width = sdhci_set_bus_width,
>> -	.reset = pxav3_reset,
>> -	.set_uhs_signaling = pxav3_set_uhs_signaling,
>> +	.set_clock			= sdhci_set_clock,
>> +	.platform_send_init_74_clocks	= pxav3_gen_init_74_clocks,
>> +	.get_max_clock			= sdhci_pltfm_clk_get_max_clock,
>> +	.set_bus_width			= sdhci_set_bus_width,
>> +	.reset				= pxav3_reset,
>> +	.set_uhs_signaling		= pxav3_set_uhs_signaling,
>
> IMHO, this is not an improvement, previous style is fine and I saw
> such style in kernel here and there
>

I had received feedback to use above style on different patch-series.
And I also think this looks more clean and readable.

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
