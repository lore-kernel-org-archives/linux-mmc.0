From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 1/2] misc: cardreader: add new Alcor Micro Cardreader
 PCI driver
Date: Wed, 5 Dec 2018 15:24:12 +0100
Message-ID: <CAPDyKFpveV-mAb1xxULE4irKkdi=_DsuVtYgupR6z82G=rDsEQ@mail.gmail.com>
References: <20181202103046.29377-1-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181202103046.29377-1-linux@rempel-privat.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Peter wein.peter" <peter.wein@gmx.de>, Daniel Drake <drake@endlessm.com>, chiu@endlessm.com, linux@endlessm.com, morling.huang@alcorlink.com, bob@alcormicro.com, jin.tsai@alcorlink.com, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 2 Dec 2018 at 11:31, Oleksij Rempel <linux@rempel-privat.de> wrote:
>
> This driver provides support for Alcor Micro AU6601 and AU6621
> card readers.
>
> This is single LUN HW and it is expected to work with following standards:
> - Support SDR104 / SDR50
> - MultiMedia Card (MMC)
> - Memory Stick (MS)
> - Memory Stick PRO (MS_Pro)
>
> Since it is a PCIe controller, it should work on any architecture
> supporting PCIe. For now, it was developed and tested only on x86_64.
>
> This driver is a result of RE work and was created without any
> documentation or real knowledge of HW internals.
>
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/misc/Makefile               |   2 +-
>  drivers/misc/cardreader/Kconfig     |  11 +
>  drivers/misc/cardreader/Makefile    |   4 +-
>  drivers/misc/cardreader/alcor_pci.c | 371 ++++++++++++++++++++++++++++
>  include/linux/alcor_pci.h           | 286 +++++++++++++++++++++
>  5 files changed, 671 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/misc/cardreader/alcor_pci.c
>  create mode 100644 include/linux/alcor_pci.h
>
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index af22bbc3d00c..fe3134cf3008 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,4 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_CTRL) += aspeed-lpc-ctrl.o
>  obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)             += ocxl/
> -obj-$(CONFIG_MISC_RTSX)                += cardreader/
> +obj-y          += cardreader/
> diff --git a/drivers/misc/cardreader/Kconfig b/drivers/misc/cardreader/Kconfig
> index 69e815e32a8c..ed8993b5d058 100644
> --- a/drivers/misc/cardreader/Kconfig
> +++ b/drivers/misc/cardreader/Kconfig
> @@ -1,3 +1,14 @@
> +config MISC_ALCOR_PCI
> +       tristate "Alcor Micro/Alcor Link PCI-E card reader"
> +       depends on PCI
> +       select MFD_CORE
> +       help
> +         This supports for Alcor Micro PCI-Express card reader including au6601,
> +         au6621.
> +         Alcor Micro card readers support access to many types of memory cards,
> +         such as Memory Stick, Memory Stick Pro, Secure Digital and
> +         MultiMediaCard.
> +
>  config MISC_RTSX_PCI
>         tristate "Realtek PCI-E card reader"
>         depends on PCI
> diff --git a/drivers/misc/cardreader/Makefile b/drivers/misc/cardreader/Makefile
> index 9fabfcc6fa7a..9882d2a1025c 100644
> --- a/drivers/misc/cardreader/Makefile
> +++ b/drivers/misc/cardreader/Makefile
> @@ -1,4 +1,4 @@
> -rtsx_pci-objs := rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o rts5260.o
> -
> +obj-$(CONFIG_MISC_ALCOR_PCI)   += alcor_pci.o
>  obj-$(CONFIG_MISC_RTSX_PCI)    += rtsx_pci.o
> +rtsx_pci-objs := rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o rts5260.o
>  obj-$(CONFIG_MISC_RTSX_USB)    += rtsx_usb.o
> diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> new file mode 100644
> index 000000000000..6872b8e29b4d
> --- /dev/null
> +++ b/drivers/misc/cardreader/alcor_pci.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Oleksij Rempel <linux@rempel-privat.de>
> + *
> + * Driver for Alcor Micro AU6601 and AU6621 controllers
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +
> +#include <linux/alcor_pci.h>
> +
> +#define DRV_NAME_ALCOR_PCI                     "alcor_pci"
> +
> +static DEFINE_IDA(alcor_pci_idr);
> +
> +static struct mfd_cell alcor_pci_cells[] = {
> +       [ALCOR_SD_CARD] = {
> +               .name = DRV_NAME_ALCOR_PCI_SDMMC,
> +       },
> +       [ALCOR_MS_CARD] = {
> +               .name = DRV_NAME_ALCOR_PCI_MS,
> +       },
> +};
> +
> +static const struct alcor_dev_cfg alcor_cfg = {
> +       .dma = 0,
> +};
> +
> +static const struct alcor_dev_cfg au6621_cfg = {
> +       .dma = 1,
> +};
> +
> +static const struct pci_device_id pci_ids[] = {
> +       { PCI_DEVICE(PCI_ID_ALCOR_MICRO, PCI_ID_AU6601),
> +               .driver_data = (kernel_ulong_t)&alcor_cfg },
> +       { PCI_DEVICE(PCI_ID_ALCOR_MICRO, PCI_ID_AU6621),
> +               .driver_data = (kernel_ulong_t)&au6621_cfg },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(pci, pci_ids);
> +
> +void alcor_write8(struct alcor_pci_priv *priv, u8 val, unsigned int addr)
> +{
> +       writeb(val, priv->iobase + addr);
> +}
> +EXPORT_SYMBOL_GPL(alcor_write8);
> +
> +void alcor_write16(struct alcor_pci_priv *priv, u16 val, unsigned int addr)
> +{
> +       writew(val, priv->iobase + addr);
> +}
> +EXPORT_SYMBOL_GPL(alcor_write16);
> +
> +void alcor_write32(struct alcor_pci_priv *priv, u32 val, unsigned int addr)
> +{
> +       writel(val, priv->iobase + addr);
> +}
> +EXPORT_SYMBOL_GPL(alcor_write32);
> +
> +void alcor_write32be(struct alcor_pci_priv *priv, u32 val, unsigned int addr)
> +{
> +       iowrite32be(val, priv->iobase + addr);
> +}
> +EXPORT_SYMBOL_GPL(alcor_write32be);
> +
> +u8 alcor_read8(struct alcor_pci_priv *priv, unsigned int addr)
> +{
> +       return readb(priv->iobase + addr);
> +}
> +EXPORT_SYMBOL_GPL(alcor_read8);
> +
> +u32 alcor_read32(struct alcor_pci_priv *priv, unsigned int addr)
> +{
> +       return readl(priv->iobase + addr);
> +}
> +EXPORT_SYMBOL_GPL(alcor_read32);
> +
> +u32 alcor_read32be(struct alcor_pci_priv *priv, unsigned int addr)
> +{
> +       return ioread32be(priv->iobase + addr);
> +}
> +EXPORT_SYMBOL_GPL(alcor_read32be);
> +
> +static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
> +                                    struct pci_dev *pci)
> +{
> +       int where;
> +       u8 val8;
> +       u32 val32;
> +
> +       where = ALCOR_CAP_START_OFFSET;
> +       pci_read_config_byte(pci, where, &val8);
> +       if (!val8)
> +               return 0;
> +
> +       where = (int)val8;
> +       while (1) {
> +               pci_read_config_dword(pci, where, &val32);
> +               if (val32 == 0xffffffff) {
> +                       dev_dbg(priv->dev, "find_cap_offset invailid value %x.\n",
> +                               val32);
> +                       return 0;
> +               }
> +
> +               if ((val32 & 0xff) == 0x10) {
> +                       dev_dbg(priv->dev, "pcie cap offset: %x\n", where);
> +                       return where;
> +               }
> +
> +               if ((val32 & 0xff00) == 0x00) {
> +                       dev_dbg(priv->dev, "pci_find_cap_offset invailid value %x.\n",
> +                               val32);
> +                       break;
> +               }
> +               where = (int)((val32 >> 8) & 0xff);
> +       }
> +
> +       return 0;
> +}
> +
> +static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
> +{
> +       struct pci_dev *pci;
> +       int where;
> +       u32 val32;
> +
> +       priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv, priv->pdev);
> +       priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
> +                                                        priv->parent_pdev);
> +
> +       if ((priv->pdev_cap_off == 0) || (priv->parent_cap_off == 0)) {
> +               dev_dbg(priv->dev, "pci_cap_off: %x, parent_cap_off: %x\n",
> +                       priv->pdev_cap_off, priv->parent_cap_off);
> +               return;
> +       }
> +
> +       /* link capability */
> +       pci   = priv->pdev;
> +       where = priv->pdev_cap_off + ALCOR_PCIE_LINK_CAP_OFFSET;
> +       pci_read_config_dword(pci, where, &val32);
> +       priv->pdev_aspm_cap = (u8)(val32 >> 10) & 0x03;
> +
> +       pci   = priv->parent_pdev;
> +       where = priv->parent_cap_off + ALCOR_PCIE_LINK_CAP_OFFSET;
> +       pci_read_config_dword(pci, where, &val32);
> +       priv->parent_aspm_cap = (u8)(val32 >> 10) & 0x03;
> +
> +       if (priv->pdev_aspm_cap != priv->parent_aspm_cap) {
> +               u8 aspm_cap;
> +
> +               dev_dbg(priv->dev, "pdev_aspm_cap: %x, parent_aspm_cap: %x\n",
> +                       priv->pdev_aspm_cap, priv->parent_aspm_cap);
> +               aspm_cap = priv->pdev_aspm_cap & priv->parent_aspm_cap;
> +               priv->pdev_aspm_cap    = aspm_cap;
> +               priv->parent_aspm_cap = aspm_cap;
> +       }
> +
> +       dev_dbg(priv->dev, "ext_config_dev_aspm: %x, pdev_aspm_cap: %x\n",
> +               priv->ext_config_dev_aspm, priv->pdev_aspm_cap);
> +       priv->ext_config_dev_aspm &= priv->pdev_aspm_cap;
> +}
> +
> +static void alcor_pci_aspm_ctrl(struct alcor_pci_priv *priv, u8 aspm_enable)
> +{
> +       struct pci_dev *pci;
> +       u8 aspm_ctrl, i;
> +       int where;
> +       u32 val32;
> +
> +       if ((!priv->pdev_cap_off) || (!priv->parent_cap_off)) {
> +               dev_dbg(priv->dev, "pci_cap_off: %x, parent_cap_off: %x\n",
> +                       priv->pdev_cap_off, priv->parent_cap_off);
> +               return;
> +       }
> +
> +       if (!priv->pdev_aspm_cap)
> +               return;
> +
> +       aspm_ctrl = 0;
> +       if (aspm_enable) {
> +               aspm_ctrl = priv->ext_config_dev_aspm;
> +
> +               if (!aspm_ctrl) {
> +                       dev_dbg(priv->dev, "aspm_ctrl == 0\n");
> +                       return;
> +               }
> +       }
> +
> +       for (i = 0; i < 2; i++) {
> +
> +               if (i) {
> +                       pci   = priv->parent_pdev;
> +                       where = priv->parent_cap_off
> +                               + ALCOR_PCIE_LINK_CTRL_OFFSET;
> +               } else {
> +                       pci   = priv->pdev;
> +                       where = priv->pdev_cap_off
> +                               + ALCOR_PCIE_LINK_CTRL_OFFSET;
> +               }
> +
> +               pci_read_config_dword(pci, where, &val32);
> +               val32 &= (~0x03);
> +               val32 |= (aspm_ctrl & priv->pdev_aspm_cap);
> +               pci_write_config_byte(pci, where, (u8)val32);
> +       }
> +
> +}
> +
> +static inline void alcor_mask_sd_irqs(struct alcor_pci_priv *priv)
> +{
> +       alcor_write32(priv, 0, AU6601_REG_INT_ENABLE);
> +}
> +
> +static inline void alcor_unmask_sd_irqs(struct alcor_pci_priv *priv)
> +{
> +       alcor_write32(priv, AU6601_INT_CMD_MASK | AU6601_INT_DATA_MASK |
> +                 AU6601_INT_CARD_INSERT | AU6601_INT_CARD_REMOVE |
> +                 AU6601_INT_OVER_CURRENT_ERR,
> +                 AU6601_REG_INT_ENABLE);
> +}
> +
> +static inline void alcor_mask_ms_irqs(struct alcor_pci_priv *priv)
> +{
> +       alcor_write32(priv, 0, AU6601_MS_INT_ENABLE);
> +}
> +
> +static inline void alcor_unmask_ms_irqs(struct alcor_pci_priv *priv)
> +{
> +       alcor_write32(priv, 0x3d00fa, AU6601_MS_INT_ENABLE);
> +}
> +
> +static int alcor_pci_probe(struct pci_dev *pdev,
> +                          const struct pci_device_id *ent)
> +{
> +       struct alcor_dev_cfg *cfg;
> +       struct alcor_pci_priv *priv;
> +       int ret, i, bar = 0;
> +
> +       cfg = (void *)ent->driver_data;
> +
> +       ret = pcim_enable_device(pdev);
> +       if (ret)
> +               return ret;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       ret = ida_simple_get(&alcor_pci_idr, 0, 0, GFP_KERNEL);
> +       if (ret < 0)
> +               return ret;
> +       priv->id = ret;
> +
> +       priv->pdev = pdev;
> +       priv->parent_pdev = pdev->bus->self;
> +       priv->dev = &pdev->dev;
> +       priv->cfg = cfg;
> +       priv->irq = pdev->irq;
> +
> +       ret = pci_request_regions(pdev, DRV_NAME_ALCOR_PCI);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Cannot request region\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> +               dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
> +               ret = -ENODEV;
> +               goto error_release_regions;
> +       }
> +
> +       priv->iobase = pcim_iomap(pdev, bar, 0);
> +       if (!priv->iobase) {
> +               ret = -ENOMEM;
> +               goto error_release_regions;
> +       }
> +
> +       /* make sure irqs are disabled */
> +       alcor_write32(priv, 0, AU6601_REG_INT_ENABLE);
> +       alcor_write32(priv, 0, AU6601_MS_INT_ENABLE);
> +
> +       ret = dma_set_mask_and_coherent(priv->dev, AU6601_SDMA_MASK);
> +       if (ret) {
> +               dev_err(priv->dev, "Failed to set DMA mask\n");
> +               goto error_release_regions;
> +       }
> +
> +       pci_set_master(pdev);
> +       pci_set_drvdata(pdev, priv);
> +       alcor_pci_init_check_aspm(priv);
> +
> +       for (i = 0; i < ARRAY_SIZE(alcor_pci_cells); i++) {
> +               alcor_pci_cells[i].platform_data = priv;
> +               alcor_pci_cells[i].pdata_size = sizeof(*priv);
> +       }
> +       ret = mfd_add_devices(&pdev->dev, priv->id, alcor_pci_cells,
> +                       ARRAY_SIZE(alcor_pci_cells), NULL, 0, NULL);
> +       if (ret < 0)
> +               goto error_release_regions;
> +
> +       alcor_pci_aspm_ctrl(priv, 0);
> +
> +       return 0;
> +
> +error_release_regions:
> +       pci_release_regions(pdev);
> +       return ret;
> +}
> +
> +static void alcor_pci_remove(struct pci_dev *pdev)
> +{
> +       struct alcor_pci_priv *priv;
> +
> +       priv = pci_get_drvdata(pdev);
> +
> +       alcor_pci_aspm_ctrl(priv, 1);
> +
> +       mfd_remove_devices(&pdev->dev);
> +
> +       ida_simple_remove(&alcor_pci_idr, priv->id);
> +
> +       pci_release_regions(pdev);
> +       pci_set_drvdata(pdev, NULL);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int alcor_suspend(struct device *dev)
> +{
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct alcor_pci_priv *priv = pci_get_drvdata(pdev);
> +
> +       alcor_pci_aspm_ctrl(priv, 1);
> +       return 0;
> +}
> +
> +static int alcor_resume(struct device *dev)
> +{
> +
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct alcor_pci_priv *priv = pci_get_drvdata(pdev);
> +
> +       alcor_pci_aspm_ctrl(priv, 0);
> +       return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(alcor_pci_pm_ops, alcor_suspend, alcor_resume);
> +
> +static struct pci_driver alcor_driver = {
> +       .name   =       DRV_NAME_ALCOR_PCI,
> +       .id_table =     pci_ids,
> +       .probe  =       alcor_pci_probe,
> +       .remove =       alcor_pci_remove,
> +       .driver =       {
> +               .pm     = &alcor_pci_pm_ops
> +       },
> +};
> +
> +module_pci_driver(alcor_driver);
> +
> +MODULE_AUTHOR("Oleksij Rempel <linux@rempel-privat.de>");
> +MODULE_DESCRIPTION("PCI driver for Alcor Micro AU6601 Secure Digital Host Controller Interface");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/alcor_pci.h b/include/linux/alcor_pci.h
> new file mode 100644
> index 000000000000..da973e8a2da8
> --- /dev/null
> +++ b/include/linux/alcor_pci.h
> @@ -0,0 +1,286 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2018 Oleksij Rempel <linux@rempel-privat.de>
> + *
> + * Driver for Alcor Micro AU6601 and AU6621 controllers
> + */
> +
> +#ifndef __ALCOR_PCI_H
> +#define __ALCOR_PCI_H
> +
> +#define ALCOR_SD_CARD 0
> +#define ALCOR_MS_CARD 1
> +
> +#define DRV_NAME_ALCOR_PCI_SDMMC               "alcor_sdmmc"
> +#define DRV_NAME_ALCOR_PCI_MS                  "alcor_ms"
> +
> +#define PCI_ID_ALCOR_MICRO                     0x1AEA
> +#define PCI_ID_AU6601                          0x6601
> +#define PCI_ID_AU6621                          0x6621
> +
> +#define MHZ_TO_HZ(freq)                                ((freq) * 1000 * 1000)
> +
> +#define AU6601_BASE_CLOCK                      31000000
> +#define AU6601_MIN_CLOCK                       150000
> +#define AU6601_MAX_CLOCK                       208000000
> +#define AU6601_MAX_DMA_SEGMENTS                        1
> +#define AU6601_MAX_PIO_SEGMENTS                        1
> +#define AU6601_MAX_DMA_BLOCK_SIZE              0x1000
> +#define AU6601_MAX_PIO_BLOCK_SIZE              0x200
> +#define AU6601_MAX_DMA_BLOCKS                  1
> +#define AU6601_DMA_LOCAL_SEGMENTS              1
> +
> +/* registers spotter by reverse engineering but still
> + * with unknown functionality:
> + * 0x10 - ADMA phy address. AU6621 only?
> + * 0x51 - LED ctrl?
> + * 0x52 - unknown
> + * 0x61 - LED related? Always toggled BIT0
> + * 0x63 - Same as 0x61?
> + * 0x77 - unknown
> + */
> +
> +/* SDMA phy address. Higher then 0x0800.0000?
> + * The au6601 and au6621 have different DMA engines with different issues. One
> + * For example au6621 engine is triggered by addr change. No other interaction
> + * is needed. This means, if we get two buffers with same address, then engine
> + * will stall.
> + */
> +#define AU6601_REG_SDMA_ADDR                   0x00
> +#define AU6601_SDMA_MASK                       0xffffffff
> +
> +#define AU6601_DMA_BOUNDARY                    0x05
> +#define AU6621_DMA_PAGE_CNT                    0x05
> +/* PIO */
> +#define AU6601_REG_BUFFER                      0x08
> +/* ADMA ctrl? AU6621 only. */
> +#define AU6621_DMA_CTRL                                0x0c
> +#define AU6621_DMA_ENABLE                      BIT(0)
> +/* CMD index */
> +#define AU6601_REG_CMD_OPCODE                  0x23
> +/* CMD parametr */
> +#define AU6601_REG_CMD_ARG                     0x24
> +/* CMD response 4x4 Bytes */
> +#define AU6601_REG_CMD_RSP0                    0x30
> +#define AU6601_REG_CMD_RSP1                    0x34
> +#define AU6601_REG_CMD_RSP2                    0x38
> +#define AU6601_REG_CMD_RSP3                    0x3C
> +/* default timeout set to 125: 125 * 40ms = 5 sec
> + * how exactly it is calculated?
> + */
> +#define AU6601_TIME_OUT_CTRL                   0x69
> +/* Block size for SDMA or PIO */
> +#define AU6601_REG_BLOCK_SIZE                  0x6c
> +/* Some power related reg, used together with AU6601_OUTPUT_ENABLE */
> +#define AU6601_POWER_CONTROL                   0x70
> +
> +/* PLL ctrl */
> +#define AU6601_CLK_SELECT                      0x72
> +#define        AU6601_CLK_OVER_CLK                     0x80
> +#define        AU6601_CLK_384_MHZ                      0x30
> +#define        AU6601_CLK_125_MHZ                      0x20
> +#define        AU6601_CLK_48_MHZ                       0x10
> +#define        AU6601_CLK_EXT_PLL                      0x04
> +#define AU6601_CLK_X2_MODE                     0x02
> +#define AU6601_CLK_ENABLE                      0x01
> +#define AU6601_CLK_31_25_MHZ                   0x00
> +
> +#define AU6601_CLK_DIVIDER                     0x73
> +
> +#define AU6601_INTERFACE_MODE_CTRL             0x74
> +#define AU6601_DLINK_MODE                      0x80
> +#define        AU6601_INTERRUPT_DELAY_TIME             0x40
> +#define        AU6601_SIGNAL_REQ_CTRL                  0x30
> +#define AU6601_MS_CARD_WP                      BIT(3)
> +#define AU6601_SD_CARD_WP                      BIT(0)
> +
> +/* same register values are used for:
> + *  - AU6601_OUTPUT_ENABLE
> + *  - AU6601_POWER_CONTROL
> + */
> +#define AU6601_ACTIVE_CTRL                     0x75
> +#define AU6601_XD_CARD                         BIT(4)
> +/* AU6601_MS_CARD_ACTIVE - will cativate MS card section? */
> +#define AU6601_MS_CARD                         BIT(3)
> +#define AU6601_SD_CARD                         BIT(0)
> +
> +/* card slot state. It should automatically detect type of
> + * the card
> + */
> +#define AU6601_DETECT_STATUS                   0x76
> +#define AU6601_DETECT_EN                       BIT(7)
> +#define AU6601_MS_DETECTED                     BIT(3)
> +#define AU6601_SD_DETECTED                     BIT(0)
> +#define AU6601_DETECT_STATUS_M                 0xf
> +
> +#define AU6601_REG_SW_RESET                    0x79
> +#define AU6601_BUF_CTRL_RESET                  BIT(7)
> +#define AU6601_RESET_DATA                      BIT(3)
> +#define AU6601_RESET_CMD                       BIT(0)
> +
> +#define AU6601_OUTPUT_ENABLE                   0x7a
> +
> +#define AU6601_PAD_DRIVE0                      0x7b
> +#define AU6601_PAD_DRIVE1                      0x7c
> +#define AU6601_PAD_DRIVE2                      0x7d
> +/* read EEPROM? */
> +#define AU6601_FUNCTION                                0x7f
> +
> +#define AU6601_CMD_XFER_CTRL                   0x81
> +#define        AU6601_CMD_17_BYTE_CRC                  0xc0
> +#define        AU6601_CMD_6_BYTE_WO_CRC                0x80
> +#define        AU6601_CMD_6_BYTE_CRC                   0x40
> +#define        AU6601_CMD_START_XFER                   0x20
> +#define        AU6601_CMD_STOP_WAIT_RDY                0x10
> +#define        AU6601_CMD_NO_RESP                      0x00
> +
> +#define AU6601_REG_BUS_CTRL                    0x82
> +#define AU6601_BUS_WIDTH_4BIT                  0x20
> +#define AU6601_BUS_WIDTH_8BIT                  0x10
> +#define AU6601_BUS_WIDTH_1BIT                  0x00
> +
> +#define AU6601_DATA_XFER_CTRL                  0x83
> +#define AU6601_DATA_WRITE                      BIT(7)
> +#define AU6601_DATA_DMA_MODE                   BIT(6)
> +#define AU6601_DATA_START_XFER                 BIT(0)
> +
> +#define AU6601_DATA_PIN_STATE                  0x84
> +#define AU6601_BUS_STAT_CMD                    BIT(15)
> +/* BIT(4) - BIT(7) are permanently 1.
> + * May be reserved or not attached DAT4-DAT7
> + */
> +#define AU6601_BUS_STAT_DAT3                   BIT(3)
> +#define AU6601_BUS_STAT_DAT2                   BIT(2)
> +#define AU6601_BUS_STAT_DAT1                   BIT(1)
> +#define AU6601_BUS_STAT_DAT0                   BIT(0)
> +#define AU6601_BUS_STAT_DAT_MASK               0xf
> +
> +#define AU6601_OPT                             0x85
> +#define        AU6601_OPT_CMD_LINE_LEVEL               0x80
> +#define        AU6601_OPT_NCRC_16_CLK                  BIT(4)
> +#define        AU6601_OPT_CMD_NWT                      BIT(3)
> +#define        AU6601_OPT_STOP_CLK                     BIT(2)
> +#define        AU6601_OPT_DDR_MODE                     BIT(1)
> +#define        AU6601_OPT_SD_18V                       BIT(0)
> +
> +#define AU6601_CLK_DELAY                       0x86
> +#define        AU6601_CLK_DATA_POSITIVE_EDGE           0x80
> +#define        AU6601_CLK_CMD_POSITIVE_EDGE            0x40
> +#define        AU6601_CLK_POSITIVE_EDGE_ALL            (AU6601_CLK_CMD_POSITIVE_EDGE \
> +                                               | AU6601_CLK_DATA_POSITIVE_EDGE)
> +
> +
> +#define AU6601_REG_INT_STATUS                  0x90
> +#define AU6601_REG_INT_ENABLE                  0x94
> +#define AU6601_INT_DATA_END_BIT_ERR            BIT(22)
> +#define AU6601_INT_DATA_CRC_ERR                        BIT(21)
> +#define AU6601_INT_DATA_TIMEOUT_ERR            BIT(20)
> +#define AU6601_INT_CMD_INDEX_ERR               BIT(19)
> +#define AU6601_INT_CMD_END_BIT_ERR             BIT(18)
> +#define AU6601_INT_CMD_CRC_ERR                 BIT(17)
> +#define AU6601_INT_CMD_TIMEOUT_ERR             BIT(16)
> +#define AU6601_INT_ERROR                       BIT(15)
> +#define AU6601_INT_OVER_CURRENT_ERR            BIT(8)
> +#define AU6601_INT_CARD_INSERT                 BIT(7)
> +#define AU6601_INT_CARD_REMOVE                 BIT(6)
> +#define AU6601_INT_READ_BUF_RDY                        BIT(5)
> +#define AU6601_INT_WRITE_BUF_RDY               BIT(4)
> +#define AU6601_INT_DMA_END                     BIT(3)
> +#define AU6601_INT_DATA_END                    BIT(1)
> +#define AU6601_INT_CMD_END                     BIT(0)
> +
> +#define AU6601_INT_NORMAL_MASK                 0x00007FFF
> +#define AU6601_INT_ERROR_MASK                  0xFFFF8000
> +
> +#define AU6601_INT_CMD_MASK    (AU6601_INT_CMD_END | \
> +               AU6601_INT_CMD_TIMEOUT_ERR | AU6601_INT_CMD_CRC_ERR | \
> +               AU6601_INT_CMD_END_BIT_ERR | AU6601_INT_CMD_INDEX_ERR)
> +#define AU6601_INT_DATA_MASK   (AU6601_INT_DATA_END | AU6601_INT_DMA_END | \
> +               AU6601_INT_READ_BUF_RDY | AU6601_INT_WRITE_BUF_RDY | \
> +               AU6601_INT_DATA_TIMEOUT_ERR | AU6601_INT_DATA_CRC_ERR | \
> +               AU6601_INT_DATA_END_BIT_ERR)
> +#define AU6601_INT_ALL_MASK                    ((u32)-1)
> +
> +/* MS_CARD mode registers */
> +
> +#define AU6601_MS_STATUS                       0xa0
> +
> +#define AU6601_MS_BUS_MODE_CTRL                        0xa1
> +#define AU6601_MS_BUS_8BIT_MODE                        0x03
> +#define AU6601_MS_BUS_4BIT_MODE                        0x01
> +#define AU6601_MS_BUS_1BIT_MODE                        0x00
> +
> +#define AU6601_MS_TPC_CMD                      0xa2
> +#define AU6601_MS_TPC_READ_PAGE_DATA           0x02
> +#define AU6601_MS_TPC_READ_REG                 0x04
> +#define AU6601_MS_TPC_GET_INT                  0x07
> +#define AU6601_MS_TPC_WRITE_PAGE_DATA          0x0D
> +#define AU6601_MS_TPC_WRITE_REG                        0x0B
> +#define AU6601_MS_TPC_SET_RW_REG_ADRS          0x08
> +#define AU6601_MS_TPC_SET_CMD                  0x0E
> +#define AU6601_MS_TPC_EX_SET_CMD               0x09
> +#define AU6601_MS_TPC_READ_SHORT_DATA          0x03
> +#define AU6601_MS_TPC_WRITE_SHORT_DATA         0x0C
> +
> +#define AU6601_MS_TRANSFER_MODE                        0xa3
> +#define        AU6601_MS_XFER_INT_TIMEOUT_CHK          BIT(2)
> +#define        AU6601_MS_XFER_DMA_ENABLE               BIT(1)
> +#define        AU6601_MS_XFER_START                    BIT(0)
> +
> +#define AU6601_MS_DATA_PIN_STATE               0xa4
> +
> +#define AU6601_MS_INT_STATUS                   0xb0
> +#define AU6601_MS_INT_ENABLE                   0xb4
> +#define AU6601_MS_INT_OVER_CURRENT_ERROR       BIT(23)
> +#define AU6601_MS_INT_DATA_CRC_ERROR           BIT(21)
> +#define AU6601_MS_INT_INT_TIMEOUT              BIT(20)
> +#define AU6601_MS_INT_INT_RESP_ERROR           BIT(19)
> +#define AU6601_MS_INT_CED_ERROR                        BIT(18)
> +#define AU6601_MS_INT_TPC_TIMEOUT              BIT(16)
> +#define AU6601_MS_INT_ERROR                    BIT(15)
> +#define AU6601_MS_INT_CARD_INSERT              BIT(7)
> +#define AU6601_MS_INT_CARD_REMOVE              BIT(6)
> +#define AU6601_MS_INT_BUF_READ_RDY             BIT(5)
> +#define AU6601_MS_INT_BUF_WRITE_RDY            BIT(4)
> +#define AU6601_MS_INT_DMA_END                  BIT(3)
> +#define AU6601_MS_INT_TPC_END                  BIT(1)
> +
> +#define AU6601_MS_INT_DATA_MASK                        0x00000038
> +#define AU6601_MS_INT_TPC_MASK                 0x003d8002
> +#define AU6601_MS_INT_TPC_ERROR                        0x003d0000
> +
> +#define ALCOR_PCIE_LINK_CTRL_OFFSET            0x10
> +#define ALCOR_PCIE_LINK_CAP_OFFSET             0x0c
> +#define ALCOR_CAP_START_OFFSET                 0x34
> +
> +struct alcor_dev_cfg {
> +       u8      dma;
> +};
> +
> +struct alcor_pci_priv {
> +       struct pci_dev *pdev;
> +       struct pci_dev *parent_pdev;
> +       struct  device *dev;
> +       void __iomem *iobase;
> +       unsigned int irq;
> +
> +       unsigned long id; /* idr id */
> +
> +       struct alcor_dev_cfg    *cfg;
> +
> +       /* PCI ASPM related vars */
> +       int pdev_cap_off;
> +       u8  pdev_aspm_cap;
> +       int parent_cap_off;
> +       u8  parent_aspm_cap;
> +       u8 ext_config_dev_aspm;
> +};
> +
> +void alcor_write8(struct alcor_pci_priv *priv, u8 val, unsigned int addr);
> +void alcor_write16(struct alcor_pci_priv *priv, u16 val, unsigned int addr);
> +void alcor_write32(struct alcor_pci_priv *priv, u32 val, unsigned int addr);
> +void alcor_write32be(struct alcor_pci_priv *priv, u32 val, unsigned int addr);
> +u8 alcor_read8(struct alcor_pci_priv *priv, unsigned int addr);
> +u32 alcor_read32(struct alcor_pci_priv *priv, unsigned int addr);
> +u32 alcor_read32be(struct alcor_pci_priv *priv, unsigned int addr);
> +#endif
> --
> 2.17.1
>
