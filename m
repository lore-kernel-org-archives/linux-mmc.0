From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: controller is suspended too early
Date: Fri, 27 Nov 2015 15:11:58 +0100
Message-ID: <CAPDyKFpuemq05PZN6-p9gY6qvm23Fkxvr3u=4_xXPbBHeq4CRg@mail.gmail.com>
References: <1448556091-502-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33432 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbbK0OL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Nov 2015 09:11:59 -0500
Received: by ykdv3 with SMTP id v3so119136988ykd.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2015 06:11:58 -0800 (PST)
In-Reply-To: <1448556091-502-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

On 26 November 2015 at 17:41, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> When calling sdhci_add_host(), the controller is already suspended. It
> causes to read 0 in registers.
> Increment the device's usage counter before calling sdhci_add_host(),
> decrement it after and put it in suspend if it is possible.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: "mmc: sdhci-of-at91: add PM support"

Thanks, applied for next!

Actually I decided to squash this change into the "Fixes commit"
itself, thus not breaking bisecting.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 81ab9db..7e7d8f0 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -200,6 +200,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>
>         sdhci_get_of_property(pdev);
>
> +       pm_runtime_get_noresume(&pdev->dev);
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
>         pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> @@ -209,6 +210,8 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         if (ret)
>                 goto pm_runtime_disable;
>
> +       pm_runtime_put_autosuspend(&pdev->dev);
> +
>         return 0;
>
>  pm_runtime_disable:
> --
> 2.5.0
>
