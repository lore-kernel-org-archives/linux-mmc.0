From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-pxav3: fix platform_data is not initialized
Date: Thu, 23 Jul 2015 14:30:07 +0200
Message-ID: <CAPDyKFr6pz2O7QS5YLfqFV31EhWn1eE3UehdKwMYa05iXCUEkA@mail.gmail.com>
References: <1437645384-13955-1-git-send-email-houjingj@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33241 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbbGWMaI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jul 2015 08:30:08 -0400
Received: by qkdl129 with SMTP id l129so171883211qkd.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2015 05:30:07 -0700 (PDT)
In-Reply-To: <1437645384-13955-1-git-send-email-houjingj@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingju Hou <houjingj@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 23 July 2015 at 11:56, Jingju Hou <houjingj@marvell.com> wrote:
> From: Jingju Hou<houjingj@marvell.com>
>
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
> Signed-off-by: Jingju Hou<houjingj@marvell.com>

Added a white-space before the "<".

> Fixes: b650352dd3df("mmc: sdhci-pxa: Add device tree support")

Thanks, applied for fixes!

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
