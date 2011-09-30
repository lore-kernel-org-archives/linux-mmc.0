From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of PCI mode for the dw_mmc driver
Date: Fri, 30 Sep 2011 09:42:49 +0100
Message-ID: <4E858109.8010807@imgtec.com>
References: <1317318052-2750-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55631 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753707Ab1I3InX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Sep 2011 04:43:23 -0400
In-Reply-To: <1317318052-2750-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Matt Fleming <matt@console-pimps.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

Hi

On 09/29/2011 06:40 PM, Shashidhar Hiremath wrote:
> Support of PCI mode for the dw_mmc driver This Patch adds the support for the scenario where the Synopsys Designware IP is present on the PCI bus.The patch adds the minimal modifications necessary for the driver to work on PCI platform. The Driver has also been tested for on the PCI platform with single Card Slot.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> v2:
> *As per Suggestions by Will Newton and James Hogan
> -Reduced the number of ifdefs
> 
>  drivers/mmc/host/Kconfig   |   11 ++
>  drivers/mmc/host/dw_mmc.c  |  352 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.h  |   13 ++
>  include/linux/mmc/dw_mmc.h |    4 +
>  4 files changed, 380 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c87096..84d8908 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -526,6 +526,17 @@ config MMC_DW
>  	  block, this provides host support for SD and MMC interfaces, in both
>  	  PIO and external DMA modes.
>  
> +config MMC_DW_PCI
> +	bool "MMC_DW Support On PCI bus"
> +	depends on MMC_DW && PCI
> +	help
> +	  This selects the PCI for the Synopsys Designware Mobile Storage IP.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
> +
>  config MMC_DW_IDMAC
>  	bool "Internal DMAC interface"
>  	depends on MMC_DW
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0f714..0bd9e16 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>  #include <linux/seq_file.h>
> @@ -101,6 +102,7 @@ struct dw_mci_slot {
>  	int			last_detect_state;
>  };
>  
> +
>  static struct workqueue_struct *dw_mci_card_workqueue;
>  
>  #if defined(CONFIG_DEBUG_FS)
> @@ -682,6 +684,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	u32 regs;
> +	u32 card_detect;
>  
>  	/* set default 1 bit mode */
>  	slot->ctype = SDMMC_CTYPE_1BIT;
> @@ -716,6 +719,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
> +		/* Enable Power to the card that has been detected */
> +		card_detect = mci_readl(slot->host, CDETECT);
> +		/* Enabling power for card 0 when PCI is the interface */
> +		mci_writel(slot->host, PWREN, ((~card_detect) & 0x1));
> +		break;
> +	case MMC_POWER_OFF:
> +		mci_writel(slot->host, PWREN, 0);
>  		break;
>  	default:
>  		break;
> @@ -1775,6 +1785,345 @@ static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
>  	return false;
>  }
>  
> +#ifdef CONFIG_MMC_DW_PCI
> +
> +static struct pci_device_id dw_mci_id  = {  PCI_DEVICE(DEVICE_ID, VENDOR_ID) };
> +
> +struct dw_mci_board pci_board_data = {
> +	.num_slots			= 1,
> +	.caps				= DW_MCI_CAPABILITIES,
> +	.bus_hz				= 33 * 1000 * 1000,
> +	.detect_delay_ms		= 200,
> +	.fifo_depth			= 32,
> +};
> +
> +static int __devinit dw_mci_probe(struct pci_dev *pdev,
> +				  const struct pci_device_id *entries)
> +{
> +	struct dw_mci *host;
> +	struct resource	*regs;
> +	struct dw_mci_board *pdata;
> +	int irq, ret, i, width;
> +	u32 fifo_size;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +	if (pci_request_regions(pdev, "dw_mmc")) {
> +		ret = -ENODEV;
> +		goto err_freehost;
> +	}
> +	irq = pdev->irq;
> +
> +	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
> +	if (!host)
> +		return -ENOMEM;
> +
> +	host->pdev = pdev;
> +	host->pdata = pdata = &pci_board_data;
> +
> +	if (!pdata->select_slot && pdata->num_slots > 1) {
> +		dev_err(&pdev->dev,
> +			"Platform data must supply select_slot function\n");
> +		ret = -ENODEV;
> +		goto err_freehost;
> +	}
> +
> +	if (!pdata->bus_hz) {
> +		dev_err(&pdev->dev,
> +			"Platform data must supply bus speed\n");
> +		ret = -ENODEV;
> +		goto err_freehost;
> +	}
> +
> +	host->bus_hz = pdata->bus_hz;
> +	host->quirks = pdata->quirks;
> +
> +	spin_lock_init(&host->lock);
> +	INIT_LIST_HEAD(&host->queue);
> +
> +	ret = -ENOMEM;
> +	host->regs = pci_iomap(pdev, PCI_BAR_NO, COMPLETE_BAR);
> +	if (!host->regs) {
> +		ret = -EIO;
> +		goto err_free_res;
> +	}
> +
> +	host->dma_ops = pdata->dma_ops;
> +	dw_mci_init_dma(host);
> +
> +	/*
> +	 * Get the host data width - this assumes that HCON has been set with
> +	 * the correct values.
> +	 */
> +	i = (mci_readl(host, HCON) >> 7) & 0x7;
> +	if (!i) {
> +		host->push_data = dw_mci_push_data16;
> +		host->pull_data = dw_mci_pull_data16;
> +		width = 16;
> +		host->data_shift = 1;
> +	} else if (i == 2) {
> +		host->push_data = dw_mci_push_data64;
> +		host->pull_data = dw_mci_pull_data64;
> +		width = 64;
> +		host->data_shift = 3;
> +	} else {
> +		/* Check for a reserved value, and warn if it is */
> +		WARN((i != 1),
> +		     "HCON reports a reserved host data width!\n"
> +		     "Defaulting to 32-bit access.\n");
> +		host->push_data = dw_mci_push_data32;
> +		host->pull_data = dw_mci_pull_data32;
> +		width = 32;
> +		host->data_shift = 2;
> +	}
> +
> +	/* Reset all blocks */
> +	if (!mci_wait_reset(&pdev->dev, host)) {
> +		ret = -ENODEV;
> +		goto err_dmaunmap;
> +	}
> +
> +	/* Clear the interrupts for the host controller */
> +	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> +
> +	/* Put in max timeout */
> +	mci_writel(host, TMOUT, 0xFFFFFFFF);
> +
> +	/*
> +	 * FIFO threshold settings  RxMark  = fifo_size / 2 - 1,
> +	 *                          Tx Mark = fifo_size / 2 DMA Size = 8
> +	 */
> +	if (!host->pdata->fifo_depth) {
> +		/*
> +		 * Power-on value of RX_WMark is FIFO_DEPTH-1, but this may
> +		 * have been overwritten by the bootloader, just like we're
> +		 * about to do, so if you know the value for your hardware, you
> +		 * should put it in the platform data.
> +		 */
> +		fifo_size = mci_readl(host, FIFOTH);
> +		fifo_size = 1 + ((fifo_size >> 16) & 0x7ff);
> +	} else {
> +		fifo_size = host->pdata->fifo_depth;
> +	}
> +	host->fifo_depth = fifo_size;
> +	host->fifoth_val = ((0x2 << 28) | ((fifo_size/2 - 1) << 16) |
> +			((fifo_size/2) << 0));
> +	mci_writel(host, FIFOTH, host->fifoth_val);
> +
> +	/* disable clock to CIU */
> +	mci_writel(host, CLKENA, 0);
> +	mci_writel(host, CLKSRC, 0);
> +
> +	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
> +	dw_mci_card_workqueue = alloc_workqueue("dw-mci-card",
> +			WQ_MEM_RECLAIM | WQ_NON_REENTRANT, 1);
> +	if (!dw_mci_card_workqueue)
> +		goto err_dmaunmap;
> +	INIT_WORK(&host->card_work, dw_mci_work_routine_card);
> +
> +	ret = request_irq(irq, dw_mci_interrupt, IRQF_SHARED, "dw-mci", host);
> +	if (ret)
> +		goto err_workqueue;
> +
> +	pci_set_drvdata(pdev, host);
> +
> +	if (host->pdata->num_slots)
> +		host->num_slots = host->pdata->num_slots;
> +	else
> +		host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
> +
> +	/* We need at least one slot to succeed */
> +	for (i = 0; i < host->num_slots; i++) {
> +		ret = dw_mci_init_slot(host, i);
> +		if (ret) {
> +			ret = -ENODEV;
> +			goto err_init_slot;
> +		}
> +	}
> +
> +	/*
> +	 * Enable interrupts for command done, data over, data empty, card det,
> +	 * receive ready and error such as transmit, receive timeout, crc error
> +	 */
> +	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> +		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> +		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> +	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
> +
> +	dev_info(&pdev->dev, "DW MMC controller at irq %d, "
> +		 "%d bit host data width, "
> +		 "%u deep fifo\n",
> +		 irq, width, fifo_size);
> +	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
> +		dev_info(&pdev->dev, "Internal DMAC interrupt fix enabled.\n");
> +
> +	return 0;
> +
> +err_init_slot:
> +	/* De-init any initialized slots */
> +	while (i > 0) {
> +		if (host->slot[i])
> +			dw_mci_cleanup_slot(host->slot[i], i);
> +		i--;
> +	}
> +	free_irq(irq, host);
> +
> +err_workqueue:
> +	destroy_workqueue(dw_mci_card_workqueue);
> +
> +err_dmaunmap:
> +	if (host->use_dma && host->dma_ops->exit)
> +		host->dma_ops->exit(host);
> +	dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
> +			  host->sg_cpu, host->sg_dma);
> +	iounmap(host->regs);
> +
> +	if (host->vmmc) {
> +		regulator_disable(host->vmmc);
> +		regulator_put(host->vmmc);
> +	}
> +
> +err_free_res:
> +	pci_release_regions(pdev);
> +
> +err_freehost:
> +	kfree(host);
> +	return ret;
> +}
> +
> +static void __devexit dw_mci_remove(struct pci_dev *pdev)
> +{
> +
> +	struct dw_mci *host = pci_get_drvdata(pdev);
> +	int i;
> +
> +	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> +
> +	pci_set_drvdata(pdev, NULL);
> +
> +	for (i = 0; i < host->num_slots; i++) {
> +		dev_dbg(&pdev->dev, "remove slot %d\n", i);
> +		if (host->slot[i])
> +			dw_mci_cleanup_slot(host->slot[i], i);
> +	}
> +
> +	/* disable clock to CIU */
> +	mci_writel(host, CLKENA, 0);
> +	mci_writel(host, CLKSRC, 0);
> +
> +	free_irq(pdev->irq, host);
> +	destroy_workqueue(dw_mci_card_workqueue);
> +	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
> +
> +	if (host->use_dma && host->dma_ops->exit)
> +		host->dma_ops->exit(host);
> +
> +	if (host->vmmc) {
> +		regulator_disable(host->vmmc);
> +		regulator_put(host->vmmc);
> +	}
> +
> +	iounmap(host->regs);
> +
> +	pci_release_regions(pdev);
> +	kfree(host);
> +}
> +
> +#ifdef CONFIG_PM
> +/*
> + * TODO: we should probably disable the clock to the card in the suspend path.
> + */
> +static int dw_mci_suspend(struct pci_dev *pdev, pm_message_t mesg)
> +{
> +	int i, ret;
> +	struct dw_mci *host = pci_get_drvdata(pdev);
> +
> +	for (i = 0; i < host->num_slots; i++) {
> +		struct dw_mci_slot *slot = host->slot[i];
> +		if (!slot)
> +			continue;
> +		ret = mmc_suspend_host(slot->mmc);
> +		if (ret < 0) {
> +			while (--i >= 0) {
> +				slot = host->slot[i];
> +				if (slot)
> +					mmc_resume_host(host->slot[i]->mmc);
> +			}
> +			return ret;
> +		}
> +	}
> +
> +	if (host->vmmc)
> +		regulator_disable(host->vmmc);
> +
> +	return 0;
> +}
> +
> +static int dw_mci_resume(struct pci_dev *pdev)
> +{
> +	int i, ret;
> +	struct dw_mci *host = pci_get_drvdata(pdev);
> +
> +	if (host->vmmc)
> +		regulator_enable(host->vmmc);
> +
> +	if (host->dma_ops->init)
> +		host->dma_ops->init(host);
> +
> +	if (!mci_wait_reset(&pdev->dev, host)) {
> +		ret = -ENODEV;
> +		return ret;
> +	}
> +
> +	/* Restore the old value at FIFOTH register */
> +	mci_writel(host, FIFOTH, host->fifoth_val);
> +
> +	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> +		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> +		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> +	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> +
> +	for (i = 0; i < host->num_slots; i++) {
> +		struct dw_mci_slot *slot = host->slot[i];
> +		if (!slot)
> +			continue;
> +		ret = mmc_resume_host(host->slot[i]->mmc);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#else
> +#define dw_mci_suspend	NULL
> +#define dw_mci_resume	NULL
> +#endif /* CONFIG_PM */
> +
> +static struct pci_driver dw_mci_driver = {
> +	.name		= "dw_mmc",
> +	.id_table	= &dw_mci_id,
> +	.probe		= dw_mci_probe,
> +	.remove		= dw_mci_remove,
> +	.suspend	= dw_mci_suspend,
> +	.resume		= dw_mci_resume,
> +};
> +
> +static int __init dw_mci_init(void)
> +{
> +	return pci_register_driver(&dw_mci_driver);
> +}
> +
> +static void __exit dw_mci_exit(void)
> +{
> +	pci_unregister_driver(&dw_mci_driver);
> +}
> +#else
> +

Duplication isn't the same as abstraction, and it's much worse to
maintain than lots of #ifdefs. What we meant was to abstract the common
code into separate static functions which are used by both pci/platform
probe/remove/suspend/resume functions (as Will has already described).

These functions should also have pci/platform in their names to
distinguish them more easily. Also I see no reason why pci and platform
registration should be mutually exclusive, i.e. the platform driver can
still be registered even if PCI is enabled.

>  static int dw_mci_probe(struct platform_device *pdev)
>  {
>  	struct dw_mci *host;
> @@ -1974,6 +2323,7 @@ err_freehost:
>  
>  static int __exit dw_mci_remove(struct platform_device *pdev)
>  {
> +
>  	struct dw_mci *host = platform_get_drvdata(pdev);
>  	int i;
>  
> @@ -2100,6 +2450,8 @@ static void __exit dw_mci_exit(void)
>  	platform_driver_unregister(&dw_mci_driver);
>  }
>  
> +#endif/* CONFIG_MMC_DW_PCI */
> +
>  module_init(dw_mci_init);
>  module_exit(dw_mci_exit);
>  
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 027d377..54bc604 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -164,4 +164,17 @@
>  	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
>  #endif
>  
> +/* PCI Specific macros */
> +#ifdef CONFIG_MMC_DW_PCI
> +#define PCI_BAR_NO 2
> +#define COMPLETE_BAR 0
> +/* Dummy Device Id and Vendor Id */
> +#define VENDOR_ID 0x700
> +#define DEVICE_ID 0x1107

Again, in what way are these values dummy? if somebody were to want to
use this, would they have to change them for their specific hardware? Is
that a common thing to have to do for other drivers like this?

> +/* Defining the Capabilities */
> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED |\
> +				MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DATA |\
> +				MMC_CAP_SDIO_IRQ)
> +#endif /* CONFIG_MMC_DW_PCI */
> +
>  #endif /* _DW_MMC_H_ */
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 6b46819..87af5a6 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -147,7 +147,11 @@ struct dw_mci {
>  	u32			current_speed;
>  	u32			num_slots;
>  	u32			fifoth_val;
> +#ifdef CONFIG_MMC_DW_PCI
> +	struct pci_dev		*pdev;
> +#else
>  	struct platform_device	*pdev;
> +#endif

The only time this is used is to find &host->pdev->dev for logging
calls. It'd be better to replace these with a single struct device *,
then it'll work with both platform and pci enabled.

>  	struct dw_mci_board	*pdata;
>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
>  

