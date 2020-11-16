Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD864C55ABD
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 09:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B1E22240
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 09:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="zEzb5bQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgKPIoX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKPIoX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2020 03:44:23 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DADC0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2020 00:44:22 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 3so12369615qtx.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2020 00:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bGDA2iyrWlf7GxxIWXRZ5/8g9v50uS/klzTQeEtd2ew=;
        b=zEzb5bQKllh3ZOCn1PMn/zkna/E82FCzsQTtuO979G00nYcla023bH8OpmNIKvmoOQ
         HtQFucwQnJrK8ciy0XsEM5uwoZG+8oDfvy8ECbSJ0dW7VdZk1lwQp8CoEAQWZJn2y1tV
         0gV8UKC5gMTFzf/iNEKNuEI4Ug1ItlFisblYMMpz7mQwhXWb2p4Xma40oY3ukZde/Hzq
         Dv8XN7+JhpnEZYbbopr2ylFE3MIDM5tkoej+Cxlv+JNnIm+Ae5lx541giz9OiNEAjhPJ
         1KvhXsLXZeaNwPdyK089v8AXQiioc8kC+KMz75y8MQtrsHTwT3v6a3ZBz7jOcKBN6AxM
         JOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bGDA2iyrWlf7GxxIWXRZ5/8g9v50uS/klzTQeEtd2ew=;
        b=LGatXPgp8GssEGTHpUbDrDSEiiiJ/pnPxxFKhseepng5fDHV9tZVz/ElxdmcM9me1V
         E9TtbNvh2G/q0WU4wnqMsrZg62unr2H071UVRKFtQNishzcAEVFFuDYrpAJ1qbeJW40N
         pGYEhGTH1egzDUh3Q8QueI9h1I5i3hg66BrwOyDrYRCKwogWyySz0sYpN3SZ2hX9pn42
         GYO6FDQlkIV7uxoODYeLTJ/bB7xN3Gw76JNqgKCiACNNC74TgEqBeEGQKf2TGbKc+yX7
         GzizoVrR+zKqmXtBlLKdOpyY2GoyXb4SEOjDsA/mQZXJ/Hza52ciRMgZNokNeHfEku46
         v9yw==
X-Gm-Message-State: AOAM530qqizOrdGGl+G6vROLC9JQkYM4zyWHe8HExV4UN0AV04+L+6JB
        DpNAOvaQfiSBeHvRcVgU593ZXalY3/0xc+cAZz4FDQ==
X-Google-Smtp-Source: ABdhPJyCYaedjd2PKsmvin+grVsIxyp15U8VgaqjiJ114urP17UTGtbMPWQrv/AGMcSkhy8GNyQc1dREWsz/2A/eUXw=
X-Received: by 2002:ac8:5c50:: with SMTP id j16mr13205674qtj.306.1605516261071;
 Mon, 16 Nov 2020 00:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20201114090811.19356-1-mw@semihalf.com> <d7f579f8-30c6-aafa-4c2d-098ec72bba0a@intel.com>
In-Reply-To: <d7f579f8-30c6-aafa-4c2d-098ec72bba0a@intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 16 Nov 2020 09:44:10 +0100
Message-ID: <CAPv3WKdSPXNDtjNX27Qo9yPEd9gLe_uT-n=iA7OBBNdttr5P4A@mail.gmail.com>
Subject: Re: [PATCH] mmc: xenon: enable ACPI support in the driver
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ziji Hu <huziji@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,


niedz., 15 lis 2020 o 21:43 Adrian Hunter <adrian.hunter@intel.com> napisa=
=C5=82(a):
>
> On 14/11/20 11:08 am, Marcin Wojtas wrote:
> > This patch introduces an alternative way of obtaining resources - via
> > ACPI tables provided by firmware. In addition to the of_* -> device_*
> > API replacement, sdhci_xenon_acpi_match table was introduced.
> > Also, the entire supply clocks configuration had to be skipped,
> > because in case of ACPI it is firmware responsibility to enable them.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> Seems fine, but maybe split into 3 patches:
> 1. of_property -> device_property changes and renaming
> 2. clock changes (if it seems neater, maybe try to simplify to 2 new
> functions: one to prepare clocks and one to unprepare clocks)
> 3. add ACPI device id
>

Sure, will do.

Thanks,
Marcin

