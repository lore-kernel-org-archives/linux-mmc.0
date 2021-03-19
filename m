Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5341AC433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3270764F4D
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCSOM4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCSOMu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 10:12:50 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D6C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:49 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id 124so3554857vsg.12
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlJHFfISV6eXa61u/YHOOMIAKUAI+BzJy+zbSrNW4B4=;
        b=L7sXGfT9AM+GZCj2vJQ5Ij0xJBqC9WpPrORDc8uZAWbIsdQFBJlSyHZShZ5PsMugV+
         YMAOx5/P3QuHosmYd6+o6J56rK61JH6QTBtCDQYLuHwxnhMrFEYqr5YU8FaS6C1HocrJ
         e/ESPLlqSwJU3+Euh03iD+IvXmvxbpVsAvzFmSGLWGUrGX2KLkdluGjgbgTi4wvC92D8
         G+6Ed+KK+ltb+gI91rNaRmP4no50VSZspaJkDnM7nPERYDxNNIgFfDkXOreOicSUhHAC
         YLoU7qkVESbHo3U/jtahrnGSdeVGNYSepAkcm/j1X6DbTsdPTRluR6SAHvYrP3SQxtA6
         I7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlJHFfISV6eXa61u/YHOOMIAKUAI+BzJy+zbSrNW4B4=;
        b=tKNTM+lYROPhvSMgmbRZuaHiEq//63Ib47TYVyzWEdUjeHNw28827LxzbrWP6hlG/x
         1Xp46xZkh5X8g84jUKqKyWle4frkAM3TxBkhWOW69Iz37TaRNFXfUZi8mgQJdb3QLudH
         PNOLWpgZ94sh+epByfH3jjPEanYgAzkeGKPReyMhexntiEXe8PZSS25SxXDSGR2Jfu7+
         n197x08PnRkdKpcKkOJMb8y18ZklTaJaRC7UrBOlg4sPvthbNHtrBhsOvu0tZSm2MQs6
         b0OaJ/nKzgUuvIDQmeLxm9MTQGLw0/x2C5O85Nm5TnC3gAmq+smnziKfOXqA3eX+ScMf
         3Jrg==
X-Gm-Message-State: AOAM531jm/O4Pu0fz6y4uc0oPszKsvWhU0vjtgXidvTcJSlOaVDaP1KM
        lG3hplNJn76V4MmLNP9RB7hTVVY0BAeNVVqbae9+Hg==
X-Google-Smtp-Source: ABdhPJyN4Cnjsd/kE0/vTV8UWGmJikiUkMIciGJubR0sDor3oOO+UTbDqwS+uPuq8tOx7qjnBHdaGXcl7SgMdlJ+KGI=
X-Received: by 2002:a67:6942:: with SMTP id e63mr2907478vsc.48.1616163169148;
 Fri, 19 Mar 2021 07:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210314230824.148969-1-festevam@gmail.com>
In-Reply-To: <20210314230824.148969-1-festevam@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:10 +0100
Message-ID: <CAPDyKFpKc5HnFfzANCOKXQgqd04OoiJAyn0Vvtw6b-gE0_PnUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: Remove non-DT stub
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Mar 2021 at 00:08, Fabio Estevam <festevam@gmail.com> wrote:
>
> i.MX has been converted to a devicetree only platform, so remove
> the non-DT stub for sdhci_esdhc_imx_probe_dt().
>
> Also, make the driver depend on OF now.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - Fix typo in Subject: immc --> mmc
>
>  drivers/mmc/host/Kconfig           |  1 +
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 ----------
>  2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index b236dfe2e879..e911eb570fbc 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -278,6 +278,7 @@ config MMC_SDHCI_ESDHC_IMX
>         tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
>         depends on ARCH_MXC || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
> +       depends on OF
>         select MMC_SDHCI_IO_ACCESSORS
>         select MMC_CQHCI
>         help
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 94327988da91..2a1fb1cd4433 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1453,7 +1453,6 @@ static const struct cqhci_host_ops esdhc_cqhci_ops = {
>         .dumpregs       = esdhc_sdhci_dumpregs,
>  };
>
> -#ifdef CONFIG_OF
>  static int
>  sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>                          struct sdhci_host *host,
> @@ -1505,15 +1504,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>
>         return 0;
>  }
> -#else
> -static inline int
> -sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
> -                        struct sdhci_host *host,
> -                        struct pltfm_imx_data *imx_data)
> -{
> -       return -ENODEV;
> -}
> -#endif
>
>  static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  {
> --
> 2.25.1
>
