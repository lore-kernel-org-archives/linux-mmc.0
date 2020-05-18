Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA563C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9B2207D4
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 07:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="y2fH3YxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgERHzO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 03:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHzN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 03:55:13 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F1C05BD09
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 00:55:12 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y13so4985992vsk.8
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlNG+O2hSLf5H9RkpSphBeOgv5YUN/b93PppdBEp3YQ=;
        b=y2fH3YxE2tfKCFhjhe+ZqOhONKYSmKaZH2N6gKaWnL9vAOeIAhDSiUbg0wWRdOEED5
         f4OWgQ6KmtJzaejB+ZyjwAq8eC+UdPO4HBeXsENrfpszkHLhWpc/TmBeZfaQA6a5q5x+
         AikhWlrfeirzOKjL3gUIkkyXuawCaVnpBbt5lSxgG0ighYSvE/1eaGZhAplI6F/hXcjQ
         x2iPPr0RWCCRHWHoTSZ+7Q6POAGIaW5++jg2n2X8iieDx7ZIxaGK2VTuJD4KEHsbg9fH
         syIaR7yQNaUJssozk05qh5HlttJqHrYtiP2B6XPzCO6+nWXZmL8WXKqcNEPUSrP+nbzI
         qQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlNG+O2hSLf5H9RkpSphBeOgv5YUN/b93PppdBEp3YQ=;
        b=Xmkj5VrdR5x25bXU+eKkreKPypjiP267A3BjBX/PlfwKhEOYf+5DQGfe0vJ3+bGyNs
         EptgSxJh2sfg4lPbrOr+tbJcKUXDmeBypUuY/VNEh9fbYR/pvOxRybpnQbDcgLYBhEV/
         4bGe8GbievphKjcD0wVIR5pIoQ/DjRojQy+zjnxK3j3Bk4p+JRQV/0g7k7P3bW2NzrVC
         euRdmFlZ8onjToUv3lOJSl/sTvgNC0CIYCHHZPY/UZLRs0Fbt+kJ9sfCQb3qfqw4GhPg
         VkWAWT1ua1IUbFheIUQTkQeiW8suXGnhzyzIwUHkCt6KhfBLC9nEJXI9TBejtn5q84Hs
         o+9g==
X-Gm-Message-State: AOAM531WvemnI8D7juNOWQEBUQCbJP6Z2OQY79k2R6zWjhgdUTTCEPCL
        ZeWNAHD0WnZ3SzqVg4X/mTH8hdxFD+8OdJYT63Ilbg==
X-Google-Smtp-Source: ABdhPJzQlC0djVKXpXjUDpQU/BrSjAKNNrwX92FfZnyv665mcBM28mvKH3fX6dCgY7PEd5aXQ33tnpivdcPoe0N8erw=
X-Received: by 2002:a05:6102:72c:: with SMTP id u12mr10324934vsg.126.1589788511277;
 Mon, 18 May 2020 00:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200515222730.967105-1-angelo.dureghello@timesys.com>
 <20200515222730.967105-3-angelo.dureghello@timesys.com> <26ed71d3-2de5-9886-9465-45735802179d@intel.com>
In-Reply-To: <26ed71d3-2de5-9886-9465-45735802179d@intel.com>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Mon, 18 May 2020 10:00:07 +0200
Message-ID: <CALJHbkAcR6YLBW8wH6KfOjwd9En1+aOVBmjOQOJGZcdPr8G0bg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: host: add Coldfire esdhc support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-mmc@vger.kernel.org,
        linux-m68k@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian and all,

thanks,

i can fix also these small issues in a v6 in case. Since is "acked" not sure
if i have to do it. Please let me know.

Also, checkpatch signals a missing maintainer name for this driver,
if there is any need to set a name for it ?

Regards,
Angelo