> > ---
> > Hi,
> >
> > In case anyone would like to test the patch, I share the EDK2
> > firmware for MacchiatoBin board, which has relevant ACPI
> > description https://drive.google.com/file/d/1ygdHGl30ww9LAqZAQlTsz2nnhN=
3Od9GG
> >
> > Looking forward to your feedback.
> >
> > Best regards,
> > Marcin
> >
> >  drivers/mmc/host/sdhci-xenon.h     |   4 +-
> >  drivers/mmc/host/sdhci-xenon-phy.c |  36 ++++---
> >  drivers/mmc/host/sdhci-xenon.c     | 109 +++++++++++++-------
> >  3 files changed, 91 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xe=
non.h
> > index 593b82d7b68a..542b6ad35ff3 100644
> > --- a/drivers/mmc/host/sdhci-xenon.h
> > +++ b/drivers/mmc/host/sdhci-xenon.h
> > @@ -93,8 +93,8 @@ struct xenon_priv {
> >  };
> >
> >  int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
> > -int xenon_phy_parse_dt(struct device_node *np,
> > -                    struct sdhci_host *host);
> > +int xenon_phy_parse_params(struct device *dev,
> > +                        struct sdhci_host *host);
> >  void xenon_soc_pad_ctrl(struct sdhci_host *host,
> >                       unsigned char signal_voltage);
> >  #endif
> > diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhc=
i-xenon-phy.c
> > index 03ce57ef4585..a6df95ec31c5 100644
> > --- a/drivers/mmc/host/sdhci-xenon-phy.c
> > +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> > @@ -689,35 +689,37 @@ static int get_dt_pad_ctrl_data(struct sdhci_host=
 *host,
> >       return ret;
> >  }
> >
> > -static int xenon_emmc_phy_parse_param_dt(struct sdhci_host *host,
> > -                                      struct device_node *np,
> > -                                      struct xenon_emmc_phy_params *pa=
rams)
> > +static int xenon_emmc_phy_parse_params(struct sdhci_host *host,
> > +                                    struct device *dev,
> > +                                    struct xenon_emmc_phy_params *para=
ms)
> >  {
> >       u32 value;
> >
> >       params->slow_mode =3D false;
> > -     if (of_property_read_bool(np, "marvell,xenon-phy-slow-mode"))
> > +     if (device_property_read_bool(dev, "marvell,xenon-phy-slow-mode")=
)
> >               params->slow_mode =3D true;
> >
> >       params->znr =3D XENON_ZNR_DEF_VALUE;
> > -     if (!of_property_read_u32(np, "marvell,xenon-phy-znr", &value))
> > +     if (!device_property_read_u32(dev, "marvell,xenon-phy-znr", &valu=
e))
> >               params->znr =3D value & XENON_ZNR_MASK;
> >
> >       params->zpr =3D XENON_ZPR_DEF_VALUE;
> > -     if (!of_property_read_u32(np, "marvell,xenon-phy-zpr", &value))
> > +     if (!device_property_read_u32(dev, "marvell,xenon-phy-zpr", &valu=
e))
> >               params->zpr =3D value & XENON_ZPR_MASK;
> >
> >       params->nr_tun_times =3D XENON_TUN_CONSECUTIVE_TIMES;
> > -     if (!of_property_read_u32(np, "marvell,xenon-phy-nr-success-tun",
> > -                               &value))
> > +     if (!device_property_read_u32(dev, "marvell,xenon-phy-nr-success-=
tun",
> > +                                   &value))
> >               params->nr_tun_times =3D value & XENON_TUN_CONSECUTIVE_TI=
MES_MASK;
> >
> >       params->tun_step_divider =3D XENON_TUNING_STEP_DIVIDER;
> > -     if (!of_property_read_u32(np, "marvell,xenon-phy-tun-step-divider=
",
> > -                               &value))
> > +     if (!device_property_read_u32(dev, "marvell,xenon-phy-tun-step-di=
vider",
> > +                                   &value))
> >               params->tun_step_divider =3D value & 0xFF;
> >
> > -     return get_dt_pad_ctrl_data(host, np, params);
> > +     if (dev->of_node)
> > +             return get_dt_pad_ctrl_data(host, dev->of_node, params);
> > +     return 0;
> >  }
> >
> >  /* Set SoC PHY Voltage PAD */
> > @@ -811,7 +813,7 @@ int xenon_phy_adj(struct sdhci_host *host, struct m=
mc_ios *ios)
> >       return ret;
> >  }
> >
> > -static int xenon_add_phy(struct device_node *np, struct sdhci_host *ho=
st,
> > +static int xenon_add_phy(struct device *dev, struct sdhci_host *host,
> >                        const char *phy_name)
> >  {
> >       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > @@ -830,15 +832,15 @@ static int xenon_add_phy(struct device_node *np, =
struct sdhci_host *host,
> >       if (ret)
> >               return ret;
> >
> > -     return xenon_emmc_phy_parse_param_dt(host, np, priv->phy_params);
> > +     return xenon_emmc_phy_parse_params(host, dev, priv->phy_params);
> >  }
> >
> > -int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host=
)
> > +int xenon_phy_parse_params(struct device *dev, struct sdhci_host *host=
)
> >  {
> >       const char *phy_type =3D NULL;
> >
> > -     if (!of_property_read_string(np, "marvell,xenon-phy-type", &phy_t=
ype))
> > -             return xenon_add_phy(np, host, phy_type);
> > +     if (!device_property_read_string(dev, "marvell,xenon-phy-type", &=
phy_type))
> > +             return xenon_add_phy(dev, host, phy_type);
> >
> > -     return xenon_add_phy(np, host, "emmc 5.1 phy");
> > +     return xenon_add_phy(dev, host, "emmc 5.1 phy");
> >  }
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xe=
non.c
> > index 24c978de2a3f..f2990e474e58 100644
> > --- a/drivers/mmc/host/sdhci-xenon.c
> > +++ b/drivers/mmc/host/sdhci-xenon.c
> > @@ -11,6 +11,7 @@
> >   * Special thanks to Video BG4 project team.
> >   */
> >
> > +#include <linux/acpi.h>
> >  #include <linux/delay.h>
> >  #include <linux/ktime.h>
> >  #include <linux/module.h>
> > @@ -247,6 +248,16 @@ static void xenon_voltage_switch(struct sdhci_host=
 *host)
> >       sdhci_readw(host, SDHCI_HOST_CONTROL2);
> >  }
> >
> > +static unsigned int xenon_get_max_clock(struct sdhci_host *host)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +
> > +     if (pltfm_host->clk)
> > +             return sdhci_pltfm_clk_get_max_clock(host);
> > +     else
> > +             return pltfm_host->clock;
> > +}
> > +
> >  static const struct sdhci_ops sdhci_xenon_ops =3D {
> >       .voltage_switch         =3D xenon_voltage_switch,
> >       .set_clock              =3D sdhci_set_clock,
> > @@ -254,7 +265,7 @@ static const struct sdhci_ops sdhci_xenon_ops =3D {
> >       .set_bus_width          =3D sdhci_set_bus_width,
> >       .reset                  =3D xenon_reset,
> >       .set_uhs_signaling      =3D xenon_set_uhs_signaling,
> > -     .get_max_clock          =3D sdhci_pltfm_clk_get_max_clock,
> > +     .get_max_clock          =3D xenon_get_max_clock,
> >  };
> >
> >  static const struct sdhci_pltfm_data sdhci_xenon_pdata =3D {
> > @@ -407,9 +418,9 @@ static void xenon_replace_mmc_host_ops(struct sdhci=
_host *host)
> >   *       Refer to XENON_SYS_CFG_INFO register
> >   * tun-count: the interval between re-tuning
> >   */
> > -static int xenon_probe_dt(struct platform_device *pdev)
> > +static int xenon_probe_params(struct platform_device *pdev)
> >  {
> > -     struct device_node *np =3D pdev->dev.of_node;
> > +     struct device *dev =3D &pdev->dev;
> >       struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >       struct mmc_host *mmc =3D host->mmc;
> >       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > @@ -418,11 +429,12 @@ static int xenon_probe_dt(struct platform_device =
*pdev)
> >       u32 tuning_count;
> >
> >       /* Disable HS200 on Armada AP806 */
> > -     if (of_device_is_compatible(np, "marvell,armada-ap806-sdhci"))
> > +     if (device_property_match_string(dev, "compatible",
> > +                                      "marvell,armada-ap806-sdhci") >=
=3D 0)
> >               host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_HS200;
> >
> >       sdhc_id =3D 0x0;
> > -     if (!of_property_read_u32(np, "marvell,xenon-sdhc-id", &sdhc_id))=
 {
> > +     if (!device_property_read_u32(dev, "marvell,xenon-sdhc-id", &sdhc=
_id)) {
> >               nr_sdhc =3D sdhci_readl(host, XENON_SYS_CFG_INFO);
> >               nr_sdhc &=3D XENON_NR_SUPPORTED_SLOT_MASK;
> >               if (unlikely(sdhc_id > nr_sdhc)) {
> > @@ -434,8 +446,8 @@ static int xenon_probe_dt(struct platform_device *p=
dev)
> >       priv->sdhc_id =3D sdhc_id;
> >
> >       tuning_count =3D XENON_DEF_TUNING_COUNT;
> > -     if (!of_property_read_u32(np, "marvell,xenon-tun-count",
> > -                               &tuning_count)) {
> > +     if (!device_property_read_u32(dev, "marvell,xenon-tun-count",
> > +                                   &tuning_count)) {
> >               if (unlikely(tuning_count >=3D XENON_TMR_RETUN_NO_PRESENT=
)) {
> >                       dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set=
 default value %d\n",
> >                               XENON_DEF_TUNING_COUNT);
> > @@ -444,7 +456,7 @@ static int xenon_probe_dt(struct platform_device *p=
dev)
> >       }
> >       priv->tuning_count =3D tuning_count;
> >
> > -     return xenon_phy_parse_dt(np, host);
> > +     return xenon_phy_parse_params(dev, host);
> >  }
> >
> >  static int xenon_sdhc_prepare(struct sdhci_host *host)
> > @@ -483,6 +495,7 @@ static void xenon_sdhc_unprepare(struct sdhci_host =
*host)
> >  static int xenon_probe(struct platform_device *pdev)
> >  {
> >       struct sdhci_pltfm_host *pltfm_host;
> > +     struct device *dev =3D &pdev->dev;
> >       struct sdhci_host *host;
> >       struct xenon_priv *priv;
> >       int err;
> > @@ -501,37 +514,39 @@ static int xenon_probe(struct platform_device *pd=
ev)
> >        */
> >       xenon_replace_mmc_host_ops(host);
> >
> > -     pltfm_host->clk =3D devm_clk_get(&pdev->dev, "core");
> > -     if (IS_ERR(pltfm_host->clk)) {
> > -             err =3D PTR_ERR(pltfm_host->clk);
> > -             dev_err(&pdev->dev, "Failed to setup input clk: %d\n", er=
r);
> > -             goto free_pltfm;
> > -     }
> > -     err =3D clk_prepare_enable(pltfm_host->clk);
> > -     if (err)
> > -             goto free_pltfm;
> > -
> > -     priv->axi_clk =3D devm_clk_get(&pdev->dev, "axi");
> > -     if (IS_ERR(priv->axi_clk)) {
> > -             err =3D PTR_ERR(priv->axi_clk);
> > -             if (err =3D=3D -EPROBE_DEFER)
> > -                     goto err_clk;
> > -     } else {
> > -             err =3D clk_prepare_enable(priv->axi_clk);
> > +     if (dev->of_node) {
> > +             pltfm_host->clk =3D devm_clk_get(&pdev->dev, "core");
> > +             if (IS_ERR(pltfm_host->clk)) {
> > +                     err =3D PTR_ERR(pltfm_host->clk);
> > +                     dev_err(&pdev->dev, "Failed to setup input clk: %=
d\n", err);
> > +                     goto free_pltfm;
> > +             }
> > +             err =3D clk_prepare_enable(pltfm_host->clk);
> >               if (err)
> > -                     goto err_clk;
> > +                     goto free_pltfm;
> > +
> > +             priv->axi_clk =3D devm_clk_get(&pdev->dev, "axi");
> > +             if (IS_ERR(priv->axi_clk)) {
> > +                     err =3D PTR_ERR(priv->axi_clk);
> > +                     if (err =3D=3D -EPROBE_DEFER)
> > +                             goto err_clk;
> > +             } else {
> > +                     err =3D clk_prepare_enable(priv->axi_clk);
> > +                     if (err)
> > +                             goto err_clk;
> > +             }
> >       }
> >
> >       err =3D mmc_of_parse(host->mmc);
> >       if (err)
> >               goto err_clk_axi;
> >
> > -     sdhci_get_of_property(pdev);
> > +     sdhci_get_property(pdev);
> >
> >       xenon_set_acg(host, false);
> >
> > -     /* Xenon specific dt parse */
> > -     err =3D xenon_probe_dt(pdev);
> > +     /* Xenon specific parameters parse */
> > +     err =3D xenon_probe_params(pdev);
> >       if (err)
> >               goto err_clk_axi;
> >
> > @@ -559,9 +574,11 @@ static int xenon_probe(struct platform_device *pde=
v)
> >       pm_runtime_put_noidle(&pdev->dev);
> >       xenon_sdhc_unprepare(host);
> >  err_clk_axi:
> > -     clk_disable_unprepare(priv->axi_clk);
> > +     if (dev->of_node)
> > +             clk_disable_unprepare(priv->axi_clk);
> >  err_clk:
> > -     clk_disable_unprepare(pltfm_host->clk);
> > +     if (dev->of_node)
> > +             clk_disable_unprepare(pltfm_host->clk);
> >  free_pltfm:
> >       sdhci_pltfm_free(pdev);
> >       return err;
> > @@ -572,6 +589,7 @@ static int xenon_remove(struct platform_device *pde=
v)
> >       struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >       struct xenon_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> > +     struct device *dev =3D &pdev->dev;
> >
> >       pm_runtime_get_sync(&pdev->dev);
> >       pm_runtime_disable(&pdev->dev);
> > @@ -580,8 +598,10 @@ static int xenon_remove(struct platform_device *pd=
ev)
> >       sdhci_remove_host(host, 0);
> >
> >       xenon_sdhc_unprepare(host);
> > -     clk_disable_unprepare(priv->axi_clk);
> > -     clk_disable_unprepare(pltfm_host->clk);
> > +     if (dev->of_node) {
> > +             clk_disable_unprepare(priv->axi_clk);
> > +             clk_disable_unprepare(pltfm_host->clk);
> > +     }
> >
> >       sdhci_pltfm_free(pdev);
> >
> > @@ -618,7 +638,8 @@ static int xenon_runtime_suspend(struct device *dev=
)
> >       if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
> >               mmc_retune_needed(host->mmc);
> >
> > -     clk_disable_unprepare(pltfm_host->clk);
> > +     if (dev->of_node)
> > +             clk_disable_unprepare(pltfm_host->clk);
> >       /*
> >        * Need to update the priv->clock here, or when runtime resume
> >        * back, phy don't aware the clock change and won't adjust phy
> > @@ -635,10 +656,12 @@ static int xenon_runtime_resume(struct device *de=
v)
> >       struct xenon_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> >       int ret;
> >
> > -     ret =3D clk_prepare_enable(pltfm_host->clk);
> > -     if (ret) {
> > -             dev_err(dev, "can't enable mainck\n");
> > -             return ret;
> > +     if (dev->of_node) {
> > +             ret =3D clk_prepare_enable(pltfm_host->clk);
> > +             if (ret) {
> > +                     dev_err(dev, "can't enable mainck\n");
> > +                     return ret;
> > +             }
> >       }
> >
> >       if (priv->restore_needed) {
> > @@ -653,7 +676,8 @@ static int xenon_runtime_resume(struct device *dev)
> >               goto out;
> >       return 0;
> >  out:
> > -     clk_disable_unprepare(pltfm_host->clk);
> > +     if (dev->of_node)
> > +             clk_disable_unprepare(pltfm_host->clk);
> >       return ret;
> >  }
> >  #endif /* CONFIG_PM */
> > @@ -674,11 +698,18 @@ static const struct of_device_id sdhci_xenon_dt_i=
ds[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> >
> > +static const struct acpi_device_id sdhci_xenon_acpi_ids[] =3D {
> > +     { .id =3D "MRVL0002",},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, sdhci_xenon_acpi_ids);
> > +
> >  static struct platform_driver sdhci_xenon_driver =3D {
> >       .driver =3D {
> >               .name   =3D "xenon-sdhci",
> >               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> >               .of_match_table =3D sdhci_xenon_dt_ids,
> > +             .acpi_match_table =3D ACPI_PTR(sdhci_xenon_acpi_ids),
> >               .pm =3D &sdhci_xenon_dev_pm_ops,
> >       },
> >       .probe  =3D xenon_probe,
> >
>
