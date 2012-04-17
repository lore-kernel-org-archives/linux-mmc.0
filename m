From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: cd-gpio.c: Include header to pickup exported symbol
 prototypes
Date: Tue, 17 Apr 2012 08:59:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204170847490.27075@axis700.grange>
References: <201204161824.26879.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59170 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2DQHAA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 03:00:00 -0400
In-Reply-To: <201204161824.26879.hartleys@visionengravers.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, cjb@laptop.org

Hi Hartley

Thanks for the patch.

On Mon, 16 Apr 2012, H Hartley Sweeten wrote:

> Include the linux/mmc/cd-gpio.h header to pickup the prototypes
> for the two exported symbols.
> 
> This quiets the sparse warnings:
> 
> warning: symbol 'mmc_cd_gpio_request' was not declared. Should it be static?
> warning: symbol 'mmc_cd_gpio_free' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> ---
> 
> diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
> index 29de31e..da7c3f9 100644
> --- a/drivers/mmc/core/cd-gpio.c
> +++ b/drivers/mmc/core/cd-gpio.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/cd-gpio.h>

Call me a pettyfogger, but please put the header above mmc/host.h, please, 
keep the alphabetic order.

>  #include <linux/module.h>
>  #include <linux/slab.h>
>  

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
