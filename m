Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3964DC4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7A361262
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 13:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhHXNx5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhHXNx4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 09:53:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A6C061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 06:53:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g13so45684430lfj.12
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+24PodXyEIN2SyWjx1mf7gOy4pJz9Ey/wTctxkODcg=;
        b=dHn8QHs3BEvlmfIlOzT0uE1EiqoofQ+l0i2P7vOqBm0HzsdFHf9gJmdHE/skq8YIhe
         WyhddNlXU7Qh6nQ4YqaM9iogym7gAg8Zts85aYJzUPg/36GdMUfei2b/MK+EOBpaiTJp
         9K9SKenJnLVM5EMelaq801QHwsYjKNVojRq5N9R744Thl89byyBIr1NJkhd5+dPuvaYv
         ZvN1n1HiqN79DI6fFKU5mGdJ3egSX8KL6M4lwX08XBL4NKoOTXYw1MEOtbabuOCN/aPO
         4n7IHvu/OuW99c0HSaroxoAx3fanGODzFfECgh2US0yfDx4Fh/hju3Fxzi3y+fLXCTAV
         +3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+24PodXyEIN2SyWjx1mf7gOy4pJz9Ey/wTctxkODcg=;
        b=T7p9PIzadvWRJwM/JnOJqMGHiFIsJLp3FsPIJEVd4IPP6KDE20hhEXMI6DxmLcqfoD
         DtcQfy7YtcHv//qMZPfyqLF7s5LZAIz5Q6Mi0S2GuzaHJ76eKxbSGJF7sgz9qQ62Pdz1
         pOMgaNywHtjGzZqz9P7Np93vBlHkysuRcpciCfPBXOQraodci2tqS9Ah+4FbNMVFgoGh
         G/Ooy0O7RE8VTaW1iuHeQMNTQ6rDotkug/+OsKdt4NNfpidOlafTRXQXIHRQ+qfBTzMT
         G4W1GbvCWaHlJzD8pBdqHm2vnY0lBku39y80G4JtVdc6sWR1fhauMXPE6gRGTUexQsZX
         N3uQ==
X-Gm-Message-State: AOAM533/rVNGIjSFtTM3iQLG0+pj36qewXET/L5r39jrDsS+e2dvtjgn
        IIx9YlqHozuCYPF9nYRmNkHZs966jUbljy7wBrZVdw==
X-Google-Smtp-Source: ABdhPJznkd9EndxsnUjM03xDTtOzfKLut/f8PKt1xwneM+G+a2vnbVkdiYGheHm1Vcbix2DHxE9ao0Jstdu4VRBAyEY=
X-Received: by 2002:a05:6512:e99:: with SMTP id bi25mr3109585lfb.486.1629813189754;
 Tue, 24 Aug 2021 06:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 15:52:33 +0200
Message-ID: <CAPDyKFr2z6t0uefxioLHaszvwrc9Pkf1OJDi=jozjpEZcKP5ng@mail.gmail.com>
Subject: Re: [PATCH 1/6] mmc: sdhci-esdhc-imx: remove redundant code for
 manual tuning
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2021 at 15:00, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> For manual tuning method, already call esdhc_prepare_tuning()
> config the necessary registers, so remove the redundant code
> in esdhc_writew_le() for SDHCI_HOST_CONTROL2.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

While discussions on the DT binding, etc, continue with Lucas and Rob
on patch 3 - do you want me to apply patch1 and patch2?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 57b19ca1ad6d..a49fac719fca 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -628,17 +628,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>                 else
>                         new_val &= ~ESDHC_VENDOR_SPEC_VSELECT;
>                 writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
> -               if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> -                       new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -                       if (val & SDHCI_CTRL_TUNED_CLK) {
> -                               new_val |= ESDHC_MIX_CTRL_SMPCLK_SEL;
> -                               new_val |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> -                       } else {
> -                               new_val &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -                               new_val &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> -                       }
> -                       writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
> -               } else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> +               if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>                         u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
>                         u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
>                         if (val & SDHCI_CTRL_TUNED_CLK) {
> --
> 2.17.1
>
