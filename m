Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B0C001E0
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Aug 2023 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHJQfe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjHJQf2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Aug 2023 12:35:28 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54268103
        for <linux-mmc@vger.kernel.org>; Thu, 10 Aug 2023 09:35:27 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d63457dd8b8so1008335276.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Aug 2023 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691685326; x=1692290126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=74qEJA231zY4tMaqWdb1XigDSYeTpJgLMJ4WiPPtkaI=;
        b=AzpMLLNWADt9pLVuk2aS4vZs4c+4Gyc+Tj35Jma7VJmBLf7l0HeZAK9YeNBc4ItPpD
         +IibzODX1noMZAsSpPrw3n0DSu4d/+Nzy7U3pC5Y6C3F9IQY8sC7T4oZ+Ekgz51qa+1F
         iSu6qfbdvPKdON+iJWu/foE7IXUssOjltCo65AE5l6FlCPvSklPwfAMJxT0okGcxZhEC
         V1qSVEc9IauIbU8gNO2d+ImDfiD3vpxMXtF+mTS8aZH0dwTr652XnACzIfmCvCm+h8KU
         sUP5DqK48extErXLRnwnFQ/TT7t8eLKjrsfv+VG/vANRkeqqTsjhDBkF+Nwl8LkLrFQu
         deRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685326; x=1692290126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74qEJA231zY4tMaqWdb1XigDSYeTpJgLMJ4WiPPtkaI=;
        b=H05VP/xJMcc29Wp39Zc83c5atXkeom3WQ/3SdFOXUbp51D0c0XhBs+DwkmH//e9OKv
         tdQKwcFqPf4HEjkwT+OPvm6gWM8zhxSN17kHsDoIfEoDkQfVEArbIE9vw6+ODPImRaPK
         AD/By8uFGs1+xEvbm5iKYliRvYmbJVC1DLXmuPGkCV9oYxrx+DF9hryFyVN8cfArozQY
         y78RpU8Y4yxBflh9kFYgouZ6u28ddWmK7TAGbKXZN68rrQR48A69yu98RF9i+oVFoynm
         eRSA4TlNdv/UghgaJFFUamqN91cFqG+V+XvByZ+mX1z3xkZUgqa/lw5Fu2tSm4umR4we
         stSA==
X-Gm-Message-State: AOJu0YxG+x+w68w8qlXfYc+1N3m+mBKBbnocQSHonY2aTgV8HsrJYfRe
        z8Nsq3hd0oL9uki2/hYFSjecUPcFJokMStddIhoGXyJj4Rwq4+b1
X-Google-Smtp-Source: AGHT+IFjEfxNOINZ1eZeg+cWvWtQQMU3sGcMiUGUyPJ7VZpsKRllF+8Y5K8u+/adUGkCKOECyUWEnLDd2JlQGq0hlYM=
X-Received: by 2002:a25:ab24:0:b0:c11:6638:af3e with SMTP id
 u33-20020a25ab24000000b00c116638af3emr1156504ybi.45.1691685326540; Thu, 10
 Aug 2023 09:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230808202319.191434-1-limings@nvidia.com> <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
 <CAPDyKFp28mmbRAGf14u8KTO3v7H=SFAYbwcz7xeb1m4tD_G2vQ@mail.gmail.com> <a2f6cd0e-8429-3468-9dcf-a5022717e2ae@intel.com>
