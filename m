From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-pxav3: fix platform_data is not initialized
Date: Fri, 24 Jul 2015 09:40:25 +0200
Message-ID: <CAPDyKFohNdX6r-FR5FDprqQsF2OUFpYP0LaT90=cOG9iHF_8gw@mail.gmail.com>
References: <1437700545-14660-1-git-send-email-houjingj@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33642 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbGXHk0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2015 03:40:26 -0400
Received: by qged69 with SMTP id d69so7247444qge.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2015 00:40:25 -0700 (PDT)
In-Reply-To: <1437700545-14660-1-git-send-email-houjingj@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingju Hou <houjingj@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 24 July 2015 at 03:15, Jingju Hou <houjingj@marvell.com> wrote:
> pdev->dev.platform_data is not initialized if match is true in function
> sdhci_pxav3_probe. Just local variable pdata is assigned the return value
> from function pxav3_get_mmc_pdata().
>
> static int sdhci_pxav3_probe(struct platform_device *pdev) {
>
>     struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>     ...
>     if (match) {
>                 ret = mmc_of_parse(host->mmc);
>                 if (ret)
>                         goto err_of_parse;
>                 sdhci_get_of_property(pdev);
>                 pdata = pxav3_get_mmc_pdata(dev);
>      }
>      ...
> }
>
> Signed-off-by: Jingju Hou <houjingj@marvell.com>
> Fixes: b650352dd3df("mmc: sdhci-pxa: Add device tree support")

You didn't need to send a v3, I have already queued the v2. I assume
this one only change in v3 is the small white space change, right?

BTW, until next time you send a patch, it helps if you add version
history such one can follow what changed.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pxav3.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 9cd5fc6..946d37f 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -411,6 +411,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>                         goto err_of_parse;
>                 sdhci_get_of_property(pdev);
>                 pdata = pxav3_get_mmc_pdata(dev);
> +               pdev->dev.platform_data = pdata;
>         } else if (pdata) {
>                 /* on-chip device */
>                 if (pdata->flags & PXA_FLAG_CARD_PERMANENT)
> --
> 1.7.9.5
>
