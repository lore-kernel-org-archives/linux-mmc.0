Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDDCC4743D
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 07:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26DD6023B
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 07:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhFKHnu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:43:50 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:47048 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhFKHns (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2021 03:43:48 -0400
Received: by mail-vs1-f45.google.com with SMTP id z15so3276038vsn.13
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jun 2021 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItJJSNuQsGI7g+61IE0nIMwufekmSSXpX5M+4Ge5lPM=;
        b=NhZmebdmXt14NUAm6K+GwxAb4Or7vkn+QV8AkNDxLXuXtdZhqwhirm8XIHm/2f24PQ
         mxIsKDA7C7KxWYr2YMMI8SuOP71c2ZpmyCnLS6f+/tmdQJ5zaiDgP9fv0MV5qjUeUo39
         9KaBOXw4Z7pELSDTqjeY+UngElOBwqJLKXAkAI+9Ll9bFfnM15uSB2xl7YpftayVdpPG
         SXNvonn+oBsqVx3h/5Eb2uvpAzNAhyimra/LEFoxN/kZfwBs6qSMSjOSSIvzbOWJmCY8
         wBqM5efzz//eoHGAXSnqMFB+zsekI768hdAStpdzlxdmUEsUSx7RrzRXIuaoeBS9+s7X
         00BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItJJSNuQsGI7g+61IE0nIMwufekmSSXpX5M+4Ge5lPM=;
        b=Trbq/HSJkKTK9xcRADwOiqBPO2f/hFDdrByQlox3VGk0lbOPTVMpO09MMvPEAmrA7w
         xbGi9EyW+kLnAzf9E6IvLvT+gdDCObwIZM9Olfuzq9vxX/R/lO5pkUsXjms/A/B8REnG
         YHm/ZFHrpj83VyQqZcFHjFbFchkEHfnC1cmasvpB5yJTzb4Tdib+J7KoibuWd+JbTKBd
         FyxgRWr/XTTXrMJ0HIKifBzkyuU596AxK0NOi0FcDO6lVd8h3P8PJhSK/z2Mm5XJrPan
         PkqKjwwuuzYsuIQM2WnNQwoL6nXaqPQY8AMYVIK5/IojLqg1rBmqcQYbvU85lfBC8qZH
         4Mxw==
X-Gm-Message-State: AOAM530b/65tXOaNnfnBjySYbWqxfww0SEo2m570ejo6SpEFW1qQHjA2
        sHYWmc2ZZWs0LI6jzPCsHU0oGDL/phryzIRq7rxHVw==
X-Google-Smtp-Source: ABdhPJzZrz6377BlNablRXtpMWoILLXWjH9VFtrOZKjUjwQRHdJBitABCAFPPYIsfLClWBYetNlTcXZW/j70PpOokM0=
X-Received: by 2002:a05:6102:386:: with SMTP id m6mr5477821vsq.48.1623397251183;
 Fri, 11 Jun 2021 00:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <1623326486-25275-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1623326486-25275-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Jun 2021 09:40:15 +0200
Message-ID: <CAPDyKFqipvEu0y=2jzxbW7WwXURqZoRZbjYJTQnVE-_L0zLi9w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: add sdio wakeup feature
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Jun 2021 at 14:19, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Set the wakeup capability for the SDIO device which can wakeup system.
> And user can enable this wakeup through sysfs interface.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7336ae749137..72c0bf0c1887 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1620,6 +1620,14 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (err)
>                 goto disable_ahb_clk;
>
> +       /*
> +        * Setup the wakeup capability here, let user to decide
> +        * whether need to enable this wakeup through sysfs interface.
> +        */
> +       if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> +                       (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ))
> +               device_set_wakeup_capable(&pdev->dev, true);
> +
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>         pm_runtime_use_autosuspend(&pdev->dev);
> --
> 2.17.1
>
