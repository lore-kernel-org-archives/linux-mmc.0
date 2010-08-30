From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH RESEND] atmel-mci.c: use resource size()
Date: Mon, 30 Aug 2010 09:47:07 +0200
Message-ID: <4C7B61FB.6060301@atmel.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200E9EA@mi8nycmail19.Mi8.com> <20100827190955.GE20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:36161 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0H3ItN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2010 04:49:13 -0400
In-Reply-To: <20100827190955.GE20407@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, haavard.skinnemoen@atmel.com

Le 27/08/2010 21:09, Chris Ball :
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> Date: Mon, 14 Dec 2009 14:11:56 -0500
> 
> Use resource_size().
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> [cjb: rebased patch against Linus]
> Signed-off-by: Chris Ball <cjb@laptop.org>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

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


-- 
Nicolas Ferre

