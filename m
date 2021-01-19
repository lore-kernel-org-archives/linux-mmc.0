Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF9C43333
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB3322E01
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbhASOsz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389648AbhASNjG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 08:39:06 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FEC061574
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:38:25 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a16so347769uad.9
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3X3PmZf5ZFX5QGwBhsXHXX/D7L5F3b1vb/uCDlLe9wI=;
        b=jNWlkaIxY6NoZOqCqC5pGF+o4jvbMn/xb8jtfR0/d/FEbfV4idHAVkLtrjB52Lpwam
         93L5kDYFuV+AVyiP7ti//mNLviydWK75z8+6hvuL/V/fixMPB/eDGEJ535CCzoEeU4Gx
         q5Szg3zoK1wtu7FO/YDNqkh/a42G3vVViXgCXkOJI0Xl8DEbVWRQo9Aue2rwOm/3Sghq
         W0jCEH3mmwUnRbkTqM1K87HAZobs6XlCaKJJ4BcpUnrW4PBBvGLIqi5OS2uVH3NoysF9
         O/ZsUryG5wesVqgQAC7G5tIC4c9ntDxaVBaesjG/oltixMaZufVeyAqAXJCnalixm0G8
         pjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3X3PmZf5ZFX5QGwBhsXHXX/D7L5F3b1vb/uCDlLe9wI=;
        b=scKvwfl2CuzaO5zgStSJR0BFTKxbnw+WpdVWxOx2PMnPfTTITbNpjQHJ3nNaVgGgTD
         LG54vnc42Wv+7Vp0DFkCP6/mst0kOLXY++WvMU9sWoKBG9Ekkh8ZA0BFjBrd4mhw2LQt
         PgsLPcM7xlCI6BAbzo720DWFhb2neMa6Ahk0lc7p8i8P1dTN42kV/uHqvx1hmK1r7t92
         E/MOcRc9d+CmyhHhbZld6pApKb+j/hRro9qxAqFKCE39MWSGjV+zfar5wsyHVVf2sjxt
         xswhcmsl6KezVzC8Wz/4DsMo3AT/Yvk8p50pQzccztIdcb/1tefgNp0jt5bm1zgAwTqY
         SXBA==
X-Gm-Message-State: AOAM530zH4i9LovAvBlwF4MwYF/gUSNbAu0sHRGbw+Pnydq5Hz1GT67v
        yHZyWGUp3rfTyXvJM3twGGWL8yl447kkO6br1x2s9g==
X-Google-Smtp-Source: ABdhPJw5Geqvr9FjKwnfUyEHlqjInTcQwC1+sWVIZ1SYOgY3Qb8NqNpKBWOWTA3PrYyyeNrvlFstj6HKTroeAi4t7fM=
X-Received: by 2002:ab0:768:: with SMTP id h95mr2255398uah.104.1611063504953;
 Tue, 19 Jan 2021 05:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20210115032423.15108-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210115032423.15108-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:37:48 +0100
Message-ID: <CAPDyKFr9Xan+FxgC4vz4KX2UfD15Eo7+TfCjD191YVC2Hv0wdw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: validate pinctrl before use it
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Bough Chen <haobo.chen@nxp.com>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Jan 2021 at 03:55, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> When imx_data->pinctrl is not a valid pointer, pinctrl_lookup_state
> will trigger kernel panic.
>
> When we boot Dual OS on Jailhouse hypervisor, we let the 1st Linux to
> configure pinmux ready for the 2nd OS, so the 2nd OS not have pinctrl
> settings.
>
> Similar to this commit b62eee9f804e ("mmc: sdhci-esdhc-imx: no fail when no pinctrl available").
>
> Reviewed-by: Bough Chen <haobo.chen@nxp.com>
> Reviewed-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Looks like the documentation of DT bindings doesn't specify pinctrls
at all. Please add it and explain when they should be used.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 16ed19f47939..11d3a2244b36 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1488,7 +1488,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>
>         mmc_of_parse_voltage(np, &host->ocr_mask);
>
> -       if (esdhc_is_usdhc(imx_data)) {
> +       if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
>                 imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
> --
> 2.28.0
>
