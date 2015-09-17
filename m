From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [patch] mmc: sdhci-of-at91: remove a line of dead code
Date: Thu, 17 Sep 2015 08:46:22 +0200
Message-ID: <20150917064622.GS32379@odux.rfo.atmel.com>
References: <20150916061949.GA21542@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:9547 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbbIQGu0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2015 02:50:26 -0400
Content-Disposition: inline
In-Reply-To: <20150916061949.GA21542@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Sep 16, 2015 at 09:19:49AM +0300, Dan Carpenter wrote:
> The goto is correct and the unreachable "return -EINVAL" should be
> removed.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Of course
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index d155664..d3df786 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -110,7 +110,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to set gck");
>  		goto hclock_disable_unprepare;
> -		return -EINVAL;
>  	}
>  	/*
>  	 * We need to check if we have the requested rate for gck because in
