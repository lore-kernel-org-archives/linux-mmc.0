From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pxav3: Remove unused local variable
Date: Mon, 11 Aug 2014 08:49:43 +0200
Message-ID: <CAPDyKFrMuJ5ibNmoAreZ2D=0Z2MeZD1VNfVfmmkXekpQ4A55QQ@mail.gmail.com>
References: <1406544530-6379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:53369 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaHKGto (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Aug 2014 02:49:44 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so7494659qaq.41
        for <linux-mmc@vger.kernel.org>; Sun, 10 Aug 2014 23:49:43 -0700 (PDT)
In-Reply-To: <1406544530-6379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Xiang Wang <wangx@marvell.com>

On 28 July 2014 12:48, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Commit "mmc: sdhci-pxav3: Use devm_* managed helpers" made the pxa local
> variable in the sdhci_pxav3_remove function unused. Remove it.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks! I squashed this change into the commit which was causing the warning.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index e90a188..91b2aa9 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -397,7 +397,6 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_pxa *pxa = pltfm_host->priv;
>
>         pm_runtime_get_sync(&pdev->dev);
>         sdhci_remove_host(host, 1);
> --
> Regards,
>
> Laurent Pinchart
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
