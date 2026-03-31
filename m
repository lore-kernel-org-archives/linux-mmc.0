Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB93AA515
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955711; cv=pass; b=cKVHqCqocCq9k8vYB/GIhdoATJ0LwCrwN5l4BZ9uZinP1ETeG4JXPIKDYd8LB/T6TZX2Srz+r7+Y0tfTNPZHOtw5E0fH/bWclOS+gWusDg06MZznW9tsux19Hz3PEYTydf58kN3BR+6f14nbrcx2GF5NI24HR/v9MH38OZmJmkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955711; c=relaxed/simple;
	bh=EcFJLu3CiijfDNmTBmQRH0pMiXZdibXW4WnjnfNthYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0Sex7c7RWXhDlHuVxVY++mxxo7WjfIqkbiwqG3TdA9Py4HCGObTaG+pYGejzEgAEVI/VHzDAuX74fJp1oZmnrTlAQmSvK3b4r9fLXiZcp1Vh68KptQIsvbiE88Xj8UuWU2Btqsyop0ZW8W+cvftpiaS6r5W5/92YdvR0C7g9tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WYC3Ib89; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYC3Ib89"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a10d130b37so5302372e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 04:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955708; cv=none;
        d=google.com; s=arc-20240605;
        b=Vl3PZdv0hQ76PCoOvGDOAC9GjHZrGHaveuI6rSn4pWgO7j7CrJiBvb3FiwE82mlLLV
         Z16u9vP/nPWy3eqrDbpKEqDxkUmH4/YVvy3tqkCtaBBy/R8kOd9fVb2b1jLlOaYRC7zS
         aVzp0+BD5Xkyh2qB0/JzH1vLrN49YV6CY9ryP84D+avnYEN6O1QCrcLgtitt1DDWAsWq
         OsCFgLWTkGUFiaDdwMdYUbRZ4eDv1yP4b8RrTXzaruuyAwJaJjYNQ10GMdfIibGTXsKt
         GsG+jZZ/PnLn6hhugfjsGT8NcLn8doD4F59GSaQiVvdNPQ7sv/lBwxiwmBMjsLn8AW1H
         6n9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4tIaIXp7FQdF0r9WNUruNeum5K2fLGgptMXAzUr3RHE=;
        fh=ok8k7O2uY2fInvyVKnbmuUAAl7beXEXcq8DXr4QAW70=;
        b=afyIlx5jGpTx2SdP+Ancs8Lr4hsJTyprG3YpJytxU6UZEDOS5qWgC6IgYGBGcwrWFn
         teutexldOpNM/1pOLyvNk5P0pbMThqkTbrtXDsIlZsvJVVH0lHLMgnPwD4ILyPzUYWJ9
         hANjKXc95LC/dBCWCFhQsF/+C5//emE25eKgtgjPJuUI8mr1jb+WpurBlu/6eOD7U2DW
         P2CqitaTRxYGtjF8DQ18/5p900/dk/PYJMAZRIS5VaeYFjTyilJGgU3K/T8t+UhJcxzU
         radwIU3rXFIsv4mtGNVzppAVsp5t+nVh03gzhsLODg3zTyhCLnLQr/YaQwwxFxY5/i6e
         NPrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774955708; x=1775560508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4tIaIXp7FQdF0r9WNUruNeum5K2fLGgptMXAzUr3RHE=;
        b=WYC3Ib8963+VQ876eTyVIK/EEs1RITtbF22TR/3KPvdvlDzGz9JMvqMPa+Q3CuIu3G
         5BLR41z6o/GsfBcA9S7B9zpqG2yYL8tj6bT9z5NjZoQxi/gI8/YiTSIeVejbCGwAOlLZ
         kII5JgZkTlXkjBWr/ZXy0ssrRbvKqTdzzLoihWG4NF/05ACjKI4CVDFti/6OsUDxLHjU
         9uUhuilotvIxQqOxWqwZEmiSbRDRogYqNds84sG9YT88wmuzV82ZJkOyEMp4sdjlSaN+
         m5fmvP44kkzDWMftyrFrGAk5LUzTIaRyr7Lz0m15PF0Ax47bqEEyQ3xgWOCqMZfq4o/g
         LSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955708; x=1775560508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tIaIXp7FQdF0r9WNUruNeum5K2fLGgptMXAzUr3RHE=;
        b=mD6ueeQ3eSdnITxGDJTwT+fH1VpnFTI+XVq68ZMXRyq4sEO4782uV/oEuln1nIDwjG
         FEF2xS9So5ynDrheGNO3+k9YnSvSa++DI6IWzs2z0H6dtgUoPDxO3hMfq007gGuClfsT
         jJHxttcxq3SX6TSRsWT+LlzL8E925x3e8eLwbQGLcqZuwPFMP3aA+4l2rsd0cEUoLkqF
         KkhadaqZz13CZt2vq8+ccIIP6uo6HMq/o/jVp7/uUv7mqKo+tsyKf81nL9mitMEs7UnU
         d4TWOIJkTcAUh9b7UuvyCTumXwIc7aEqmTQelUav1OmUvH5G2QBWnTsMVSZ28MPgAJ15
         LviA==
