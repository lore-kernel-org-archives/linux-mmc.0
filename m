From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: pxamci: prepare and unprepare the clocks
Date: Mon, 01 Sep 2014 11:09:27 +0200
Message-ID: <87bnqz6720.fsf@free.fr>
References: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:37300 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbaIAJRZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 05:17:25 -0400
In-Reply-To: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr> (Robert
	Jarzmik's message of "Mon, 9 Jun 2014 21:56:14 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Add the clock prepare and unprepare call to the driver initialization
> phase. This will remove a warning once the PXA architecture is migrated
> to the clock infrastructure.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Ping ?

--
Robert

> ---
>  drivers/mmc/host/pxamci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 32fe113..f0f2074 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -681,6 +681,9 @@ static int pxamci_probe(struct platform_device *pdev)
>  		host->clk = NULL;
>  		goto out;
>  	}
> +	ret = clk_prepare(host->clk);
> +	if (ret)
> +		goto out;
>  
>  	host->clkrate = clk_get_rate(host->clk);
>  
> @@ -820,8 +823,10 @@ err_gpio_ro:
>  			iounmap(host->base);
>  		if (host->sg_cpu)
>  			dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
> -		if (host->clk)
> +		if (host->clk) {
> +			clk_unprepare(host->clk);
>  			clk_put(host->clk);
> +		}
>  	}
>  	if (mmc)
>  		mmc_free_host(mmc);
> @@ -871,6 +876,7 @@ static int pxamci_remove(struct platform_device *pdev)
>  		iounmap(host->base);
>  		dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>  
> +		clk_unprepare(host->clk);
>  		clk_put(host->clk);
>  
>  		release_resource(host->res);
