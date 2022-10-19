Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C8C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 18:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJSSQh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJSSQg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 14:16:36 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763271669A7
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 11:16:35 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k67so1250114vsk.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfqaWFlWX03qJjtXLatVr0AX1rxrTcKQJrK9OFei/b4=;
        b=DaMK+okJkhTqXO0tCHUo2PGaEoIoLwmvBLK++ag/DlJYkkcWzc5QW1vlV7mIE4YGyl
         4Si9nq3pHOrzFQPyQOlEIEuyeftKo9fg/wwopYyXUoMoJ38lBaJIadjxMobcVwUhLoW4
         tZ/R7LG1MoOWWGCv899vlYQsGbcV/11Q3LUfFCYUvm6oM3pbusgKbV5BkID3GLx/ypQm
         eHpX2XNY6WBI1kwbEx+kVNYW6FxYTkpuURAwOi7Cl4X3KvGYTDm7hmuDS9pewX8BOpTR
         t9t3I4M0tzovvViRCzsFSsLBicmjyNN2BgUkxRP5e2+o10FAd4UnburFpltk4RQlU9J6
         WqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfqaWFlWX03qJjtXLatVr0AX1rxrTcKQJrK9OFei/b4=;
        b=WdBgsLt0iIpSMEdiGG2P3rU5Liz8NZcH85LSmpWJZikv58pWwcUyLLVUZT2X6kRBGy
         ZkhAMyXCTZtpX0WA86bTFebc345+9OQnKTJg4hDb19BYe1eRM6giDiNoS4odRTGbNDPL
         BCnTvW96jGRUKRexHqqwxrwdJRUhcCHeuB+HwbcYLpA5JZZM2ZPtjy+sIY1x16nF9jS9
         ZUD4ZyjWNK+KpGkw4H5nxOZaquXCZl4x5upEuaZ8M+MUw1VRbfVrGc5BaoXLnAAC9PvP
         WCYBqftB1zsnyS/K2HWjf1zidv/fQtN1ERqGLcy0jyzMfozHN+8nO3SpbhnyOEHLHSFv
         WqXg==
X-Gm-Message-State: ACrzQf0VG8Nz1XshUbBtIhh7QkrP4eOOND3fPCcK+8madxPvutHuTl/C
        QX909ZBhYCHc5zVuXK2pm76LQWPwB5c1m2o1QhlBZw==
X-Google-Smtp-Source: AMsMyM6zjb9LpkQkKbRcSiTaG9pbmECJJ2b9kgB//3kBqfIGYtIgxYJ2EeGD/OFPsFmQnygUlgV1hfoPe9bQlNC4auA=
X-Received: by 2002:a67:f342:0:b0:38c:8b81:629f with SMTP id
 p2-20020a67f342000000b0038c8b81629fmr4924691vsm.60.1666203394333; Wed, 19 Oct
 2022 11:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221013210017.3751025-1-ptf@google.com> <CAPDyKFoWy883VqnA8Qmk8OvP2FAQKALys41yDab+YQhs29Y63A@mail.gmail.com>
In-Reply-To: <CAPDyKFoWy883VqnA8Qmk8OvP2FAQKALys41yDab+YQhs29Y63A@mail.gmail.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Wed, 19 Oct 2022 14:16:26 -0400
Message-ID: <CAJs+hrHDjX7csdZouuT75y=k=aiSezTkYEDTM2wk-fMpvLfgMQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on
 Jasper Lake
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC Development <linux-mmc@vger.kernel.org>,
        Sangwhan Moon <sxm@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thank you Ulf,

Are there any actions that I need to take?

Best,
Patrick

On Fri, Oct 14, 2022 at 10:08 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 Oct 2022 at 23:00, Patrick Thompson <ptf@google.com> wrote:
> >
> > Enhanced Strobe (ES) does not work correctly on the ASUS 1100 series of
> > devices. Jasper Lake eMMCs (pci_id 8086:4dc4) are supposed to support
> > ES. There are also two system families under the series, thus this is
> > being scoped to the ASUS BIOS.
> >
> > The failing ES prevents the installer from writing to disk. Falling back
> > to HS400 without ES fixes the issue.
> >
> > Signed-off-by: Patrick Thompson <ptf@google.com>
> >
> > Fixes: 315e3bd7ac19 ("mmc: sdhci-pci: Add support for Intel JSL")
>
> Applied for fixes and by adding a stable tag, thanks!
>
> Kind regards
> Uffe
>
>
> >
> > ---
> >
> > Changes in v3:
> > * Remove redundant MMC_CAP2_HS400 selection
> >
> > Changes in v2:
> > * Only disable ES instead of CQE in its entirety.
> > * Target Jasper Lake (JSL)
> > * Target ASUS BIOS instead of specific system family
> >
> >  drivers/mmc/host/sdhci-pci-core.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 169b84761041..34ea1acbb3cc 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -914,6 +914,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
> >                 dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> >  }
> >
> > +static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
> > +{
> > +       return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_JSL_EMMC &&
> > +                       dmi_match(DMI_BIOS_VENDOR, "ASUSTeK COMPUTER INC.");
> > +}
> > +
> >  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
> >  {
> >         int ret = byt_emmc_probe_slot(slot);
> > @@ -922,9 +928,11 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
> >                 slot->host->mmc->caps2 |= MMC_CAP2_CQE;
> >
> >         if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> > -               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> > -               slot->host->mmc_host_ops.hs400_enhanced_strobe =
> > -                                               intel_hs400_enhanced_strobe;
> > +               if (!jsl_broken_hs400es(slot)) {
> > +                       slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> > +                       slot->host->mmc_host_ops.hs400_enhanced_strobe =
> > +                                                       intel_hs400_enhanced_strobe;
> > +               }
> >                 slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> >         }
> >
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