On Sat, May 16, 2020 at 8:09 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/05/20 1:27 am, Angelo Dureghello wrote:
> > This driver has been developed as a separate module starting
> > from the similar sdhci-esdhc-imx.c.
> >
> > Reasons for a separate sdchi-esdhc-mcf driver:
> >
> > - m68K architecture does not support devicetrees, so modifying
> > sdhci-of-esdhc.c that is devicetree-related adding platform data
> > seems not appropriate,
> > - clock-related part, has to be implemented specifically for
> > mcf5441x family (see esdhc_mcf_pltfm_set_clock()),
> > - this is a big endian cpu accessing a big endian controller,
> > but about sdma, this controller does not support hw swap, which
> > needs to be handled with specific code,
> > - some other minor differences but mainly to avoid risks on
> > tweaking inside largely used imx driver. Adding just a small
> > size ColdFire-specific driver, with benefits in a further less
> > risky maintenance.
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
>
> One minor comment below, nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> > Changes for v3:
> > - fix write support
> > Changes for v4:
> > none
> > Changes for v5:
> > - better probe cleanup on errors
> > - test for bounce buffer to be allocated
> > - rename pre_dma_transfer to copy_to_bounce_buffer
> > - change swap to swap and copy to bounce buffer
> > - fix line alignments to pass checkpatch --strict
> > ---
> >  drivers/mmc/host/Kconfig           |  13 +
> >  drivers/mmc/host/Makefile          |   1 +
> >  drivers/mmc/host/sdhci-esdhc-mcf.c | 522 +++++++++++++++++++++++++++++
> >  3 files changed, 536 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-esdhc-mcf.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 462b5352fea7..da793fc95203 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -235,6 +235,19 @@ config MMC_SDHCI_CNS3XXX
> >
> >         If unsure, say N.
> >
> > +config MMC_SDHCI_ESDHC_MCF
> > +     tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
> > +     depends on M5441x
> > +     depends on MMC_SDHCI_PLTFM
> > +     select MMC_SDHCI_IO_ACCESSORS
> > +     help
> > +       This selects the Freescale eSDHC controller support for
> > +       ColdFire mcf5441x devices.
> > +
> > +       If you have a controller with this interface, say Y or M here.
> > +
> > +       If unsure, say N.
> > +
> >  config MMC_SDHCI_ESDHC_IMX
> >       tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
> >       depends on ARCH_MXC
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index b929ef941208..af2cdaadc4d3 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_REALTEK_USB)       += rtsx_usb_sdmmc.o
> >  obj-$(CONFIG_MMC_SDHCI_PLTFM)                += sdhci-pltfm.o
> >  obj-$(CONFIG_MMC_SDHCI_CADENCE)              += sdhci-cadence.o
> >  obj-$(CONFIG_MMC_SDHCI_CNS3XXX)              += sdhci-cns3xxx.o
> > +obj-$(CONFIG_MMC_SDHCI_ESDHC_MCF)       += sdhci-esdhc-mcf.o
> >  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)    += sdhci-esdhc-imx.o
> >  obj-$(CONFIG_MMC_SDHCI_DOVE)         += sdhci-dove.o
> >  obj-$(CONFIG_MMC_SDHCI_TEGRA)                += sdhci-tegra.o
> > diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> > new file mode 100644
> > index 000000000000..445faf76e676
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> > @@ -0,0 +1,522 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Freescale eSDHC ColdFire family controller driver, platform bus.
> > + *
> > + * Copyright (c) 2020 Timesys Corporation
> > + *   Author: Angelo Dureghello <angelo.dureghello@timesys.it>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_data/mmc-esdhc-mcf.h>
> > +#include <linux/mmc/mmc.h>
> > +#include "sdhci-pltfm.h"
> > +#include "sdhci-esdhc.h"
> > +
> > +#define      ESDHC_PROCTL_D3CD               0x08
> > +#define ESDHC_SYS_CTRL_DTOCV_MASK    0x0f
> > +#define ESDHC_DEFAULT_HOST_CONTROL   0x28
> > +
> > +/*
> > + * Freescale eSDHC has DMA ERR flag at bit 28, not as std spec says, bit 25.
> > + */
> > +#define ESDHC_INT_VENDOR_SPEC_DMA_ERR        BIT(28)
> > +
> > +struct pltfm_mcf_data {
> > +     struct clk *clk_ipg;
> > +     struct clk *clk_ahb;
> > +     struct clk *clk_per;
> > +     int aside;
> > +     int current_bus_width;
> > +};
> > +
> > +static inline void esdhc_mcf_buffer_swap32(u32 *buf, int len)
> > +{
> > +     int i;
> > +     u32 temp;
> > +
> > +     len = (len + 3) >> 2;
> > +
> > +     for (i = 0; i < len;  i++) {
> > +             temp = swab32(*buf);
> > +             *buf++ = temp;
> > +     }
> > +}
> > +
> > +static inline void esdhc_clrset_be(struct sdhci_host *host,
> > +                                u32 mask, u32 val, int reg)
> > +{
> > +     void __iomem *base = host->ioaddr + (reg & ~3);
> > +     u8 shift = (reg & 3) << 3;
> > +
> > +     mask <<= shift;
> > +     val <<= shift;
> > +
> > +     if (reg == SDHCI_HOST_CONTROL)
> > +             val |= ESDHC_PROCTL_D3CD;
> > +
> > +     writel((readl(base) & ~mask) | val, base);
> > +}
> > +
> > +/*
> > + * Note: mcf is big-endian, single bytes need to be accessed at big endian
> > + * offsets.
> > + */
> > +static void esdhc_mcf_writeb_be(struct sdhci_host *host, u8 val, int reg)
> > +{
> > +     void __iomem *base = host->ioaddr + (reg & ~3);
> > +     u8 shift = (reg & 3) << 3;
> > +     u32 mask = ~(0xff << shift);
> > +
> > +     if (reg == SDHCI_HOST_CONTROL) {
> > +             u32 host_ctrl = ESDHC_DEFAULT_HOST_CONTROL;
> > +             u8 dma_bits = (val & SDHCI_CTRL_DMA_MASK) >> 3;
> > +             u8 tmp = readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> > +
> > +             tmp &= ~0x03;
> > +             tmp |= dma_bits;
> > +
> > +             /*
> > +              * Recomposition needed, restore always endianness and
> > +              * keep D3CD and AI, just setting bus width.
> > +              */
> > +             host_ctrl |= val;
> > +             host_ctrl |= (dma_bits << 8);
> > +             writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> > +
> > +             return;
> > +     }
> > +
> > +     writel((readl(base) & mask) | (val << shift), base);
> > +}
> > +
> > +static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int reg)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +     struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +     void __iomem *base = host->ioaddr + (reg & ~3);
> > +     u8 shift = (reg & 3) << 3;
> > +     u32 mask = ~(0xffff << shift);
> > +
> > +     switch (reg) {
> > +     case SDHCI_TRANSFER_MODE:
> > +             mcf_data->aside = val;
> > +             return;
> > +     case SDHCI_COMMAND:
> > +             if (host->cmd->opcode == MMC_STOP_TRANSMISSION)
> > +                     val |= SDHCI_CMD_ABORTCMD;
> > +
> > +             /*
> > +              * As for the fsl driver,
> > +              * we have to set the mode in a single write here.
> > +              */
> > +             writel(val << 16 | mcf_data->aside,
> > +                    host->ioaddr + SDHCI_TRANSFER_MODE);
> > +             return;
> > +     }
> > +
> > +     writel((readl(base) & mask) | (val << shift), base);
> > +}
> > +
> > +static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +     writel(val, host->ioaddr + reg);
> > +}
> > +
> > +static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
> > +{
> > +     if (reg == SDHCI_HOST_CONTROL) {
> > +             u8 __iomem *base = host->ioaddr + (reg & ~3);
> > +             u16 val = readw(base + 2);
> > +             u8 dma_bits = (val >> 5) & SDHCI_CTRL_DMA_MASK;
> > +             u8 host_ctrl = val & 0xff;
> > +
> > +             host_ctrl &= ~SDHCI_CTRL_DMA_MASK;
> > +             host_ctrl |= dma_bits;
> > +
> > +             return host_ctrl;
> > +     }
> > +
> > +     return readb(host->ioaddr + (reg ^ 0x3));
> > +}
> > +
> > +static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> > +{
> > +     /*
> > +      * For SDHCI_HOST_VERSION, sdhci specs defines 0xFE,
> > +      * a wrong offset for us, we are at 0xFC.
> > +      */
> > +     if (reg == SDHCI_HOST_VERSION)
> > +             reg -= 2;
> > +
> > +     return readw(host->ioaddr + (reg ^ 0x2));
> > +}
> > +
> > +static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
> > +{
> > +     u32 val;
> > +
> > +     val = readl(host->ioaddr + reg);
> > +
> > +     /*
> > +      * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> > +      * So forcing legacy mode at 25Mhz.
> > +      */
> > +     if (unlikely(reg == SDHCI_CAPABILITIES))
> > +             val &= ~SDHCI_CAN_DO_HISPD;
> > +
> > +     if (unlikely(reg == SDHCI_INT_STATUS)) {
> > +             if (val & ESDHC_INT_VENDOR_SPEC_DMA_ERR) {
> > +                     val &= ~ESDHC_INT_VENDOR_SPEC_DMA_ERR;
> > +                     val |= SDHCI_INT_ADMA_ERROR;
> > +             }
> > +     }
> > +
> > +     return val;
> > +}
> > +
> > +static unsigned int esdhc_mcf_get_max_timeout_count(struct sdhci_host *host)
> > +{
> > +     return 1 << 27;
> > +}
> > +
> > +static void esdhc_mcf_set_timeout(struct sdhci_host *host,
> > +                               struct mmc_command *cmd)
> > +{
> > +     /* Use maximum timeout counter */
> > +     esdhc_clrset_be(host, ESDHC_SYS_CTRL_DTOCV_MASK, 0xE,
> > +                     SDHCI_TIMEOUT_CONTROL);
> > +}
> > +
> > +static void esdhc_mcf_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +     struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +     sdhci_reset(host, mask);
> > +
> > +     esdhc_clrset_be(host, ESDHC_CTRL_BUSWIDTH_MASK,
> > +                     mcf_data->current_bus_width, SDHCI_HOST_CONTROL);
> > +
> > +     sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +     sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +}
> > +
> > +static unsigned int esdhc_mcf_pltfm_get_max_clock(struct sdhci_host *host)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +
> > +     return pltfm_host->clock;
> > +}
> > +
> > +static unsigned int esdhc_mcf_pltfm_get_min_clock(struct sdhci_host *host)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +
> > +     return pltfm_host->clock / 256 / 16;
> > +}
> > +
> > +static void esdhc_mcf_pltfm_set_clock(struct sdhci_host *host,
> > +                                   unsigned int clock)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +     unsigned long *pll_dr = (unsigned long *)MCF_PLL_DR;
> > +     u32 fvco, fsys, fesdhc, temp;
> > +     const int sdclkfs[] = {2, 4, 8, 16, 32, 64, 128, 256};
> > +     int delta, old_delta = clock;
> > +     int i, q, ri, rq;
> > +
> > +     if (clock == 0) {
> > +             host->mmc->actual_clock = 0;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * ColdFire eSDHC clock.s
> > +      *
> > +      * pll -+-> / outdiv1 --> fsys
> > +      *      +-> / outdiv3 --> eSDHC clock ---> / SDCCLKFS / DVS
> > +      *
> > +      * mcf5441x datasheet says:
> > +      * (8.1.2) eSDHC should be 40 MHz max
> > +      * (25.3.9) eSDHC input is, as example, 96 Mhz ...
> > +      * (25.3.9) sd pin clock must never exceed 25Mhz
> > +      *
> > +      * fvco = fsys * outdvi1 + 1
> > +      * fshdc = fvco / outdiv3 + 1
> > +      */
> > +     temp = readl(pll_dr);
> > +     fsys = pltfm_host->clock;
> > +     fvco = fsys * ((temp & 0x1f) + 1);
> > +     fesdhc = fvco / (((temp >> 10) & 0x1f) + 1);
> > +
> > +     for (i = 0; i < 8; ++i) {
> > +             int result = fesdhc / sdclkfs[i];
> > +
> > +             for (q = 1; q < 17; ++q) {
> > +                     int finale = result / q;
> > +
> > +                     delta = abs(clock - finale);
> > +
> > +                     if (delta < old_delta) {
> > +                             old_delta = delta;
> > +                             ri = i;
> > +                             rq = q;
> > +                     }
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Apply divisors and re-enable all the clocks
> > +      */
> > +     temp = ((sdclkfs[ri] >> 1) << 8) | ((rq - 1) << 4) |
> > +             (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN);
> > +     esdhc_clrset_be(host, 0x0000fff7, temp, SDHCI_CLOCK_CONTROL);
> > +
> > +     host->mmc->actual_clock = clock;
> > +
> > +     mdelay(1);
> > +}
> > +
> > +static void esdhc_mcf_pltfm_set_bus_width(struct sdhci_host *host, int width)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +     struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +     switch (width) {
> > +     case MMC_BUS_WIDTH_4:
> > +             mcf_data->current_bus_width = ESDHC_CTRL_4BITBUS;
> > +             break;
> > +     default:
> > +             mcf_data->current_bus_width = 0;
> > +             break;
> > +     }
> > +
> > +     esdhc_clrset_be(host, ESDHC_CTRL_BUSWIDTH_MASK,
> > +                     mcf_data->current_bus_width, SDHCI_HOST_CONTROL);
> > +}
> > +
> > +static void esdhc_mcf_request_done(struct sdhci_host *host,
> > +                                struct mmc_request *mrq)
> > +{
> > +     struct scatterlist *sg;
> > +     u32 *buffer;
> > +     int i;
> > +
> > +     if (!mrq->data || !mrq->data->bytes_xfered)
> > +             goto exit_done;
> > +
> > +     if (mmc_get_dma_dir(mrq->data) != DMA_FROM_DEVICE)
> > +             goto exit_done;
> > +
> > +     /*
> > +      * On mcf5441x there is no hw sdma option/flag to select the dma
> > +      * transfer endiannes. A swap after the transfer is needed.
> > +      */
> > +     for_each_sg(mrq->data->sg, sg, mrq->data->sg_len, i) {
> > +             buffer = (u32 *)sg_virt(sg);
> > +             esdhc_mcf_buffer_swap32(buffer, sg->length);
> > +     }
> > +
> > +exit_done:
> > +     mmc_request_done(host->mmc, mrq);
> > +}
> > +
> > +static void esdhc_mcf_copy_to_bounce_buffer(struct sdhci_host *host,
> > +                                         struct mmc_data *data)
> > +{
> > +     unsigned int length = data->blksz * data->blocks;
> > +
> > +     sg_copy_to_buffer(data->sg, data->sg_len,
> > +                       host->bounce_buffer, length);
> > +
> > +     esdhc_mcf_buffer_swap32((u32 *)host->bounce_buffer,
> > +                             data->blksz * data->blocks);
>
> data->blksz * data->blocks is already calculated as 'length'
>
> > +}
> > +
> > +static struct sdhci_ops sdhci_esdhc_ops = {
> > +     .reset = esdhc_mcf_reset,
> > +     .set_clock = esdhc_mcf_pltfm_set_clock,
> > +     .get_max_clock = esdhc_mcf_pltfm_get_max_clock,
> > +     .get_min_clock = esdhc_mcf_pltfm_get_min_clock,
> > +     .set_bus_width = esdhc_mcf_pltfm_set_bus_width,
> > +     .get_max_timeout_count = esdhc_mcf_get_max_timeout_count,
> > +     .set_timeout = esdhc_mcf_set_timeout,
> > +     .write_b = esdhc_mcf_writeb_be,
> > +     .write_w = esdhc_mcf_writew_be,
> > +     .write_l = esdhc_mcf_writel_be,
> > +     .read_b = esdhc_mcf_readb_be,
> > +     .read_w = esdhc_mcf_readw_be,
> > +     .read_l = esdhc_mcf_readl_be,
> > +     .copy_to_bounce_buffer = esdhc_mcf_copy_to_bounce_buffer,
> > +     .request_done = esdhc_mcf_request_done,
> > +};
> > +
> > +static const struct sdhci_pltfm_data sdhci_esdhc_mcf_pdata = {
> > +     .ops = &sdhci_esdhc_ops,
> > +     .quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_FORCE_DMA,
> > +              /*
> > +               * Mandatory quirk,
> > +               * controller does not support cmd23,
> > +               * without, on > 8G cards cmd23 is used, and
> > +               * driver times out.
> > +               */
> > +               SDHCI_QUIRK2_HOST_NO_CMD23,
> > +};
> > +
> > +static int esdhc_mcf_plat_init(struct sdhci_host *host,
> > +                            struct pltfm_mcf_data *mcf_data)
> > +{
> > +     struct mcf_esdhc_platform_data *plat_data;
> > +
> > +     if (!host->mmc->parent->platform_data) {
> > +             dev_err(mmc_dev(host->mmc), "no platform data!\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     plat_data = (struct mcf_esdhc_platform_data *)
> > +                     host->mmc->parent->platform_data;
> > +
> > +     /* Card_detect */
> > +     switch (plat_data->cd_type) {
> > +     default:
> > +     case ESDHC_CD_CONTROLLER:
> > +             /* We have a working card_detect back */
> > +             host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > +             break;
> > +     case ESDHC_CD_PERMANENT:
> > +             host->mmc->caps |= MMC_CAP_NONREMOVABLE;
> > +             break;
> > +     case ESDHC_CD_NONE:
> > +             break;
> > +     }
> > +
> > +     switch (plat_data->max_bus_width) {
> > +     case 4:
> > +             host->mmc->caps |= MMC_CAP_4_BIT_DATA;
> > +             break;
> > +     case 1:
> > +     default:
> > +             host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
> > +{
> > +     struct sdhci_host *host;
> > +     struct sdhci_pltfm_host *pltfm_host;
> > +     struct pltfm_mcf_data *mcf_data;
> > +     int err;
> > +
> > +     host = sdhci_pltfm_init(pdev, &sdhci_esdhc_mcf_pdata,
> > +                             sizeof(*mcf_data));
> > +
> > +     if (IS_ERR(host))
> > +             return PTR_ERR(host);
> > +
> > +     pltfm_host = sdhci_priv(host);
> > +     mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +     host->sdma_boundary = 0;
> > +
> > +     host->flags |= SDHCI_AUTO_CMD12;
> > +
> > +     mcf_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > +     if (IS_ERR(mcf_data->clk_ipg)) {
> > +             err = PTR_ERR(mcf_data->clk_ipg);
> > +             goto err_exit;
> > +     }
> > +
> > +     mcf_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> > +     if (IS_ERR(mcf_data->clk_ahb)) {
> > +             err = PTR_ERR(mcf_data->clk_ahb);
> > +             goto err_exit;
> > +     }
> > +
> > +     mcf_data->clk_per = devm_clk_get(&pdev->dev, "per");
> > +     if (IS_ERR(mcf_data->clk_per)) {
> > +             err = PTR_ERR(mcf_data->clk_per);
> > +             goto err_exit;
> > +     }
> > +
> > +     pltfm_host->clk = mcf_data->clk_per;
> > +     pltfm_host->clock = clk_get_rate(pltfm_host->clk);
> > +     err = clk_prepare_enable(mcf_data->clk_per);
> > +     if (err)
> > +             goto err_exit;
> > +
> > +     err = clk_prepare_enable(mcf_data->clk_ipg);
> > +     if (err)
> > +             goto unprep_per;
> > +
> > +     err = clk_prepare_enable(mcf_data->clk_ahb);
> > +     if (err)
> > +             goto unprep_ipg;
> > +
> > +     err = esdhc_mcf_plat_init(host, mcf_data);
> > +     if (err)
> > +             goto unprep_ahb;
> > +
> > +     err = sdhci_setup_host(host);
> > +     if (err)
> > +             goto unprep_ahb;
> > +
> > +     if (!host->bounce_buffer) {
> > +             dev_err(&pdev->dev, "bounce buffer not allocated");
> > +             err = -ENOMEM;
> > +             goto cleanup;
> > +     }
> > +
> > +     err = __sdhci_add_host(host);
> > +     if (err)
> > +             goto cleanup;
> > +
> > +     return 0;
> > +
> > +cleanup:
> > +     sdhci_cleanup_host(host);
> > +unprep_ahb:
> > +     clk_disable_unprepare(mcf_data->clk_ahb);
> > +unprep_ipg:
> > +     clk_disable_unprepare(mcf_data->clk_ipg);
> > +unprep_per:
> > +     clk_disable_unprepare(mcf_data->clk_per);
> > +err_exit:
> > +     sdhci_pltfm_free(pdev);
> > +
> > +     return err;
> > +}
> > +
> > +static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
> > +{
> > +     struct sdhci_host *host = platform_get_drvdata(pdev);
> > +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +     struct pltfm_mcf_data *mcf_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +     sdhci_remove_host(host, 0);
> > +
> > +     clk_disable_unprepare(mcf_data->clk_ipg);
> > +     clk_disable_unprepare(mcf_data->clk_ahb);
> > +     clk_disable_unprepare(mcf_data->clk_per);
> > +
> > +     sdhci_pltfm_free(pdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver sdhci_esdhc_mcf_driver = {
> > +     .driver = {
> > +             .name = "sdhci-esdhc-mcf",
> > +     },
> > +     .probe = sdhci_esdhc_mcf_probe,
> > +     .remove = sdhci_esdhc_mcf_remove,
> > +};
> > +
> > +module_platform_driver(sdhci_esdhc_mcf_driver);
> > +
> > +MODULE_DESCRIPTION("SDHCI driver for Freescale ColdFire eSDHC");
> > +MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com>");
> > +MODULE_LICENSE("GPL v2");
> >
>


-- 
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
