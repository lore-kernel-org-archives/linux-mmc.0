From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 6/9] mmc: cavium: Add MMC PCI driver for ThunderX SOCs
Date: Fri, 17 Mar 2017 15:58:26 +0100
Message-ID: <CAPDyKFp2-KOSYy41QCFcqdU_Rzfncea8Q4QvjHSmho+tAMYMKg@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-7-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310132507.32025-7-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
> Add a platform driver for ThunderX ARM SOCs.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/mmc/host/Kconfig               |  10 ++
>  drivers/mmc/host/Makefile              |   2 +
>  drivers/mmc/host/cavium-mmc.h          |  10 +-
>  drivers/mmc/host/cavium-pci-thunderx.c | 198 +++++++++++++++++++++++++++++++++
>  4 files changed, 218 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mmc/host/cavium-pci-thunderx.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 68cc811..3983dee 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -632,6 +632,16 @@ config MMC_CAVIUM_OCTEON
>
>           If unsure, say N.
>
> +config MMC_CAVIUM_THUNDERX
> +       tristate "Cavium ThunderX SD/MMC Card Interface support"
> +       depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
> +       select GPIO_THUNDERX

Do you really need to select GPIO_THUNDERX? What is the relationship?

Maybe "depends on GPIOLIB" instead?

> +       help
> +         This selects Cavium ThunderX SD/MMC Card Interface.
> +         If you have an Cavium ARM64 board with a Multimedia Card slot
> +         or builtin eMMC chip say Y or M here. If built as a module
> +         the module will be called thunderx_mmc.ko.
> +
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
>         depends on HAS_DMA
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index c7f0ccf..0068610 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -44,6 +44,8 @@ obj-$(CONFIG_MMC_VIA_SDMMC)   += via-sdmmc.o
>  obj-$(CONFIG_SDH_BFIN)         += bfin_sdh.o
>  octeon-mmc-objs := cavium-mmc.o cavium-pltfm-octeon.o
>  obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o
> +thunderx-mmc-objs := cavium-mmc.o cavium-pci-thunderx.o
> +obj-$(CONFIG_MMC_CAVIUM_THUNDERX) += thunderx-mmc.o
>  obj-$(CONFIG_MMC_DW)           += dw_mmc.o
>  obj-$(CONFIG_MMC_DW_PLTFM)     += dw_mmc-pltfm.o
>  obj-$(CONFIG_MMC_DW_EXYNOS)    += dw_mmc-exynos.o
> diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
> index 4b22432..fb82aee 100644
> --- a/drivers/mmc/host/cavium-mmc.h
> +++ b/drivers/mmc/host/cavium-mmc.h
> @@ -22,8 +22,12 @@
>  #define CAVIUM_MAX_MMC         4
>
>  /* DMA register addresses */
> -#define MIO_EMM_DMA_CFG(x)     (0x00 + x->reg_off_dma)
> -#define MIO_EMM_DMA_ADR(x)     (0x08 + x->reg_off_dma)
> +#define MIO_EMM_DMA_CFG(x)     (0x20 + x->reg_off_dma)
> +#define MIO_EMM_DMA_ADR(x)     (0x28 + x->reg_off_dma)
> +#define MIO_EMM_DMA_INT(x)     (0x30 + x->reg_off_dma)
> +#define MIO_EMM_DMA_INT_W1S(x) (0x38 + x->reg_off_dma)
> +#define MIO_EMM_DMA_INT_ENA_W1S(x) (0x40 + x->reg_off_dma)
> +#define MIO_EMM_DMA_INT_ENA_W1C(x) (0x48 + x->reg_off_dma)
>
>  /* register addresses */
>  #define MIO_EMM_CFG(x)         (0x00 + x->reg_off)
> @@ -39,6 +43,8 @@
>  #define MIO_EMM_SAMPLE(x)      (0x90 + x->reg_off)
>  #define MIO_EMM_STS_MASK(x)    (0x98 + x->reg_off)
>  #define MIO_EMM_RCA(x)         (0xa0 + x->reg_off)
> +#define MIO_EMM_INT_EN_SET(x)  (0xb0 + x->reg_off)
> +#define MIO_EMM_INT_EN_CLR(x)  (0xb8 + x->reg_off)
>  #define MIO_EMM_BUF_IDX(x)     (0xe0 + x->reg_off)
>  #define MIO_EMM_BUF_DAT(x)     (0xe8 + x->reg_off)
>
> diff --git a/drivers/mmc/host/cavium-pci-thunderx.c b/drivers/mmc/host/cavium-pci-thunderx.c
> new file mode 100644
> index 0000000..6ad36b4
> --- /dev/null
> +++ b/drivers/mmc/host/cavium-pci-thunderx.c
> @@ -0,0 +1,198 @@
> +/*
> + * Driver for MMC and SSD cards for Cavium ThunderX SOCs.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2016 Cavium Inc.
> + */
> +#include <linux/dma-mapping.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include "cavium-mmc.h"
> +
> +struct platform_device *slot_pdev[2];

Let's not be lazy. We don't want global arrays of platform devices,
whatever the reason.

