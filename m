Return-Path: <SRS0=7kHn=62=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5323EC2D0F7
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 18:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD5620673
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 18:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="K/FR9+yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgELSAd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 May 2020 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELSAc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 May 2020 14:00:32 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E96C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2020 11:00:32 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id w68so3571564vke.5
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2020 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuCUl7YXkYZhm/Vf+ymFMctV6hCkNIOAdOMWrB3OfiI=;
        b=K/FR9+yLe/YXfLNFVATPU5drsPnWL3xYTnEsEgsuqXXQLq8pJg2AkjCC1OlrNvNExX
         qjkit9EztNwLa4Tk9tB8tqVts7y/UXJXrXIsoCVFRaP67kl+RXe9DxTkzyeyVv0fBarY
         G9wCB+RMpxAp2jmfTZjtGY/vSEJBpgiTW1vD4qZvggHNSCuDqCC8tk/8wLj7qUk3vfk1
         BbiICuTY/k834KDksb/SrOFCJ4Mwn4v9+NBfHuZkigl5Qea279e91h9tR3qpQEraHbax
         +tAVzJ14X6tLFa5L5IAKNKPP04vmwKm3L5+h6MRD1PVFS3Tyw/e9CV50Pd8pZrUrHqpC
         /tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuCUl7YXkYZhm/Vf+ymFMctV6hCkNIOAdOMWrB3OfiI=;
        b=l8gye77ZsUjCH+1mG5uNZ/jqbjx/eSNm6knn7yO2H3qmu4NrqzDe+yumJ/FPNdIymD
         tRkFfvCEK2H2EHdq9YFYad00sIHhP3CZJQnOCwE76y0mCh/FzOz4CJd/Nt56a7bjww2/
         CAbLvPaM+nCk7/sIYs4yFSM9ubcw53mHMMs2q6zsaksBb1CQeMvFQLNWqzjqMrAGyRZ2
         mhMFEel7Ril9KnhShJtXVrQa/0X7UFxZV9pHAZCtrWEkFe+QOTQSbzb8q2o/YoKEZYQH
         k/XdRMNpD96IJNHq2e+XAmsqo5f2GaBRskmm7MWMYno7nXPrgkXb+kSU7M7uLykwPi1a
         KLug==
X-Gm-Message-State: AGi0PuYWaBwasz7L3+jEVErhN2CpdVJhD5iF97RIa/74uAL3K7iEZBAV
        REiS/J0aIvNRzQJ2wFpSU2yL73iEG1JMWFS6018ruQ==
X-Google-Smtp-Source: APiQypLewJ9Ygz2Zk2wvZ0p0VIw+V6pariiG0UdzwU1NDmB3iaF2GlQfXRt2HOJKqc+oe1sw5ZuKJppA/6f6Abx9jxU=
X-Received: by 2002:a1f:a6d2:: with SMTP id p201mr17211753vke.7.1589306431248;
 Tue, 12 May 2020 11:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200501235907.3978-1-angelo.dureghello@timesys.com> <2cbd0165-6134-e605-c9d7-e8f6cc07ced0@linux-m68k.org>
In-Reply-To: <2cbd0165-6134-e605-c9d7-e8f6cc07ced0@linux-m68k.org>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Tue, 12 May 2020 20:05:12 +0200
Message-ID: <CALJHbkAS1=NUUKNLAdctjVTRzQYwqTV8o0dJrKZFYwYG1tiAag@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: mcf5441x: add support for esdhc mmc controller
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-m68k@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Greg and all,

thanks a lot !

ack, let me know if you can add that comment, or i can send a v4.

I am also appending a test log, just to show the driver is working quite well,
for me it really speed-up each type of development in this cpu.

/mnt/sd # chmod 755 test-sd.sh
/mnt/sd # ./test-sd.sh
[01] test: simple file creation ...
creating testfiles ...
checking testfiles ...
passed
[02] test: file deletion ...
removing all testfiles ...
passed
[03] test: folder creation ...
creating testdirs ...
passed
[04] test: touching files in testdirs ...
passed
[05] test: full removal ...
passed
[06] test: big file write ...
passed
[07] test: big file move ...
passed
[08] test: big file and dir removal ...
passed
[09] test: simple read ...
trullallero
passed
[10] test: simple read from dir ...
trullallero
passed
[11] test: cleanup ...
passed
/mnt/sd #


Regards,
angelo