X-Gm-Message-State: AOJu0Yw/NVUrvGNNszc2QdA/YecQ9wqnsnhu9uv1SsuZBk9/YtB/IPSD
	wPPybztROJjRhpa1LQJ79yz0b+l2UsDImjJVaVGESeEnJRj1vp3LtlMeCkpwyAP4GKp75H1dY+2
	MfFo6woLMF9sNrWd+2256C/JyPX3hrtLsdgi46UWv6HsrFxCLMaZL
X-Gm-Gg: ATEYQzxJ9Vzj10oSS5miN60mhPnn/547u6R+FNvr7SMfj7rNzhAYpW9l+NkkYMV6rTv
	eRERQlADHOeofFeEloIpnPVDNwEUr6g6HEccjiwenlyzZ0LY0CQmWScYP/o9rseeagvI88kjeAL
	9H7PzlBHkAKcpXtiGyUaNS2sdW/rM1PE5duRWfvxUB7zNBxWNx6oYuIv0kABsGIShWlmPjP25GB
	WnRXwuwgNt2lffxKKNExNApJ/yvq2IZ4oN6qpb31L2du+dIrfQtQjT9HvmMMWgdAv99Uz9DL/3R
	a3exA6hX
X-Received: by 2002:a05:6512:2313:b0:5a1:53a8:fe20 with SMTP id
 2adb3069b0e04-5a2baae136cmr1098957e87.8.1774955707894; Tue, 31 Mar 2026
 04:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1774657762-152522-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1774657762-152522-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:14:31 +0200
