From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pxav3: Use devm_* managed helpers
Date: Sat, 26 Jul 2014 11:47:43 +0200
Message-ID: <CAPDyKFoyRoZWMgitmi-cu89vUkxA7B=ALETGPog3Rqun2BXAYw@mail.gmail.com>
References: <1405497009-20338-1-git-send-email-wangxfdu@gmail.com>
	<1405504422-4509-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:39597 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaGZJro (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Jul 2014 05:47:44 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so5577841qaq.24
        for <linux-mmc@vger.kernel.org>; Sat, 26 Jul 2014 02:47:43 -0700 (PDT)
In-Reply-To: <1405504422-4509-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Xiang Wang <wangx@marvell.com>

On 16 July 2014 11:53, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> This simplifies probe error and remove code paths.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pxav3.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> This patch applies on top of Xiang Wang's " mmc: sdhci-pxav3: fix error
> handling of sdhci_add_host" patch.
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 19b7c8a..e90a188 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -288,15 +288,13 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>         int ret;
>         struct clk *clk;
>
> -       pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
> +       pxa = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_pxa), GFP_KERNEL);
>         if (!pxa)
>                 return -ENOMEM;
>
>         host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata, 0);
> -       if (IS_ERR(host)) {
> -               kfree(pxa);
> +       if (IS_ERR(host))
>                 return PTR_ERR(host);
> -       }
>
>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
> @@ -308,7 +306,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>         pltfm_host = sdhci_priv(host);
>         pltfm_host->priv = pxa;
>
> -       clk = clk_get(dev, NULL);
> +       clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(clk)) {
>                 dev_err(dev, "failed to get io clock\n");
>                 ret = PTR_ERR(clk);
> @@ -389,11 +387,9 @@ err_add_host:
>  err_of_parse:
>  err_cd_req:
>         clk_disable_unprepare(clk);
> -       clk_put(clk);
>  err_clk_get:
>  err_mbus_win:
>         sdhci_pltfm_free(pdev);
> -       kfree(pxa);
>         return ret;
>  }
>
> @@ -408,10 +404,8 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>
>         clk_disable_unprepare(pltfm_host->clk);
> -       clk_put(pltfm_host->clk);
>
>         sdhci_pltfm_free(pdev);
> -       kfree(pxa);
>
>         return 0;
>  }
> --
> Regards,
>
> Laurent Pinchart
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
