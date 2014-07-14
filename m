From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/6] mmc: sdhci-s3c: Fix local I/O clock gating
Date: Mon, 14 Jul 2014 17:05:29 +0900
Message-ID: <53C38F49.7050504@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-2-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9079 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaGNIFc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jul 2014 04:05:32 -0400
In-reply-to: <1403618235-19353-2-git-send-email-t.figa@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 06/24/2014 10:57 PM, Tomasz Figa wrote:
> For internal card detection mechanism it is required that the local I/O
> clock is always running. However while current implementation accounts
> for this, it does so incorrectly leading to race conditions and warnings
> about unbalanced clock disables.
> 
> This patch fixes it by inverting the logic, which now increases local
> I/O clock enable count when internal card detect is used, instead of
> decreasing it otherwise.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-s3c.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index fa5954a..1795e1f 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -487,8 +487,13 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>  		goto err_pdata_io_clk;
>  	}
>  
> -	/* enable the local io clock and keep it running for the moment. */
> -	clk_prepare_enable(sc->clk_io);
> +	/*
> +	 * Keep local I/O clock enabled for internal card detect pin
> +	 * or runtime PM is disabled.
> +	 */
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL
> +	    || !IS_ENABLED(CONFIG_PM_RUNTIME))
> +		clk_prepare_enable(sc->clk_io);
>  
>  	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>  		char name[14];
> @@ -611,15 +616,13 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>  		goto err_req_regs;
>  	}
>  
> -#ifdef CONFIG_PM_RUNTIME
> -	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
> -		clk_disable_unprepare(sc->clk_io);
> -#endif
>  	return 0;
>  
>   err_req_regs:
>   err_no_busclks:
> -	clk_disable_unprepare(sc->clk_io);
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL
> +	    || !IS_ENABLED(CONFIG_PM_RUNTIME))
> +		clk_disable_unprepare(sc->clk_io);
>  
>   err_pdata_io_clk:
>  	sdhci_free_host(host);
> 

