From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH RESEND] au1xmmc.c: use resource_size()
Date: Fri, 27 Aug 2010 20:26:26 +0100
Message-ID: <20100827192626.GD7258@console-pimps.org>
References: <BD79186B4FD85F4B8E60E381CAEE19090200E9FB@mi8nycmail19.Mi8.com>
 <20100827191134.GF20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:42134 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751389Ab0H0T02 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 15:26:28 -0400
Content-Disposition: inline
In-Reply-To: <20100827191134.GF20407@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>

[Adding maintainer to CC]

On Fri, Aug 27, 2010 at 08:11:34PM +0100, Chris Ball wrote:
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> Date: Mon, 14 Dec 2009 14:28:06 -0500
> 
> Use resource_size().
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> [cjb: rebased patch against Linus]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/au1xmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index c8da5d3..e14b866 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -964,7 +964,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
>  		goto out1;
>  	}
>  
> -	host->ioarea = request_mem_region(r->start, r->end - r->start + 1,
> +	host->ioarea = request_mem_region(r->start, resource_size(r),
>  					   pdev->name);
>  	if (!host->ioarea) {
>  		dev_err(&pdev->dev, "mmio already in use\n");
> -- 
> 1.7.0.1
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
