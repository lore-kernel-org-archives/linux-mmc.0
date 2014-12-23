From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: remove unnecessary debug message
Date: Tue, 23 Dec 2014 16:35:55 +0100
Message-ID: <CAPDyKFrDAwfbEE+iox+BPidqe1Ar317ZPtFjsv-E+Y3HBWh9QQ@mail.gmail.com>
References: <1419336453-6411-1-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:52852 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbaLWPf4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Dec 2014 10:35:56 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so4796349qcx.31
        for <linux-mmc@vger.kernel.org>; Tue, 23 Dec 2014 07:35:55 -0800 (PST)
In-Reply-To: <1419336453-6411-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 23 December 2014 at 13:07, Beomho Seo <beomho.seo@samsung.com> wrote:
> This patch remove unnecessary 'out of memory' message on dw mmc driver.
>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    4 +---
>  drivers/mmc/host/dw_mmc.c        |    4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index f936704..74eb081 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -230,10 +230,8 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>         int ret;
>
>         priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> -       if (!priv) {
> -               dev_err(host->dev, "mem alloc failed for private data\n");
> +       if (!priv)
>                 return -ENOMEM;
> -       }
>
>         for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
>                 if (of_device_is_compatible(np, exynos_compat[idx].compatible))
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a1b80e5..6e4d864 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2546,10 +2546,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>         u32 clock_frequency;
>
>         pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -       if (!pdata) {
> -               dev_err(dev, "could not allocate memory for pdata\n");
> +       if (!pdata)
>                 return ERR_PTR(-ENOMEM);
> -       }
>
>         /* find out number of slots supported */
>         if (of_property_read_u32(dev->of_node, "num-slots",
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
