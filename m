Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6115C2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85F82074F
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iu2LC+jH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896475AbgDOKn7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896477AbgDOKXh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 06:23:37 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB75C0610D5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:28 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y15so1886305vsm.5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjEZMO0SU7rIu8lnCDeDsF/aghcVDa3TqsVdoRMbMEE=;
        b=Iu2LC+jHJsIB6vZbtwVzRAfa2cQkr1qZliuN7B1CB4zXFPPDwe6389BCY8Ja757gO3
         l68GmGiTtRlb8f1fUF/0mYUsfNC1wROzXtlhIE3iEmwRmL0jBFp8J4bNS+zxPSUYohuz
         lXkqsxV8CkLEQz+xoxviB6mgVEfI18CHQU9lmMMsdREkwKEtAPXbyjM5kJx4z3PY3dqU
         uAox33zcxIKYCiGaz1oEWbtCgkqdOZZceB95RMK9yeOt+gALZbuEBiia1kHhoakqY8XH
         yBrpyq6EsWsJJj7OpZKpPXLdM1O21iP8I1e+MJ+Gs6m7p3KZW9LvguEUwaJNh/m454c8
         qclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjEZMO0SU7rIu8lnCDeDsF/aghcVDa3TqsVdoRMbMEE=;
        b=VchnhEz3YqwSL4siogFcdZL9ajNflKfxLajTy7VJHQwHK2zYo+RMCxng1yTbrKBJyr
         5g1QwVmNDTbtU20R8PeHT2esI/U5KZSaer8pBtVBpq8/v9kpK+g8/4wDraFg0A7Uk44G
         fCkdRPZsTDe/6D1QZHmsikQcFCSTJ/kcpU5IfFkJEBA3zU0yXmlYVj0DAy/cgEqgj8Gv
         irA65MVEI/XBjvgUmtb15kUmvrLKYivM/+fHzzw9+DZADSFaA2Xpm8dIHCRA+mGBDBU7
         97/w/hoV4MH4qYLb7FKroR5e+CpQtMTo5d+eLTTqHDIM/vc1JydiDVUFlAmGRN62++zl
         osSQ==
X-Gm-Message-State: AGi0PuZkiTkJZTc1aYgdRuoAOv3Ugcjez9u4eMOFslWC5TZ028uzsysU
        djL4qtglKCSg6TjBb9WQiA1LkAaxyWCty9O9httKcQ==
X-Google-Smtp-Source: APiQypILzw+Mgfa0IPeRWLq+ed7OhGK1AmhdY/ISSlbVg17eVUjcHARL3Ijh9uyzWw4vScHNgOR0sy1q0m+qUlp2P5Y=
X-Received: by 2002:a67:11c4:: with SMTP id 187mr3793955vsr.34.1586946147163;
 Wed, 15 Apr 2020 03:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200408072105.422-1-yamada.masahiro@socionext.com>
 <20200408072105.422-2-yamada.masahiro@socionext.com> <3cc8c9b8-b957-2fef-d6da-47980d1926aa@intel.com>
In-Reply-To: <3cc8c9b8-b957-2fef-d6da-47980d1926aa@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 12:21:51 +0200
Message-ID: <CAPDyKFrAWWm=2zG2iBydEjqqWKPYWcwjPP7jOJ=_y_OdFrGocA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: use FIELD_GET/PREP for capabilities bit masks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Apr 2020 at 11:35, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 8/04/20 10:21 am, Masahiro Yamada wrote:
> > Use FIELD_GET and FIELD_PREP to get access to the register fields.
> > Delete the shift macros. I used GENMASK() for touched macros.
>
> That has the side-effect of changing the constants to 64-bit on 64-bit
> platforms, which needs to be mentioned in the commit message.
>
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Apart from above:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, by amending the changelog according to the
suggestion by Adrian.

Kind regards
Uffe