On Tue, May 12, 2020 at 5:06 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> Hi Angelo,
>
> On 2/5/20 9:59 am, Angelo Dureghello wrote:
> > Add support for sdhci-edshc mmc controller.
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> > ---
> > Changes for v3:
> > - removed volatile cast from clk.c
> > ---
> >   arch/m68k/coldfire/clk.c                    | 15 ++++++++++
> >   arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
> >   arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
> >   arch/m68k/include/asm/m5441xsim.h           | 19 ++++++++++++
> >   arch/m68k/include/asm/mcfclk.h              |  2 ++
> >   include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
> >   6 files changed, 95 insertions(+), 3 deletions(-)
> >   create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
> >
> > diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> > index 7bc666e482eb..8d048a72e173 100644
> > --- a/arch/m68k/coldfire/clk.c
> > +++ b/arch/m68k/coldfire/clk.c
> > @@ -73,6 +73,21 @@ struct clk_ops clk_ops1 = {
> >   #endif /* MCFPM_PPMCR1 */
> >   #endif /* MCFPM_PPMCR0 */
> >
> > +static void __clk_enable2(struct clk *clk)
> > +{
> > +     __set_bit(clk->slot, MCFSDHC_CLK);
> > +}
> > +
> > +static void __clk_disable2(struct clk *clk)
> > +{
> > +     __clear_bit(clk->slot, MCFSDHC_CLK);
> > +}
> > +
> > +struct clk_ops clk_ops2 = {
> > +     .enable         = __clk_enable2,
> > +     .disable        = __clk_disable2,
> > +};
> > +
> >   struct clk *clk_get(struct device *dev, const char *id)
> >   {
> >       const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
> > diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> > index b4103b6bfdeb..9ef4ec0aea00 100644
> > --- a/arch/m68k/coldfire/device.c
> > +++ b/arch/m68k/coldfire/device.c
> > @@ -22,6 +22,7 @@
> >   #include <asm/mcfqspi.h>
> >   #include <linux/platform_data/edma.h>
> >   #include <linux/platform_data/dma-mcf-edma.h>
> > +#include <linux/platform_data/mmc-esdhc-mcf.h>
> >
> >   /*
> >    *  All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
> > @@ -551,9 +552,35 @@ static struct platform_device mcf_edma = {
> >               .platform_data = &mcf_edma_data,
> >       }
> >   };
> > -
> >   #endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
> >
> > +#if IS_ENABLED(CONFIG_MMC)
> > +static struct mcf_esdhc_platform_data mcf_esdhc_data = {
> > +     .max_bus_width = 4,
> > +     .cd_type = ESDHC_CD_NONE,
> > +};
> > +
> > +static struct resource mcf_esdhc_resources[] = {
> > +     {
> > +             .start = MCFSDHC_BASE,
> > +             .end = MCFSDHC_BASE + MCFSDHC_SIZE - 1,
> > +             .flags = IORESOURCE_MEM,
> > +     }, {
> > +             .start = MCF_IRQ_SDHC,
> > +             .end = MCF_IRQ_SDHC,
> > +             .flags = IORESOURCE_IRQ,
> > +     },
> > +};
> > +
> > +static struct platform_device mcf_esdhc = {
> > +     .name                   = "sdhci-esdhc-mcf",
> > +     .id                     = 0,
> > +     .num_resources          = ARRAY_SIZE(mcf_esdhc_resources),
> > +     .resource               = mcf_esdhc_resources,
> > +     .dev.platform_data      = &mcf_esdhc_data,
> > +};
> > +#endif /* IS_ENABLED(CONFIG_MMC) */
> > +
> >   static struct platform_device *mcf_devices[] __initdata = {
> >       &mcf_uart,
> >   #if IS_ENABLED(CONFIG_FEC)
> > @@ -586,6 +613,9 @@ static struct platform_device *mcf_devices[] __initdata = {
> >   #if IS_ENABLED(CONFIG_MCF_EDMA)
> >       &mcf_edma,
> >   #endif
> > +#if IS_ENABLED(CONFIG_MMC)
> > +     &mcf_esdhc,
> > +#endif
> >   };
> >
> >   /*
> > @@ -614,4 +644,3 @@ static int __init mcf_init_devices(void)
> >   }
> >
> >   arch_initcall(mcf_init_devices);
> > -
> > diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> > index 5bd24c9b865d..ffa02de1a3fb 100644
> > --- a/arch/m68k/coldfire/m5441x.c
> > +++ b/arch/m68k/coldfire/m5441x.c
> > @@ -52,7 +52,7 @@ DEFINE_CLK(0, "mcfssi.0", 47, MCF_CLK);
> >   DEFINE_CLK(0, "pll.0", 48, MCF_CLK);
> >   DEFINE_CLK(0, "mcfrng.0", 49, MCF_CLK);
> >   DEFINE_CLK(0, "mcfssi.1", 50, MCF_CLK);
> > -DEFINE_CLK(0, "mcfsdhc.0", 51, MCF_CLK);
> > +DEFINE_CLK(0, "sdhci-esdhc-mcf.0", 51, MCF_CLK);
> >   DEFINE_CLK(0, "enet-fec.0", 53, MCF_CLK);
> >   DEFINE_CLK(0, "enet-fec.1", 54, MCF_CLK);
> >   DEFINE_CLK(0, "switch.0", 55, MCF_CLK);
> > @@ -74,6 +74,10 @@ DEFINE_CLK(1, "mcfpwm.0", 34, MCF_BUSCLK);
> >   DEFINE_CLK(1, "sys.0", 36, MCF_BUSCLK);
> >   DEFINE_CLK(1, "gpio.0", 37, MCF_BUSCLK);
> >
> > +DEFINE_CLK(2, "ipg.0", 0, MCF_CLK);
> > +DEFINE_CLK(2, "ahb.0", 1, MCF_CLK);
> > +DEFINE_CLK(2, "per.0", 2, MCF_CLK);
> > +
> >   struct clk *mcf_clks[] = {
> >       &__clk_0_2,
> >       &__clk_0_8,
> > @@ -131,6 +135,11 @@ struct clk *mcf_clks[] = {
> >       &__clk_1_34,
> >       &__clk_1_36,
> >       &__clk_1_37,
> > +
> > +     &__clk_2_0,
> > +     &__clk_2_1,
> > +     &__clk_2_2,
> > +
> >       NULL,
> >   };
> >
> > @@ -151,6 +160,7 @@ static struct clk * const enable_clks[] __initconst = {
> >       &__clk_0_33, /* pit.1 */
> >       &__clk_0_37, /* eport */
> >       &__clk_0_48, /* pll */
> > +     &__clk_0_51, /* esdhc */
> >
> >       &__clk_1_36, /* CCM/reset module/Power management */
> >       &__clk_1_37, /* gpio */
> > diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
> > index 4892f314ff38..750555a6fa87 100644
> > --- a/arch/m68k/include/asm/m5441xsim.h
> > +++ b/arch/m68k/include/asm/m5441xsim.h
> > @@ -278,6 +278,17 @@
> >   #define MCFGPIO_IRQ_VECBASE (MCFINT_VECBASE - MCFGPIO_IRQ_MIN)
> >   #define MCFGPIO_PIN_MAX             87
> >
> > +/*********************************************************************
> > + *
> > + * Phase Locked Loop (PLL)
> > + *
> > + *********************************************************************/
>
> Style nit. Just a simple:
>
> /*
>   * Phase Locked Loop (PLL)
>   */
>
> comment is preferred here - to be consistent with other comments in this file.
>
> Otherwise:
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>
> Regards
> Greg
>
>
> > +/* Register read/write macros */
> > +#define MCF_PLL_CR           0xFC0C0000
> > +#define MCF_PLL_DR           0xFC0C0004
> > +#define MCF_PLL_SR           0xFC0C0008
> > +
> >   /*
> >    *  DSPI module.
> >    */
> > @@ -298,5 +309,13 @@
> >   #define MCFEDMA_IRQ_INTR16  (MCFINT1_VECBASE + MCFEDMA_EDMA_INTR16)
> >   #define MCFEDMA_IRQ_INTR56  (MCFINT2_VECBASE + MCFEDMA_EDMA_INTR56)
> >   #define MCFEDMA_IRQ_ERR     (MCFINT0_VECBASE + MCFINT0_EDMA_ERR)
> > +/*
> > + *  esdhc module.
> > + */
> > +#define MCFSDHC_BASE         0xfc0cc000
> > +#define MCFSDHC_SIZE         256
> > +#define MCFINT2_SDHC         31
> > +#define MCF_IRQ_SDHC         (MCFINT2_VECBASE + MCFINT2_SDHC)
> > +#define MCFSDHC_CLK          (MCFSDHC_BASE + 0x2c)
> >
> >   #endif /* m5441xsim_h */
> > diff --git a/arch/m68k/include/asm/mcfclk.h b/arch/m68k/include/asm/mcfclk.h
> > index 0aca504fae31..722627e06d66 100644
> > --- a/arch/m68k/include/asm/mcfclk.h
> > +++ b/arch/m68k/include/asm/mcfclk.h
> > @@ -30,6 +30,8 @@ extern struct clk_ops clk_ops0;
> >   extern struct clk_ops clk_ops1;
> >   #endif /* MCFPM_PPMCR1 */
> >
> > +extern struct clk_ops clk_ops2;
> > +
> >   #define DEFINE_CLK(clk_bank, clk_name, clk_slot, clk_rate) \
> >   static struct clk __clk_##clk_bank##_##clk_slot = { \
> >       .name = clk_name, \
> > diff --git a/include/linux/platform_data/mmc-esdhc-mcf.h b/include/linux/platform_data/mmc-esdhc-mcf.h
> > new file mode 100644
> > index 000000000000..85cb786a62fe
> > --- /dev/null
> > +++ b/include/linux/platform_data/mmc-esdhc-mcf.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> > +#define __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> > +
> > +enum cd_types {
> > +     ESDHC_CD_NONE,          /* no CD, neither controller nor gpio */
> > +     ESDHC_CD_CONTROLLER,    /* mmc controller internal CD */
> > +     ESDHC_CD_PERMANENT,     /* no CD, card permanently wired to host */
> > +};
> > +
> > +struct mcf_esdhc_platform_data {
> > +     int max_bus_width;
> > +     int cd_type;
> > +};
> > +
> > +#endif /* __LINUX_PLATFORM_DATA_MCF_ESDHC_H__ */
> >



-- 
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
