Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C4C433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370602086A
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8EeTkjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgH1Ioy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1Ioi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 04:44:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1457C061239
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:37 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j188so198020vsd.2
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOjUEv8igJ0yZCPibungJXoJvaKQfNTLa2b/lPJoFpQ=;
        b=P8EeTkjhZznsHUCyQ62tUYBAUUo7KrGQnD1zf3EtP9gsFr9iYuPp6udsX/mPMgJkOI
         f0iVtBk13eAkuRsbz4JqtAi7n+gdFJ/WgLqWTYOmAnCEKBKGnM9FhAcyXNXQ6VrLRblv
         9oQDkPPO3aE97nLESlupA1aXpXa0eNT53XXVpRuFpAu7GHzZP5FA9Md74yaOVMKDwVVf
         gSnCudJEphZxgWbxmBC36OALm5gqs+ZDoVxTpJwh/Fu43YbFbQfERkLAsEpBpAz0YwRT
         2SyV5Y1pjEoySkqybWdWk0ToDbR5ETAEZsvMxM7qmeIu7tnZYigebOvURo36UQUQwEjO
         ArKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOjUEv8igJ0yZCPibungJXoJvaKQfNTLa2b/lPJoFpQ=;
        b=ZQUJBs1KJFll/jlhE2XccbciU6rKUsRWQXJB/gYFE6E8gTIik5ynxDx1WXOyfj/CVR
         SmH+Z+EUit5G44uoE5mUDwTROwjBhAw2CwyMp99U0QOrhcVaerC7rrapasxV74NYKCFr
         /JtoLg+cLL2CVFkrciZKYXkwIDHSu2CF1L7dOKWCIFqLsJ+tN3CzrQhj5xEQlC7XsNUt
         AxzM1VjSeyL3gUGcFIKPbfwTcPkUG9XWZtRXLl2EBql/jMEu/Rj2v1KXV02nhuoKWzXo
         kpNazsGaK33Pi+cJ7ny5gOZ1GbDXjJI10k2BIEQNT5CBsCy7IkPU6v/EaYXTzPAP4sQn
         lMyQ==
X-Gm-Message-State: AOAM530B+mx8j1ExNVGuFJhvYqK33uJuUk5OFQFOU+P27EL65jcNUkeA
        9gTyRh5cPuozWzf1istpJfn+LNM7ZqTFLf95nidpGw==
X-Google-Smtp-Source: ABdhPJwJORz7T1/8rWlEJk65rbOG1rZixcUGP0SwByG+adenjodvZCpMQ+UkXivxQCijDx72v1hBLTeCxaTG4h3Ihkg=
X-Received: by 2002:a67:c19b:: with SMTP id h27mr175758vsj.160.1598604276948;
 Fri, 28 Aug 2020 01:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <1598265914-23606-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1598265914-23606-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:44:01 +0200
Message-ID: <CAPDyKFqsJ5645L7ZuN8rO+56sQ-KKfNP5qZX4fuMYvRwcQAc8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: remove unused code
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Aug 2020 at 12:51, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Value assigned to a variable(err) is never used, so remove it
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 3d6eaf490d4a..3d2615eb7d56 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1673,10 +1673,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 goto disable_ipg_clk;
>
>         imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
> -       if (IS_ERR(imx_data->pinctrl)) {
> -               err = PTR_ERR(imx_data->pinctrl);
> +       if (IS_ERR(imx_data->pinctrl))
>                 dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
> -       }
>
>         if (esdhc_is_usdhc(imx_data)) {
>                 host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> --
> 2.17.1
>
