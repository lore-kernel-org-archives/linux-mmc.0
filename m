Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AACC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Mar 2022 16:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiCNQUs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiCNQUr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2022 12:20:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914912627
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 09:19:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id n19so28067393lfh.8
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsECqUsoFbbzLH0Glzdoc8bZjT2HULO2MIfNHDFqJyA=;
        b=LNjQS6fhFXL6+0Ws1dM0xnINDZ8mmTVQ2RwKMMjOJBPWzeK1YXviahNsjFU/2iejlX
         PBRRO++wNXfwbZmBpH2JA2VRg/oqwY4eGIzvugO2LmcXPYuxTwv9zIg7OGZvL70LGYMM
         7kgHlYifWQhri7stVCGqvSnFL1n27UsH11PWXw5PUdUklMgknPOYHDSLarcQ9p2egX99
         g/yqJlh+Zgw/P1AUcztcZIia35ccQc9IO05H17vsP1iT5MXDFql58WW3rHL2auUr1PgU
         kwlvDuQtjSPFHns2twncXXuCgFSdE4ciGj/e2ZxJ/wG5IeIZSCCY0zeihaDpTO25kNcE
         wDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsECqUsoFbbzLH0Glzdoc8bZjT2HULO2MIfNHDFqJyA=;
        b=5jz1CtezqqJN5GJaoesLNmj54Xyudfl8yH9yQckux5GsRJ042JcK4NI5EJCXm9a55P
         0KBwGQ0t+1J2/j/Rdvn2KDaNhgmDGFDmjzPGM8u4t9aUwdjKYh5YZtbyxM0X9yDk3b1D
         LuXT+XjYCO+ktrw+xU1wkpEGbxue28f4fagh+/fR1MdUi6gxykburFv7b2uMll/k6XV0
         X4ZYZofB+fwYnziuh6gMgf0il67FS2SmvddlCCz7A7qT1Zbw6CEehNAtMgBT1ODhDlAz
         MJehwhvSSuWC+26mtjzHyw1qgvEUQIVtutMas2zmTJizmuj6stAdsMrynT+MK+IxfZia
         vaug==
X-Gm-Message-State: AOAM533h17hhSpQ24Je9ntWZvAIBtr3tg4HIHj6mAQlyFHUmDMiH3Zhq
        FtqcNao3HegAfPO++1EBFWaN+x65qm/9cQjyuiPH1w==
X-Google-Smtp-Source: ABdhPJwk3xNnA6dfC1g0ptmBYgkfInoa7C7kBHyEF0x5FY61Ih07fZy+W0JFH+UDq+hbdLjVNRcSaCjWxMtaZiBArZ4=
X-Received: by 2002:a05:6512:12c4:b0:448:6d12:4434 with SMTP id
 p4-20020a05651212c400b004486d124434mr9966501lfg.71.1647274775103; Mon, 14 Mar
 2022 09:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220314095225.53563-1-yann.gautier@foss.st.com>
 <20220314125554.190574-1-yann.gautier@foss.st.com> <CAPDyKFruN9Xwk4uqFumwBdcn4SjKQcSQVBbALa3kVxY4mVzOnQ@mail.gmail.com>
 <9e4fbf6a-1309-3aee-fcb0-be7c2c683892@foss.st.com>
