From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC driver full patch for Moorestown platform
Date: Fri, 27 Aug 2010 21:02:40 +0100
Message-ID: <20100827200240.GP23079@void.printf.net>
References: <20100617151623.9951.41387.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45928 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab0H0UCn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 16:02:43 -0400
Content-Disposition: inline
In-Reply-To: <20100617151623.9951.41387.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: pierre@ossman.eu, linux-mmc@vger.kernel.org, JiebingLi <jiebing.li@intel.com>, Kyungmin Park <kmpark@infradead.org>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

Hi,

This wasn't merged -- Kyungmin Park pointed out a conflict with other
newly-added 8-bit support.  Alan (or Kyungmin?), are you interested in
rebasing and sending to Andrew?

On Thu, Jun 17, 2010 at 04:17:00PM +0100, Alan Cox wrote:
> From: JiebingLi <jiebing.li@intel.com>
> 
> This patch enables Moorestown Langwell A-3 platform.
> 
> The main thrust of this is adding support for serialization of devices as
> we do on various other bits of hardware with bugs. We also deal with spurious
> interrupts and clock rewriting.
> 
> The PCI handling code is slightly tweaked so that the driver specific methods
> can override the number of slots, and a method provided so devices can indicate
> they only support one slot even if the PCI config says otherwise.
> 
> The serialization support is as clean as we can see how to make it and as
> general as possible - with just one pair of tiny changes to the core code
> that can be used by any future driver with such limits.
> 
> Quirks tidied up by Alan Cox
> 
> Signed-off-by: JiebingLi <jiebing.li@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/mmc/core/core.c      |    6 ++
>  drivers/mmc/host/sdhci-pci.c |   48 ++++++++++++++++++-
>  drivers/mmc/host/sdhci.c     |  108 ++++++++++++++++++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h     |    7 +++
>  include/linux/mmc/host.h     |    2 +
>  include/linux/pci_ids.h      |    2 +
>  6 files changed, 151 insertions(+), 22 deletions(-)
> 
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 569e94d..10d1c8d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -213,9 +213,15 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>  	mrq->done_data = &complete;
>  	mrq->done = mmc_wait_done;
>  
> +	if (host->port_mutex)
> +		mutex_lock(host->port_mutex);
> +
>  	mmc_start_request(host, mrq);
>  
>  	wait_for_completion(&complete);
> +
> +	if (host->port_mutex)
> +		mutex_unlock(host->port_mutex);
>  }
>  
>  EXPORT_SYMBOL(mmc_wait_for_req);
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 65483fd..9ce725b 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -39,6 +39,8 @@
>  
>  #define MAX_SLOTS			8
>  
> +static DEFINE_MUTEX(port_mutex);
> +
>  struct sdhci_pci_chip;
>  struct sdhci_pci_slot;
>  
> @@ -364,6 +366,30 @@ static const struct sdhci_pci_fixes sdhci_via = {
>  	.probe		= via_probe,
>  };
>  
> +static int single_slot(struct sdhci_pci_chip *chip)
> +{
> +	chip->num_slots = 1;
> +	return 0;
> +}
> +
> +/*
> + * ADMA operation is disabled for Moorestown platform due to
> + * hardware bugs.
> + */
> +static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
> +	.quirks		= SDHCI_QUIRK_BROKEN_ADMA |
> +			  SDHCI_QUIRK_SERIALIZE |
> +			  SDHCI_QUIRK_BROKEN_RESETALL |
> +			  SDHCI_QUIRK_FORCE_FULL_SPEED_MODE,
> +};
> +
> +static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1 = {
> +	.quirks		= SDHCI_QUIRK_BROKEN_ADMA |
> +			  SDHCI_QUIRK_BROKEN_RESETALL |
> +			  SDHCI_QUIRK_FORCE_FULL_SPEED_MODE,
> +	.probe		= single_slot
> +};
> +
>  static const struct pci_device_id pci_ids[] __devinitdata = {
>  	{
>  		.vendor		= PCI_VENDOR_ID_RICOH,
> @@ -445,6 +471,22 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
>  		.driver_data	= (kernel_ulong_t)&sdhci_via,
>  	},
>  
> +	{
> +		.vendor		= PCI_VENDOR_ID_INTEL,
> +		.device		= PCI_DEVICE_ID_INTEL_MRST_SD0,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc0,
> +	},
> +
> +	{
> +		.vendor		= PCI_VENDOR_ID_INTEL,
> +		.device		= PCI_DEVICE_ID_INTEL_MRST_SD1,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1,
> +	},
> +
>  	{	/* Generic SD host controller */
>  		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
>  	},
> @@ -643,6 +685,9 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
>  
>  	host->irq = pdev->irq;
>  
> +	if (host->quirks & SDHCI_QUIRK_SERIALIZE)
> +		host->mmc->port_mutex = &port_mutex;
> +
>  	ret = pci_request_region(pdev, bar, mmc_hostname(host->mmc));
>  	if (ret) {
>  		dev_err(&pdev->dev, "cannot request region\n");
> @@ -728,6 +773,7 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  
>  	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
> +
>  	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
>  	if (slots == 0)
>  		return -ENODEV;
> @@ -769,7 +815,7 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  			goto free;
>  	}
>  
> -	for (i = 0;i < slots;i++) {
> +	for (i = 0;i < chip->num_slots;i++) {
>  		slot = sdhci_pci_probe_slot(pdev, chip, first_bar + i);
>  		if (IS_ERR(slot)) {
>  			for (i--;i >= 0;i--)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..e720106 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -162,9 +162,11 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>  	/* hw clears the bit when it's done */
>  	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>  		if (timeout == 0) {
> -			printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
> -				mmc_hostname(host->mmc), (int)mask);
> -			sdhci_dumpregs(host);
> +			if (!(host->quirks & SDHCI_QUIRK_BROKEN_RESETALL)) {
> +				printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
> +					mmc_hostname(host->mmc), (int)mask);
> +				sdhci_dumpregs(host);
> +			}
>  			return;
>  		}
>  		timeout--;
> @@ -179,10 +181,19 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
> -	if (soft)
> -		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
> -	else
> -		sdhci_reset(host, SDHCI_RESET_ALL);
> +	u32 intmask;
> +
> +	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
> +	sdhci_writel(host,
> +		intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE),
> +		SDHCI_INT_STATUS);
> +
> +	if (!(host->quirks & SDHCI_QUIRK_BROKEN_RESETALL)) {
> +		if (soft)
> +			sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
> +		else
> +			sdhci_reset(host, SDHCI_RESET_ALL);
> +	}
>  
>  	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
>  		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
> @@ -195,6 +206,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  		host->clock = 0;
>  		sdhci_set_ios(host->mmc, &host->mmc->ios);
>  	}
> +
> +	/* disable wakeup signal during initialization */
> +	sdhci_writeb(host, 0x0, SDHCI_WAKE_UP_CONTROL);
>  }
>  
>  static void sdhci_reinit(struct sdhci_host *host)
> @@ -625,11 +639,8 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
>  			break;
>  	}
>  
> -	if (count >= 0xF) {
> -		printk(KERN_WARNING "%s: Too large timeout requested!\n",
> -			mmc_hostname(host->mmc));
> +	if (count >= 0xF)
>  		count = 0xE;
> -	}
>  
>  	return count;
>  }
> @@ -873,6 +884,36 @@ static void sdhci_finish_data(struct sdhci_host *host)
>  		tasklet_schedule(&host->finish_tasklet);
>  }
>  
> +/*
> + * HW problem exists in LNW A3 so clock register has to be set
> + * for every command if both SDIO0 and SDIO1 are enabled.
> + */
> +static void sdhci_clock_reset(struct sdhci_host *host)
> +{
> +	u16 clk;
> +	unsigned long timeout;
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 10 ms */
> +	timeout = 10;
> +	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +		& SDHCI_CLOCK_INT_STABLE)) {
> +		if (timeout == 0) {
> +			printk(KERN_ERR "%s: Internal clock never "
> +				"stabilised.\n",
> +				mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +}
> +
>  static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int flags;
> @@ -940,6 +981,9 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	if (cmd->data)
>  		flags |= SDHCI_CMD_DATA;
>  
> +	if (host->quirks & SDHCI_QUIRK_SERIALIZE)
> +		sdhci_clock_reset(host);
> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  }
>  
> @@ -1159,12 +1203,23 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  
> -	if (ios->bus_width == MMC_BUS_WIDTH_4)
> +	if (ios->bus_width == MMC_BUS_WIDTH_8) {
> +		ctrl |= SDHCI_CTRL_8BITBUS;
> +		ctrl &= ~SDHCI_CTRL_4BITBUS;
> +	} else if (ios->bus_width == MMC_BUS_WIDTH_4) {
> +		ctrl &= ~SDHCI_CTRL_8BITBUS;
>  		ctrl |= SDHCI_CTRL_4BITBUS;
> -	else
> +	} else {
> +		ctrl &= ~SDHCI_CTRL_8BITBUS;
>  		ctrl &= ~SDHCI_CTRL_4BITBUS;
> +	}
>  
> -	if (ios->timing == MMC_TIMING_SD_HS)
> +/*
> + * For LNW A3, HISPD bit has to be cleared in order to enable 50MHz clock
> + */
> +	if (!(host->quirks & SDHCI_QUIRK_FORCE_FULL_SPEED_MODE) &&
> +		(ios->timing == MMC_TIMING_SD_HS ||
> +		ios->timing == MMC_TIMING_MMC_HS))
>  		ctrl |= SDHCI_CTRL_HISPD;
>  	else
>  		ctrl &= ~SDHCI_CTRL_HISPD;
> @@ -1365,11 +1420,18 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
>  {
>  	BUG_ON(intmask == 0);
>  
> +	/*
> +	 * Intel MRST:
> +	 * HW problem exists in LNW A3 which leads to fake interrupt on SDIO1
> +	 * if SDIO0 and SDIO1 are both enabled.
> +	 */
>  	if (!host->cmd) {
> -		printk(KERN_ERR "%s: Got command interrupt 0x%08x even "
> -			"though no command operation was in progress.\n",
> -			mmc_hostname(host->mmc), (unsigned)intmask);
> -		sdhci_dumpregs(host);
> +		if (!(host->quirks & SDHCI_QUIRK_SERIALIZE)) {
> +			printk(KERN_ERR "%s: Got command interrupt 0x%08x even "
> +				"though no command operation in progress.\n",
> +				mmc_hostname(host->mmc), (unsigned)intmask);
> +			sdhci_dumpregs(host);
> +		}
>  		return;
>  	}
>  
> @@ -1676,7 +1738,8 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (debug_quirks)
>  		host->quirks = debug_quirks;
>  
> -	sdhci_reset(host, SDHCI_RESET_ALL);
> +	if (!(host->quirks & SDHCI_QUIRK_BROKEN_RESETALL))
> +		sdhci_reset(host, SDHCI_RESET_ALL);
>  
>  	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	host->version = (host->version & SDHCI_SPEC_VER_MASK)
> @@ -1796,8 +1859,11 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
>  
> +	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> +		mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
>  	if (caps & SDHCI_CAN_DO_HISPD)
> -		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> +		mmc->caps |= (MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED);
>  
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;
> @@ -1855,7 +1921,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	} else {
>  		mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
>  				SDHCI_MAX_BLOCK_SHIFT;
> -		if (mmc->max_blk_size >= 3) {
> +		if (mmc->max_blk_size > 3) {
>  			printk(KERN_WARNING "%s: Invalid maximum block size, "
>  				"assuming 512 bytes\n", mmc_hostname(mmc));
>  			mmc->max_blk_size = 0;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..cf96152 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -67,6 +67,7 @@
>  #define  SDHCI_CTRL_LED		0x01
>  #define  SDHCI_CTRL_4BITBUS	0x02
>  #define  SDHCI_CTRL_HISPD	0x04
> +#define  SDHCI_CTRL_8BITBUS	0x20
>  #define  SDHCI_CTRL_DMA_MASK	0x18
>  #define   SDHCI_CTRL_SDMA	0x00
>  #define   SDHCI_CTRL_ADMA1	0x08
> @@ -240,6 +241,12 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
>  /* Controller cannot support End Attribute in NOP ADMA descriptor */
>  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller can only handle full speed mode */
> +#define SDHCI_QUIRK_FORCE_FULL_SPEED_MODE		(1<<27)
> +/* Controller has an issue with software reset all function */
> +#define SDHCI_QUIRK_BROKEN_RESETALL			(1<<28)
> +/* Controller has an issue when its two slots enabled together */
> +#define SDHCI_QUIRK_SERIALIZE				(1<<29)
>  
>  	int			irq;		/* Device IRQ */
>  	void __iomem *		ioaddr;		/* Mapped address */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..648740e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -211,6 +211,8 @@ struct mmc_host {
>  
>  	struct dentry		*debugfs_root;
>  
> +	struct mutex		*port_mutex;
> +
>  	unsigned long		private[0] ____cacheline_aligned;
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4eb4679..f5ebea1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2398,6 +2398,8 @@
>  #define PCI_DEVICE_ID_INTEL_82375	0x0482
>  #define PCI_DEVICE_ID_INTEL_82424	0x0483
>  #define PCI_DEVICE_ID_INTEL_82378	0x0484
> +#define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
> +#define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
>  #define PCI_DEVICE_ID_INTEL_I960	0x0960
>  #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
>  #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062
> 
> --

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
