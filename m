Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D55C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 09:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F1661A0B
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 09:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhCXJlK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhCXJkw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 05:40:52 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8DDC061763
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 02:40:51 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id h25so10973570vso.2
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvhpDl1AAHFY4H0MPMtPmo4A1rCybGcZF6IYmIJ9+do=;
        b=uXPDMfPhJKxMikl0BWmY9Yc9095iRTM/fa3rJubJjh2vp/iVjufGjGShzJ8n2ewx5G
         YTP/IObg//fKVHK6ij0j6/vCk7aTsUU4QX2fKPwmgzk5VHee6oxEG32M5nRFY3bVVhN+
         4QufpVPTAWtr0hpWDR4IgpYssLUpV6qHhXsKJlhPpqw2X8+3wmD8hxVDc6nMP/Zfl7yM
         HDcqhfPMWLrUXuulON32f3Vuj2wbZnxwoP+ghS8QqIi+Xkb5i9sWsOoVd9tvQJrZ6sUQ
         KUKJwHRXrR8SBao9ynML0mgblnN0cdS/LB0TdNupx2AZDcvu1stDk9mKCGWHtY6mcgXw
         gXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvhpDl1AAHFY4H0MPMtPmo4A1rCybGcZF6IYmIJ9+do=;
        b=AUhGFMkhKZP5utyYM3cvav/b1nWt2xuyTX9aXHLZnfDhspiMbM00ggjOLLS0dZJDrR
         vyNB0mLmzTBok1hMpRyqYgldfB0Stut8+1wPtCT7gbtK5FnEkq2jv7et2YtaeEO5scvo
         H23jT8sSOgP/6iEh7KfhNXj2zQRmMluBr3heFhj38h68qrsTfNfRbDleaY6A+xmPg0gd
         1fQWxzIqaFPpvp3KjyhSjWkBrahr+qEL5Uwk2hCf+D+WXNxIqsk9Jb+aFNq+jWgLTQmE
         bGu7EVdKHJj7kGpYvSSkivZ7nXepHdImZsNCnAU7KI610WFoNgOYcw0NQarK39EPo1dY
         onfQ==
X-Gm-Message-State: AOAM532s5nqUjsMBK+ePVgCU6365IhlGT08VyfJaqYAPWOyDE5jKErKN
        By45bbqv99BoJPdlVsqhSTCMv/LNDzxHGdYNbgXANA==
X-Google-Smtp-Source: ABdhPJwZ6jyR1ZO74Zp6vx0ALwwMQ24RNB3P6MPcnYomOjB8s2fm1rrA8Rv8VJteu1fnOrHyqWbfRd33zNdAidULSuc=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr865110vsc.55.1616578850796;
 Wed, 24 Mar 2021 02:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <1616403599-29650-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1616403599-29650-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Mar 2021 10:40:14 +0100
Message-ID: <CAPDyKFo87FyUFoMExPAfL2MqdsEZ6YNKTZVN8ArmpzJorBA7_w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: make sure ipg clock enabled during suspend/resume
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2021 at 10:13, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> During suspend/resume, need to access usdhc register, so need to enable
> IPG clock to avoid bus error.
>
> Find this issue when both enable CONFIG_PM and CONFIG_PM_SLEEP, which
> means both support PM and Runtime PM. If the card slot do not insert
> a card, then after system boot up, will do sdhci_esdhc_runtime_suspend(),
> disable all clocks, include the ipg clock. In this case, when suspend the
> system, due to no card present, sdhci_esdhc_runtime_resume() will not be
> called before sdhci_esdhc_suspend(), so will meet system hung or bus err
> once access usdhc register.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 94327988da91..a48b977ca13f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1695,10 +1695,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> +       ret = clk_prepare_enable(imx_data->clk_ipg);
> +       if (ret)
> +               return ret;
> +

This isn't sufficient.

If the device is attached to a PM domain, that needs to be powered on
too. In other words, you need to call pm_runtime_get_sync() instead of
clk_prepare_enable().

That said, it's kind of surprising to me, that the clocks may remain
ungated during system suspend, but are gated in runtime suspend.
Perhaps what you really should look into, is to re-organize the code
and then can call pm_runtime_force_suspend() from
sdhci_esdhc_suspend() (and pm_runtime_force_resume() from
sdhci_esdhc_suspend()). I think that will be both easier and likely
helps to avoid wasting energy as well.

>         if (host->mmc->caps2 & MMC_CAP2_CQE) {
>                 ret = cqhci_suspend(host->mmc);
>                 if (ret)
> -                       return ret;
> +                       goto disable_ipg_clk;
>         }
>
>         if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
> @@ -1712,38 +1716,52 @@ static int sdhci_esdhc_suspend(struct device *dev)
>
>         ret = sdhci_suspend_host(host);
>         if (ret)
> -               return ret;
> +               goto disable_ipg_clk;
>
>         ret = pinctrl_pm_select_sleep_state(dev);
>         if (ret)
> -               return ret;
> +               goto disable_ipg_clk;
>
>         ret = mmc_gpio_set_cd_wake(host->mmc, true);
>
> +disable_ipg_clk:
> +       clk_disable_unprepare(imx_data->clk_ipg);
> +
>         return ret;
>  }

[...]

Kind regards
Uffe
