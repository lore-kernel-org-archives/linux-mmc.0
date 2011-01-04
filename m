From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH V2 2/2] sdhci: Support for SD/MMC Dual Data Rate
Date: Mon, 3 Jan 2011 20:41:32 -0800
Message-ID: <D23DAD59-D0AF-469D-B91A-8528A3F14597@marvell.com>
References: <35CD48DB-A420-4319-968D-400D45EE9C0D@marvell.com>
 <AANLkTi=ERwn3W8tvt3NNS3Xiq93mhy7TV7vAT9dwjvaq@mail.gmail.com>
 <DF9AC92A-B56D-4D22-8CE3-5AC15F9EAB8C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50576 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751099Ab1ADEtS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Jan 2011 23:49:18 -0500
In-Reply-To: <DF9AC92A-B56D-4D22-8CE3-5AC15F9EAB8C@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


On Jan 3, 2011, at 8:25 PM, Philip Rakity wrote:

> 
> On Jan 3, 2011, at 7:39 PM, zhangfei gao wrote:
> 
>> On Sun, Jan 2, 2011 at 11:45 AM, Philip Rakity <prakity@marvell.com> wrote:
>>> 
>>> mmc->caps MMC_CAP_1_8V_DDR is set by looking at cabability_1
>>> register if sd 3.0 controller.
>>> 
>>> Support for dual data rate (DDR50) with 1_8V signalling added
>>> with optional call back to enable external control of signalling
>>> voltage.
>>> 
>>> no support for 1.2V core voltage since SD 3.0 does not support
>>> this.
>>> 
>>> **** QUESTION ****
>>> should this be part of regulator framework ?
>>> 
>>> delay for signaling voltage to settle set to 5ms (per spec).
>>> 
>>> this code does not change the voltage supplied to the card.
>>> It assumes that this is correctly handled in the core/ layer.
>>> 
>>> There is no requirement that the card voltage be at 1.8v
>>> for DDR to work.  This violates DDR specification for
>>> SD Host Controller 3.0 since explicitly states card voltage
>>> is 3.3v while signalling voltage is set to 1.8v.
>>> 
>>> tested on mmp2 -- brownstone -- under linux-next.
>>> 
>>> Note:  this board design runs a fixed voltage to the card and
>>> signaling voltage cannot be changed.
>>> 
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> ---
>>> drivers/mmc/host/sdhci.c |   53 ++++++++++++++++++++++++++++++++++++++++++---
>>> drivers/mmc/host/sdhci.h |    5 ++++
>>> 2 files changed, 54 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index d5febe5..805f850 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -84,6 +84,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
>>>       printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
>>>               sdhci_readw(host, SDHCI_COMMAND),
>>>               sdhci_readl(host, SDHCI_MAX_CURRENT));
>>> +       printk(KERN_DEBUG DRIVER_NAME ": HostCtrl2:0x%08x\n",
>>> +               sdhci_readw(host, SDHCI_HOST_CONTROL_2));
>>> 
>>>       if (host->flags & SDHCI_USE_ADMA)
>>>               printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
>>> @@ -986,6 +988,38 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>>       host->cmd = NULL;
>>> }
>>> 
>>> +/*
>>> + * Handle 1.8V signaling for DDR. No need to check for other
>>> + * DDR values since driver supports ONLY 1_8V DDR.  This is
>>> + * set by the MMC_CAP_1_8V_DDR.  1_2V DDR is not supported.
>>> + */
>>> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
>>> +{
>>> +       u16 con;
>>> +
>>> +       if (ddr == MMC_SDR_MODE)
>>> +               return;
>>> +
>>> +       con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
>>> +       con |= SDCTRL_2_SDH_V18_EN;
>>> +       sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
>>> +
>>> +       /* Change sigalling voltage and wait for it to be stable */
>>> +       if (host->ops->set_signaling_voltage)
>>> +               host->ops->set_signaling_voltage(host, 18);
>>> +       else
>>> +               mdelay(5);
>> 
>> In fact, have considered this method before, mdelay(5) in
>> spin_lock_irqsave is terrible, since timer can not update system time,
>> and android must die.
> 
> where is the spin_lock set ?

in the set_ios routine on entry 

> maybe we need a check to not do this twice by saving the current ddr state  


Forgot to mention -- set clock can wait up to 20ms and is called with
the spin_lock being held. so why the objection to the 5ms ?

<snip>
static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
{
	struct sdhci_host *host;
	unsigned long flags;
	u8 ctrl;

	host = mmc_priv(mmc);

	spin_lock_irqsave(&host->lock, flags);

	if (host->flags & SDHCI_DEVICE_DEAD)
		goto out;

	/*
	 * Reset the chip on each power off.
	 * Should clear out any weird states.
	 */
	if (ios->power_mode == MMC_POWER_OFF) {
		sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
		sdhci_reinit(host);
	}

	sdhci_set_clock(host, ios->clock);
	sdhci_set_ddr(host, ios->ddr);


=====

static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
{
	int div;
	u16 clk;
	unsigned long timeout;

	if (clock == host->clock)
		return;

	if (host->ops->set_clock) {
		host->ops->set_clock(host, clock);
		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
			return;
	}

	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);

	if (clock == 0)
		goto out;

	if (host->version >= SDHCI_SPEC_300) {
		/* Version 3.00 divisors must be a multiple of 2. */
		if (host->max_clk <= clock)
			div = 1;
		else {
			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
				if ((host->max_clk / div) <= clock)
					break;
			}
		}
	} else {
		/* Version 2.00 divisors must be a power of 2. */
		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
			if ((host->max_clk / div) <= clock)
				break;
		}
	}
	div >>= 1;

	clk = (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
		<< SDHCI_DIVIDER_HI_SHIFT;
	clk |= SDHCI_CLOCK_INT_EN;
	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

	/* Wait max 20 ms */
	timeout = 20;
	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
		& SDHCI_CLOCK_INT_STABLE)) {
		if (timeout == 0) {
			printk(KERN_ERR "%s: Internal clock never "
				"stabilised.\n", mmc_hostname(host->mmc));
			sdhci_dumpregs(host);
			return;
		}
		timeout--;
		mdelay(1);
	}

	clk |= SDHCI_CLOCK_CARD_EN;
	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