> +
> +static void thunder_mmc_acquire_bus(struct cvm_mmc_host *host)
> +{
> +       down(&host->mmc_serializer);
> +}
> +
> +static void thunder_mmc_release_bus(struct cvm_mmc_host *host)
> +{
> +       up(&host->mmc_serializer);
> +}
> +
> +static void thunder_mmc_int_enable(struct cvm_mmc_host *host, u64 val)
> +{
> +       writeq(val, host->base + MIO_EMM_INT(host));
> +       writeq(val, host->base + MIO_EMM_INT_EN_SET(host));
> +}
> +
> +static int thunder_mmc_register_interrupts(struct cvm_mmc_host *host,
> +                                          struct pci_dev *pdev)
> +{
> +       int nvec, ret, i;
> +
> +       nvec = pci_alloc_irq_vectors(pdev, 1, 9, PCI_IRQ_MSIX);
> +       if (nvec < 0)
> +               return nvec;
> +
> +       /* register interrupts */
> +       for (i = 0; i < nvec; i++) {
> +               ret = devm_request_irq(&pdev->dev, pci_irq_vector(pdev, i),
> +                                      cvm_mmc_interrupt,
> +                                      0, cvm_mmc_irq_names[i], host);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;
> +}
> +
> +static int thunder_mmc_probe(struct pci_dev *pdev,
> +                            const struct pci_device_id *id)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *child_node;
> +       struct cvm_mmc_host *host;
> +       int ret, i = 0;
> +
> +       host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> +       if (!host)
> +               return -ENOMEM;
> +
> +       pci_set_drvdata(pdev, host);
> +       ret = pcim_enable_device(pdev);
> +       if (ret)
> +               return ret;
> +
> +       ret = pci_request_regions(pdev, KBUILD_MODNAME);
> +       if (ret)
> +               return ret;
> +
> +       host->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +       if (!host->base)
> +               return -EINVAL;
> +
> +       /* On ThunderX these are identical */
> +       host->dma_base = host->base;
> +
> +       host->reg_off = 0x2000;
> +       host->reg_off_dma = 0x160;
> +
> +       host->clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(host->clk))
> +               return PTR_ERR(host->clk);
> +
> +       ret = clk_prepare_enable(host->clk);
> +       if (ret)
> +               return ret;
> +       host->sys_freq = clk_get_rate(host->clk);
> +
> +       spin_lock_init(&host->irq_handler_lock);
> +       sema_init(&host->mmc_serializer, 1);
> +
> +       host->dev = dev;
> +       host->acquire_bus = thunder_mmc_acquire_bus;
> +       host->release_bus = thunder_mmc_release_bus;
> +       host->int_enable = thunder_mmc_int_enable;
> +
> +       host->big_dma_addr = true;
> +       host->need_irq_handler_lock = true;
> +       host->last_slot = -1;
> +
> +       ret = dma_set_mask(dev, DMA_BIT_MASK(48));
> +       if (ret)
> +               goto error;
> +
> +       /*
> +        * Clear out any pending interrupts that may be left over from
> +        * bootloader. Writing 1 to the bits clears them.
> +        */
> +       writeq(127, host->base + MIO_EMM_INT_EN(host));
> +       writeq(3, host->base + MIO_EMM_DMA_INT_ENA_W1C(host));
> +
> +       ret = thunder_mmc_register_interrupts(host, pdev);
> +       if (ret)
> +               goto error;
> +
> +       for_each_child_of_node(node, child_node) {
> +               /*
> +                * TODO: mmc_of_parse and devm* require one device per slot.

I guess the TODO is about fixing this behavior in the mmc core, such
we can use mmc_of_parse() in more flexible manner. You may want to
remove the "TODO", but please keep the comment.

> +                * Create a dummy device per slot and set the node pointer to
> +                * the slot. The easiest way to get this is using
> +                * of_platform_device_create.
> +                */
> +               if (!slot_pdev[i])
> +                       slot_pdev[i] = of_platform_device_create(child_node, NULL,
> +                                                     &pdev->dev);

Seems like we should verify that this is a slot node, by checking the
compatible, before creating a platform device for it. No?

> +               if (!slot_pdev[i])
> +                       continue;
> +               ret = cvm_mmc_of_slot_probe(&slot_pdev[i]->dev, host);
> +               if (ret)
> +                       goto error;
> +               i++;
> +       }
> +       dev_info(dev, "probed\n");
> +       return 0;
> +
> +error:
> +       clk_disable_unprepare(host->clk);
> +       return ret;
> +}
> +
> +static void thunder_mmc_remove(struct pci_dev *pdev)
> +{
> +       struct cvm_mmc_host *host = pci_get_drvdata(pdev);
> +       u64 dma_cfg;
> +       int i;
> +
> +       for (i = 0; i < CAVIUM_MAX_MMC; i++)
> +               if (host->slot[i]) {
> +                       cvm_mmc_of_slot_remove(host->slot[i]);
> +                       platform_device_del(slot_pdev[i]);
> +               }
> +
> +       dma_cfg = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
> +       dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
> +       writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
> +
> +       clk_disable_unprepare(host->clk);
> +}
> +
> +static const struct pci_device_id thunder_mmc_id_table[] = {
> +       { PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa010) },
> +       { 0, }  /* end of table */
> +};
> +
> +static struct pci_driver thunder_mmc_driver = {
> +       .name = KBUILD_MODNAME,
> +       .id_table = thunder_mmc_id_table,
> +       .probe = thunder_mmc_probe,
> +       .remove = thunder_mmc_remove,
> +};
> +
> +static int __init thunder_mmc_init_module(void)
> +{
> +       return pci_register_driver(&thunder_mmc_driver);
> +}
> +
> +static void __exit thunder_mmc_exit_module(void)
> +{
> +       pci_unregister_driver(&thunder_mmc_driver);
> +}
> +
> +module_init(thunder_mmc_init_module);
> +module_exit(thunder_mmc_exit_module);
> +
> +MODULE_AUTHOR("Cavium Inc.");
> +MODULE_DESCRIPTION("Cavium ThunderX eMMC Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(pci, thunder_mmc_id_table);
> --
> 2.9.0.rc0.21.g7777322
>

Kind regards
Uffe
