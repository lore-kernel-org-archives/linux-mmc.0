Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D6C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Nov 2022 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKGUN6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKGUNs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2022 15:13:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D756D2B24F
        for <linux-mmc@vger.kernel.org>; Mon,  7 Nov 2022 12:13:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10892476pjs.4
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2022 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEhxlERJwZonuUCUuaPVtYZF+0Ak3g5SIMelh6zIx84=;
        b=hRoTrdsgwk17CdDl6ZM6PAfBqeIOqaca373q4Nnminbz05nDjOy44u+cY927y2f4Ri
         vAeH4ZaKWnfVYlQOZ61rfVxINZJNiEWt6sjIdm3T4Lw4rWB95obMUBUzumVdH8pmorju
         +OvqLqIwpn8oQRn5DOCH6AZTVDp7CLJenK5kcUhL1YkwZgnZtCjtTecltpPqgJNjChwG
         z7457VEYQ+SBYALYWV2rg3/uV9BM23nnmATCvR8jGnNVclZuvO0X8/XzFZZx1g1rWimb
         ct4XeuLg+s5r/TH+3f1mpkPD4hZEfCZyUJ9NWQvmBQk7syvwPLwXvUyRZ+eF3+t2f5pC
         C0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEhxlERJwZonuUCUuaPVtYZF+0Ak3g5SIMelh6zIx84=;
        b=DBst8qWjzVHi276ifAZx5YZFHcQhQPsc4zYBBiKmj5svRTEUqcwjjdsO9CQgE+fUVy
         FogsQqAlFmvjunD5y6TtGl5NJLa1itpxB57Tw+uTTtSyjY9+ynC9NMkaFT2wx/wRwPMj
         cWBCvIEuD8cLPWN2CMOyRbLTlzFu7XETH0TRI/AE1TOS1jUjSdlOYswg0tgrs78x121B
         1PI0qqXFwy+z+WRY3lby0e8vIu7IBGwbKZ+n0qKcpf/IxNeQTdS1CMtkwvZTG6Ee7uiL
         L3FEsTBLuYROkkXOADkij/vSGKQTZpNPXOwDes1BR5wWkDqfeyT8HqoJz28I/a9f9X1h
         dnvw==
X-Gm-Message-State: ACrzQf3jm6RU50Gal28KJ0PEHCZa94Jg+LWFEor5v1IZ8vDuN1LxY6//
        /W1FFMioEDgpznZLfy9t+OY2xnRXDyOeyk1QBH1Gmg==
X-Google-Smtp-Source: AMsMyM7NzReteLt2BUF9TShf+VmPoWNQ+bznAgRn2w48nJnwy9W4vwAcG+h89CGoWqzGUuNpe/taCSQworXl3Ox6v1Q=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr53387093plb.148.1667852021086; Mon, 07
 Nov 2022 12:13:41 -0800 (PST)
MIME-Version: 1.0
References: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:04 +0100
Message-ID: <CAPDyKFrWxAmEszEsuyyCrXTFWvYrQnXZwj=-4ZubO2jHdGzYMw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset the tuning logic before
 execute tuning
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, sherry.sun@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Oct 2022 at 11:25, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> For standard tuning method on usdhc, the previous tuning result can
> impact current tuning result, let current tuning can't set the correct
> delay cell. And from the logic, this is also reasonable for manual
> tuning method. So reset the tuning logic before execute tuning.
> To avoid compile issue, this patch also move the esdhc_reset_tuning()
> upper.
>
> Find this issue when support SDIO WiFi in band wakeup feature. After
> system resume back, will do re-tuning, but then meet data CRC error.
>
> Do not meet this issue on SD/eMMC, because we already call
> esdhc_reset_tuning() when config the legency ios, and SD/eMMC need
> to re-init when system resume back, but SDIO device don't do re-init
> if it has MMC_PM_KEEP_POWER pm_flags.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 82 ++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b073e79dcd99..4559599d897d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1012,6 +1012,44 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>                         SDHCI_HOST_CONTROL);
>  }
>
> +static void esdhc_reset_tuning(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +       u32 ctrl;
> +       int ret;
> +
> +       /* Reset the tuning circuit */
> +       if (esdhc_is_usdhc(imx_data)) {
> +               if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> +                       ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +                       ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +                       ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> +                       writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> +                       writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +               } else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> +                       ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> +                       ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> +                       ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> +                       writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> +                       /* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
> +                       ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
> +                               ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
> +                       if (ret == -ETIMEDOUT)
> +                               dev_warn(mmc_dev(host->mmc),
> +                                "Warning! clear execute tuning bit failed\n");
> +                       /*
> +                        * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
> +                        * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
> +                        * will finally make sure the normal data transfer logic correct.
> +                        */
> +                       ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
> +                       ctrl |= SDHCI_INT_DATA_AVAIL;
> +                       writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
> +               }
> +       }
> +}
> +
>  static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -1023,6 +1061,12 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         if (host->timing == MMC_TIMING_UHS_DDR50)
>                 return 0;
>
> +       /*
> +        * Reset tuning circuit logic. If not, the previous tuning result
> +        * will impact current tuning, make current tuning can't set the
> +        * correct delay cell.
> +        */
> +       esdhc_reset_tuning(host);
>         return sdhci_execute_tuning(mmc, opcode);
>  }
>
> @@ -1196,44 +1240,6 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>                 "warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
>  }
>
> -static void esdhc_reset_tuning(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -       u32 ctrl;
> -       int ret;
> -
> -       /* Reset the tuning circuit */
> -       if (esdhc_is_usdhc(imx_data)) {
> -               if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
> -                       ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -                       ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -                       ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> -                       writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> -                       writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> -               } else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> -                       ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -                       ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -                       ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> -                       writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -                       /* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
> -                       ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
> -                               ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
> -                       if (ret == -ETIMEDOUT)
> -                               dev_warn(mmc_dev(host->mmc),
> -                                "Warning! clear execute tuning bit failed\n");
> -                       /*
> -                        * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
> -                        * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
> -                        * will finally make sure the normal data transfer logic correct.
> -                        */
> -                       ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
> -                       ctrl |= SDHCI_INT_DATA_AVAIL;
> -                       writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
> -               }
> -       }
> -}
> -
>  static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  {
>         u32 m;
> --
> 2.34.1
>
