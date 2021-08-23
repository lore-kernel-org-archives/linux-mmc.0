Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA592C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34CA61360
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhHWBcb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhHWBcb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:32:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD9C061575
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:31:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g21so23700070edw.4
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtC0NlDRXaPHiOms/x7ErI2iV6V0C0fYS2A76I1nV/k=;
        b=X4DBOBf28h5df5hk21oGJWvsdMuI8PBKQcBrPuAY2M4HDdDqEBpbSyW44QV2zS1FRO
         /Nkg3FYrhppGV0aT6TQQj++5SY0t1HqHGQV3RjY3sGpepJnStvDMjUNSClXIi7Reiyf1
         /qBzQGOw01pvHPANXJYerYNTk1ctKno5A5gB3U1meEETdNthXkwHFk9FnpT1LZ9ui7rf
         t/ZJo0Ih4SafJyuvjgXv6DXbjTYA0LjpUQUhAhulTH8jTT1UgkjjJm/xehVZ5L8w7e/n
         3S/r/BR0XxNOZVFV76ecqodkFBP5sZn12ytdEc8lLd7KqU594XvovIsa7b9OhzU3Zbog
         vZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtC0NlDRXaPHiOms/x7ErI2iV6V0C0fYS2A76I1nV/k=;
        b=GFL3u+zxDCd8Zrz1uZoaaP6yd2mrb5QQ1bsMKwyYHihJOmQeBdEXi7Ii60gOM4t4DV
         tTWzCKVuW2zR0G5XY1TVr6tfX0LT4lr6ate3LfzppqofBEy6Wck9FQTXhE7BMeNGgazQ
         tS5Klag+qotwkwtynFKqvVXrAlqTJVVt5tpZQxHapv0DhJ6qMYxR7UignCGK5QryWM9b
         Zoe73voOXRwFZSdAVKjH2+1TQMsXol4RWyDlTeP7Fq3xlIa0wQUUBW8sQyzFDDi7MSC1
         fVTnI6zpTFxrJMKOE0VL2ZO6G2QA9i4OhOPWqgUmo1qjabbrCqFuATRku943CL018PAa
         nsKQ==
X-Gm-Message-State: AOAM531UbSIIN4x6ug5sctzK6wFdk4xotDQdAdqT/kZpXNhLj1jPF7Hy
        P32t3NNSW6FQ7/mdRnHr5zsSoahv0njYl+av1Hevbw==
X-Google-Smtp-Source: ABdhPJwaPLge2H1vFOJvyaDffDkJcvMVsQ5UViBRI6GQB14TquMB+gIxON9tlklGcPRRm4Sdzj1za5H4wNjzTDOcLBo=
X-Received: by 2002:a05:6402:4cb:: with SMTP id n11mr34347934edw.292.1629682307653;
 Sun, 22 Aug 2021 18:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-6-brad@pensando.io>
 <CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwnAzAan5p7w@mail.gmail.com> <CAK7LNAQYptL=wJ1ofauX41oV+bZRaSq1V5FabMz4eyZBzxDQaw@mail.gmail.com>
In-Reply-To: <CAK7LNAQYptL=wJ1ofauX41oV+bZRaSq1V5FabMz4eyZBzxDQaw@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:31:37 -0700
Message-ID: <CAK9rFnwQ0g=B-=k9KLx=3tRgshkDLji+tKjsG3_Y5RrSeP-SMQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Yamada-san,

On Fri, Apr 9, 2021 at 1:25 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Mar 30, 2021 at 7:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > + Masahiro Yamada (main author of the driver)
> >
> > On Mon, 29 Mar 2021 at 03:59, Brad Larson <brad@pensando.io> wrote:
> > >
> > > Add support for Pensando Elba SoC which explicitly controls
> > > byte-lane enables on writes.  Refactor to allow platform
> > > specific write ops.
> > >
> > > Signed-off-by: Brad Larson <brad@pensando.io>
> > > ---
> > >  drivers/mmc/host/Kconfig              |  15 +++
> > >  drivers/mmc/host/Makefile             |   1 +
> > >  drivers/mmc/host/sdhci-cadence-elba.c | 137 ++++++++++++++++++++++++++
> >
> > By looking at the amount of code changes that seem to be needed to
> > support the Pensando Elba variant, I don't think it's necessary to
> > split this into a separate file.
> >
> > Unless Yamada-san has a different opinion, I would rather just stick
> > with using sdhci-cadence.c.
>
>
> I agree with Ulf.

I've folded Elba SoC support into sdhci-cadence.c.

> BTW, this patch cannot probe
> "pensando,elba-emmc"
> when CONFIG_MMC_SDHCI_CADENCE_ELBA=m.

Right, that issue is gone now.  There is no separate sdhci-cadence-elba.c

> > > +#define SDIO_REG_HRS4          0x10
>
> This is the same as SDHCI_CDNS_HRS04
>
>
>
> > > +#define REG_DELAY_HS           0x00
>
> This is the same as SDHCI_CDNS_PHY_DLY_SD_HS
>
>
> > > +#define REG_DELAY_DEFAULT      0x01
>
>
> This is the same as SDHCI_CDNS_PHY_DLY_SD_DEFAULT
>
>
>
> > > +#define REG_DELAY_UHSI_SDR50   0x04
>
> This is the same as SDHCI_CDNS_PHY_DLY_UHS_SDR50
>
>
>
> > > +#define REG_DELAY_UHSI_DDR50   0x05
>
>
> This is the same as SDHCI_CDNS_PHY_DLY_UHS_DDR50
>

