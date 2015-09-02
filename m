From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-pxav3: Fix tabbing issue
Date: Wed, 2 Sep 2015 13:09:21 +0530
Message-ID: <55E6A7A9.3070309@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150902145408.69a44f71@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902145408.69a44f71@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Wednesday 02 September 2015 12:24 PM, Jisheng Zhang wrote:
> On Wed, 2 Sep 2015 00:54:13 +0530
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>
>> There were some coding style issues where spaces have been used instead
>> of tabs, for example, in macro definitions, alignment of function
>> declarations/definitions, etc...
>>
>> This patch fixes all such occurrences in the code.
>> And also use BIT for bit definitions.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/mmc/host/sdhci-pxav3.c | 63 ++++++++++++++++++++++--------------------
>>   1 file changed, 33 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index 946d37f..d02bc37 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -39,24 +39,29 @@
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
>> +#define  SDCFG_GEN_PAD_CLK_ON		BIT(6)
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
>> +#define  SDCE_MISC_INT			BIT(2)
>> +#define  SDCE_MISC_INT_EN		BIT(1)
>
> BIT or (1 << y) are both fine, is there any reason to change to BIT?
> If so, there will be lots of source code need such changes.
>

I have received comments for my other patches (PMIC/Regulator/mfd),
so applying same here as well before doing any real
functionality/coding changes to the driver.


>> +
>> +/* IO Power control */
>> +#define IO_PWR_AKEY_ASFAR		0xbaba
>> +#define IO_PWR_AKEY_ASSAR		0xeb10
>> +#define IO_PWR_MMC1_PAD_1V8		BIT(2)
>>
>>   struct sdhci_pxa {
>>   	struct clk *clk_core;
>> @@ -128,7 +133,7 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
>>   }
>>
>>   static int armada_38x_quirks(struct platform_device *pdev,
>> -			     struct sdhci_host *host)
>> +			struct sdhci_host *host)
>>   {
>>   	struct device_node *np = pdev->dev.of_node;
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -136,8 +141,7 @@ static int armada_38x_quirks(struct platform_device *pdev,
>>   	struct resource *res;
>>
>>   	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> -					   "conf-sdio3");
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "conf-sdio3");
>>   	if (res) {
>>   		pxa->sdio3_conf_reg = devm_ioremap_resource(&pdev->dev, res);
>>   		if (IS_ERR(pxa->sdio3_conf_reg))
>> @@ -284,10 +288,10 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>   	 * FE-2946959
>>   	 */
>>   	if (pxa->sdio3_conf_reg) {
>> -		u8 reg_val  = readb(pxa->sdio3_conf_reg);
>> +		u8 reg_val = readb(pxa->sdio3_conf_reg);
>>
>>   		if (uhs == MMC_TIMING_UHS_SDR50 ||
>> -		    uhs == MMC_TIMING_UHS_DDR50) {
>> +				uhs == MMC_TIMING_UHS_DDR50) {
>>   			reg_val &= ~SDIO3_CONF_CLK_INV;
>>   			reg_val |= SDIO3_CONF_SD_FB_CLK;
>>   		} else {
>> @@ -304,20 +308,20 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
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
>>   };
>
> IMHO these two styles are both fine. For example, the mmc_sd_ops structure in
> drivers/mmc/core/sd.c also follows the sdhci-pxav3's original coding style
>
>>

Ditto here.

I did similar changes to mfd driver, so applied same changes here as
well.

Trying to avoid another spin of actual patches due to such trivial 
comments :)


Thanks,
Vaibhav
