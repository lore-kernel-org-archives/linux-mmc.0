From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
Date: Tue, 8 Dec 2015 16:06:53 +0100
Message-ID: <CAPDyKFp=buvJ8Li3XC8XSUAUO7BsE+U6vEQH2xTrgcHAkdG8bQ@mail.gmail.com>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36748 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965055AbbLHPGy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2015 10:06:54 -0500
Received: by vkay187 with SMTP id y187so14864793vka.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2015 07:06:53 -0800 (PST)
In-Reply-To: <1448988109-32630-1-git-send-email-carlo@caione.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Daniel Drake <drake@endlessm.com>, jerry.cao@amlogic.com, victor.wan@amlogic.com, linux-meson@googlegroups.com, Carlo Caione <carlo@endlessm.com>

On 1 December 2015 at 17:41, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> Add a driver for the SD/MMC host found on the Amlogic MesonX SoCs. This
> is an MMC controller which provides an interface between the application
> processor and various memory cards. It supports the SD specification
> v2.0 and the eMMC specification v4.41.
>
> This patch adds also the binding documentation.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
> Changelog:
>
> v2:
>    * fix typo in commit message
>    * avoid the bounce buffer (max_segs == 1)
>
> v3:
>    * simplify meson_mmc_map_dma() and fix memory leak
>
> v4:
>    * code and documentation cleanup
>    * removed redundant variables
>    * removed useless printing
>    * introduced MMC_CAP2_NO_SDIO
>    * removed state machine
>    * better spinlocks management and positioning
> ---
>  .../devicetree/bindings/mmc/meson-mmc.txt          |  29 ++
>  drivers/mmc/host/Kconfig                           |   7 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/meson-mmc.c                       | 527 +++++++++++++++++++++
>  4 files changed, 564 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/meson-mmc.txt
>  create mode 100644 drivers/mmc/host/meson-mmc.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/meson-mmc.txt b/Documentation/devicetree/bindings/mmc/meson-mmc.txt
> new file mode 100644
> index 0000000..7ff9e9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/meson-mmc.txt
> @@ -0,0 +1,29 @@
> +* Amlogic MesonX MMC controller
> +
> +The highspeed MMC host controller on Amlogic SoCs provides an interface
> +for MMC, SD, SDIO and SDHC types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.41 as well
> +as the speed of SD standard 2.0.
> +
> +Required properties:
> + - compatible : "amlogic,meson-mmc"
> + - reg : mmc controller base registers
> + - interrupts : mmc controller interrupt
> + - clocks : phandle to clock provider
> + - pinctrl-names : should contain "sdio_a" or "sdio_b"

This is weird. I don't think you need this specific states.
You should be able to cope with common used "default" state.

Later in the driver code I realize that you have some register bits
that is related to either using port a or port b. But I don't think
that is the same thing as having different pinctrls states.

If you can't detect whether port a or b is used in runtime by the
driver, I suggest you add a separate meson mmc DT binding telling what
port is being used.

> + - pinctrl-0: Should specify pin control groups used for this controller
> +
> +Optional properties:
> + - for cd, bus-width and additional generic mmc parameters
> +   please refer to mmc.txt within this directory
> +
> +Examples:
> +       mmc0: mmc@c1108c20 {
> +               pinctrl-names = "sdio_b";
> +               pinctrl-0 = <&mmc0_sd_b_pins>;
> +               compatible = "amlogic,meson-mmc";
> +               reg = <0xc1108c20 0x20>;
> +               interrupts = <0 28 1>;
> +               clocks = <&clkc CLKID_CLK81>;
> +       };

Overall the DT documentation looks okay (beside the comments above).
Although, please separate it to become a patch 1/2. The rest below
shoud go into a patch 2/2.

For the DT patch please include the DT maintainers when posting the new version.

> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1dee533..7f2c5ae 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -765,6 +765,13 @@ config MMC_REALTEK_USB
>           Say Y here to include driver code to support SD/MMC card interface
>           of Realtek RTS5129/39 series card reader
>
> +config MMC_MESON
> +       tristate "Amlogic MesonX SD/MMC Host Controller support"
> +       depends on ARCH_MESON
> +       help
> +         This selects support for the SD/MMC Host Controller on
> +         Amlogic MesonX SoCs.
> +
>  config MMC_SUNXI
>         tristate "Allwinner sunxi SD/MMC Host Controller support"
>         depends on ARCH_SUNXI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 3595f83..26ddf76 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_MMC_VUB300)      += vub300.o
>  obj-$(CONFIG_MMC_USHC)         += ushc.o
>  obj-$(CONFIG_MMC_WMT)          += wmt-sdmmc.o
>  obj-$(CONFIG_MMC_MOXART)       += moxart-mmc.o
> +obj-$(CONFIG_MMC_MESON)                += meson-mmc.o
>  obj-$(CONFIG_MMC_SUNXI)                += sunxi-mmc.o
>  obj-$(CONFIG_MMC_USDHI6ROL0)   += usdhi6rol0.o
>  obj-$(CONFIG_MMC_TOSHIBA_PCI)  += toshsd.o
> diff --git a/drivers/mmc/host/meson-mmc.c b/drivers/mmc/host/meson-mmc.c
> new file mode 100644
> index 0000000..6382470
> --- /dev/null
> +++ b/drivers/mmc/host/meson-mmc.c
> @@ -0,0 +1,527 @@
> +/*
> + * meson-mmc.c - Meson SDH Controller
> + *
> + * Copyright (C) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
> +
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>
> +
> +#define SDIO_ARGU              (0x00)
> +#define SDIO_SEND              (0x04)
> +#define SDIO_CONF              (0x08)
> +#define SDIO_IRQS              (0x0c)
> +#define SDIO_IRQC              (0x10)
> +#define SDIO_MULT              (0x14)
> +#define SDIO_ADDR              (0x18)
> +#define SDIO_EXT               (0x1c)
> +
> +#define REG_IRQS_RESP_CRC7     BIT(5)
> +#define REG_IRQS_RD_CRC16      BIT(6)
> +#define REG_IRQS_WR_CRC16      BIT(7)
> +#define REG_IRQS_CMD_INT       BIT(9)
> +
> +#define REG_IRQC_ARC_CMD_INT   BIT(4)
> +
> +#define REG_CONF_CLK_DIV_M     (0x3ff)
> +#define REG_CONF_BUS_WIDTH     BIT(20)
> +
> +#define REG_MULT_PORT_SEL_M    (0x3)
> +#define REG_MULT_RD_INDEX_M    (0x0f)
> +#define REG_MULT_RD_INDEX_S    (12)
> +#define REG_MULT_WR_RD_OUT_IND BIT(8)
> +
> +#define REG_SEND_CMD_COMMAND_M (0xff)
> +#define REG_SEND_CMD_RESP_S    (8)
> +#define REG_SEND_RESP_NO_CRC7  BIT(16)
> +#define REG_SEND_RESP_HAVE_DATA        BIT(17)
> +#define REG_SEND_RESP_CRC7_F_8 BIT(18)
> +#define REG_SEND_CHECK_BUSY_D0 BIT(19)
> +#define REG_SEND_CMD_SEND_DATA BIT(20)
> +#define REG_SEND_REP_PACK_N_M  (0xff)
> +#define REG_SEND_REP_PACK_N_S  (24)
> +
> +#define REG_EXT_DAT_RW_NUM_M   (0x3fff)
> +#define REG_EXT_DAT_RW_NUM_S   (16)
> +
> +#define SDIO_BOUNCE_REQ_SIZE   (128 * 1024)
> +
> +struct meson_mmc_host {
> +       struct mmc_host         *mmc;
> +       struct mmc_request      *mrq;
> +       struct delayed_work     timeout_work;
> +       struct clk              *clk;
> +       spinlock_t              lock;
> +       void __iomem            *base;
> +       long                    timeout;
> +       int                     irq;
> +       int                     error;
> +       unsigned int            port;
> +       bool                    cmd_is_stop;
> +       bool                    dying;
> +};
> +
> +static int meson_mmc_clk_set_rate(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct meson_mmc_host *host = mmc_priv(mmc);
> +       unsigned long clk_rate;
> +       unsigned int clk_ios = ios->clock;
> +       unsigned int clk_div;
> +       u32 conf_reg;
> +
> +       clk_rate = clk_get_rate(host->clk);
> +       if (clk_rate < 0) {
> +               dev_err(mmc_dev(mmc), "cannot get clock rate\n");
> +               return -EINVAL;
> +       }
> +
> +       clk_rate >>= 1;
> +       clk_div = clk_rate / clk_ios - !(clk_rate % clk_ios);
> +
> +       conf_reg = readl(host->base + SDIO_CONF);
> +       conf_reg &= ~REG_CONF_CLK_DIV_M;
> +       conf_reg |= clk_div;
> +       writel(conf_reg, host->base + SDIO_CONF);
> +
> +       dev_dbg(mmc_dev(mmc), "clk_ios: %d, clk_div: %d, clk_rate: %ld\n",
> +               clk_ios, clk_div, clk_rate);

It's good practice to update mmc->actual_clock, as it's being used
from mmc core's debugfs support.

> +
> +       return 0;
> +}
> +
> +static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct meson_mmc_host *host = mmc_priv(mmc);
> +       u32 reg;
> +
> +       reg = readl(host->base + SDIO_CONF);
> +
> +       switch (ios->bus_width) {
> +       case MMC_BUS_WIDTH_1:
> +               reg &= ~REG_CONF_BUS_WIDTH;
> +               break;
> +       case MMC_BUS_WIDTH_4:
> +               reg |= REG_CONF_BUS_WIDTH;
> +               break;
> +       case MMC_BUS_WIDTH_8:
> +       default:
> +               dev_err(mmc_dev(mmc), "meson controller doesn't support 8bit data bus\n");
> +               host->error = -EINVAL;
> +               return;
> +       }
> +
> +       writel(reg, host->base + SDIO_CONF);
> +
> +       if (ios->clock && ios->power_mode)
> +               host->error = meson_mmc_clk_set_rate(mmc, ios);
> +}
> +
> +static void meson_mmc_start_cmd(struct mmc_host *mmc,
> +                               struct mmc_command *cmd)
> +{
> +       struct meson_mmc_host *host = mmc_priv(mmc);
> +       unsigned int pack_size;
> +       u32 irqc, irqs, mult;
> +       u32 send = 0;
> +       u32 ext = 0;
> +
> +       switch (mmc_resp_type(cmd)) {
> +       case MMC_RSP_R1:
> +       case MMC_RSP_R1B:
> +       case MMC_RSP_R3:
> +               send |= (45 << REG_SEND_CMD_RESP_S);
> +               break;
> +       case MMC_RSP_R2:
> +               send |= (133 << REG_SEND_CMD_RESP_S);
> +               send |= REG_SEND_RESP_CRC7_F_8;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (!(cmd->flags & MMC_RSP_CRC))
> +               send |= REG_SEND_RESP_NO_CRC7;
> +
> +       if (cmd->flags & MMC_RSP_BUSY)
> +               send |= REG_SEND_CHECK_BUSY_D0;
> +
> +       if (cmd->data) {
> +               send &= ~(REG_SEND_REP_PACK_N_M << REG_SEND_REP_PACK_N_S);
> +               send |= ((cmd->data->blocks - 1) << REG_SEND_REP_PACK_N_S);
> +
> +               ext &= ~(REG_EXT_DAT_RW_NUM_M << REG_EXT_DAT_RW_NUM_S);
> +               if (mmc->ios.bus_width)
> +                       pack_size = cmd->data->blksz * 8 + (16 - 1) * 4;
> +               else
> +                       pack_size = cmd->data->blksz * 8 + (16 - 1);
> +               ext |= (pack_size << REG_EXT_DAT_RW_NUM_S);
> +
> +               if (cmd->data->flags & MMC_DATA_WRITE)
> +                       send |= REG_SEND_CMD_SEND_DATA;
> +               else
> +                       send |= REG_SEND_RESP_HAVE_DATA;
> +       }
> +
> +       send &= ~REG_SEND_CMD_COMMAND_M;
> +       send |= (0x40 | cmd->opcode);
> +
> +       irqc = readl(host->base + SDIO_IRQC);
> +       irqc |= REG_IRQC_ARC_CMD_INT;
> +
> +       irqs = readl(host->base + SDIO_IRQS);
> +       irqs |= REG_IRQS_CMD_INT;
> +
> +       mult = readl(host->base + SDIO_MULT);
> +       mult &= ~REG_MULT_PORT_SEL_M;
> +       mult |= host->port;
> +       mult |= (1 << 31);
> +       writel(mult, host->base + SDIO_MULT);
> +       writel(irqs, host->base + SDIO_IRQS);
> +       writel(irqc, host->base + SDIO_IRQC);
> +
> +       writel(cmd->arg, host->base + SDIO_ARGU);
> +       writel(ext, host->base + SDIO_EXT);
> +       writel(send, host->base + SDIO_SEND);
> +}
> +
> +static int meson_mmc_map_dma(struct meson_mmc_host *host,
> +                            struct mmc_data *data,
> +                            unsigned int flags)
> +{      u32 dma_len;
> +       struct scatterlist *sg = data->sg;
> +
> +       if (sg->offset & 3 || sg->length & 3) {
> +               dev_err(mmc_dev(host->mmc),
> +                       "unaligned scatterlist: os %x length %d\n",
> +                       sg->offset, sg->length);
> +               return -EINVAL;
> +       }
> +
> +       dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +                            ((data->flags & MMC_DATA_READ) ?
> +                            DMA_FROM_DEVICE : DMA_TO_DEVICE));
> +       if (dma_len == 0) {
> +               dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct meson_mmc_host *host = mmc_priv(mmc);
> +       struct mmc_command *cmd = mrq->cmd;
> +       struct mmc_data *data = mrq->data;
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       if (host->error) {
> +               cmd->error = host->error;
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               mmc_request_done(mmc, mrq);
> +               return;
> +       }
> +
> +       if (data) {
> +               ret = meson_mmc_map_dma(host, data, data->flags);
> +               if (ret < 0) {
> +                       dev_err(mmc_dev(mmc), "map DMA failed\n");
> +                       cmd->error = ret;
> +                       data->error = ret;
> +                       spin_unlock_irqrestore(&host->lock, flags);
> +                       mmc_request_done(mmc, mrq);
> +                       return;
> +               }
> +               writel(sg_dma_address(data->sg), host->base + SDIO_ADDR);
> +       }
> +
> +       host->mrq = mrq;
> +       meson_mmc_start_cmd(mmc, mrq->cmd);
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       schedule_delayed_work(&host->timeout_work, host->timeout);
> +}
> +
> +static irqreturn_t meson_mmc_irq(int irq, void *data)
> +{
> +       struct meson_mmc_host *host = (void *) data;
> +       struct mmc_request *mrq = host->mrq;
> +       u32 irqs;
> +
> +       irqs = readl(host->base + SDIO_IRQS);
> +       if (mrq && (irqs & REG_IRQS_CMD_INT))
> +               return IRQ_WAKE_THREAD;
> +
> +       return IRQ_HANDLED;
> +}
> +
> +void meson_mmc_read_response(struct meson_mmc_host *host)
> +{
> +       struct mmc_command *cmd = host->mrq->cmd;
> +       u32 mult;
> +       int i, resp[4] = { 0 };
> +
> +       mult = readl(host->base + SDIO_MULT);
> +       mult |= REG_MULT_WR_RD_OUT_IND;
> +       mult &= ~(REG_MULT_RD_INDEX_M << REG_MULT_RD_INDEX_S);
> +       writel(mult, host->base + SDIO_MULT);
> +
> +       if (cmd->flags & MMC_RSP_136) {
> +               for (i = 0; i <= 3; i++)
> +                       resp[3 - i] = readl(host->base + SDIO_ARGU);
> +               cmd->resp[0] = (resp[0] << 8) | ((resp[1] >> 24) & 0xff);
> +               cmd->resp[1] = (resp[1] << 8) | ((resp[2] >> 24) & 0xff);
> +               cmd->resp[2] = (resp[2] << 8) | ((resp[3] >> 24) & 0xff);
> +               cmd->resp[3] = (resp[3] << 8);
> +       } else if (cmd->flags & MMC_RSP_PRESENT) {
> +               cmd->resp[0] = readl(host->base + SDIO_ARGU);
> +       }
> +}
> +
> +static irqreturn_t meson_mmc_irq_thread(int irq, void *irq_data)
> +{
> +       struct meson_mmc_host *host = (void *) irq_data;
> +       struct mmc_data *data;
> +       unsigned long flags;
> +       struct mmc_request *mrq;
> +       u32 irqs, send;
> +
> +       cancel_delayed_work_sync(&host->timeout_work);
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       mrq = host->mrq;
> +       data = mrq->data;
> +
> +       if (!mrq) {
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (host->cmd_is_stop)
> +               goto out;
> +
> +       irqs = readl(host->base + SDIO_IRQS);
> +       send = readl(host->base + SDIO_SEND);
> +
> +       mrq->cmd->error = 0;
> +
> +       if (!data) {
> +               if (!((irqs & REG_IRQS_RESP_CRC7) ||
> +                     (send & REG_SEND_RESP_NO_CRC7)))
> +                       mrq->cmd->error = -EILSEQ;
> +               else
> +                       meson_mmc_read_response(host);
> +       } else {
> +               if (!((irqs & REG_IRQS_RD_CRC16) ||
> +                     (irqs & REG_IRQS_WR_CRC16))) {
> +                       mrq->cmd->error = -EILSEQ;
> +               } else {
> +                       data->bytes_xfered = data->blksz * data->blocks;
> +                       dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +                                    ((data->flags & MMC_DATA_READ) ?
> +                                    DMA_FROM_DEVICE : DMA_TO_DEVICE));
> +               }
> +       }
> +
> +       if (mrq->stop) {
> +               host->cmd_is_stop = true;
> +               meson_mmc_start_cmd(host->mmc, mrq->stop);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               return IRQ_HANDLED;
> +       }
> +
> +out:
> +       host->cmd_is_stop = false;
> +       host->mrq = NULL;
> +       spin_unlock_irqrestore(&host->lock, flags);
> +       mmc_request_done(host->mmc, mrq);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void meson_mmc_timeout(struct work_struct *work)
> +{
> +       struct meson_mmc_host *host = container_of(work,
> +                                                  struct meson_mmc_host,
> +                                                  timeout_work.work);
> +       struct mmc_request *mrq = host->mrq;
> +       unsigned long flags;
> +       u32 irqc;
> +
> +       /* Do not run after meson_mmc_remove() */
> +       if (host->dying)
> +               return;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       dev_err(mmc_dev(host->mmc), "Timeout on CMD%u\n", mrq->cmd->opcode);
> +
> +       irqc = readl(host->base + SDIO_IRQC);
> +       irqc &= ~REG_IRQC_ARC_CMD_INT;
> +       writel(irqc, host->base + SDIO_IRQC);
> +
> +       mrq->cmd->error = -ETIMEDOUT;
> +
> +       host->mrq = NULL;
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       mmc_request_done(host->mmc, mrq);
> +}
> +
> +static struct mmc_host_ops meson_mmc_ops = {
> +       .request        = meson_mmc_request,
> +       .set_ios        = meson_mmc_set_ios,
> +       .get_cd         = mmc_gpio_get_cd,
> +};
> +
> +static int meson_mmc_probe(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc;
> +       struct meson_mmc_host *host;
> +       struct pinctrl *pinctrl;
> +       struct pinctrl_state *pins;
> +       struct resource *res;
> +       int ret, irq;
> +
> +       mmc = mmc_alloc_host(sizeof(struct meson_mmc_host), &pdev->dev);
> +       if (!mmc) {
> +               dev_err(&pdev->dev, "mmc alloc host failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->timeout = msecs_to_jiffies(2000);

I don't think this timeout will cover all cases, although I can't
really tell what a proper value should be as it's dynamically
changning between requests.

Perhaps try to pick a value that's already being used by other hosts
is good enough!?

> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       host->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(host->base)) {
> +               ret = PTR_ERR(host->base);
> +               goto error_free_host;
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
> +                                       meson_mmc_irq_thread, 0, "meson_mmc",
> +                                       host);
> +       if (ret)
> +               goto error_free_host;
> +
> +       host->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(host->clk)) {
> +               ret = PTR_ERR(host->clk);
> +               goto error_free_host;
> +       }

A clk_prepare_enable() is missing somwhere around here and of course
then the clock needs to be gated as well. Both in the error handling
of ->probe() but also in meson_mmc_remove().

> +
> +       /* we do not support scatter lists in hardware */
> +       mmc->max_segs = 1;
> +       mmc->max_req_size = SDIO_BOUNCE_REQ_SIZE;
> +       mmc->max_seg_size = mmc->max_req_size;
> +       mmc->max_blk_count = 256;
> +       mmc->max_blk_size = mmc->max_req_size / mmc->max_blk_count;
> +       mmc->f_min = 300000;
> +       mmc->f_max = 50000000;
> +       mmc->caps |= MMC_CAP_4_BIT_DATA;
> +       mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> +       mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +       mmc->ocr_avail = MMC_VDD_33_34;
> +       mmc->ops = &meson_mmc_ops;
> +
> +       spin_lock_init(&host->lock);
> +
> +       INIT_DELAYED_WORK(&host->timeout_work, meson_mmc_timeout);
> +
> +       pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (IS_ERR(pinctrl)) {
> +               ret = PTR_ERR(pinctrl);
> +               goto error_free_host;
> +       }
> +
> +       /* We need to know at runtime which port we are using */
> +       pins = pinctrl_lookup_state(pinctrl, "sdio_b");
> +       if (!IS_ERR(pins))
> +               host->port = 1; /* PORT_B */
> +       else
> +               host->port = 0; /* PORT_A */
> +

I think the pinctrl code can be removed, according to my eariler
comments for the DT documentation.

Instead you need a way to find out the currently used port...

> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               goto error_free_host;
> +
> +       platform_set_drvdata(pdev, mmc);
> +
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto error_free_host;
> +
> +       dev_info(&pdev->dev, "base:0x%p irq:%u port:%u\n",
> +                host->base, irq, host->port);
> +
> +       return 0;
> +
> +error_free_host:
> +       mmc_free_host(mmc);
> +
> +       return ret;
> +}
> +
> +static int meson_mmc_remove(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc = platform_get_drvdata(pdev);
> +       struct meson_mmc_host *host = mmc_priv(mmc);
> +
> +       host->dying = true;
> +
> +       mmc_remove_host(mmc);
> +       cancel_delayed_work_sync(&host->timeout_work);
> +
> +       mmc_free_host(mmc);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id meson_mmc_of_match[] = {
> +       { .compatible = "amlogic,meson-mmc", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, meson_mmc_of_match);
> +
> +static struct platform_driver meson_mmc_driver = {
> +       .probe   = meson_mmc_probe,
> +       .remove  = meson_mmc_remove,
> +       .driver  = {
> +               .name = "meson-mmc",
> +               .of_match_table = of_match_ptr(meson_mmc_of_match),
> +       },
> +};
> +
> +module_platform_driver(meson_mmc_driver);
> +
> +MODULE_DESCRIPTION("Meson Secure Digital Host Driver");
> +MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.5.0
>

Kind regards
Uffe
