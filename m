From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-{pxav2,pxav3}: Use of_match_ptr() macro
Date: Thu, 21 Mar 2013 20:41:13 +0800
Message-ID: <CADz5_gKeW7Xo3EWeQL43n1VE=UDvTZv=zgLWst730Z1ToggV-w@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEC869A4@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:62924 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758060Ab3CUMlO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Mar 2013 08:41:14 -0400
Received: by mail-ob0-f179.google.com with SMTP id un3so2743020obb.24
        for <linux-mmc@vger.kernel.org>; Thu, 21 Mar 2013 05:41:13 -0700 (PDT)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEC869A4@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@nvidia.com>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Axel Lin [mailto:axel.lin@ingics.com]
> Sent: Wednesday, March 20, 2013 3:49 PM
> To: Chris Ball
> Cc: Zhangfei Gao; Kevin Liu; Philip Rakity; linux-mmc@vger.kernel.org
> Subject: [PATCH] mmc: sdhci-{pxav2,pxav3}: Use of_match_ptr() macro
>
> This eliminates having an #ifdef returning NULL for the case
> when OF is disabled.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c |    4 +---
>  drivers/mmc/host/sdhci-pxav3.c |    4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index eeb7d43..d57c047 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -262,9 +262,7 @@ static struct platform_driver sdhci_pxav2_driver = {
>         .driver         = {
>                 .name   = "sdhci-pxav2",
>                 .owner  = THIS_MODULE,
> -#ifdef CONFIG_OF
> -               .of_match_table = sdhci_pxav2_of_match,
> -#endif
> +               .of_match_table = of_match_ptr(sdhci_pxav2_of_match),
>                 .pm     = SDHCI_PLTFM_PMOPS,
>         },
>         .probe          = sdhci_pxav2_probe,
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index a0cdbc5..bbadfbd 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -439,9 +439,7 @@ static const struct dev_pm_ops sdhci_pxav3_pmops = {
>  static struct platform_driver sdhci_pxav3_driver = {
>         .driver         = {
>                 .name   = "sdhci-pxav3",
> -#ifdef CONFIG_OF
> -               .of_match_table = sdhci_pxav3_of_match,
> -#endif
> +               .of_match_table = of_match_ptr(sdhci_pxav3_of_match),
>                 .owner  = THIS_MODULE,
>                 .pm     = SDHCI_PXAV3_PMOPS,
>         },
>

Reviewed-by: Kevin Liu <kliu5@marvell.com>

--
> 1.7.9.5
>
>
>
