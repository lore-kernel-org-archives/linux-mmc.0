From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 30 Nov 2011 10:15:45 +0000
Message-ID: <4ED60251.6080409@imgtec.com>
References: <1322591437-4494-1-git-send-email-shashidharh@vayavyalabs.com>	<20111129212633.GB26823@balrog> <CANYdXnqB6DhFd6Sd72OE+YZ5tpEnkN3a68vZKBLXSn9FyHUaPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:10379 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab1K3KP4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Nov 2011 05:15:56 -0500
In-Reply-To: <CANYdXnqB6DhFd6Sd72OE+YZ5tpEnkN3a68vZKBLXSn9FyHUaPA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: James Hogan <james@albanarts.com>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On 11/30/2011 10:01 AM, Shashidhar Hiremath wrote:
> Hi James,
>   thanks for the reply.
> 
> On Wed, Nov 30, 2011 at 2:56 AM, James Hogan <james@albanarts.com> wrote:
>> Hi,
>>
>> Thanks for the update. It's better, but there's still a few issues...
>>
>> On Wed, Nov 30, 2011 at 12:00:37AM +0530, Shashidhar Hiremath wrote:
>>> Support of PCI mode for the dw_mmc driver This Patch adds the support for the scenario where the Synopsys Designware IP is present on the PCI bus.The patch adds the minimal modifications necessary for the driver to work on PCI platform.Also added separate files for PCI and PLATFORM modes of operation
>>
>> Being picky, but full stop at end of sentences, and a space between
>> sentences would be nice. Wrapping to 72 characters is nice too. :)
>>
>>>
>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>> ---
>>> v2:
>>> *As per Suggestions by Will Newton and James Hogan
>>> -Reduced the number of ifdefs
>>> v3:
>>> *As per Suggestions by Will Newton and James Hogan
>>> -Added separate files for PCI and PLATFORM Modes similar to SDHCI driver
>>>  drivers/mmc/host/Kconfig        |   23 ++++++
>>>  drivers/mmc/host/Makefile       |    2 +
>>>  drivers/mmc/host/dw_mmc-pci.c   |  159 +++++++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/dw_mmc-pltfm.c |  125 ++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/dw_mmc.c       |  155 ++++++++++++++------------------------
>>>  drivers/mmc/host/dw_mmc.h       |    7 ++
>>>  include/linux/mmc/dw_mmc.h      |    4 +-
>>>  7 files changed, 374 insertions(+), 101 deletions(-)
>>>  create mode 100644 drivers/mmc/host/dw_mmc-pci.c
>>>  create mode 100644 drivers/mmc/host/dw_mmc-pltfm.c
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 87d5067..6735fbe 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -534,6 +534,29 @@ config MMC_DW_IDMAC
>>>         Designware Mobile Storage IP block. This disables the external DMA
>>>         interface.
>>>
>>> +config MMC_DW_PCI
>>> +     tristate "Synopsys Designware MCI support on PCI bus"
>>> +     depends on MMC_DW && PCI
>>> +     help
>>> +       This selects the PCI bus for the Synopsys Designware Mobile Storage IP.
>>> +       Select this option if the IP is present on PCI platform.
>>> +
>>> +       If you have a controller with this interface, say Y or M here.
>>> +
>>> +       If unsure, say N.
>>> +
>>> +config MMC_DW_PLTFM
>>> +     tristate "platform driver helper for Synopsys Designware Mobile Storage IP"
>>> +     depends on MMC_DW
>>> +     help
>>> +       This selects the common helper functions support for Host Controller
>>> +       Interface based platform driver.Please select this option if the IP
>>> +       is present as a platform device.
>>> +
>>> +       If you have a controller with this interface, say Y or M here.
>>> +
>>> +       If unsure, say N.
>>> +
>>>  config MMC_SH_MMCIF
>>>       tristate "SuperH Internal MMCIF support"
>>>       depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>> index b4b83f3..3aa2fa3 100644
>>> --- a/drivers/mmc/host/Makefile
>>> +++ b/drivers/mmc/host/Makefile
>>> @@ -38,6 +38,8 @@ obj-$(CONFIG_MMC_CB710)             += cb710-mmc.o
>>>  obj-$(CONFIG_MMC_VIA_SDMMC)  += via-sdmmc.o
>>>  obj-$(CONFIG_SDH_BFIN)               += bfin_sdh.o
>>>  obj-$(CONFIG_MMC_DW)         += dw_mmc.o
>>> +obj-$(CONFIG_MMC_DW_PLTFM)   += dw_mmc-pltfm.o
>>> +obj-$(CONFIG_MMC_DW_PCI)     += dw_mmc-pci.o
>>>  obj-$(CONFIG_MMC_SH_MMCIF)   += sh_mmcif.o
>>>  obj-$(CONFIG_MMC_JZ4740)     += jz4740_mmc.o
>>>  obj-$(CONFIG_MMC_VUB300)     += vub300.o
>>> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
>>> new file mode 100644
>>> index 0000000..7d8fb5e
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/dw_mmc-pci.c
>>> @@ -0,0 +1,159 @@
>>> +/*
>>> + * Synopsys DesignWare Multimedia Card PCI Interface driver
>>> + *
>>> + * Copyright (C) 2011 Vayavya Labs Pvt. Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/mmc/host.h>
>>> +#include <linux/mmc/mmc.h>
>>> +#include <linux/mmc/dw_mmc.h>
>>> +#include "dw_mmc.h"
>>> +
>>> +#define PCI_BAR_NO 2
>>> +#define COMPLETE_BAR 0
>>> +#define DW_MCI_VENDOR_ID 0x700
>>> +#define DW_MCI_DEVICE_ID 0x1107
>>> +/* Defining the Capabilities */
>>> +#define DW_MCI_CAPABILITIES (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED |\
>>> +                             MMC_CAP_SD_HIGHSPEED | MMC_CAP_8_BIT_DATA |\
>>> +                             MMC_CAP_SDIO_IRQ)
>>> +
>>> +static struct dw_mci_board pci_board_data = {
>>> +     .num_slots                      = 1,
>>> +     .caps                           = DW_MCI_CAPABILITIES,
>>> +     .bus_hz                         = 33 * 1000 * 1000,
>>> +     .detect_delay_ms                = 200,
>>> +     .fifo_depth                     = 32,
>>> +};
>>> +
>>> +static int __devinit dw_mci_pci_probe(struct pci_dev *pdev,
>>> +                               const struct pci_device_id *entries)
>>> +{
>>> +     struct  dw_mci *host;
>>> +     int     ret;
>>> +
>>> +     ret = pci_enable_device(pdev);
>>> +     if (ret)
>>> +             return ret;
>>> +     if (pci_request_regions(pdev, "dw_mmc_pci")) {
>>> +             ret = -ENODEV;
>>> +             goto err_freehost;
>>
>> This will kfree the as yet uninitialised host.
>>
>> Should this (and later error handlers) also undo the effects of
>> pci_enable_device with pci_disable_device?
>>
> Yes , Will make the change
>>> +     }
>>> +
>>> +     host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>>> +     if (!host)
>>> +             return -ENOMEM;
>>> +
>>> +     host->irq = pdev->irq;
>>> +     host->dev = pdev->dev;
>>> +     host->pdata = &pci_board_data;
>>> +
>>> +     ret = -ENOMEM;
>>
>> what's this for?
>>
> This has somehow creeped from the old code.Will clean it up.
>>> +     host->regs = pci_iomap(pdev, PCI_BAR_NO, COMPLETE_BAR);
>>> +     if (!host->regs) {
>>> +             pci_release_regions(pdev);
>>> +             ret = -EIO;
>>> +             goto err_freehost;
>>> +     }
>>> +
>>> +
>>> +     pci_set_drvdata(pdev, host);
>>> +     ret = dw_mci_probe(host);
>>> +     if (ret)
>>> +err_freehost:
>>> +             kfree(host);
>>
>> pci_iounmap?
>>
> will add this.
>>> +     return ret;
>>
>> Since there are several things that need cleaning up on failure, it
>> should really have the error handling labels after the return like a lot
>> of other kernel drivers do (e.g. see ioapic_probe() in
>> drivers/pci/ioapic.c). This makes the code a lot neater and easier to
>> read.
>>
>>> +}
>>> +
>>> +
>>> +
>>> +
>>> +static void __devexit dw_mci_pci_remove(struct pci_dev *pdev)
>>> +{
>>> +
>>
>> no need for a newline here
>>
>>> +     struct dw_mci *host = pci_get_drvdata(pdev);
>>> +
>>> +     mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>> +     mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>>> +
>>> +     pci_set_drvdata(pdev, NULL);
>>> +     dw_mci_remove(host);
>>> +     pci_release_regions(pdev);
>>> +     kfree(host);
>>
>> should this also be pci_iounmap'ing, and pci_disable_device'ing?
>>
> Yes, will make the change.
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +static int dw_mci_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
>>> +{
>>> +     int  ret;
>>> +     struct dw_mci *host = pci_get_drvdata(pdev);
>>> +
>>> +     ret = dw_mci_suspend(host);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/*
>>> + * TODO: we should probably disable the clock to the card in the suspend path.
>>> + */
>>> +
>>> +
>>> +static int dw_mci_pci_resume(struct pci_dev *pdev)
>>> +{
>>> +     int ret;
>>> +     struct dw_mci *host = pci_get_drvdata(pdev);
>>> +
>>> +     ret = dw_mci_resume(host);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +#else
>>> +#define dw_mci_pci_suspend   NULL
>>> +#define dw_mci_pci_resume    NULL
>>> +#endif /* CONFIG_PM */
>>> +
>>> +static DEFINE_PCI_DEVICE_TABLE(dw_mci_pci_id) = {
>>> +     { PCI_DEVICE(DW_MCI_DEVICE_ID, DW_MCI_VENDOR_ID) },
>>> +     {}
>>> +};
>>> +MODULE_DEVICE_TABLE(pci, dw_mci_pci_id);
>>> +
>>> +static struct pci_driver dw_mci_pci_driver = {
>>> +     .name           = "dw_mmc_pci",
>>> +     .id_table       = dw_mci_pci_id,
>>> +     .probe          = dw_mci_pci_probe,
>>> +     .remove         = dw_mci_pci_remove,
>>> +     .suspend        = dw_mci_pci_suspend,
>>> +     .resume         = dw_mci_pci_resume,
>>> +};
>>> +
>>> +static int __init dw_mci_init(void)
>>> +{
>>> +     return pci_register_driver(&dw_mci_pci_driver);
>>> +}
>>> +
>>> +static void __exit dw_mci_exit(void)
>>> +{
>>> +     pci_unregister_driver(&dw_mci_pci_driver);
>>> +}
>>> +
>>> +module_init(dw_mci_init);
>>> +module_exit(dw_mci_exit);
>>> +
>>> +MODULE_DESCRIPTION("DW Multimedia Card PCI Interface driver");
>>> +MODULE_AUTHOR("Shashidhar Hiremath <shashidharh@vayavyalabs.com>");
>>> +MODULE_AUTHOR("VayavyaLabs Pvt. Ltd.");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
>>> new file mode 100644
>>> index 0000000..0c6a95df
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>> @@ -0,0 +1,125 @@
>>> +/*
>>> + * Synopsys DesignWare Multimedia Card Interface driver
>>> + *
>>> + * Copyright (C) 2009 NXP Semiconductors
>>> + * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/mmc/host.h>
>>> +#include <linux/mmc/mmc.h>
>>> +#include <linux/mmc/dw_mmc.h>
>>> +#include "dw_mmc.h"
>>> +
>>> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
>>> +{
>>> +     struct dw_mci *host;
>>> +     struct resource *regs;
>>> +     int  ret;
>>
>> no need for the extra space before ret.
>>
>>> +
>>> +     host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>>> +     if (!host)
>>> +             return -ENOMEM;
>>> +
>>> +     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +     if (!regs)
>>> +             return -ENXIO;
>>> +
>>> +     host->irq = platform_get_irq(pdev, 0);
>>> +     if (host->irq < 0)
>>> +             return host->irq;
>>> +
>>> +     host->dev = pdev->dev;
>>> +     host->pdata = pdev->dev.platform_data;
>>> +     ret = -ENOMEM;
>>> +     host->regs = ioremap(regs->start, resource_size(regs));
>>> +     if (!host->regs)
>>> +             goto err_freehost;
>>> +     platform_set_drvdata(pdev, host);
>>> +     ret = dw_mci_probe(host);
>>> +     if (ret)
>>> +err_freehost:
>>> +             kfree(host);
>>> +     return ret;
>>
>> same stuff again, please fix the error handling.
>>
> will do the change.
>>> +}
>>> +
>>> +static int __exit dw_mci_pltfm_remove(struct platform_device *pdev)
>>> +{
>>> +     struct dw_mci *host = platform_get_drvdata(pdev);
>>> +
>>> +     mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>> +     mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>>> +
>>> +     platform_set_drvdata(pdev, NULL);
>>> +     dw_mci_remove(host);
>>> +     kfree(host);
>>
>> iounmap (see below)?
>>
>>> +     return 0;
>>> +}
>>> +#ifdef CONFIG_PM
>>> +/*
>>> + * TODO: we should probably disable the clock to the card in the suspend path.
>>> + */
>>> +static int dw_mci_pltfm_suspend(struct platform_device *pdev, pm_message_t mesg)
>>> +{
>>> +
>>> +     int  ret;
>>> +     struct dw_mci *host = platform_get_drvdata(pdev);
>>> +
>>> +     ret = dw_mci_suspend(host);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int dw_mci_pltfm_resume(struct platform_device *pdev)
>>> +{
>>> +
>>> +     int ret;
>>> +     struct dw_mci *host = platform_get_drvdata(pdev);
>>> +
>>> +     ret = dw_mci_resume(host);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +#else
>>> +#define dw_mci_pltfm_suspend NULL
>>> +#define dw_mci_pltfm_resume  NULL
>>> +#endif /* CONFIG_PM */
>>> +
>>> +static struct platform_driver dw_mci_pltfm_driver = {
>>> +     .remove         = __exit_p(dw_mci_pltfm_remove),
>>> +     .suspend        = dw_mci_pltfm_suspend,
>>> +     .resume         = dw_mci_pltfm_resume,
>>> +     .driver         = {
>>> +             .name           = "dw_mmc",
>>> +     },
>>> +};
>>> +
>>> +static int __init dw_mci_init(void)
>>> +{
>>> +     return platform_driver_probe(&dw_mci_pltfm_driver, dw_mci_pltfm_probe);
>>> +}
>>> +
>>> +static void __exit dw_mci_exit(void)
>>> +{
>>> +     platform_driver_unregister(&dw_mci_pltfm_driver);
>>> +}
>>> +
>>> +module_init(dw_mci_init);
>>> +module_exit(dw_mci_exit);
>>> +
>>> +MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
>>> +MODULE_AUTHOR("NXP Semiconductor VietNam");
>>> +MODULE_AUTHOR("Imagination Technologies Ltd");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 3aaeb08..7d33626 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -269,7 +269,7 @@ static void dw_mci_start_command(struct dw_mci *host,
>>>                                struct mmc_command *cmd, u32 cmd_flags)
>>>  {
>>>       host->cmd = cmd;
>>> -     dev_vdbg(&host->pdev->dev,
>>> +     dev_vdbg(&host->dev,
>>>                "start command: ARGR=0x%08x CMDR=0x%08x\n",
>>>                cmd->arg, cmd_flags);
>>>
>>> @@ -302,7 +302,7 @@ static void dw_mci_dma_cleanup(struct dw_mci *host)
>>>       struct mmc_data *data = host->data;
>>>
>>>       if (data)
>>> -             dma_unmap_sg(&host->pdev->dev, data->sg, data->sg_len,
>>> +             dma_unmap_sg(&host->dev, data->sg, data->sg_len,
>>>                            ((data->flags & MMC_DATA_WRITE)
>>>                             ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
>>>  }
>>> @@ -327,7 +327,7 @@ static void dw_mci_idmac_complete_dma(struct dw_mci *host)
>>>  {
>>>       struct mmc_data *data = host->data;
>>>
>>> -     dev_vdbg(&host->pdev->dev, "DMA complete\n");
>>> +     dev_vdbg(&host->dev, "DMA complete\n");
>>>
>>>       host->dma_ops->cleanup(host);
>>>
>>> @@ -463,10 +463,10 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>>>       else
>>>               direction = DMA_TO_DEVICE;
>>>
>>> -     sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
>>> +     sg_len = dma_map_sg(&host->dev, data->sg, data->sg_len,
>>>                           direction);
>>>
>>> -     dev_vdbg(&host->pdev->dev,
>>> +     dev_vdbg(&host->dev,
>>>                "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
>>>                (unsigned long)host->sg_cpu, (unsigned long)host->sg_dma,
>>>                sg_len);
>>> @@ -716,6 +716,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>       switch (ios->power_mode) {
>>>       case MMC_POWER_UP:
>>>               set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
>>> +             mci_writel(slot->host, PWREN, (0x1 << (slot->id)));
>>
>> Was this something that the original driver should have been doing? (it
>> might be best as a separate patch if so).
>>
> Yes, I will submit another patch on this.
>> Does it need to be undone somewhere?
>>
>> Won't it unintentionally power down all other slots by writing 0 to
>> them?
>>
>> Do you "wait for regulator/switch ramp-up time before trying to
>> initialize card" (quoting TRM) or is that handled by other code?
>>
>>>               break;
>>>       default:
>>>               break;
>>> @@ -804,12 +805,12 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>>>               slot = list_entry(host->queue.next,
>>>                                 struct dw_mci_slot, queue_node);
>>>               list_del(&slot->queue_node);
>>> -             dev_vdbg(&host->pdev->dev, "list not empty: %s is next\n",
>>> +             dev_vdbg(&host->dev, "list not empty: %s is next\n",
>>>                        mmc_hostname(slot->mmc));
>>>               host->state = STATE_SENDING_CMD;
>>>               dw_mci_start_request(host, slot);
>>>       } else {
>>> -             dev_vdbg(&host->pdev->dev, "list empty\n");
>>> +             dev_vdbg(&host->dev, "list empty\n");
>>>               host->state = STATE_IDLE;
>>>       }
>>>
>>> @@ -941,7 +942,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>>>                                       data->bytes_xfered = 0;
>>>                                       data->error = -ETIMEDOUT;
>>>                               } else {
>>> -                                     dev_err(&host->pdev->dev,
>>> +                                     dev_err(&host->dev,
>>>                                               "data FIFO error "
>>>                                               "(status=%08x)\n",
>>>                                               status);
>>> @@ -1651,7 +1652,7 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>>       struct mmc_host *mmc;
>>>       struct dw_mci_slot *slot;
>>>
>>> -     mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), &host->pdev->dev);
>>> +     mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), &host->dev);
>>>       if (!mmc)
>>>               return -ENOMEM;
>>>
>>> @@ -1757,10 +1758,10 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
>>>  static void dw_mci_init_dma(struct dw_mci *host)
>>>  {
>>>       /* Alloc memory for sg translation */
>>> -     host->sg_cpu = dma_alloc_coherent(&host->pdev->dev, PAGE_SIZE,
>>> +     host->sg_cpu = dma_alloc_coherent(&host->dev, PAGE_SIZE,
>>>                                         &host->sg_dma, GFP_KERNEL);
>>>       if (!host->sg_cpu) {
>>> -             dev_err(&host->pdev->dev, "%s: could not alloc DMA memory\n",
>>> +             dev_err(&host->dev, "%s: could not alloc DMA memory\n",
>>>                       __func__);
>>>               goto no_dma;
>>>       }
>>> @@ -1768,7 +1769,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>>>       /* Determine which DMA interface to use */
>>>  #ifdef CONFIG_MMC_DW_IDMAC
>>>       host->dma_ops = &dw_mci_idmac_ops;
>>> -     dev_info(&host->pdev->dev, "Using internal DMA controller.\n");
>>> +     dev_info(&host->dev, "Using internal DMA controller.\n");
>>>  #endif
>>>
>>>       if (!host->dma_ops)
>>> @@ -1776,12 +1777,12 @@ static void dw_mci_init_dma(struct dw_mci *host)
>>>
>>>       if (host->dma_ops->init) {
>>>               if (host->dma_ops->init(host)) {
>>> -                     dev_err(&host->pdev->dev, "%s: Unable to initialize "
>>> +                     dev_err(&host->dev, "%s: Unable to initialize "
>>>                               "DMA Controller.\n", __func__);
>>>                       goto no_dma;
>>>               }
>>>       } else {
>>> -             dev_err(&host->pdev->dev, "DMA initialization not found.\n");
>>> +             dev_err(&host->dev, "DMA initialization not found.\n");
>>>               goto no_dma;
>>>       }
>>>
>>> @@ -1789,7 +1790,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>>>       return;
>>>
>>>  no_dma:
>>> -     dev_info(&host->pdev->dev, "Using PIO mode.\n");
>>> +     dev_info(&host->dev, "Using PIO mode.\n");
>>>       host->use_dma = 0;
>>>       return;
>>>  }
>>> @@ -1815,61 +1816,37 @@ static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
>>>       return false;
>>>  }
>>>
>>> -static int dw_mci_probe(struct platform_device *pdev)
>>> +int dw_mci_probe(struct dw_mci *host)
>>>  {
>>> -     struct dw_mci *host;
>>> -     struct resource *regs;
>>> -     struct dw_mci_board *pdata;
>>> -     int irq, ret, i, width;
>>> +     int width, i , ret;
>>
>> no need for a space after the i.
>>
>>>       u32 fifo_size;
>>>
>>> -     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> -     if (!regs)
>>> -             return -ENXIO;
>>> -
>>> -     irq = platform_get_irq(pdev, 0);
>>> -     if (irq < 0)
>>> -             return irq;
>>> -
>>> -     host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
>>> -     if (!host)
>>> -             return -ENOMEM;
>>> -
>>> -     host->pdev = pdev;
>>> -     host->pdata = pdata = pdev->dev.platform_data;
>>> -     if (!pdata || !pdata->init) {
>>> -             dev_err(&pdev->dev,
>>> +     if (!host->pdata || !host->pdata->init) {
>>> +             dev_err(&host->dev,
>>>                       "Platform data must supply init function\n");
>>> -             ret = -ENODEV;
>>> -             goto err_freehost;
>>> +             return -ENODEV;
>>>       }
>>>
>>> -     if (!pdata->select_slot && pdata->num_slots > 1) {
>>> -             dev_err(&pdev->dev,
>>> +     if (!host->pdata->select_slot && host->pdata->num_slots > 1) {
>>> +             dev_err(&host->dev,
>>>                       "Platform data must supply select_slot function\n");
>>> -             ret = -ENODEV;
>>> -             goto err_freehost;
>>> +             return -ENODEV;
>>>       }
>>>
>>> -     if (!pdata->bus_hz) {
>>> -             dev_err(&pdev->dev,
>>> +     if (!host->pdata->bus_hz) {
>>> +             dev_err(&host->dev,
>>>                       "Platform data must supply bus speed\n");
>>> -             ret = -ENODEV;
>>> -             goto err_freehost;
>>> +             return -ENODEV;
>>>       }
>>>
>>> -     host->bus_hz = pdata->bus_hz;
>>> -     host->quirks = pdata->quirks;
>>> +     host->bus_hz = host->pdata->bus_hz;
>>> +     host->quirks = host->pdata->quirks;
>>>
>>>       spin_lock_init(&host->lock);
>>>       INIT_LIST_HEAD(&host->queue);
>>>
>>> -     ret = -ENOMEM;
>>> -     host->regs = ioremap(regs->start, resource_size(regs));
>>> -     if (!host->regs)
>>> -             goto err_freehost;
>>>
>>> -     host->dma_ops = pdata->dma_ops;
>>> +     host->dma_ops = host->pdata->dma_ops;
>>>       dw_mci_init_dma(host);
>>>
>>>       /*
>>> @@ -1899,7 +1876,7 @@ static int dw_mci_probe(struct platform_device *pdev)
>>>       }
>>>
>>>       /* Reset all blocks */
>>> -     if (!mci_wait_reset(&pdev->dev, host)) {
>>> +     if (!mci_wait_reset(&host->dev, host)) {
>>>               ret = -ENODEV;
>>>               goto err_dmaunmap;
>>>       }
>>> @@ -1942,13 +1919,13 @@ static int dw_mci_probe(struct platform_device *pdev)
>>>       if (!dw_mci_card_workqueue)
>>>               goto err_dmaunmap;
>>>       INIT_WORK(&host->card_work, dw_mci_work_routine_card);
>>> -
>>> -     ret = request_irq(irq, dw_mci_interrupt, 0, "dw-mci", host);
>>> +#ifdef CONFIG_MMC_DW_PCI
>>> +     ret = request_irq(host->irq, dw_mci_interrupt, IRQF_SHARED, "dw-mci", host);
>>> +#else
>>> +     ret = request_irq(host->irq, dw_mci_interrupt, 0, "dw-mci", host);
>>> +#endif
>>
>> is this necessary? perhaps it could pass in the irq flags from the
>> caller somehow.
>>
>>>       if (ret)
>>>               goto err_workqueue;
>>> -
>>> -     platform_set_drvdata(pdev, host);
>>> -
>>>       if (host->pdata->num_slots)
>>>               host->num_slots = host->pdata->num_slots;
>>>       else
>>> @@ -1985,12 +1962,12 @@ static int dw_mci_probe(struct platform_device *pdev)
>>>                  DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
>>>       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
>>>
>>> -     dev_info(&pdev->dev, "DW MMC controller at irq %d, "
>>> +     dev_info(&host->dev, "DW MMC controller at irq %d, "
>>>                "%d bit host data width, "
>>>                "%u deep fifo\n",
>>> -              irq, width, fifo_size);
>>> +              host->irq, width, fifo_size);
>>>       if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>>> -             dev_info(&pdev->dev, "Internal DMAC interrupt fix enabled.\n");
>>> +             dev_info(&host->dev, "Internal DMAC interrupt fix enabled.\n");
>>>
>>>       return 0;
>>>
>>> @@ -2001,7 +1978,7 @@ err_init_slot:
>>>                       dw_mci_cleanup_slot(host->slot[i], i);
>>>               i--;
>>>       }
>>> -     free_irq(irq, host);
>>> +     free_irq(host->irq, host);
>>>
>>>  err_workqueue:
>>>       destroy_workqueue(dw_mci_card_workqueue);
>>> @@ -2009,7 +1986,7 @@ err_workqueue:
>>>  err_dmaunmap:
>>>       if (host->use_dma && host->dma_ops->exit)
>>>               host->dma_ops->exit(host);
>>> -     dma_free_coherent(&host->pdev->dev, PAGE_SIZE,
>>> +     dma_free_coherent(&host->dev, PAGE_SIZE,
>>>                         host->sg_cpu, host->sg_dma);
>>>       iounmap(host->regs);
>>
>> this iounmap can be moved out to caller now that regs it initialised by
>> caller.
>>
>>>
>>> @@ -2017,25 +1994,16 @@ err_dmaunmap:
>>>               regulator_disable(host->vmmc);
>>>               regulator_put(host->vmmc);
>>>       }
>>> -
>>> -
>>> -err_freehost:
>>> -     kfree(host);
>>>       return ret;
>>>  }
>>> +EXPORT_SYMBOL(dw_mci_probe);
>>>
>>> -static int __exit dw_mci_remove(struct platform_device *pdev)
>>> +void dw_mci_remove(struct dw_mci *host)
>>>  {
>>> -     struct dw_mci *host = platform_get_drvdata(pdev);
>>>       int i;
>>>
>>> -     mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>> -     mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>>
>> This seems pretty independent of PCI/platform, and is done by both
>> callers anyway. Perhaps it should stay where it is.
>>
>>> -
>>> -     platform_set_drvdata(pdev, NULL);
>>> -
>>>       for (i = 0; i < host->num_slots; i++) {
>>> -             dev_dbg(&pdev->dev, "remove slot %d\n", i);
>>> +             dev_dbg(&host->dev, "remove slot %d\n", i);
>>>               if (host->slot[i])
>>>                       dw_mci_cleanup_slot(host->slot[i], i);
>>>       }
>>> @@ -2044,9 +2012,9 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
>>>       mci_writel(host, CLKENA, 0);
>>>       mci_writel(host, CLKSRC, 0);
>>>
>>> -     free_irq(platform_get_irq(pdev, 0), host);
>>> +     free_irq(host->irq, host);
>>>       destroy_workqueue(dw_mci_card_workqueue);
>>> -     dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>>> +     dma_free_coherent(&host->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>>>
>>>       if (host->use_dma && host->dma_ops->exit)
>>>               host->dma_ops->exit(host);
>>> @@ -2057,19 +2025,18 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
>>>       }
>>>
>>>       iounmap(host->regs);
>>
>> same here (move out to caller)
>>
>>> -
>>> -     kfree(host);
>>> -     return 0;
>>>  }
>>> +EXPORT_SYMBOL(dw_mci_remove);
>>> +
>>> +
>>>
>>>  #ifdef CONFIG_PM
>>>  /*
>>>   * TODO: we should probably disable the clock to the card in the suspend path.
>>>   */
>>> -static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
>>> +int dw_mci_suspend(struct dw_mci *host)
>>>  {
>>>       int i, ret;
>>> -     struct dw_mci *host = platform_get_drvdata(pdev);
>>>
>>>       for (i = 0; i < host->num_slots; i++) {
>>>               struct dw_mci_slot *slot = host->slot[i];
>>> @@ -2091,19 +2058,18 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
>>>
>>>       return 0;
>>>  }
>>> +EXPORT_SYMBOL(dw_mci_suspend);
>>>
>>> -static int dw_mci_resume(struct platform_device *pdev)
>>> +int dw_mci_resume(struct dw_mci *host)
>>>  {
>>>       int i, ret;
>>> -     struct dw_mci *host = platform_get_drvdata(pdev);
>>> -
>>>       if (host->vmmc)
>>>               regulator_enable(host->vmmc);
>>>
>>>       if (host->dma_ops->init)
>>>               host->dma_ops->init(host);
>>>
>>> -     if (!mci_wait_reset(&pdev->dev, host)) {
>>> +     if (!mci_wait_reset(&host->dev, host)) {
>>>               ret = -ENODEV;
>>>               return ret;
>>>       }
>>> @@ -2125,31 +2091,22 @@ static int dw_mci_resume(struct platform_device *pdev)
>>>               if (ret < 0)
>>>                       return ret;
>>>       }
>>> -
>>>       return 0;
>>>  }
>>> +EXPORT_SYMBOL(dw_mci_resume);
>>>  #else
>>>  #define dw_mci_suspend       NULL
>>>  #define dw_mci_resume        NULL
>>
>> this else bit can probably go since the #defines aren't being used
>> any more.
>>
>>>  #endif /* CONFIG_PM */
>>>
>>> -static struct platform_driver dw_mci_driver = {
>>> -     .remove         = __exit_p(dw_mci_remove),
>>> -     .suspend        = dw_mci_suspend,
>>> -     .resume         = dw_mci_resume,
>>> -     .driver         = {
>>> -             .name           = "dw_mmc",
>>> -     },
>>> -};
>>> -
>>>  static int __init dw_mci_init(void)
>>>  {
>>> -     return platform_driver_probe(&dw_mci_driver, dw_mci_probe);
>>> +     printk(KERN_INFO "Synopsys Designware Multimedia Card Interface Driver");
>>> +     return 0;
>>>  }
>>>
>>>  static void __exit dw_mci_exit(void)
>>>  {
>>> -     platform_driver_unregister(&dw_mci_driver);
>>>  }
>>>
>>>  module_init(dw_mci_init);
>>
>> if the init and exit functions of the main driver no longer do anything,
>> they can probably go too.
> Actually, when I looked at the SDHCI-PCI drivers, these are still
> present because the the plain sdhci.ko can be loaded as an independent
> module, after that we can insert either pltfm.ko module or pci.ko
> module. So I feel it would be better to keep them as it is.

Okay, fair enough.

Thanks
James

>>
>>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>>> index 72c071f..70078f6 100644
>>> --- a/drivers/mmc/host/dw_mmc.h
>>> +++ b/drivers/mmc/host/dw_mmc.h
>>> @@ -175,4 +175,11 @@
>>>       (*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
>>>  #endif
>>>
>>> +extern int dw_mci_probe(struct dw_mci *host);
>>> +extern void dw_mci_remove(struct dw_mci *host);
>>> +#ifdef CONFIG_PM
>>> +extern int dw_mci_suspend(struct dw_mci *host);
>>> +extern int dw_mci_resume(struct dw_mci *host);
>>> +#endif
>>> +
>>>  #endif /* _DW_MMC_H_ */
>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>>> index 6dc9b80..5240446 100644
>>> --- a/include/linux/mmc/dw_mmc.h
>>> +++ b/include/linux/mmc/dw_mmc.h
>>> @@ -74,7 +74,7 @@ struct mmc_data;
>>>   * @num_slots: Number of slots available.
>>>   * @verid: Denote Version ID.
>>>   * @data_offset: Set the offset of DATA register according to VERID.
>>> - * @pdev: Platform device associated with the MMC controller.
>>> + * @dev: device associated with the MMC controller.
>>
>> I'm being picky here, but you could capitalise the d of device, for
>> consistency with the rest of the descriptions.
>>
>>>   * @pdata: Platform data associated with the MMC controller.
>>>   * @slot: Slots sharing this MMC controller.
>>>   * @fifo_depth: depth of FIFO.
>>> @@ -151,7 +151,7 @@ struct dw_mci {
>>>       u32                     fifoth_val;
>>>       u16                     verid;
>>>       u16                     data_offset;
>>> -     struct platform_device  *pdev;
>>> +     struct device           *dev;
>>>       struct dw_mci_board     *pdata;
>>>       struct dw_mci_slot      *slot[MAX_MCI_SLOTS];
>>>
>>> --
>>> 1.7.6.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Thanks
>> James
> 
> 
> 

