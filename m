Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A00C433E7
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0390B2074F
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxz8iya0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgJLIl2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Oct 2020 04:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgJLIl2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2020 04:41:28 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB237C0613CE;
        Mon, 12 Oct 2020 01:41:27 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id x20so12803086ybs.8;
        Mon, 12 Oct 2020 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFM3OiH0jnEOLWaI2UvpXZsCixIw9PA6Cp1fgzGRjYY=;
        b=fxz8iya0ByOgySuxsA7kLDAVc3P40gME0I/7uHfQqWyr35HuPYJSSi2EnL8rB4AafR
         8S/kUqiW7+wpnGxHiixWAEE/bAXeGQEf9G0zfsDzSez1wZbNQOvTglSA6NdcDt+W8rTV
         FDjLejuHarpObYulnYMXd/HOfNwYW81h6ne2AW09Pes32MtnJ0dqXwXmMQcPb0wiq1Dm
         ct3zw2fDOLvjAuQUV0nUTjld+Q38YaIuRsf51C6kyMRD9jcXZj229P2TOtpZZnocFYXn
         ZliypdG3/++PI1AGekOHZ1Zk8Qfv3LNMwob4d74RyxxIGYwkrSXTOVeUhVk4T+8qXHN7
         r+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFM3OiH0jnEOLWaI2UvpXZsCixIw9PA6Cp1fgzGRjYY=;
        b=IN92zgv51vIhhEhDPB2qc+uzxeHNE/kUQfD5JSXw96w9HZ9/0ZCCx1dRbfNaDLBnrI
         ixcLwor9pF9ChJVB9UA68TfzaMb/4jLLHcGocP/Bi0HKyXLj8IJbdfusqyPbuEoDAn+n
         limgK3OQl/E10tOIZHUxaZIHQLYATQRqOsih1lSKgsUhjbK63PSHYAk2zdhAd71rfH56
         VJukpT41Gci1prsD2TP43tEYkZIJxjysrzMVEsH59puoppe17Wieg/YSbcVGEyVDFKbS
         hi921LRcvsuxywoEsaPsk1cIxcfoyOQj99m6+RXm+7gAMD5ex+TznULtb3w2SmSBIO/B
         vVOg==
X-Gm-Message-State: AOAM533ek/hWwKoO3myVjLGrPZktkiLMKG1aZgqCzdNxbr8E62Ybo1Z1
        INByDO/tPdLCgQquqvz/YKZv2UlE4ec1Hy3cQ20=
X-Google-Smtp-Source: ABdhPJzYafTSujy3Qs5r/o4AimfkVf6thEI2m75SC0EgUoOm2AFrxueU/sx9J0x6jEbeUM4Ll+F226qex1dkqoi0Qj8=
X-Received: by 2002:a25:e688:: with SMTP id d130mr33032381ybh.177.1602492086425;
 Mon, 12 Oct 2020 01:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200717033350.13006-1-benchuanggli@gmail.com> <CAPDyKFpp54tNRiQ+or-3o9dUJ=CB+PpsRc=fkxc10dAUY-x_SQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpp54tNRiQ+or-3o9dUJ=CB+PpsRc=fkxc10dAUY-x_SQ@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Mon, 12 Oct 2020 16:41:15 +0800
Message-ID: <CACT4zj-Z0yiuYF9KVyvTM+0nvk__YnBh=c7MHuB1XOFVpTtmHw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and
 enable SSC for GL975x
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

Regarding this patch, we also want to fix the EMI of one hardware
using the old version(such as v5.4).
Is there a chance to append a Fixes tag on this patch ?
Or what should I do ?

Best Regards,
Ben

