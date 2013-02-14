From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 RESEND] mmc: sdhci-s3c: Use devm_clk_get()
Date: Thu, 14 Feb 2013 12:58:44 +0100
Message-ID: <CAPDyKFqN8=Bs96uhV_+da_==_5Rw2tEvE62fAiVCAf3cm46g9g@mail.gmail.com>
References: <01c101ce08d0$7d8808d0$78981a70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:45683 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934253Ab3BNL6p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 06:58:45 -0500
Received: by mail-la0-f47.google.com with SMTP id fj20so2157773lab.6
        for <linux-mmc@vger.kernel.org>; Thu, 14 Feb 2013 03:58:44 -0800 (PST)
In-Reply-To: <01c101ce08d0$7d8808d0$78981a70$%han@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

On 12 February 2013 04:24, Jingoo Han <jg1.han@samsung.com> wrote:
> Use devm_clk_get() rather than clk_get() to make cleanup paths
> more simple.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Changes since v1:
> - modified the commit message
>
>  drivers/mmc/host/sdhci-s3c.c |   17 ++---------------
>  1 files changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 82a8de1..5aaef5b 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -608,7 +608,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, host);
>
> -       sc->clk_io = clk_get(dev, "hsmmc");
> +       sc->clk_io = devm_clk_get(dev, "hsmmc");
>         if (IS_ERR(sc->clk_io)) {
>                 dev_err(dev, "failed to get io clock\n");
>                 ret = PTR_ERR(sc->clk_io);
> @@ -623,7 +623,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>                 char name[14];
>
>                 snprintf(name, 14, "mmc_busclk.%d", ptr);
> -               clk = clk_get(dev, name);
> +               clk = devm_clk_get(dev, name);
>                 if (IS_ERR(clk))
>                         continue;
>
> @@ -765,15 +765,9 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>  #ifndef CONFIG_PM_RUNTIME
>         clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
>  #endif
> -       for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
> -               if (sc->clk_bus[ptr]) {
> -                       clk_put(sc->clk_bus[ptr]);
> -               }
> -       }
>
>   err_no_busclks:
>         clk_disable_unprepare(sc->clk_io);
> -       clk_put(sc->clk_io);
>
>   err_pdata_io_clk:
>         sdhci_free_host(host);
> @@ -786,7 +780,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
>         struct sdhci_host *host =  platform_get_drvdata(pdev);
>         struct sdhci_s3c *sc = sdhci_priv(host);
>         struct s3c_sdhci_platdata *pdata = sc->pdata;
> -       int ptr;
>
>         if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
>                 pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
> @@ -806,13 +799,7 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
>  #ifndef CONFIG_PM_RUNTIME
>         clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
>  #endif
> -       for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
> -               if (sc->clk_bus[ptr]) {
> -                       clk_put(sc->clk_bus[ptr]);
> -               }
> -       }
>         clk_disable_unprepare(sc->clk_io);
> -       clk_put(sc->clk_io);
>
>         sdhci_free_host(host);
>         platform_set_drvdata(pdev, NULL);
> --
> 1.7.2.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
