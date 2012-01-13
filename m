From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v6] mmc:Support of PCI mode for the dw_mmc driver
Date: Fri, 13 Jan 2012 12:30:17 +0000
Message-ID: <4F1023D9.5050700@imgtec.com>
References: <1326450897-9248-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:31622 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab2AMMaW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Jan 2012 07:30:22 -0500
In-Reply-To: <1326450897-9248-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On 13/01/12 10:34, Shashidhar Hiremath wrote:
> Support of PCI mode for the dw_mmc driver. This Patch adds the
> support for the scenario where the Synopsys Designware IP
> is present on the PCI bus. The patch adds the minimal modifications
> necessary for the driver to work on PCI platform. Also added separate
> files for PCI and PLATFORM modes of operation.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Acked-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
> v2:
> *As per Suggestions by Will Newton and James Hogan
> -Reduced the number of ifdefs
> v3:
> *As per Suggestions by Will Newton and James Hogan
> -Added separate files for PCI and PLATFORM Modes similar to SDHCI driver
> v4:
> *As per Suggestions by James Hogan
> -Fixed Indentation Issue.
> -Added Proper error Handling for probe and remove sequences.
> -Modified location of some code.
> -Added isr_flags to dw_mmc.h and removed the ifdef PCI from driver.
> v5:
> *As per Suggestions by James Hogan
> -removed the redundant code.
> -fixed the compilation errors.
> -Modified the menuconfig Message for PLATFORM mode.
> v6:
> *As per suggestions by James Hogan
> -Added few includes
> -reformatted the patch to include Jae hoon's Patch on pm_ops
>  drivers/mmc/host/Kconfig        |   25 ++++++
>  drivers/mmc/host/Makefile       |    2 +
>  drivers/mmc/host/dw_mmc-pci.c   |  158 +++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc-pltfm.c |  137 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.c       |  155 +++++++++++++-------------------------
>  drivers/mmc/host/dw_mmc.h       |    7 ++
>  include/linux/mmc/dw_mmc.h      |    8 ++-
>  7 files changed, 388 insertions(+), 104 deletions(-)
>  create mode 100644 drivers/mmc/host/dw_mmc-pci.c
>  create mode 100644 drivers/mmc/host/dw_mmc-pltfm.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index cf444b0..efe7e1a 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -534,6 +534,31 @@ config MMC_DW_IDMAC
>  	  Designware Mobile Storage IP block. This disables the external DMA
>  	  interface.
>  
> +config MMC_DW_PLTFM
> +	tristate "Synopsys Designware MCI Support as platform device"
> +	depends on MMC_DW
> +	default y
> +	help
> +	  This selects the common helper functions support for Host Controller
> +	  Interface based platform driver. Please select this option if the IP
> +	  is present as a platform device. This is the common interface for the
> +	  Synopsys Designware IP.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say Y.
> +
> +config MMC_DW_PCI
> +	tristate "Synopsys Designware MCI support on PCI bus"
> +	depends on MMC_DW && PCI
> +	help
> +	  This selects the PCI bus for the Synopsys Designware Mobile Storage IP.
> +	  Select this option if the IP is present on PCI platform.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SH_MMCIF
>  	tristate "SuperH Internal MMCIF support"
>  	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 745f8fc..3e7e26d 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -39,6 +39,8 @@ obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
>  obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
>  obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
>  obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
> +obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
> +obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
>  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
>  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
>  obj-$(CONFIG_MMC_VUB300)	+= vub300.o
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
> new file mode 100644
> index 0000000..dc0d25a
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -0,0 +1,158 @@
> +/*
> + * Synopsys DesignWare Multimedia Card PCI Interface driver
> + *
> + * Copyright (C) 2012 Vayavya Labs Pvt. Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/dw_mmc.h>
> +#include "dw_mmc.h"
> +
> +#define PCI_BAR_NO 2
> +#define COMPLETE_BAR 0
> +#define SYNOPSYS_DW_MCI_VENDOR_ID 0x700
> +#define SYNOPSYS_DW_MCI_DEVICE_ID 0x1107
> +/* Defining the Capabilities */
> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED |\
> +				MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DATA |\
> +				MMC_CAP_SDIO_IRQ)
> +
> +static struct dw_mci_board pci_board_data = {
> +	.num_slots			= 1,
> +	.caps				= DW_MCI_CAPABILITIES,
> +	.bus_hz				= 33 * 1000 * 1000,
> +	.detect_delay_ms		= 200,
> +	.fifo_depth			= 32,
> +};
> +
> +static int __devinit dw_mci_pci_probe(struct pci_dev *pdev,
> +				  const struct pci_device_id *entries)
> +{
> +	struct dw_mci *host;
> +	int ret;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +	if (pci_request_regions(pdev, "dw_mmc_pci")) {
> +		ret = -ENODEV;
> +		goto err_disable_dev;
> +	}
> +
> +	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
> +	if (!host) {
> +		ret = -ENOMEM;
> +		goto err_release;
> +	}
> +
> +	host->irq = pdev->irq;
> +	host->irq_flags = IRQF_SHARED;
> +	host->dev = pdev->dev;
> +	host->pdata = &pci_board_data;
> +
> +	host->regs = pci_iomap(pdev, PCI_BAR_NO, COMPLETE_BAR);
> +	if (!host->regs) {
> +		ret = -EIO;
> +		goto err_unmap;
> +	}
> +
> +	pci_set_drvdata(pdev, host);
> +	ret = dw_mci_probe(host);
> +	if (ret)
> +		goto err_probe_failed;
> +	return ret;
> +
> +err_probe_failed:
> +	pci_iounmap(pdev, host->regs);
> +err_unmap:
> +	kfree(host);
> +err_release:
> +	pci_release_regions(pdev);
> +err_disable_dev:
> +	pci_disable_device(pdev);
> +	return ret;
> +}
> +
> +static void __devexit dw_mci_pci_remove(struct pci_dev *pdev)
> +{
> +	struct dw_mci *host = pci_get_drvdata(pdev);
> +
> +	dw_mci_remove(host);
> +	pci_set_drvdata(pdev, NULL);
> +	pci_release_regions(pdev);
> +	pci_iounmap(pdev, host->regs);
> +	kfree(host);
> +	pci_disable_device(pdev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dw_mci_pci_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct dw_mci *host = pci_get_drvdata(pdev);
> +
> +	ret = dw_mci_suspend(host);
> +	return ret;
> +}
> +
> +static int dw_mci_pci_resume(struct device *dev)
> +{
> +	int ret;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct dw_mci *host = pci_get_drvdata(pdev);
> +
> +	ret = dw_mci_resume(host);
> +	return ret;
> +}
> +#else
> +#define dw_mci_pci_suspend	NULL
> +#define dw_mci_pci_resume	NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(dw_mci_pci_pmops, dw_mci_pci_suspend, dw_mci_pci_resume);
> +
> +static DEFINE_PCI_DEVICE_TABLE(dw_mci_pci_id) = {
> +	{ PCI_DEVICE(SYNOPSYS_DW_MCI_VENDOR_ID, SYNOPSYS_DW_MCI_DEVICE_ID) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, dw_mci_pci_id);
> +
> +static struct pci_driver dw_mci_pci_driver = {
> +	.name		= "dw_mmc_pci",
> +	.id_table	= dw_mci_pci_id,
> +	.probe		= dw_mci_pci_probe,
> +	.remove		= dw_mci_pci_remove,
> +	.driver		=	{
> +		.pm =   &dw_mci_pci_pmops
> +	},
> +};
> +
> +static int __init dw_mci_init(void)
> +{
> +	return pci_register_driver(&dw_mci_pci_driver);
> +}
> +
> +static void __exit dw_mci_exit(void)
> +{
> +	pci_unregister_driver(&dw_mci_pci_driver);
> +}
> +
> +module_init(dw_mci_init);
> +module_exit(dw_mci_exit);
> +
> +MODULE_DESCRIPTION("DW Multimedia Card PCI Interface driver");
> +MODULE_AUTHOR("Shashidhar Hiremath <shashidharh@vayavyalabs.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> new file mode 100644
> index 0000000..f800c70
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -0,0 +1,137 @@
> +/*
> + * Synopsys DesignWare Multimedia Card Interface driver
> + *
> + * Copyright (C) 2009 NXP Semiconductors
> + * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/dw_mmc.h>
> +#include "dw_mmc.h"
> +
> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
> +{
> +	struct dw_mci *host;
> +	struct resource	*regs;
> +	int  ret;
> +
> +	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
> +	if (!host)
> +		return -ENOMEM;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs) {
> +		ret = -ENXIO;
> +		goto err_free;
> +	}
> +
> +	host->irq = platform_get_irq(pdev, 0);
> +	if (host->irq < 0) {
> +		ret = host->irq;
> +		goto err_free;
> +	}
> +
> +	host->dev = pdev->dev;
> +	host->irq_flags = 0;
> +	host->pdata = pdev->dev.platform_data;
> +	ret = -ENOMEM;
> +	host->regs = ioremap(regs->start, resource_size(regs));
> +	if (!host->regs)
> +		goto err_free;
> +	platform_set_drvdata(pdev, host);
> +	ret = dw_mci_probe(host);
> +	if (ret)
> +		goto err_out;
> +	return ret;
> +err_out:
> +	iounmap(host->regs);
> +err_free:
> +	kfree(host);
> +	return ret;
> +}
> +
> +static int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
> +{
> +	struct dw_mci *host = platform_get_drvdata(pdev);
> +
> +
> +	platform_set_drvdata(pdev, NULL);
> +	dw_mci_remove(host);
> +	iounmap(host->regs);
> +	kfree(host);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +/*
> + * TODO: we should probably disable the clock to the card in the suspend path.
> + */
> +static int dw_mci_pltfm_suspend(struct device *dev)
> +{
> +
> +	int  ret;
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +
> +	ret = dw_mci_suspend(host);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int dw_mci_pltfm_resume(struct device *dev)
> +{
> +
> +	int ret;
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +
> +	ret = dw_mci_resume(host);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +#else
> +#define dw_mci_pltfm_suspend	NULL
> +#define dw_mci_pltfm_resume	NULL
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(dw_mci_pltfm_pmops, dw_mci_pltfm_suspend, dw_mci_pltfm_resume);
> +
> +static struct platform_driver dw_mci_pltfm_driver = {
> +	.remove		= __exit_p(dw_mci_pltfm_remove),
> +	.driver		= {
> +		.name		= "dw_mmc",
> +		.pm		= &dw_mci_pltfm_pmops,
> +	},
> +};
> +
> +static int __init dw_mci_init(void)
> +{
> +	return platform_driver_probe(&dw_mci_pltfm_driver, dw_mci_pltfm_probe);
> +}
> +
> +static void __exit dw_mci_exit(void)
> +{
> +	platform_driver_unregister(&dw_mci_pltfm_driver);
> +}
> +
> +module_init(dw_mci_init);
> +module_exit(dw_mci_exit);
> +
> +MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
> +MODULE_AUTHOR("NXP Semiconductor VietNam");
> +MODULE_AUTHOR("Imagination Technologies Ltd");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0e34279..a0b5fb3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -269,7 +269,7 @@ static void dw_mci_start_command(struct dw_mci *host,
>  				 struct mmc_command *cmd, u32 cmd_flags)
>  {
>  	host->cmd = cmd;
> -	dev_vdbg(&host->pdev->dev,
> +	dev_vdbg(&host->dev,
>  		 "start command: ARGR=0x%08x CMDR=0x%08x\n",
>  		 cmd->arg, cmd_flags);
>  
> @@ -302,7 +302,7 @@ static void dw_mci_dma_cleanup(struct dw_mci *host)
>  	struct mmc_data *data = host->data;
>  
>  	if (data)
> -		dma_unmap_sg(&host->pdev->dev, data->sg, data->sg_len,
> +		dma_unmap_sg(&host->dev, data->sg, data->sg_len,
>  			     ((data->flags & MMC_DATA_WRITE)
>  			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
>  }
> @@ -327,7 +327,7 @@ static void dw_mci_idmac_complete_dma(struct dw_mci *host)
>  {
>  	struct mmc_data *data = host->data;
>  
> -	dev_vdbg(&host->pdev->dev, "DMA complete\n");
> +	dev_vdbg(&host->dev, "DMA complete\n");
>  
>  	host->dma_ops->cleanup(host);
>  
> @@ -463,10 +463,10 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>  	else
>  		direction = DMA_TO_DEVICE;
>  
> -	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
> +	sg_len = dma_map_sg(&host->dev, data->sg, data->sg_len,
>  			    direction);
>  
> -	dev_vdbg(&host->pdev->dev,
> +	dev_vdbg(&host->dev,
>  		 "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
>  		 (unsigned long)host->sg_cpu, (unsigned long)host->sg_dma,
>  		 sg_len);
> @@ -816,12 +816,12 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>  		slot = list_entry(host->queue.next,
>  				  struct dw_mci_slot, queue_node);
>  		list_del(&slot->queue_node);
> -		dev_vdbg(&host->pdev->dev, "list not empty: %s is next\n",
> +		dev_vdbg(&host->dev, "list not empty: %s is next\n",
>  			 mmc_hostname(slot->mmc));
>  		host->state = STATE_SENDING_CMD;
>  		dw_mci_start_request(host, slot);
>  	} else {
> -		dev_vdbg(&host->pdev->dev, "list empty\n");
> +		dev_vdbg(&host->dev, "list empty\n");
>  		host->state = STATE_IDLE;
>  	}
>  
> @@ -960,7 +960,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>  					data->bytes_xfered = 0;
>  					data->error = -ETIMEDOUT;
>  				} else {
> -					dev_err(&host->pdev->dev,
> +					dev_err(&host->dev,
>  						"data FIFO error "
>  						"(status=%08x)\n",
>  						status);
> @@ -1676,7 +1676,7 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	struct mmc_host *mmc;
>  	struct dw_mci_slot *slot;
>  
> -	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), &host->pdev->dev);
> +	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), &host->dev);
>  	if (!mmc)
>  		return -ENOMEM;
>  
> @@ -1783,10 +1783,10 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
>  static void dw_mci_init_dma(struct dw_mci *host)
>  {
>  	/* Alloc memory for sg translation */
> -	host->sg_cpu = dma_alloc_coherent(&host->pdev->dev, PAGE_SIZE,
> +	host->sg_cpu = dma_alloc_coherent(&host->dev, PAGE_SIZE,
>  					  &host->sg_dma, GFP_KERNEL);
>  	if (!host->sg_cpu) {
> -		dev_err(&host->pdev->dev, "%s: could not alloc DMA memory\n",
> +		dev_err(&host->dev, "%s: could not alloc DMA memory\n",
>  			__func__);
>  		goto no_dma;
>  	}
> @@ -1794,7 +1794,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  	/* Determine which DMA interface to use */
>  #ifdef CONFIG_MMC_DW_IDMAC
>  	host->dma_ops = &dw_mci_idmac_ops;
> -	dev_info(&host->pdev->dev, "Using internal DMA controller.\n");
> +	dev_info(&host->dev, "Using internal DMA controller.\n");
>  #endif
>  
>  	if (!host->dma_ops)
> @@ -1802,12 +1802,12 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  
>  	if (host->dma_ops->init) {
>  		if (host->dma_ops->init(host)) {
> -			dev_err(&host->pdev->dev, "%s: Unable to initialize "
> +			dev_err(&host->dev, "%s: Unable to initialize "
>  				"DMA Controller.\n", __func__);
>  			goto no_dma;
>  		}
>  	} else {
> -		dev_err(&host->pdev->dev, "DMA initialization not found.\n");
> +		dev_err(&host->dev, "DMA initialization not found.\n");
>  		goto no_dma;
>  	}
>  
> @@ -1815,7 +1815,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  	return;
>  
>  no_dma:
> -	dev_info(&host->pdev->dev, "Using PIO mode.\n");
> +	dev_info(&host->dev, "Using PIO mode.\n");
>  	host->use_dma = 0;
>  	return;
>  }
> @@ -1841,61 +1841,37 @@ static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
>  	return false;
>  }
>  
> -static int dw_mci_probe(struct platform_device *pdev)
> +int dw_mci_probe(struct dw_mci *host)
>  {
> -	struct dw_mci *host;
> -	struct resource	*regs;
> -	struct dw_mci_board *pdata;
> -	int irq, ret, i, width;
> +	int width, i, ret = 0;
>  	u32 fifo_size;
>  
> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!regs)
> -		return -ENXIO;
> -
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> -
> -	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
> -	if (!host)
> -		return -ENOMEM;
> -
> -	host->pdev = pdev;
> -	host->pdata = pdata = pdev->dev.platform_data;
> -	if (!pdata || !pdata->init) {
> -		dev_err(&pdev->dev,
> +	if (!host->pdata || !host->pdata->init) {
> +		dev_err(&host->dev,
>  			"Platform data must supply init function\n");
> -		ret = -ENODEV;
> -		goto err_freehost;
> +		return -ENODEV;
>  	}
>  
> -	if (!pdata->select_slot && pdata->num_slots > 1) {
> -		dev_err(&pdev->dev,
> +	if (!host->pdata->select_slot && host->pdata->num_slots > 1) {
> +		dev_err(&host->dev,
>  			"Platform data must supply select_slot function\n");
> -		ret = -ENODEV;
> -		goto err_freehost;
> +		return -ENODEV;
>  	}
>  
> -	if (!pdata->bus_hz) {
> -		dev_err(&pdev->dev,
> +	if (!host->pdata->bus_hz) {
> +		dev_err(&host->dev,
>  			"Platform data must supply bus speed\n");
> -		ret = -ENODEV;
> -		goto err_freehost;
> +		return -ENODEV;
>  	}
>  
> -	host->bus_hz = pdata->bus_hz;
> -	host->quirks = pdata->quirks;
> +	host->bus_hz = host->pdata->bus_hz;
> +	host->quirks = host->pdata->quirks;
>  
>  	spin_lock_init(&host->lock);
>  	INIT_LIST_HEAD(&host->queue);
>  
> -	ret = -ENOMEM;
> -	host->regs = ioremap(regs->start, resource_size(regs));
> -	if (!host->regs)
> -		goto err_freehost;
>  
> -	host->dma_ops = pdata->dma_ops;
> +	host->dma_ops = host->pdata->dma_ops;
>  	dw_mci_init_dma(host);
>  
>  	/*
> @@ -1925,7 +1901,7 @@ static int dw_mci_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Reset all blocks */
> -	if (!mci_wait_reset(&pdev->dev, host)) {
> +	if (!mci_wait_reset(&host->dev, host)) {
>  		ret = -ENODEV;
>  		goto err_dmaunmap;
>  	}
> @@ -1968,13 +1944,10 @@ static int dw_mci_probe(struct platform_device *pdev)
>  	if (!dw_mci_card_workqueue)
>  		goto err_dmaunmap;
>  	INIT_WORK(&host->card_work, dw_mci_work_routine_card);
> -
> -	ret = request_irq(irq, dw_mci_interrupt, 0, "dw-mci", host);
> +	ret = request_irq(host->irq, dw_mci_interrupt, host->irq_flags, "dw-mci", host);
>  	if (ret)
>  		goto err_workqueue;
>  
> -	platform_set_drvdata(pdev, host);
> -
>  	if (host->pdata->num_slots)
>  		host->num_slots = host->pdata->num_slots;
>  	else
> @@ -1994,7 +1967,7 @@ static int dw_mci_probe(struct platform_device *pdev)
>  	 * Need to check the version-id and set data-offset for DATA register.
>  	 */
>  	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
> -	dev_info(&pdev->dev, "Version ID is %04x\n", host->verid);
> +	dev_info(&host->dev, "Version ID is %04x\n", host->verid);
>  
>  	if (host->verid < DW_MMC_240A)
>  		host->data_offset = DATA_OFFSET;
> @@ -2011,12 +1984,12 @@ static int dw_mci_probe(struct platform_device *pdev)
>  		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
>  	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
>  
> -	dev_info(&pdev->dev, "DW MMC controller at irq %d, "
> +	dev_info(&host->dev, "DW MMC controller at irq %d, "
>  		 "%d bit host data width, "
>  		 "%u deep fifo\n",
> -		 irq, width, fifo_size);
> +		 host->irq, width, fifo_size);
>  	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
> -		dev_info(&pdev->dev, "Internal DMAC interrupt fix enabled.\n");
> +		dev_info(&host->dev, "Internal DMAC interrupt fix enabled.\n");
>  
>  	return 0;
>  
> @@ -2027,7 +2000,7 @@ err_init_slot:
>  			dw_mci_cleanup_slot(host->slot[i], i);
>  		i--;
>  	}
> -	free_irq(irq, host);
> +	free_irq(host->irq, host);
>  
>  err_workqueue:
>  	destroy_workqueue(dw_mci_card_workqueue);
> @@ -2035,33 +2008,26 @@ err_workqueue:
>  err_dmaunmap:
>  	if (host->use_dma && host->dma_ops->exit)
>  		host->dma_ops->exit(host);
> -	dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
> +	dma_free_coherent(&host->dev, PAGE_SIZE,
>  			  host->sg_cpu, host->sg_dma);
> -	iounmap(host->regs);
>  
>  	if (host->vmmc) {
>  		regulator_disable(host->vmmc);
>  		regulator_put(host->vmmc);
>  	}
> -
> -
> -err_freehost:
> -	kfree(host);
>  	return ret;
>  }
> +EXPORT_SYMBOL(dw_mci_probe);
>  
> -static int __exit dw_mci_remove(struct platform_device *pdev)
> +void dw_mci_remove(struct dw_mci *host)
>  {
> -	struct dw_mci *host = platform_get_drvdata(pdev);
>  	int i;
>  
>  	mci_writel(host, RINTSTS, 0xFFFFFFFF);
>  	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	for (i = 0; i < host->num_slots; i++) {
> -		dev_dbg(&pdev->dev, "remove slot %d\n", i);
> +		dev_dbg(&host->dev, "remove slot %d\n", i);
>  		if (host->slot[i])
>  			dw_mci_cleanup_slot(host->slot[i], i);
>  	}
> @@ -2070,9 +2036,9 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
>  	mci_writel(host, CLKENA, 0);
>  	mci_writel(host, CLKSRC, 0);
>  
> -	free_irq(platform_get_irq(pdev, 0), host);
> +	free_irq(host->irq, host);
>  	destroy_workqueue(dw_mci_card_workqueue);
> -	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
> +	dma_free_coherent(&host->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>  
>  	if (host->use_dma && host->dma_ops->exit)
>  		host->dma_ops->exit(host);
> @@ -2082,20 +2048,18 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
>  		regulator_put(host->vmmc);
>  	}
>  
> -	iounmap(host->regs);
> -
> -	kfree(host);
> -	return 0;
>  }
> +EXPORT_SYMBOL(dw_mci_remove);
> +
> +
>  
>  #ifdef CONFIG_PM_SLEEP
>  /*
>   * TODO: we should probably disable the clock to the card in the suspend path.
>   */
> -static int dw_mci_suspend(struct device *dev)
> +int dw_mci_suspend(struct dw_mci *host)
>  {
> -	int i, ret;
> -	struct dw_mci *host = dev_get_drvdata(dev);
> +	int i, ret = 0;
>  
>  	for (i = 0; i < host->num_slots; i++) {
>  		struct dw_mci_slot *slot = host->slot[i];
> @@ -2117,11 +2081,11 @@ static int dw_mci_suspend(struct device *dev)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(dw_mci_suspend);
>  
> -static int dw_mci_resume(struct device *dev)
> +int dw_mci_resume(struct dw_mci *host)
>  {
>  	int i, ret;
> -	struct dw_mci *host = dev_get_drvdata(dev);
>  
>  	if (host->vmmc)
>  		regulator_enable(host->vmmc);
> @@ -2129,7 +2093,7 @@ static int dw_mci_resume(struct device *dev)
>  	if (host->dma_ops->init)
>  		host->dma_ops->init(host);
>  
> -	if (!mci_wait_reset(dev, host)) {
> +	if (!mci_wait_reset(&host->dev, host)) {
>  		ret = -ENODEV;
>  		return ret;
>  	}
> @@ -2151,32 +2115,19 @@ static int dw_mci_resume(struct device *dev)
>  		if (ret < 0)
>  			return ret;
>  	}
> -
>  	return 0;
>  }
> -#else
> -#define dw_mci_suspend	NULL
> -#define dw_mci_resume	NULL
> +EXPORT_SYMBOL(dw_mci_resume);
>  #endif /* CONFIG_PM_SLEEP */
>  
> -static SIMPLE_DEV_PM_OPS(dw_mci_pmops, dw_mci_suspend, dw_mci_resume);
> -
> -static struct platform_driver dw_mci_driver = {
> -	.remove		= __exit_p(dw_mci_remove),
> -	.driver		= {
> -		.name		= "dw_mmc",
> -		.pm		= &dw_mci_pmops,
> -	},
> -};
> -
>  static int __init dw_mci_init(void)
>  {
> -	return platform_driver_probe(&dw_mci_driver, dw_mci_probe);
> +	printk(KERN_INFO "Synopsys Designware Multimedia Card Interface Driver");
> +	return 0;
>  }
>  
>  static void __exit dw_mci_exit(void)
>  {
> -	platform_driver_unregister(&dw_mci_driver);
>  }
>  
>  module_init(dw_mci_init);
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index df392a1..15c27e1 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -175,4 +175,11 @@
>  	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
>  #endif
>  
> +extern int dw_mci_probe(struct dw_mci *host);
> +extern void dw_mci_remove(struct dw_mci *host);
> +#ifdef CONFIG_PM
> +extern int dw_mci_suspend(struct dw_mci *host);
> +extern int dw_mci_resume(struct dw_mci *host);
> +#endif
> +
>  #endif /* _DW_MMC_H_ */
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index e8779c6..b4c031d 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -74,7 +74,7 @@ struct mmc_data;
>   * @num_slots: Number of slots available.
>   * @verid: Denote Version ID.
>   * @data_offset: Set the offset of DATA register according to VERID.
> - * @pdev: Platform device associated with the MMC controller.
> + * @dev: Device associated with the MMC controller.
>   * @pdata: Platform data associated with the MMC controller.
>   * @slot: Slots sharing this MMC controller.
>   * @fifo_depth: depth of FIFO.
> @@ -85,6 +85,8 @@ struct mmc_data;
>   * @push_data: Pointer to FIFO push function.
>   * @pull_data: Pointer to FIFO pull function.
>   * @quirks: Set of quirks that apply to specific versions of the IP.
> + * @irq_flags: The flags to be passed to request_irq.
> + * @irq: The irq value to be passed to request_irq.
>   *
>   * Locking
>   * =======
> @@ -151,7 +153,7 @@ struct dw_mci {
>  	u32			fifoth_val;
>  	u16			verid;
>  	u16			data_offset;
> -	struct platform_device	*pdev;
> +	struct device		dev;
>  	struct dw_mci_board	*pdata;
>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
>  
> @@ -172,6 +174,8 @@ struct dw_mci {
>  	u32			quirks;
>  
>  	struct regulator	*vmmc;	/* Power regulator */
> +	unsigned long		irq_flags; /* IRQ flags */
> +	unsigned int		irq;
>  };
>  
>  /* DMA ops for Internal/External DMAC interface */