out:
	host->clock = clock;
}



>> 
>>> +
>>> +       /*
>>> +        * We can fail here but there is no higher level recovery
>>> +        * since the card is already past the switch to ddr
>>> +        */
>>> +       con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
>>> +       con &= ~SDCTRL_2_UHS_MODE_MASK;
>>> +       con |= SDCTRL_2_UHS_MODE_SEL_DDR50;
>>> +       sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
>>> +}
>>> +
>>> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>> {
>>>       int div;
>>> @@ -1180,6 +1214,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>       }
>>> 
>>>       sdhci_set_clock(host, ios->clock);
>>> +       sdhci_set_ddr(host, ios->ddr);
>>> 
>>>       if (ios->power_mode == MMC_POWER_OFF)
>>>               sdhci_set_power(host, -1);
>>> @@ -1744,7 +1779,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
>>> int sdhci_add_host(struct sdhci_host *host)
>>> {
>>>       struct mmc_host *mmc;
>>> -       unsigned int caps, ocr_avail;
>>> +       unsigned int caps, caps_h, ocr_avail;
>>>       int ret;
>>> 
>>>       WARN_ON(host == NULL);
>>> @@ -1767,8 +1802,19 @@ int sdhci_add_host(struct sdhci_host *host)
>>>                       host->version);
>>>       }
>>> 
>>> -       caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
>>> -               sdhci_readl(host, SDHCI_CAPABILITIES);
>>> +       if (host->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>>> +               caps = host->caps;
>>> +               caps_h = 0;
>>> +       } else {
>>> +               caps = sdhci_readl(host, SDHCI_CAPABILITIES);
>>> +               if (host->version >= SDHCI_SPEC_300)
>>> +                       caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>> +               else
>>> +                       caps_h = 0;
>>> +       }
>>> +
>>> +       if (caps_h & SDHCI_CAN_DDR50)
>>> +               mmc->caps |= MMC_CAP_1_8V_DDR;
>>> 
>>>       if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>>               host->flags |= SDHCI_USE_SDMA;
>>> @@ -1905,7 +1951,6 @@ int sdhci_add_host(struct sdhci_host *host)
>>>               ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
>>>       if (caps & SDHCI_CAN_VDD_180)
>>>               ocr_avail |= MMC_VDD_165_195;
>>> -
>>>       mmc->ocr_avail = ocr_avail;
>>>       mmc->ocr_avail_sdio = ocr_avail;
>>>       if (host->ocr_avail_sdio)
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 36f3861..d976e4f 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -182,6 +182,9 @@
>>> #define  SDHCI_CAN_64BIT       0x10000000
>>> 
>>> #define SDHCI_CAPABILITIES_1   0x44
>>> +#define  SDHCI_CAN_SDR50       0x00000001
>>> +#define  SDHCI_CAN_SDR104      0x00000002
>>> +#define  SDHCI_CAN_DDR50       0x00000004
>>> 
>>> #define SDHCI_MAX_CURRENT      0x48
>>> 
>>> @@ -237,6 +240,8 @@ struct sdhci_ops {
>>>       void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>>                                            u8 power_mode);
>>>       unsigned int    (*get_ro)(struct sdhci_host *host);
>>> +       unsigned int    (*set_signaling_voltage)(struct sdhci_host *host,
>>> +                               unsigned short voltage);
>>> };
>>> 
>>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>> --
>>> 1.7.0.4
>>> 
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
> 