X-Gm-Features: AQROBzBS7blAll21TPGO827Cd20xrsesnJXSVw3i6fyudfuXltEqUXvSzzsypys
Message-ID: <CAPDyKFosqzuv=t69tq_JBn+uy1YDNw7eT12hJs1SHD4P37OvRg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-dwcmshc: Refactor Rockchip platform data
 for controller revisions
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Mar 2026 at 01:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> The driver previously used an enum (dwcmshc_rk_type) to distinguish
> platforms like the RK3568 and RK3588 based on DT compatible names.
> This approach is inflexible, scales poorly for future revisions or
> mixed-revision platforms, and conflates SoC names with controller
> revisions. One example is RK3576 which lists "rockchip,rk3588-dwcmshc"
> as a secondary compatible string just in order to claim it uses the
> same controller revision as RK3588. This is confusing and makes it
> error-prone to add new SoC support.
>
> Introduces a new struct rockchip_pltfm_data containing a dedicated
> revision field. The old enum is removed, and all code paths are
> updated to use the revision-based data.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - remove unnecesary parentheses
> - add Adrian's tag
>
> Changes in v2:
> - update commit msg
> - document the revision field
> - re-order the Rockchip plftm data
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 92 +++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a91b3e7..6139516 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -278,14 +278,8 @@
>  #define PHY_DELAY_CODE_EMMC            0x17
>  #define PHY_DELAY_CODE_SD              0x55
>
> -enum dwcmshc_rk_type {
> -       DWCMSHC_RK3568,
> -       DWCMSHC_RK3588,
> -};
> -
>  struct rk35xx_priv {
>         struct reset_control *reset;
> -       enum dwcmshc_rk_type devtype;
>         u8 txclk_tapnum;
>  };
>
> @@ -330,6 +324,16 @@ struct k230_pltfm_data {
>         u32 write_prot_bit;
>  };
>
> +struct rockchip_pltfm_data {
> +       struct dwcmshc_pltfm_data dwcmshc_pdata;
> +       /*
> +        * The controller hardware has two known revisions documented internally:
> +        * - Revision 0: Exclusively used by RK3566 and RK3568 SoCs.
> +        * - Revision 1: Implemented in all other Rockchip SoCs, including RK3576, RK3588, etc.
> +        */
> +       int revision;
> +};
> +
>  static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>  {
>         u16 ctrl;
> @@ -749,6 +753,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>         struct rk35xx_priv *priv = dwc_priv->priv;
> +       const struct rockchip_pltfm_data *rockchip_pdata = to_pltfm_data(dwc_priv, rockchip);
>         u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>         u32 extra, reg;
>         int err;
> @@ -816,7 +821,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>          * we must set it in higher speed mode.
>          */
>         extra = DWCMSHC_EMMC_DLL_DLYENA;
> -       if (priv->devtype == DWCMSHC_RK3568)
> +       if (rockchip_pdata->revision == 0)
>                 extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
>         sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
>
> @@ -842,7 +847,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>             host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>                 txclk_tapnum = priv->txclk_tapnum;
>
> -       if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +       if (rockchip_pdata->revision == 1 && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>                 txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
>
>                 extra = DLL_CMDOUT_SRC_CLK_NEG |
> @@ -898,11 +903,6 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>         if (!priv)
>                 return -ENOMEM;
>
> -       if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
> -               priv->devtype = DWCMSHC_RK3588;
> -       else
> -               priv->devtype = DWCMSHC_RK3568;
> -
>         priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>         if (IS_ERR(priv->reset)) {
>                 err = PTR_ERR(priv->reset);
> @@ -2115,30 +2115,52 @@ static const struct cqhci_host_ops rk35xx_cqhci_ops = {
>         .set_tran_desc  = dwcmshc_set_tran_desc,
>  };
>
> -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> -       .pdata = {
> -               .ops = &sdhci_dwcmshc_rk35xx_ops,
> -               .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -                         SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -               .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -                          SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
> +       .dwcmshc_pdata = {
> +               .pdata = {
> +                       .ops = &sdhci_dwcmshc_rk35xx_ops,
> +                       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +                                 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +                       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +               },
> +               .cqhci_host_ops = &rk35xx_cqhci_ops,
> +               .init = dwcmshc_rk35xx_init,
> +               .postinit = dwcmshc_rk35xx_postinit,
>         },
> -       .cqhci_host_ops = &rk35xx_cqhci_ops,
> -       .init = dwcmshc_rk35xx_init,
> -       .postinit = dwcmshc_rk35xx_postinit,
> +       .revision = 0,
>  };
>
> -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> -       .pdata = {
> -               .ops = &sdhci_dwcmshc_rk35xx_ops,
> -               .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -                         SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -               .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -                          SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> +       .dwcmshc_pdata = {
> +               .pdata = {
> +                       .ops = &sdhci_dwcmshc_rk35xx_ops,
> +                       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +                                 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +                       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +               },
> +               .cqhci_host_ops = &rk35xx_cqhci_ops,
> +               .init = dwcmshc_rk35xx_init,
> +               .postinit = dwcmshc_rk3576_postinit,
> +       },
> +       .revision = 1,
> +};
> +
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3588_pdata = {
> +       .dwcmshc_pdata = {
> +               .pdata = {
> +                       .ops = &sdhci_dwcmshc_rk35xx_ops,
> +                       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +                                 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +                       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +               },
> +               .cqhci_host_ops = &rk35xx_cqhci_ops,
> +               .init = dwcmshc_rk35xx_init,
> +               .postinit = dwcmshc_rk35xx_postinit,
>         },
> -       .cqhci_host_ops = &rk35xx_cqhci_ops,
> -       .init = dwcmshc_rk35xx_init,
> -       .postinit = dwcmshc_rk3576_postinit,
> +       .revision = 1,
>  };
>
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> @@ -2309,7 +2331,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>         },
>         {
>                 .compatible = "rockchip,rk3588-dwcmshc",
> -               .data = &sdhci_dwcmshc_rk35xx_pdata,
> +               .data = &sdhci_dwcmshc_rk3588_pdata,
>         },
>         {
>                 .compatible = "rockchip,rk3576-dwcmshc",
> @@ -2317,7 +2339,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>         },
>         {
>                 .compatible = "rockchip,rk3568-dwcmshc",
> -               .data = &sdhci_dwcmshc_rk35xx_pdata,
> +               .data = &sdhci_dwcmshc_rk3568_pdata,
>         },
>         {
>                 .compatible = "snps,dwcmshc-sdhci",
> --
> 2.7.4
>
