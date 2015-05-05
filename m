From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-{pxav2,pxav3}: Use of_match_ptr() macro
Date: Tue, 5 May 2015 17:24:29 +0800
Message-ID: <20150505172429.4711e86f@xhacker>
References: <1430817114.20613.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40735 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031446AbbEEJ1e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 05:27:34 -0400
In-Reply-To: <1430817114.20613.1.camel@ingics.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, 5 May 2015 02:11:54 -0700
Axel Lin <axel.lin@ingics.com> wrote:

> This eliminates having an #ifdef returning NULL for the case
> when OF is disabled.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 4 +---
>  drivers/mmc/host/sdhci-pxav3.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index f98008b..beffd86 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -252,9 +252,7 @@ static int sdhci_pxav2_remove(struct platform_device *pdev)
>  static struct platform_driver sdhci_pxav2_driver = {
>  	.driver		= {
>  		.name	= "sdhci-pxav2",
> -#ifdef CONFIG_OF
> -		.of_match_table = sdhci_pxav2_of_match,
> -#endif
> +		.of_match_table = of_match_ptr(sdhci_pxav2_of_match),
>  		.pm	= SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe		= sdhci_pxav2_probe,
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index b5103a2..01cb2d3 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -578,9 +578,7 @@ static const struct dev_pm_ops sdhci_pxav3_pmops = {
>  static struct platform_driver sdhci_pxav3_driver = {
>  	.driver		= {
>  		.name	= "sdhci-pxav3",
> -#ifdef CONFIG_OF
> -		.of_match_table = sdhci_pxav3_of_match,
> -#endif
> +		.of_match_table = of_match_ptr(sdhci_pxav3_of_match),
>  		.pm	= SDHCI_PXAV3_PMOPS,
>  	},
>  	.probe		= sdhci_pxav3_probe,

Looks good to me.

Thanks