All of those redundant definitions are gone, I'm now using the
existing definitions you're identifying.

> > > +
> > > +static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
> > > +{
> > > +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&priv->wrlock, flags);
> > > +       writel(0x78, priv->ctl_addr);
> > > +       writel(val, host->ioaddr + reg);
> > > +       spin_unlock_irqrestore(&priv->wrlock, flags);
> > > +}
[...]
> > > +static void elba_priv_write_l(struct sdhci_cdns_priv *priv,
> > > +               u32 val, void __iomem *reg)
> > > +{
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&priv->wrlock, flags);
> > > +       writel(0x78, priv->ctl_addr);
> > > +       writel(val, reg);
> > > +       spin_unlock_irqrestore(&priv->wrlock, flags);
> > > +}
>
>
> Maybe, can this avoid code duplication?
>
> static void elba_hrs_write_l(struct sdhci_cdns_priv *priv,
>                               u32 val, int reg)
> {
>         unsigned long flags;
>
>         spin_lock_irqsave(&priv->wrlock, flags);
>         writel(0x78, priv->ctl_addr);
>         writel(val, priv->hrs_addr + reg);
>         spin_unlock_irqrestore(&priv->wrlock, flags);
> }
>
> static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
> {
>         elba_hrs_write_l(sdhci_cdns_priv(host), val, SDHCI_CDNS_SRS_BASE + reg);
> }

Yes, some code can be reduced.   This is the current implementation I
propose to include with the v3 patchset

/*
 * The Pensando Elba SoC explicitly controls byte-lane enables on writes
 * which includes writes to the HRS registers.
 */
static void elba_priv_write_l(struct sdhci_cdns_priv *priv, u32 val,
                              void __iomem *reg)
{
        unsigned long flags;

        spin_lock_irqsave(&priv->wrlock, flags);
        writel(0x78, priv->ctl_addr);
        writel(val, reg);
        spin_unlock_irqrestore(&priv->wrlock, flags);
}

static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
{
        elba_priv_write_l(sdhci_cdns_priv(host), val, host->ioaddr + reg);
}

> > > +static void sd4_set_dlyvr(struct sdhci_host *host,
> > > +                         unsigned char addr, unsigned char data)
> >
> > Please, try to think of a better function name that's more
> > descriptive. Moreover, please use a common prefix for functions that
> > is used on elba.

This function is removed and the existing sdhci_cdns_phy_init() is
used with DT properties

> > > +{
> > > +       unsigned long dlyrv_reg;
> > > +
> > > +       dlyrv_reg = ((unsigned long)data << 8);
> > > +       dlyrv_reg |= addr;
> > > +
> > > +       // set data and address
> > > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > > +       dlyrv_reg |= (1uL << 24uL);
> > > +       // send write request
> > > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > > +       dlyrv_reg &= ~(1uL << 24);
> > > +       // clear write request
> > > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
>
>
> This seems to be equivalent to sdhci_cdns_write_phy_reg().

Yes after looking at the implementation it is, there was nothing
special required for Elba.  I've refactored and the function
sdhci_cdns_write_phy_reg() which is used in sdhci_cdns_phy_init()
dependent on DT properties is now used for Elba phy init.

> > > +static void phy_config(struct sdhci_host *host)
> >
> > Ditto.
> >
> > > +{
> > > +       sd4_set_dlyvr(host, REG_DELAY_DEFAULT, 0x04);
> > > +       sd4_set_dlyvr(host, REG_DELAY_HS, 0x04);
> > > +       sd4_set_dlyvr(host, REG_DELAY_UHSI_SDR50, 0x06);
> > > +       sd4_set_dlyvr(host, REG_DELAY_UHSI_DDR50, 0x16);
>
>
> Hard-code board (or chip) specific parameters to the driver?
>
> This should go to DT properties.
>
> See Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml

Exactly, v3 of the patchset will incorporate this recommendation.  In
the case of Elba SoC these are the DT properties being used

cdns,phy-input-delay-sd-highspeed = <0x4>;
cdns,phy-input-delay-legacy = <0x4>;
cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;

> > > +static int elba_drv_init(struct platform_device *pdev)
> > > +{
> > > +       struct sdhci_host *host = platform_get_drvdata(pdev);
> > > +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > > +       struct resource *iomem;
> > > +       void __iomem *ioaddr;
> > > +
> > > +       host->mmc->caps |= (MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA);
> > > +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > +       if (!iomem)
> > > +               return -ENOMEM;
> > > +       ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> > > +       if (IS_ERR(ioaddr))
> > > +               return PTR_ERR(ioaddr);
>
>
>
> Use  devm_platform_ioremap_resource(pdev, 1)

Replaced devm_ioremap_resource(&pdev->dev, iomem) with
devm_platform_ioremap_resource(pdev, 1).  The change will be in v3 of
the patchset.

Regards,
Brad
