From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pxav2: add error handling of
 clk_prepare_enable()
Date: Tue, 28 Feb 2017 13:55:31 +0200
Message-ID: <4a7a61c9-fb1f-1c43-c018-af019576ccec@intel.com>
References: <1486767286-3361-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41466 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbdB1MJ2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Feb 2017 07:09:28 -0500
In-Reply-To: <1486767286-3361-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Jisheng Zhang <jszhang@marvell.com>

On 11/02/17 00:54, Alexey Khoroshilov wrote:
> There is no check if clk_prepare_enable() succeed in sdhci_pxav2_probe().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pxav2.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 347eae2d7b6a..80513f54e9d4 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -185,7 +185,11 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  		goto err_clk_get;
>  	}
>  	pltfm_host->clk = clk;
> -	clk_prepare_enable(clk);
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable io clock\n");
> +		goto err_clk_enable;
> +	}
>  
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
>  		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> @@ -228,6 +232,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  
>  err_add_host:
>  	clk_disable_unprepare(clk);
> +err_clk_enable:
>  	clk_put(clk);
>  err_clk_get:
>  	sdhci_pltfm_free(pdev);
> 