>
> > ---
> >
> >  drivers/mmc/host/sdhci-esdhc-imx.c |  4 +++-
> >  drivers/mmc/host/sdhci-of-at91.c   |  5 +++--
> >  drivers/mmc/host/sdhci-pci-core.c  |  8 ++------
> >  drivers/mmc/host/sdhci.c           | 19 +++++++------------
> >  drivers/mmc/host/sdhci.h           | 17 ++++++-----------
> >  5 files changed, 21 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 5ec8e4bf1ac7..38cd83118082 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -8,6 +8,7 @@
> >   *   Author: Wolfram Sang <kernel@pengutronix.de>
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/io.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/delay.h>
> > @@ -399,7 +400,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
> >                               val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
> >                                       | SDHCI_SUPPORT_SDR50
> >                                       | SDHCI_USE_SDR50_TUNING
> > -                                     | (SDHCI_TUNING_MODE_3 << SDHCI_RETUNING_MODE_SHIFT);
> > +                                     | FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
> > +                                                  SDHCI_TUNING_MODE_3);
> >
> >                       if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> >                               val |= SDHCI_SUPPORT_HS400;
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> > index c79bff5e2280..25f4e0f4f53b 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -6,6 +6,7 @@
> >   *            2015 Ludovic Desroches <ludovic.desroches@atmel.com>
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> > @@ -179,9 +180,9 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
> >       clk_mul = gck_rate / clk_base_rate - 1;
> >
> >       caps0 &= ~SDHCI_CLOCK_V3_BASE_MASK;
> > -     caps0 |= (clk_base << SDHCI_CLOCK_BASE_SHIFT) & SDHCI_CLOCK_V3_BASE_MASK;
> > +     caps0 |= FIELD_PREP(SDHCI_CLOCK_V3_BASE_MASK, clk_base);
> >       caps1 &= ~SDHCI_CLOCK_MUL_MASK;
> > -     caps1 |= (clk_mul << SDHCI_CLOCK_MUL_SHIFT) & SDHCI_CLOCK_MUL_MASK;
> > +     caps1 |= FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);
> >       /* Set capabilities in r/w mode. */
> >       writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN, host->ioaddr + SDMMC_CACR);
> >       writel(caps0, host->ioaddr + SDHCI_CAPABILITIES);
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 525de2454a4d..a98c9476bfc8 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -249,12 +249,8 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
> >  static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
> >  {
> >       slot->host->caps =
> > -             ((0x21 << SDHCI_TIMEOUT_CLK_SHIFT)
> > -                     & SDHCI_TIMEOUT_CLK_MASK) |
> > -
> > -             ((0x21 << SDHCI_CLOCK_BASE_SHIFT)
> > -                     & SDHCI_CLOCK_BASE_MASK) |
> > -
> > +             FIELD_PREP(SDHCI_TIMEOUT_CLK_MASK, 0x21) |
> > +             FIELD_PREP(SDHCI_CLOCK_BASE_MASK, 0x21) |
> >               SDHCI_TIMEOUT_CLK_UNIT |
> >               SDHCI_CAN_VDD_330 |
> >               SDHCI_CAN_DO_HISPD |
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 3f716466fcfd..344a7e0e33fe 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -4117,11 +4117,9 @@ int sdhci_setup_host(struct sdhci_host *host)
> >       }
> >
> >       if (host->version >= SDHCI_SPEC_300)
> > -             host->max_clk = (host->caps & SDHCI_CLOCK_V3_BASE_MASK)
> > -                     >> SDHCI_CLOCK_BASE_SHIFT;
> > +             host->max_clk = FIELD_GET(SDHCI_CLOCK_V3_BASE_MASK, host->caps);
> >       else
> > -             host->max_clk = (host->caps & SDHCI_CLOCK_BASE_MASK)
> > -                     >> SDHCI_CLOCK_BASE_SHIFT;
> > +             host->max_clk = FIELD_GET(SDHCI_CLOCK_BASE_MASK, host->caps);
> >
> >       host->max_clk *= 1000000;
> >       if (host->max_clk == 0 || host->quirks &
> > @@ -4139,8 +4137,7 @@ int sdhci_setup_host(struct sdhci_host *host)
> >        * In case of Host Controller v3.00, find out whether clock
> >        * multiplier is supported.
> >        */
> > -     host->clk_mul = (host->caps1 & SDHCI_CLOCK_MUL_MASK) >>
> > -                     SDHCI_CLOCK_MUL_SHIFT;
> > +     host->clk_mul = FIELD_GET(SDHCI_CLOCK_MUL_MASK, host->caps1);
> >
> >       /*
> >        * In case the value in Clock Multiplier is 0, then programmable
> > @@ -4173,8 +4170,7 @@ int sdhci_setup_host(struct sdhci_host *host)
> >               mmc->f_max = max_clk;
> >
> >       if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> > -             host->timeout_clk = (host->caps & SDHCI_TIMEOUT_CLK_MASK) >>
> > -                                     SDHCI_TIMEOUT_CLK_SHIFT;
> > +             host->timeout_clk = FIELD_GET(SDHCI_TIMEOUT_CLK_MASK, host->caps);
> >
> >               if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
> >                       host->timeout_clk *= 1000;
> > @@ -4326,8 +4322,8 @@ int sdhci_setup_host(struct sdhci_host *host)
> >               mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
> >
> >       /* Initial value for re-tuning timer count */
> > -     host->tuning_count = (host->caps1 & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
> > -                          SDHCI_RETUNING_TIMER_COUNT_SHIFT;
> > +     host->tuning_count = FIELD_GET(SDHCI_RETUNING_TIMER_COUNT_MASK,
> > +                                    host->caps1);
> >
> >       /*
> >        * In case Re-tuning Timer is not disabled, the actual value of
> > @@ -4337,8 +4333,7 @@ int sdhci_setup_host(struct sdhci_host *host)
> >               host->tuning_count = 1 << (host->tuning_count - 1);
> >
> >       /* Re-tuning mode supported by the Host Controller */
> > -     host->tuning_mode = (host->caps1 & SDHCI_RETUNING_MODE_MASK) >>
> > -                          SDHCI_RETUNING_MODE_SHIFT;
> > +     host->tuning_mode = FIELD_GET(SDHCI_RETUNING_MODE_MASK, host->caps1);
> >
> >       ocr_avail = 0;
> >
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index b786b68e0302..d7f1441b0fc3 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -200,12 +200,10 @@
> >  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
> >
> >  #define SDHCI_CAPABILITIES   0x40
> > -#define  SDHCI_TIMEOUT_CLK_MASK      0x0000003F
> > -#define  SDHCI_TIMEOUT_CLK_SHIFT 0
> > +#define  SDHCI_TIMEOUT_CLK_MASK              GENMASK(5, 0)
> >  #define  SDHCI_TIMEOUT_CLK_UNIT      0x00000080
> > -#define  SDHCI_CLOCK_BASE_MASK       0x00003F00
> > -#define  SDHCI_CLOCK_V3_BASE_MASK    0x0000FF00
> > -#define  SDHCI_CLOCK_BASE_SHIFT      8
> > +#define  SDHCI_CLOCK_BASE_MASK               GENMASK(13, 8)
> > +#define  SDHCI_CLOCK_V3_BASE_MASK    GENMASK(15, 8)
> >  #define  SDHCI_MAX_BLOCK_MASK        0x00030000
> >  #define  SDHCI_MAX_BLOCK_SHIFT  16
> >  #define  SDHCI_CAN_DO_8BIT   0x00040000
> > @@ -227,13 +225,10 @@
> >  #define  SDHCI_DRIVER_TYPE_A 0x00000010
> >  #define  SDHCI_DRIVER_TYPE_C 0x00000020
> >  #define  SDHCI_DRIVER_TYPE_D 0x00000040
> > -#define  SDHCI_RETUNING_TIMER_COUNT_MASK     0x00000F00
> > -#define  SDHCI_RETUNING_TIMER_COUNT_SHIFT    8
> > +#define  SDHCI_RETUNING_TIMER_COUNT_MASK     GENMASK(11, 8)
> >  #define  SDHCI_USE_SDR50_TUNING                      0x00002000
> > -#define  SDHCI_RETUNING_MODE_MASK            0x0000C000
> > -#define  SDHCI_RETUNING_MODE_SHIFT           14
> > -#define  SDHCI_CLOCK_MUL_MASK        0x00FF0000
> > -#define  SDHCI_CLOCK_MUL_SHIFT       16
> > +#define  SDHCI_RETUNING_MODE_MASK            GENMASK(15, 14)
> > +#define  SDHCI_CLOCK_MUL_MASK                        GENMASK(23, 16)
> >  #define  SDHCI_CAN_DO_ADMA3  0x08000000
> >  #define  SDHCI_SUPPORT_HS400 0x80000000 /* Non-standard */
> >
> >
>
