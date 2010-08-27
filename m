From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH RESEND] atmel-mci.c: use resource size()
Date: Fri, 27 Aug 2010 20:25:19 +0100
Message-ID: <20100827192519.GC7258@console-pimps.org>
References: <BD79186B4FD85F4B8E60E381CAEE19090200E9EA@mi8nycmail19.Mi8.com>
 <20100827190955.GE20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:42125 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751401Ab0H0TZW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 15:25:22 -0400
Content-Disposition: inline
In-Reply-To: <20100827190955.GE20407@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, haavard.skinnemoen@atmel.com, Nicolas Ferre <nicolas.ferre@atmel.com>

[Adding Nicolas to Cc]

On Fri, Aug 27, 2010 at 08:09:55PM +0100, Chris Ball wrote:
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> Date: Mon, 14 Dec 2009 14:11:56 -0500
> 
> Use resource_size().
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> [cjb: rebased patch against Linus]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/atmel-mci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 95ef864..1d4e546 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1777,7 +1777,7 @@ static int __init atmci_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = -ENOMEM;
> -	host->regs = ioremap(regs->start, regs->end - regs->start + 1);
> +	host->regs = ioremap(regs->start, resource_size(regs));
>  	if (!host->regs)
>  		goto err_ioremap;
>  
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