On Wed, Aug 5, 2020 at 2:34 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 17 Jul 2020 at 05:33, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > Set SDR104's clock to 205MHz and enable SSC for GL9750 and GL9755
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Applied for next (a while ago), thanks!
>
> Kind regards
> Uffe
>
>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 220 ++++++++++++++++++++++++++++++-
> >  1 file changed, 218 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index ca0166d9bf82..5da2b06d84ae 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -31,10 +31,18 @@
> >  #define   SDHCI_GLI_9750_ALL_RST      (BIT(24)|BIT(25)|BIT(28)|BIT(30))
> >
> >  #define SDHCI_GLI_9750_PLL           0x864
> > +#define   SDHCI_GLI_9750_PLL_LDIV       GENMASK(9, 0)
> > +#define   SDHCI_GLI_9750_PLL_PDIV       GENMASK(14, 12)
> > +#define   SDHCI_GLI_9750_PLL_DIR        BIT(15)
> >  #define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
> >  #define   SDHCI_GLI_9750_PLL_TX2_DLY    GENMASK(22, 20)
> >  #define   GLI_9750_PLL_TX2_INV_VALUE    0x1
> >  #define   GLI_9750_PLL_TX2_DLY_VALUE    0x0
> > +#define   SDHCI_GLI_9750_PLLSSC_STEP    GENMASK(28, 24)
> > +#define   SDHCI_GLI_9750_PLLSSC_EN      BIT(31)
> > +
> > +#define SDHCI_GLI_9750_PLLSSC        0x86C
> > +#define   SDHCI_GLI_9750_PLLSSC_PPM    GENMASK(31, 16)
> >
> >  #define SDHCI_GLI_9750_SW_CTRL      0x874
> >  #define   SDHCI_GLI_9750_SW_CTRL_4    GENMASK(7, 6)
> > @@ -76,6 +84,21 @@
> >  #define PCIE_GLI_9763E_SCR      0x8E0
> >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> >
> > +#define PCI_GLI_9755_WT       0x800
> > +#define   PCI_GLI_9755_WT_EN    BIT(0)
> > +#define   GLI_9755_WT_EN_ON     0x1
> > +#define   GLI_9755_WT_EN_OFF    0x0
> > +
> > +#define PCI_GLI_9755_PLL            0x64
> > +#define   PCI_GLI_9755_PLL_LDIV       GENMASK(9, 0)
> > +#define   PCI_GLI_9755_PLL_PDIV       GENMASK(14, 12)
> > +#define   PCI_GLI_9755_PLL_DIR        BIT(15)
> > +#define   PCI_GLI_9755_PLLSSC_STEP    GENMASK(28, 24)
> > +#define   PCI_GLI_9755_PLLSSC_EN      BIT(31)
> > +
> > +#define PCI_GLI_9755_PLLSSC        0x68
> > +#define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
> > +
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> >  /* Genesys Logic chipset */
> > @@ -280,6 +303,84 @@ static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
> >         return 0;
> >  }
> >
> > +static void gl9750_disable_ssc_pll(struct sdhci_host *host)
> > +{
> > +       u32 pll;
> > +
> > +       gl9750_wt_on(host);
> > +       pll = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> > +       pll &= ~(SDHCI_GLI_9750_PLL_DIR | SDHCI_GLI_9750_PLLSSC_EN);
> > +       sdhci_writel(host, pll, SDHCI_GLI_9750_PLL);
> > +       gl9750_wt_off(host);
> > +}
> > +
> > +static void gl9750_set_pll(struct sdhci_host *host, u8 dir, u16 ldiv, u8 pdiv)
> > +{
> > +       u32 pll;
> > +
> > +       gl9750_wt_on(host);
> > +       pll = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> > +       pll &= ~(SDHCI_GLI_9750_PLL_LDIV |
> > +                SDHCI_GLI_9750_PLL_PDIV |
> > +                SDHCI_GLI_9750_PLL_DIR);
> > +       pll |= FIELD_PREP(SDHCI_GLI_9750_PLL_LDIV, ldiv) |
> > +              FIELD_PREP(SDHCI_GLI_9750_PLL_PDIV, pdiv) |
> > +              FIELD_PREP(SDHCI_GLI_9750_PLL_DIR, dir);
> > +       sdhci_writel(host, pll, SDHCI_GLI_9750_PLL);
> > +       gl9750_wt_off(host);
> > +
> > +       /* wait for pll stable */
> > +       mdelay(1);
> > +}
> > +
> > +static void gl9750_set_ssc(struct sdhci_host *host, u8 enable, u8 step, u16 ppm)
> > +{
> > +       u32 pll;
> > +       u32 ssc;
> > +
> > +       gl9750_wt_on(host);
> > +       pll = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> > +       ssc = sdhci_readl(host, SDHCI_GLI_9750_PLLSSC);
> > +       pll &= ~(SDHCI_GLI_9750_PLLSSC_STEP |
> > +                SDHCI_GLI_9750_PLLSSC_EN);
> > +       ssc &= ~SDHCI_GLI_9750_PLLSSC_PPM;
> > +       pll |= FIELD_PREP(SDHCI_GLI_9750_PLLSSC_STEP, step) |
> > +              FIELD_PREP(SDHCI_GLI_9750_PLLSSC_EN, enable);
> > +       ssc |= FIELD_PREP(SDHCI_GLI_9750_PLLSSC_PPM, ppm);
> > +       sdhci_writel(host, ssc, SDHCI_GLI_9750_PLLSSC);
> > +       sdhci_writel(host, pll, SDHCI_GLI_9750_PLL);
> > +       gl9750_wt_off(host);
> > +}
> > +
> > +static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
> > +{
> > +       /* set pll to 205MHz and enable ssc */
> > +       gl9750_set_ssc(host, 0x1, 0x1F, 0xFFE7);
> > +       gl9750_set_pll(host, 0x1, 0x246, 0x0);
> > +}
> > +
> > +static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
> > +{
> > +       struct mmc_ios *ios = &host->mmc->ios;
> > +       u16 clk;
> > +
> > +       host->mmc->actual_clock = 0;
> > +
> > +       gl9750_disable_ssc_pll(host);
> > +       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +
> > +       if (clock == 0)
> > +               return;
> > +
> > +       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> > +       if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> > +               host->mmc->actual_clock = 205000000;
> > +               gl9750_set_ssc_pll_205mhz(host);
> > +       }
> > +
> > +       sdhci_enable_clk(host, clk);
> > +}
> > +
> >  static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
> >  {
> >         int ret;
> > @@ -295,6 +396,121 @@ static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
> >         slot->host->irq = pci_irq_vector(slot->chip->pdev, 0);
> >  }
> >
> > +static inline void gl9755_wt_on(struct pci_dev *pdev)
> > +{
> > +       u32 wt_value;
> > +       u32 wt_enable;
> > +
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_WT, &wt_value);
> > +       wt_enable = FIELD_GET(PCI_GLI_9755_WT_EN, wt_value);
> > +
> > +       if (wt_enable == GLI_9755_WT_EN_ON)
> > +               return;
> > +
> > +       wt_value &= ~PCI_GLI_9755_WT_EN;
> > +       wt_value |= FIELD_PREP(PCI_GLI_9755_WT_EN, GLI_9755_WT_EN_ON);
> > +
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_WT, wt_value);
> > +}
> > +
> > +static inline void gl9755_wt_off(struct pci_dev *pdev)
> > +{
> > +       u32 wt_value;
> > +       u32 wt_enable;
> > +
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_WT, &wt_value);
> > +       wt_enable = FIELD_GET(PCI_GLI_9755_WT_EN, wt_value);
> > +
> > +       if (wt_enable == GLI_9755_WT_EN_OFF)
> > +               return;
> > +
> > +       wt_value &= ~PCI_GLI_9755_WT_EN;
> > +       wt_value |= FIELD_PREP(PCI_GLI_9755_WT_EN, GLI_9755_WT_EN_OFF);
> > +
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_WT, wt_value);
> > +}
> > +
> > +static void gl9755_disable_ssc_pll(struct pci_dev *pdev)
> > +{
> > +       u32 pll;
> > +
> > +       gl9755_wt_on(pdev);
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_PLL, &pll);
> > +       pll &= ~(PCI_GLI_9755_PLL_DIR | PCI_GLI_9755_PLLSSC_EN);
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_PLL, pll);
> > +       gl9755_wt_off(pdev);
> > +}
> > +
> > +static void gl9755_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
> > +{
> > +       u32 pll;
> > +
> > +       gl9755_wt_on(pdev);
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_PLL, &pll);
> > +       pll &= ~(PCI_GLI_9755_PLL_LDIV |
> > +                PCI_GLI_9755_PLL_PDIV |
> > +                PCI_GLI_9755_PLL_DIR);
> > +       pll |= FIELD_PREP(PCI_GLI_9755_PLL_LDIV, ldiv) |
> > +              FIELD_PREP(PCI_GLI_9755_PLL_PDIV, pdiv) |
> > +              FIELD_PREP(PCI_GLI_9755_PLL_DIR, dir);
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_PLL, pll);
> > +       gl9755_wt_off(pdev);
> > +
> > +       /* wait for pll stable */
> > +       mdelay(1);
> > +}
> > +
> > +static void gl9755_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
> > +{
> > +       u32 pll;
> > +       u32 ssc;
> > +
> > +       gl9755_wt_on(pdev);
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_PLL, &pll);
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_PLLSSC, &ssc);
> > +       pll &= ~(PCI_GLI_9755_PLLSSC_STEP |
> > +                PCI_GLI_9755_PLLSSC_EN);
> > +       ssc &= ~PCI_GLI_9755_PLLSSC_PPM;
> > +       pll |= FIELD_PREP(PCI_GLI_9755_PLLSSC_STEP, step) |
> > +              FIELD_PREP(PCI_GLI_9755_PLLSSC_EN, enable);
> > +       ssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_PPM, ppm);
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_PLLSSC, ssc);
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_PLL, pll);
> > +       gl9755_wt_off(pdev);
> > +}
> > +
> > +static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
> > +{
> > +       /* set pll to 205MHz and enable ssc */
> > +       gl9755_set_ssc(pdev, 0x1, 0x1F, 0xFFE7);
> > +       gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
> > +}
> > +
> > +static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
> > +{
> > +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> > +       struct mmc_ios *ios = &host->mmc->ios;
> > +       struct pci_dev *pdev;
> > +       u16 clk;
> > +
> > +       pdev = slot->chip->pdev;
> > +       host->mmc->actual_clock = 0;
> > +
> > +       gl9755_disable_ssc_pll(pdev);
> > +       sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +
> > +       if (clock == 0)
> > +               return;
> > +
> > +       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> > +       if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> > +               host->mmc->actual_clock = 205000000;
> > +               gl9755_set_ssc_pll_205mhz(pdev);
> > +       }
> > +
> > +       sdhci_enable_clk(host, clk);
> > +}
> > +
> >  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> >  {
> >         struct sdhci_host *host = slot->host;
> > @@ -440,7 +656,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
> >  }
> >
> >  static const struct sdhci_ops sdhci_gl9755_ops = {
> > -       .set_clock              = sdhci_set_clock,
> > +       .set_clock              = sdhci_gl9755_set_clock,
> >         .enable_dma             = sdhci_pci_enable_dma,
> >         .set_bus_width          = sdhci_set_bus_width,
> >         .reset                  = sdhci_reset,
> > @@ -460,7 +676,7 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
> >
> >  static const struct sdhci_ops sdhci_gl9750_ops = {
> >         .read_l                 = sdhci_gl9750_readl,
> > -       .set_clock              = sdhci_set_clock,
> > +       .set_clock              = sdhci_gl9750_set_clock,
> >         .enable_dma             = sdhci_pci_enable_dma,
> >         .set_bus_width          = sdhci_set_bus_width,
> >         .reset                  = sdhci_gl9750_reset,
> > --
> > 2.27.0
> >
