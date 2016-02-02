From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix pm runtime unbalanced issue in
 error path
Date: Tue, 2 Feb 2016 12:32:29 +0100
Message-ID: <CAPDyKFoAHPVHybhZG4BRcWHe8rm4MF0env0LfOuV2V5KZ9OaYQ@mail.gmail.com>
References: <1453804954-3490-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34457 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbcBBLca (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 06:32:30 -0500
Received: by mail-yk0-f173.google.com with SMTP id u9so49270018ykd.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 03:32:29 -0800 (PST)
In-Reply-To: <1453804954-3490-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 26 January 2016 at 11:42, Jisheng Zhang <jszhang@marvell.com> wrote:
> The device power usage counter is increased by pm_runtime_get_noresume
> but isn't decreased in err_add_host error path.
>
> Fix this issue by calling pm_runtime_put_noidle() in the error path to
> restore the device's power usage counter.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Fixes: f5f17813ae9b ("mmc: sdhci-of-at91: add PM support)
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 7db7163..3bf6f31 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -210,7 +210,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>
>  pm_runtime_disable:
>         pm_runtime_disable(&pdev->dev);
> -       pm_runtime_set_suspended(&pdev->dev);

What's the reason you want to remove the call to
pm_runtime_set_suspended()? I think it could stay.

> +       pm_runtime_put_noidle(&pdev->dev);
>  clocks_disable_unprepare:
>         clk_disable_unprepare(priv->gck);
>         clk_disable_unprepare(priv->mainck);
> --
> 2.7.0
>

Kind regards
Uffe
