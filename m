Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC93C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9BA61361
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhHWB3o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhHWB3o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:29:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73DC061756
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:29:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d6so23731057edt.7
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BtvawLEnJf8O5cokIhNT5nFsov3wP2QeJLoIv+uSf4=;
        b=K1nkmuGKqLA0aGjTbz07dhlbn7RWVJq4WBXLQX2JCuT9rsK9BTLOrAiTkDQ5oFa8H/
         uPelwFv6eEpsgr1bTGCjE70zNekrDAQgijV/ZCh2gb5REGok0hQ01OvBRHzUoielnT4m
         nW2yquEyQMPWjmFJZU4+PQt13zOW1jdrHtq2wE+dYIro1LlNEjsqQAbA+DU7L8V+mARg
         0+K+57oie//uSvJcKFvNQFJxMzIWG5erO97hOaOIBMf7WC2wZixPblkYzSFsu+fkEPX9
         /pVAw0vm1sVLHejh3r1Zf5qMfUCL5Iz6nBvY+BRhjgd7+mhqJiWg3d5nO6KIsyALlzUH
         4eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BtvawLEnJf8O5cokIhNT5nFsov3wP2QeJLoIv+uSf4=;
        b=dqrVaMJpbnmBTp0mySAYmK0Z28Ged7jCkI7xdKGS6VzaksUA93S13awXtD5Mjkf9me
         pg8MIlUe80hgJ5bJEV9vD3HmcAUB6pfebyo1Wrs+wLGBsGh9ozqocfjtW4dawl5CAWh2
         3thWZ2VGhObx4LOiaKllqq3UV7cf8n2a/A0SZ+cQavPICe6rMYYhIQ13c/5ZocM7eTwE
         vJ3KOYu1gkjb+9P29PwpA5fv6nF75TjpvKkCNbvGLDR09nhtAJXwIgv33ZM2QgewxPTI
         kC8es1OjiQ56sZ0jmVrYXmH4q5Bhjnp33Z2b9IMM7HkqcsetZtJlnGrM85eYg69fwq8z
         gouA==
X-Gm-Message-State: AOAM533HirQjUE+jZPvrAhDc1H70/oKbNaJ7UYe6G4XbYzdoDpx8QFjx
        BSr4l9doZ6kQ5PKJ+3hlKwo3IT6PfQWGZpMZYKVTSQ==
X-Google-Smtp-Source: ABdhPJz07adYOV4gu6aRGlpnuW6jXKZWFcHQ9cxUUHnNNMaXPpLkqLvWStXZRcuB70kgNSPxEjdlRwGkZUO+5RGMy+Y=
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr35021340edb.268.1629682141082;
 Sun, 22 Aug 2021 18:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-6-brad@pensando.io>
 <CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwnAzAan5p7w@mail.gmail.com>
In-Reply-To: <CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwnAzAan5p7w@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:28:50 -0700
Message-ID: <CAK9rFnwBGV=J+duhoFkX4Npr+fbf-EyP0UnhzMVGfJr77f=KFw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe,

On Tue, Mar 30, 2021 at 3:31 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Masahiro Yamada (main author of the driver)
>
> On Mon, 29 Mar 2021 at 03:59, Brad Larson <brad@pensando.io> wrote:
> >
> > Add support for Pensando Elba SoC which explicitly controls
> > byte-lane enables on writes.  Refactor to allow platform
> > specific write ops.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> >  drivers/mmc/host/Kconfig              |  15 +++
> >  drivers/mmc/host/Makefile             |   1 +
> >  drivers/mmc/host/sdhci-cadence-elba.c | 137 ++++++++++++++++++++++++++
>
> By looking at the amount of code changes that seem to be needed to
> support the Pensando Elba variant, I don't think it's necessary to
> split this into a separate file.
>
> Unless Yamada-san has a different opinion, I would rather just stick
> with using sdhci-cadence.c.

Yamada-san agreed with the recommendation.  This is a summary of the
changes for the updated patchset based upon all the review comments.

- Add Elba support into sdhci-cadence.c
- Removes new files sdhci-cadence-elba.c and sdhci-cadence.h.
- Remove Kconfig option MMC_SDHCI_CADENCE_ELBA
- Use the existing SDHCI_CDNS_* register defines
- Prefixed the remaining Elba SoC specific functions with elba_
- Use C Comment syntax
- The Elba specific phy init code is removed and the existing
sdhci_cdns_phy_init() is used for these Elba properties set in the DT

cdns,phy-input-delay-sd-highspeed = <0x4>;
cdns,phy-input-delay-legacy = <0x4>;
cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;

> > +config MMC_SDHCI_CADENCE_ELBA
> > +       tristate "SDHCI support for the Pensando/Cadence SD/SDIO/eMMC controller"
> > +       depends on ARCH_PENSANDO_ELBA_SOC
> > +       depends on MMC_SDHCI
> > +       depends on OF
> > +       depends on MMC_SDHCI_CADENCE
> > +       depends on MMC_SDHCI_PLTFM
> > +       select MMC_SDHCI_IO_ACCESSORS
>
> According to the comment above - then you should probably just extend
> the conditions for when building MMC_SDHCI_CADENCE, rather than having
> to add a new Kconfig for "*_ELBA".

Yes, config MMC_SDHCI_CADENCE_ELBA is removed.  Elba support is
enabled with CONFIG_MMC_SDHCI_CADENCE.

> > +// delay regs address
>
> Please don't use "//" when adding comments, but instead "/* ... */".
> This applies to several more places of the patch.
>

Only C syntax is now used for comments.

> > +static void sd4_set_dlyvr(struct sdhci_host *host,
> > +                         unsigned char addr, unsigned char data)
>
> Please, try to think of a better function name that's more
> descriptive. Moreover, please use a common prefix for functions that
> is used on elba.

The Elba specific functions such as sd4_set_dlyvr() are deleted and
the existing sdhci_cdns_phy_init() with DT properties are used for PHY
init.  The remaining Elba specific functions have the prefix elba_

> > +{
> > +       unsigned long dlyrv_reg;
> > +
> > +       dlyrv_reg = ((unsigned long)data << 8);
> > +       dlyrv_reg |= addr;
> > +
> > +       // set data and address
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +       dlyrv_reg |= (1uL << 24uL);
> > +       // send write request
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +       dlyrv_reg &= ~(1uL << 24);
> > +       // clear write request
> > +       writel(dlyrv_reg, host->ioaddr + SDIO_REG_HRS4);
> > +}
> > +
> > +static void phy_config(struct sdhci_host *host)
>
> Ditto.

Yes, C syntax only.  Refactored to use existing sdhci_cdns_phy_init()
and removed phy_config().

> > @@ -453,8 +444,14 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
> >  static const struct of_device_id sdhci_cdns_match[] = {
> >         {
> >                 .compatible = "socionext,uniphier-sd4hc",
> > -               .data = &sdhci_cdns_uniphier_pltfm_data,
> > +               .data = &sdhci_cdns_uniphier_drv_data,
> >         },
> > +#ifdef CONFIG_MMC_SDHCI_CADENCE_ELBA
>
> No need to hide this minor piece of code behind ifdefs.

No longer hidden by an ifdef, the config option
CONFIG_MMC_SDHCI_CADENCE_ELBA is gone.

> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-cadence.h
>
> This new header file can go away too, if you fold in all the code in
> the common c-file.

Exactly, the added file sdhci-cadence.h is gone.

Regards,
Brad
