From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mmcif: fix use after free
Date: Mon, 29 Oct 2012 17:23:28 -0400
Message-ID: <878vapq8fj.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1210231406080.13115@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35441 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812Ab2J2VXd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 17:23:33 -0400
In-Reply-To: <Pine.LNX.4.64.1210231406080.13115@axis700.grange> (Guennadi
	Liakhovetski's message of "Tue, 23 Oct 2012 14:08:52 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Guennadi,

On Tue, Oct 23 2012, Guennadi Liakhovetski wrote:
> A recent commit "mmc: sh_mmcif: fix clock management" has introduced a use
> after free bug in sh_mmcif.c: in sh_mmcif_remove() the call to
> mmc_free_host() frees private driver data, therefore using it afterwards
> is a bug. Revert that hunk.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Chris, the offending patch appeared in 3.6, so, this has to go to 
> 3.6.stable, as well as to 3.7-rc.
>
>  drivers/mmc/host/sh_mmcif.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 11d2bc3..d25bc97 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1466,9 +1466,9 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, NULL);
>  
> +	clk_disable(host->hclk);
>  	mmc_free_host(host->mmc);
>  	pm_runtime_put_sync(&pdev->dev);
> -	clk_disable(host->hclk);
>  	pm_runtime_disable(&pdev->dev);
>  
>  	return 0;

Thanks, pushed to mmc-next for 3.7.  In future, feel free to note the
stable@ situation by adding:

   Cc: stable@vger.kernel.org [3.6]

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
