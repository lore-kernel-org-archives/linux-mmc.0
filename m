From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH V2 2/2] sdhci: Support for SD/MMC Dual Data Rate
Date: Sun, 2 Jan 2011 11:02:32 -0800
Message-ID: <2D605427-1ED4-4599-9F4D-0ED8A4FB6D4E@marvell.com>
References: <35CD48DB-A420-4319-968D-400D45EE9C0D@marvell.com>
 <20110102185557.GB24820@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54172 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754488Ab1ABTCf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Jan 2011 14:02:35 -0500
In-Reply-To: <20110102185557.GB24820@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


On Jan 2, 2011, at 10:55 AM, Chris Ball wrote:

> Hi Philip,
> 
> On Sun, Jan 02, 2011 at 08:45:10AM -0800, Philip Rakity wrote:
>> 
>> mmc->caps MMC_CAP_1_8V_DDR is set by looking at cabability_1
>> register if sd 3.0 controller.
>> 
>> Support for dual data rate (DDR50) with 1_8V signalling added
>> with optional call back to enable external control of signalling
>> voltage.
>> 
>> no support for 1.2V core voltage since SD 3.0 does not support
>> this.
>> 
>> **** QUESTION ****
>> should this be part of regulator framework ?
>> 
>> delay for signaling voltage to settle set to 5ms (per spec).
>> 
>> this code does not change the voltage supplied to the card.
>> It assumes that this is correctly handled in the core/ layer.
>> 
>> There is no requirement that the card voltage be at 1.8v
>> for DDR to work.  This violates DDR specification for
>> SD Host Controller 3.0 since explicitly states card voltage
>> is 3.3v while signalling voltage is set to 1.8v.
>> 
>> tested on mmp2 -- brownstone -- under linux-next.
>> 
>> Note:  this board design runs a fixed voltage to the card and
>> signaling voltage cannot be changed.
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>> drivers/mmc/host/sdhci.c |   53 ++++++++++++++++++++++++++++++++++++++++++---
>> drivers/mmc/host/sdhci.h |    5 ++++
>> 2 files changed, 54 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d5febe5..805f850 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -84,6 +84,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
>> 	printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
>> 		sdhci_readw(host, SDHCI_COMMAND),
>> 		sdhci_readl(host, SDHCI_MAX_CURRENT));
>> +	printk(KERN_DEBUG DRIVER_NAME ": HostCtrl2:0x%08x\n",
>> +		sdhci_readw(host, SDHCI_HOST_CONTROL_2));
>> 
>> 	if (host->flags & SDHCI_USE_ADMA)
>> 		printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
>> @@ -986,6 +988,38 @@ static void sdhci_finish_command(struct sdhci_host *host)
>> 	host->cmd = NULL;
>> }
>> 
>> +/*
>> + * Handle 1.8V signaling for DDR. No need to check for other
>> + * DDR values since driver supports ONLY 1_8V DDR.  This is
>> + * set by the MMC_CAP_1_8V_DDR.  1_2V DDR is not supported.
>> + */
>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
>> +{
>> +	u16 con;
>> +
>> +	if (ddr == MMC_SDR_MODE)
>> +		return;
>> +
>> +	con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
>> +	con |= SDCTRL_2_SDH_V18_EN;
>> +	sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
>> +
>> +	/* Change sigalling voltage and wait for it to be stable */
> 
> signaling
> 
>> +	if (host->ops->set_signaling_voltage)
>> +		host->ops->set_signaling_voltage(host, 18);
> 
> What do you think about passing the ddr mode itself (MMC_1_8V_DDR_MODE)
> and having set_signaling_voltage() work out what voltage it needs to use
> to achieve that?  I don't like passing the raw number around so much.

hmmm

concur about numbers and can pass the mode in.  The concern I had was if this function
ever needed to be more generic then wanted the voltage.  Thought about using the VDD
voltage defines but they are a range of values and not appropriate.  Thoughts ?

> 
>> +	else
>> +		mdelay(5);
>> +
>> +	/*
>> +	 * We can fail here but there is no higher level recovery
>> +	 * since the card is already past the switch to ddr
>> +	 */
>> +	con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
>> +	con &= ~SDCTRL_2_UHS_MODE_MASK;
>> +	con |= SDCTRL_2_UHS_MODE_SEL_DDR50;
>> +	sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
>> +}
>> +
>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>> {
>> 	int div;
>> @@ -1180,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> 	}
>> 
>> 	sdhci_set_clock(host, ios->clock);
>> +	sdhci_set_ddr(host, ios->ddr);
>> 
>> 	if (ios->power_mode == MMC_POWER_OFF)
>> 		sdhci_set_power(host, -1);
>> @@ -1744,7 +1779,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>> int sdhci_add_host(struct sdhci_host *host)
>> {
>> 	struct mmc_host *mmc;
>> -	unsigned int caps, ocr_avail;
>> +	unsigned int caps, caps_h, ocr_avail;
> 
> Maybe choose a more understandable name for caps_h?

okay

> 
>> 	int ret;
>> 
>> 	WARN_ON(host == NULL);
>> @@ -1767,8 +1802,19 @@ int sdhci_add_host(struct sdhci_host *host)
>> 			host->version);
>> 	}
>> 
>> -	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>> -		sdhci_readl(host, SDHCI_CAPABILITIES);
>> +	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>> +		caps = host->caps;
>> +		caps_h = 0;
>> +	} else {
>> +		caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +		if (host->version >= SDHCI_SPEC_300) 
>> +			caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>> +		else
>> +			caps_h = 0;
>> +	}
>> +
>> +	if (caps_h & SDHCI_CAN_DDR50)
>> +		mmc->caps |= MMC_CAP_1_8V_DDR;
>> 
>> 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>> 		host->flags |= SDHCI_USE_SDMA;
>> @@ -1905,7 +1951,6 @@ int sdhci_add_host(struct sdhci_host *host)
>> 		ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
>> 	if (caps & SDHCI_CAN_VDD_180)
>> 		ocr_avail |= MMC_VDD_165_195;
>> -
>> 	mmc->ocr_avail = ocr_avail;
>> 	mmc->ocr_avail_sdio = ocr_avail;
>> 	if (host->ocr_avail_sdio)
> 
> This whitespace change shouldn't be here.

will fix

> 
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 36f3861..d976e4f 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -182,6 +182,9 @@
>> #define  SDHCI_CAN_64BIT	0x10000000
>> 
>> #define SDHCI_CAPABILITIES_1	0x44
>> +#define  SDHCI_CAN_SDR50	0x00000001
>> +#define  SDHCI_CAN_SDR104	0x00000002
>> +#define  SDHCI_CAN_DDR50	0x00000004
>> 
> 
> You could use the BIT(0..2) macros here.

would prefer
1<<0
1<<1
1<<2

you okay with this ?

> 
>> #define SDHCI_MAX_CURRENT	0x48
>> 
>> @@ -237,6 +240,8 @@ struct sdhci_ops {
>> 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>> 					     u8 power_mode);
>> 	unsigned int    (*get_ro)(struct sdhci_host *host);
>> +	unsigned int    (*set_signaling_voltage)(struct sdhci_host *host,
>> +				unsigned short voltage);
>> };
>> 
>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> -- 
> 
> Thanks,
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

