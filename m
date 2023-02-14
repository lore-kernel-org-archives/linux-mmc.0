Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A92FC61DA4
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 10:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBNKnl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 05:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjBNKmh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 05:42:37 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C46D244B5
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 02:42:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z1so16606340plg.6
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 02:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIcLt/ncNWTfm4ID0hyfIryBF5hBxiEJQDxsOaXIt2M=;
        b=p8EZ3Qtoxudapbd+bc0BhDaxF3x7P2fWDFtEZ2jAWg5TKI5k9BVMG7xKYjhLv75K1H
         U0fafG87uCsjITiMlfHrE1EZU11xDB8HgLLd7gJs+YJXM/BmDdVX3TxJL4CPtrK4BkJt
         1CdzjqtRLaZkDEYUJsKEp98hexXpIOkxtTZb/vMAlnvRNPwoBBP2LFkjvCNcTl2mnO6A
         t+8nDe/PZZ/cveZK0brM2dSGzL6GJhfsBEiWz4p2KcK90sLPhfW1drpSGhe/fVly6NLl
         2D2pZon2fGb7jN7A26lZmklhTQ+NVoxl2bl4NJzfDXjyGuUvGMd41Q/gQYBd0PHBejNi
         Q63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIcLt/ncNWTfm4ID0hyfIryBF5hBxiEJQDxsOaXIt2M=;
        b=T9lyb4DtUeZLeHoy2K5wy2gPkHXs4co5fbxnyDeXPYpi5Ac//8Ca1U2pi2xqQm+Bm/
         mwEzzVBPzzHmo4+CqdkGC7rBXq9f3G+K7jyMEJRiyDp0chqtFUaiec1wzMj44L2sB5VI
         KlsZWwcKCFuAaplv8K4WkYxPJSgnoKvOWc7wyEh37aRlpMXua6b6xCRlKq1T11PZ647u
         SJhIGlW+ACBTEF0pBUwhqHnvez8GuS+b8Ro6lGX85W07KOQ+ddJLpczwRalZTAVpnpYR
         +QQ1nRwVWIC6IsVHQeBZH6okorJxhDICh+7A3cDhgtB3w3LRZTgqDquJWUX6AbtuzMSE
         HeMg==
X-Gm-Message-State: AO0yUKXQ3RPKM912GfbxfYXZM1UaKZHSpVH7O/1I6KeXTbPK9ZZFPw3U
        BAkgMqB6coFmQvyu4+X5+Nnc2h6zaHKnWBRkE1cwYQ==
X-Google-Smtp-Source: AK7set/A7WcJ0yHJ3d+Hs+u46jZzU03CMklgPWmGQRmOrDtgV4ZS/9cmIoctzq1f6+VYos3ii/7LWUfLNCu+V8kBP+g=
X-Received: by 2002:a17:903:32cf:b0:19a:b801:13d7 with SMTP id
 i15-20020a17090332cf00b0019ab80113d7mr347588plr.2.1676371327685; Tue, 14 Feb
 2023 02:42:07 -0800 (PST)
MIME-Version: 1.0
References: <1675298118-64243-1-git-send-email-shawn.lin@rock-chips.com>
 <1675298118-64243-3-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFoN3GDRYRJep1ARf8rSftZRBUceda92OPuDQLvG3dVhhQ@mail.gmail.com> <a336a9ef-77e9-fa1d-ad95-805a8b5a89cb@rock-chips.com>
In-Reply-To: <a336a9ef-77e9-fa1d-ad95-805a8b5a89cb@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 11:41:30 +0100
Message-ID: <CAPDyKFrpv+DoqMK9cLrYMBk1m6dXoDXu40xSJ_UMVK8O+=Ud6A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-dwcmshc: Add runtime PM support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Feb 2023 at 04:36, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Ulf,
>
> On 2023/2/14 7:45, Ulf Hansson wrote:
> > On Thu, 2 Feb 2023 at 01:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >>
> >> This patch adds runtime PM support.
> >>
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> ---
> >>
> >> Changes in v2: None
> >>
> >>   drivers/mmc/host/sdhci-of-dwcmshc.c | 51 ++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 50 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> index 46b1ce7..fc917ed 100644
> >> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >> @@ -15,6 +15,7 @@
> >>   #include <linux/module.h>
> >>   #include <linux/of.h>
> >>   #include <linux/of_device.h>
> >> +#include <linux/pm_runtime.h>
> >>   #include <linux/reset.h>
> >>   #include <linux/sizes.h>
> >>
> >> @@ -551,6 +552,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >>          if (err)
> >>                  goto err_setup_host;
> >>
> >> +       pm_runtime_get_noresume(&pdev->dev);
> >> +       pm_runtime_set_active(&pdev->dev);
> >> +       pm_runtime_enable(&pdev->dev);
> >> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> >> +       pm_runtime_use_autosuspend(&pdev->dev);
> >> +       pm_runtime_put_autosuspend(&pdev->dev);
> >> +
> >>          return 0;
> >>
> >>   err_setup_host:
> >> @@ -580,6 +588,11 @@ static int dwcmshc_remove(struct platform_device *pdev)
> >>          if (rk_priv)
> >>                  clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> >>                                             rk_priv->rockchip_clks);
> >> +
> >> +       pm_runtime_get_sync(&pdev->dev);
> >> +       pm_runtime_disable(&pdev->dev);
> >> +       pm_runtime_put_noidle(&pdev->dev);
> >> +
> >>          sdhci_pltfm_free(pdev);
> >>
> >>          return 0;
> >> @@ -638,7 +651,43 @@ static int dwcmshc_resume(struct device *dev)
> >>   }
> >>   #endif
> >>
> >> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> >> +#ifdef CONFIG_PM
> >> +static int dwcmshc_runtime_suspend(struct device *dev)
> >> +{
> >> +       struct sdhci_host *host = dev_get_drvdata(dev);
> >> +       u16 data;
> >> +       int ret;
> >> +
> >> +       ret = sdhci_runtime_suspend_host(host);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       data = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +       data &= ~SDHCI_CLOCK_CARD_EN;
> >> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int dwcmshc_runtime_resume(struct device *dev)
> >> +{
> >> +       struct sdhci_host *host = dev_get_drvdata(dev);
> >> +       u16 data;
> >> +
> >> +       data = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +       data |= SDHCI_CLOCK_CARD_EN;
> >> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
> >> +
> >> +       return sdhci_runtime_resume_host(host, 0);
> >> +}
> >> +#endif
> >> +
> >> +static const struct dev_pm_ops dwcmshc_pmops = {
> >> +       SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend,
> >> +                               dwcmshc_resume)
> >
> > I have looked at dwcmshc_suspend(), which calls sdhci_suspend_host().
> > As sdhci_suspend_host() will write to internal registers of the IP
> > block, it's recommended to make sure the device's runtime resumed
> > before doing that call. So that needs to be added along with $subject
> > patch.
> >
>
> Yep, let me add a check here.
>
> > There is also another option that may better for you, which is to use
> > the pm_runtime_force_suspend|resume() helpers. There should be plenty
> > of references to look at, but don't hesitate to ask around that, if
> > you need some more help to get that working.
>
> If I understand correctly,  pm_runtime_force_suspend|resume() helpers
> would use runtime PM ops for suspend/resume routine. In this case, the
> main issue is the handling of clock is quite different. In suspend we
> need to gate all clocks but in rpm case, it shouldn't.

I see, but let me then ask, what's the point of keeping the clocks
ungated at runtime suspend?

That sounds like wasting energy to me - but maybe there are good reasons for it?

[...]

Kind regards
Uffe
