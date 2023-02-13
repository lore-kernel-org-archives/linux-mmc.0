Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0007C636D4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBMXpw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjBMXpv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:45:51 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451851352C
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:45:50 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z6so5223757pgk.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676331950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DhUoEEyFzWRZQqBIAao8WKNUgwOq97HT93SpLc2M0Y4=;
        b=BS83QTz9+eelcCmnU/UL9XuoulqPIh9I+y3sp24n+jVWIN1WYI+sy6HeyTsfmVg8lk
         DLWBPfAxWazPBsNonmeGoPQjS/+OAr34OUT7P3/019o7++iFiBv7gZkf/zCFIJ656p5f
         UZkMkvBzWRfpF+VPGMg3GYfrjtY9HaHHP1O8/XALW9Ov9KvZJU4N8nx44bubNjXu1CPH
         EuWOKkqB0OQQhI7KAsRMVlMipIPVjXyq8a6N4IaT02/d1yGnIWz9UxGabomg4l46snLH
         1fISd+JWcc9UjKhLFeCfuNCTRD4cYosS4PEMbmE3cKpeXUtVlh7B2ipk+3HoxgR42CTt
         9WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676331950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhUoEEyFzWRZQqBIAao8WKNUgwOq97HT93SpLc2M0Y4=;
        b=UXMOdRGRw2dWg+ff3Qc8EApxIbCMuImm3ZG+XaScRxXIMSA354UlrmDfOCLMWStwho
         OPIF7DyB9G7UsTRwU2TxDR9yc+kgFKuLYQUcMnSclXTnOvgz5cj+N1cnd81y/4MCthhK
         pFSyo0xl9yvUAAAQlQo0LZig5XAVKk5bgwYjOgdoh8lDFMJZASgc0LIY2pcbizu4ExB0
         Njf8kHwSWUFPMlPQBmztDfvwomoS5MrZPMWz/gtNEDSv1oYwJVQAnzj94LruqPb5Itg7
         tMp1dgIT5Q/bwgSVceyj6fMaQh/nyvexLz++qTNdSynsmqg/UI17f4mOAD/Vlv6tluKy
         rVlQ==
X-Gm-Message-State: AO0yUKV5YOSDGknWF/Rl0RXhX6g6qiJyFrF87r06d+NlxNfto8CHIlXK
        kRbEoNodaVwxta33xLL+hqYMghAah9ps23YFkP8cOJYuysDQo/sR
X-Google-Smtp-Source: AK7set8QpcE6j144AFa/2xJ6S58zok2NijdxAbhkDm+umkvi7hT963bEnxcZMXN2gye4wyPyKgnZVGl4IcFKOVl3ahU=
X-Received: by 2002:a62:1784:0:b0:5a8:bdd1:6c53 with SMTP id
 126-20020a621784000000b005a8bdd16c53mr57862pfx.9.1676331949639; Mon, 13 Feb
 2023 15:45:49 -0800 (PST)
MIME-Version: 1.0
References: <1675298118-64243-1-git-send-email-shawn.lin@rock-chips.com> <1675298118-64243-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1675298118-64243-3-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:45:13 +0100
Message-ID: <CAPDyKFoN3GDRYRJep1ARf8rSftZRBUceda92OPuDQLvG3dVhhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-dwcmshc: Add runtime PM support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Feb 2023 at 01:35, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> This patch adds runtime PM support.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 51 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 46b1ce7..fc917ed 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>
> @@ -551,6 +552,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_setup_host;
>
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_put_autosuspend(&pdev->dev);
> +
>         return 0;
>
>  err_setup_host:
> @@ -580,6 +588,11 @@ static int dwcmshc_remove(struct platform_device *pdev)
>         if (rk_priv)
>                 clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>                                            rk_priv->rockchip_clks);
> +
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         sdhci_pltfm_free(pdev);
>
>         return 0;
> @@ -638,7 +651,43 @@ static int dwcmshc_resume(struct device *dev)
>  }
>  #endif
>
> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> +#ifdef CONFIG_PM
> +static int dwcmshc_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       u16 data;
> +       int ret;
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       data = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       data &= ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +
> +static int dwcmshc_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       u16 data;
> +
> +       data = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       data |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, data, SDHCI_CLOCK_CONTROL);
> +
> +       return sdhci_runtime_resume_host(host, 0);
> +}
> +#endif
> +
> +static const struct dev_pm_ops dwcmshc_pmops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend,
> +                               dwcmshc_resume)

I have looked at dwcmshc_suspend(), which calls sdhci_suspend_host().
As sdhci_suspend_host() will write to internal registers of the IP
block, it's recommended to make sure the device's runtime resumed
before doing that call. So that needs to be added along with $subject
patch.

There is also another option that may better for you, which is to use
the pm_runtime_force_suspend|resume() helpers. There should be plenty
of references to look at, but don't hesitate to ask around that, if
you need some more help to get that working.

> +       SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
> +                          dwcmshc_runtime_resume, NULL)
> +};
>
>  static struct platform_driver sdhci_dwcmshc_driver = {
>         .driver = {

Kind regards
Uffe