In-Reply-To: <9e4fbf6a-1309-3aee-fcb0-be7c2c683892@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Mar 2022 17:18:58 +0100
Message-ID: <CAPDyKFq2Du1UWpvRFpVF_qL65SP0DfEV872U9Xe-9i7xKxXhqg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: manage MMC_PM_KEEP_POWER per variant config
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Mar 2022 at 15:34, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 3/14/22 14:03, Ulf Hansson wrote:
> > On Mon, 14 Mar 2022 at 13:56, Yann Gautier <yann.gautier@foss.st.com> wrote:
> >>
> >> Add a disable_keep_power field in variant_data struct. The
> >> MMC_PM_KEEP_POWER flag will be enabled if disable_keep_power is not set.
> >> It is only set to true for stm32_sdmmc variants.
> >>
> >> The issue was seen on STM32MP157C-DK2 board, which embeds a wifi chip.
> >> It doesn't correctly support low power on this board. The Wifi chip
> >> awaits an always-on regulator, but it was connected to v3v3 which is off
> >> in low-power sequence. MMC_PM_KEEP_POWER should then be disabled.
> >
> > Just to make sure I get this correct.
> >
> > Why can't the regulator stay on during system suspend? The point is,
> > we don't need an always on regulator to cope with this.
> >
> > Kind regards
> > Uffe
>
> Hi Ulf,
>
> This v3v3 regulator powers most of the devices on this board. So we need
> to switch it off to gain power in suspend mode.

I see. Thanks for sharing that information.

The MMC_PM_KEEP_POWER flag is there to describe what is supported by
the platform/host. It doesn't mean that the card *must* stay powered
on during system suspend. Instead that depends on whether system
wakeup for the SDIO/WiFi is supported too - and if that is enabled by
userspace. If not, the regulator will be turned off for the SDIO card
during system suspend.

Assuming the regulator is implemented as a proper regulator and can
remain on during system suspend, the right thing would be to keep the
MMC_PM_KEEP_POWER flag around.

Kind regards
Uffe

>
>
> Yann
>
> >
> >>
> >> The flag can still be enabled through DT property:
> >> keep-power-in-suspend.
> >>
> >> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >> ---
> >> Update in v2:
> >> Reword commit message to better explain the issue.
> >>
> >> Resend the patch alone. It was previoulsy in a series [1] for which the
> >> other patches will be reworked.
> >>
> >> [1] https://lore.kernel.org/lkml/20220304135134.47827-1-yann.gautier@foss.st.com/
> >>
> >>   drivers/mmc/host/mmci.c | 5 ++++-
> >>   drivers/mmc/host/mmci.h | 1 +
> >>   2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >> index 45b8608c935c..0e2f2f5d6a52 100644
> >> --- a/drivers/mmc/host/mmci.c
> >> +++ b/drivers/mmc/host/mmci.c
> >> @@ -274,6 +274,7 @@ static struct variant_data variant_stm32_sdmmc = {
> >>          .busy_detect            = true,
> >>          .busy_detect_flag       = MCI_STM32_BUSYD0,
> >>          .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
> >> +       .disable_keep_power     = true,
> >>          .init                   = sdmmc_variant_init,
> >>   };
> >>
> >> @@ -301,6 +302,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
> >>          .busy_detect            = true,
> >>          .busy_detect_flag       = MCI_STM32_BUSYD0,
> >>          .busy_detect_mask       = MCI_STM32_BUSYD0ENDMASK,
> >> +       .disable_keep_power     = true,
> >>          .init                   = sdmmc_variant_init,
> >>   };
> >>
> >> @@ -2172,7 +2174,8 @@ static int mmci_probe(struct amba_device *dev,
> >>          host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
> >>
> >>          /* We support these PM capabilities. */
> >> -       mmc->pm_caps |= MMC_PM_KEEP_POWER;
> >> +       if (!variant->disable_keep_power)
> >> +               mmc->pm_caps |= MMC_PM_KEEP_POWER;
> >>
> >>          /*
> >>           * We can do SGIO
> >> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> >> index e1a9b96a3396..2cad1ef9766a 100644
> >> --- a/drivers/mmc/host/mmci.h
> >> +++ b/drivers/mmc/host/mmci.h
> >> @@ -361,6 +361,7 @@ struct variant_data {
> >>          u32                     opendrain;
> >>          u8                      dma_lli:1;
> >>          u32                     stm32_idmabsize_mask;
> >> +       u8                      disable_keep_power:1;
> >>          void (*init)(struct mmci_host *host);
> >>   };
> >>
> >> --
> >> 2.25.1
> >>
>
