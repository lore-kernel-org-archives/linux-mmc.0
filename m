From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v5 10/13] mmc: sdhci-pxav3: add quirks2
Date: Sat, 29 Sep 2012 15:47:33 +0800
Message-ID: <CAMj5BkjPEfcsrRPRtD=LeHcKUgF7hL1aY2EHb=cO-edmtBWucA@mail.gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
	<1348818972-26711-11-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49140 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab2I2Hrf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 29 Sep 2012 03:47:35 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so464059wgb.1
        for <linux-mmc@vger.kernel.org>; Sat, 29 Sep 2012 00:47:33 -0700 (PDT)
In-Reply-To: <1348818972-26711-11-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

On Fri, Sep 28, 2012 at 3:56 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c          |    2 ++
>  include/linux/platform_data/pxa_sdhci.h |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index ccd1906..60829c9 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -280,6 +280,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
>
>                 if (pdata->quirks)
>                         host->quirks |= pdata->quirks;
> +               if (pdata->quirks2)
> +                       host->quirks2 |= pdata->quirks2;
>                 if (pdata->host_caps)
>                         host->mmc->caps |= pdata->host_caps;
>                 if (pdata->host_caps2)
> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
> index 59acd98..fdf38d6 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -38,6 +38,7 @@
>   * @max_speed: the maximum speed supported
>   * @host_caps: Standard MMC host capabilities bit field.
>   * @quirks: quirks of platfrom
> + * @quirks2: quirks2 of platfrom
>   * @pm_caps: pm_caps of platfrom
>   */
>  struct sdhci_pxa_platdata {
> @@ -51,6 +52,7 @@ struct sdhci_pxa_platdata {
>         unsigned int    host_caps;
>         unsigned int    host_caps2;
>         unsigned int    quirks;
> +       unsigned int    quirks2;
>         unsigned int    pm_caps;
>  };
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
