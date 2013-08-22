From: Balaji T K <balajitk@ti.com>
Subject: Re: [patch] mmc: omap_hsmmc: precedence bug in omap_hsmmc_context_restore()
Date: Thu, 22 Aug 2013 20:16:28 +0530
Message-ID: <52162444.1050908@ti.com>
References: <20130822125613.GB2543@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60419 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab3HVOqi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Aug 2013 10:46:38 -0400
In-Reply-To: <20130822125613.GB2543@elgon.mountain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thursday 22 August 2013 06:26 PM, Dan Carpenter wrote:
> '!' has higher precedence than '&' so this doesn't work as intended
> although since RESETDONE is 1 it would work if none of the other bits
> are set.
>
Hi Dan,

Thanks for the patch, Indeed other bits are reserved.
however ...

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Untested.
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1865321..7346b15 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -612,7 +612,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
>   	if (host->context_loss == context_loss)
>   		return 1;
>
> -	if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
> +	if (!(OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE))
>   		return 1;

This check is unnecessary, will send a patch to remove this.

