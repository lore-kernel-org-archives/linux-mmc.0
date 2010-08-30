From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH RESEND] at91_mci.c: use resource_size()
Date: Mon, 30 Aug 2010 09:45:50 +0200
Message-ID: <4C7B61AE.8010201@atmel.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200E9E8@mi8nycmail19.Mi8.com> <20100827190812.GD20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:36161 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0H3ItW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 04:49:22 -0400
In-Reply-To: <20100827190812.GD20407@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org

Le 27/08/2010 21:08, Chris Ball :
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> Date: Mon, 14 Dec 2009 14:10:26 -0500
> 
> Use resource_size().
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> [cjb: rebased patch against Linus]
> Signed-off-by: Chris Ball <cjb@laptop.org>

A bit late but you can add my:

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/mmc/host/at91_mci.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
> index 5f3a599..3995db3 100644
> --- a/drivers/mmc/host/at91_mci.c
> +++ b/drivers/mmc/host/at91_mci.c
> @@ -927,7 +927,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
>  	if (!res)
>  		return -ENXIO;
>  
> -	if (!request_mem_region(res->start, res->end - res->start + 1, DRIVER_NAME))
> +	if (!request_mem_region(res->start, resource_size(res), DRIVER_NAME))
>  		return -EBUSY;
>  
>  	mmc = mmc_alloc_host(sizeof(struct at91mci_host), &pdev->dev);
> @@ -1016,7 +1016,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
>  	/*
>  	 * Map I/O region
>  	 */
> -	host->baseaddr = ioremap(res->start, res->end - res->start + 1);
> +	host->baseaddr = ioremap(res->start, resource_size(res));
>  	if (!host->baseaddr) {
>  		ret = -ENOMEM;
>  		goto fail1;
> @@ -1092,7 +1092,7 @@ fail4b:
>  fail5:
>  	mmc_free_host(mmc);
>  fail6:
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
>  	dev_err(&pdev->dev, "probe failed, err %d\n", ret);
>  	return ret;
>  }
> @@ -1137,7 +1137,7 @@ static int __exit at91_mci_remove(struct platform_device *pdev)
>  
>  	iounmap(host->baseaddr);
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
>  
>  	mmc_free_host(mmc);
>  	platform_set_drvdata(pdev, NULL);


-- 
Nicolas Ferre