In-Reply-To: <a2f6cd0e-8429-3468-9dcf-a5022717e2ae@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Aug 2023 18:34:50 +0200
Message-ID: <CAPDyKFqTWMghEAsBdLUF+K4QNEWBozNi3_a7w0+KuuO3x+wkTQ@mail.gmail.com>
Subject: Re: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Aug 2023 at 14:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 10/08/23 13:21, Ulf Hansson wrote:
> > On Thu, 10 Aug 2023 at 10:13, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 8/08/23 23:23, Liming Sun wrote:
> >>> This commit implements the runtime PM operations to disable eMMC
> >>> card clock when idle.
> >>>
> >>> Reviewed-by: David Thompson <davthompson@nvidia.com>
> >>> Signed-off-by: Liming Sun <limings@nvidia.com>
> >>> ---
> >>> v6->v7:
> >>>     - Address Ulf's comment;
> >>> v5->v6:
> >>>     - Address Adrian's more comments and add coordination between
> >>>       runtime PM and system PM;
> >>> v4->v5:
> >>>     - Address Adrian's comment to move the pm_enable to the end to
> >>>       avoid race;
> >>> v3->v4:
> >>>     - Fix compiling reported by 'kernel test robot';
> >>> v2->v3:
> >>>     - Revise the commit message;
> >>> v1->v2:
> >>>     Updates for comments from Ulf:
> >>>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> >>> v1: Initial version.
> >>> ---
> >>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
> >>>  1 file changed, 70 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> index e68cd87998c8..c8e145031429 100644
> >>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> @@ -15,6 +15,7 @@
> >>>  #include <linux/module.h>
> >>>  #include <linux/of.h>
> >>>  #include <linux/of_device.h>
> >>> +#include <linux/pm_runtime.h>
> >>>  #include <linux/reset.h>
> >>>  #include <linux/sizes.h>
> >>>
> >>> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >>>
> >>>       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> >>>
> >>> +     pm_runtime_get_noresume(dev);
> >>> +     pm_runtime_set_active(dev);
> >>> +     pm_runtime_enable(dev);
> >>> +
> >>>       err = sdhci_setup_host(host);
> >>>       if (err)
> >>> -             goto err_clk;
> >>> +             goto err_rpm;
> >>>
> >>>       if (rk_priv)
> >>>               dwcmshc_rk35xx_postinit(host, priv);
> >>> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >>>       if (err)
> >>>               goto err_setup_host;
> >>>
> >>> +     pm_runtime_put(dev);
> >>> +
> >>>       return 0;
> >>>
> >>>  err_setup_host:
> >>>       sdhci_cleanup_host(host);
> >>> +err_rpm:
> >>> +     pm_runtime_disable(dev);
> >>> +     pm_runtime_put_noidle(dev);
> >>>  err_clk:
> >>>       clk_disable_unprepare(pltfm_host->clk);
> >>>       clk_disable_unprepare(priv->bus_clk);
> >>> @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> +     ret = pm_runtime_force_suspend(dev);
> >>> +     if (ret) {
> >>> +             sdhci_resume_host(host);
> >>> +             return ret;
> >>> +     }
> >>
> >> Since you are only using the runtime PM callbacks to turn off the card
> >> clock via SDHCI_CLOCK_CONTROL, pm_runtime_force_suspend() and
> >> pm_runtime_force_resume() are not needed at all.
> >
> > Right, it can be done without these too.
> >
> >>
> >> sdhci_suspend_host() does not care if SDHCI_CLOCK_CARD_EN is on or off.
> >> (And you are disabling pltfm_host->clk and priv->bus_clk, so presumably
> >> the result is no clock either way)
> >>
> >> sdhci_resume_host() does not restore state unless
> >> SDHCI_QUIRK2_HOST_OFF_CARD_ON is used, it just resets, so the internal clock
> >> SDHCI_CLOCK_INT_EN is off which is consistent with either runtime suspended
> >> or runtime resumed.
> >
> > Even if this may work, to me, it doesn't look like good practice for
> > how to use runtime PM in combination with system wide suspend/resume.
> >
> > The point is, sdhci_suspend|resume_host() may end up reading/writing
> > to sdhci registers - and we should *not* allow that (because it may
> > not always work), unless the sdhci controller has been runtime resumed
> > first, right?
>
> I am OK with drivers that just want to use runtime PM to turn off a
> functional clock.  sdhci-tegra.c is also doing that although using the
> clock framework.

Yes, I agree. At least this works for SoC specific drivers.

>
> Certainly that approach assumes that the host controller's power state
> is not changed due to runtime PM.
>
> To ensure that the host controller is runtime resumed before calling
> sdhci_suspend_host(), we can just call pm_runtime_resume() I think.

Yes, that was kind of what I proposed in the other thread as option 1)
(except for the replacement of pm_runtime_force_suspend|resume).

Although, to be clear I would probably use pm_runtime_get_sync()
instead, to make sure the usage count is incremented too.

I don't have a strong opinion here, but from an optimization point of
view I would at least consider what I proposed in option 2) (in the
other thread). The benefit is that it can allow us to potentially
avoid runtime resuming the device, during system suspend.

Kind regards
Uffe
