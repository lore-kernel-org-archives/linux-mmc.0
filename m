From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
Date: Fri, 19 May 2017 10:30:13 +0200
Message-ID: <CAPDyKFoDgLGnNcOJi83=0G3tOitsyqgoorJGfp1+uhM24YEf7A@mail.gmail.com>
References: <20170516061720.1755-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35592 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755168AbdESIaP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 04:30:15 -0400
Received: by mail-qk0-f177.google.com with SMTP id a72so55387991qkj.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2017 01:30:14 -0700 (PDT)
In-Reply-To: <20170516061720.1755-1-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ziji Hu <huziji@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 16 May 2017 at 08:17, Jisheng Zhang <jszhang@marvell.com> wrote:
> Currently, the xenon_clean_phy() is only used for freeing phy_params.
> The phy_params is allocated by devm_kzalloc(), there's no need to free
> is explicitly.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 14 +-------------
>  drivers/mmc/host/sdhci-xenon.c     |  6 +-----
>  drivers/mmc/host/sdhci-xenon.h     |  1 -
>  3 files changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index 6356781f1cca..f7e26b031e76 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -787,14 +787,6 @@ int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
>         return ret;
>  }
>
> -void xenon_clean_phy(struct sdhci_host *host)
> -{
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -
> -       kfree(priv->phy_params);
> -}
> -
>  static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
>                          const char *phy_name)
>  {
> @@ -819,11 +811,7 @@ static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
>         if (ret)
>                 return ret;
>
> -       ret = xenon_emmc_phy_parse_param_dt(host, np, priv->phy_params);
> -       if (ret)
> -               xenon_clean_phy(host);
> -
> -       return ret;
> +       return xenon_emmc_phy_parse_param_dt(host, np, priv->phy_params);
>  }
>
>  int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host)
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 67246655315b..bc1781bb070b 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -486,7 +486,7 @@ static int xenon_probe(struct platform_device *pdev)
>
>         err = xenon_sdhc_prepare(host);
>         if (err)
> -               goto clean_phy_param;
> +               goto err_clk;
>
>         err = sdhci_add_host(host);
>         if (err)
> @@ -496,8 +496,6 @@ static int xenon_probe(struct platform_device *pdev)
>
>  remove_sdhc:
>         xenon_sdhc_unprepare(host);
> -clean_phy_param:
> -       xenon_clean_phy(host);
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
>  free_pltfm:
> @@ -510,8 +508,6 @@ static int xenon_remove(struct platform_device *pdev)
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>
> -       xenon_clean_phy(host);
> -
>         sdhci_remove_host(host, 0);
>
>         xenon_sdhc_unprepare(host);
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 6e6523ea01ce..73debb42dc2f 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -93,7 +93,6 @@ struct xenon_priv {
>  };
>
>  int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
> -void xenon_clean_phy(struct sdhci_host *host);
>  int xenon_phy_parse_dt(struct device_node *np,
>                        struct sdhci_host *host);
>  void xenon_soc_pad_ctrl(struct sdhci_host *host,
> --
> 2.11.0
>
