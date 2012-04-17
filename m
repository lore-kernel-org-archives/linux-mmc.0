From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] mmc: cd-gpio.c: Include header to pickup exported
 symbol prototypes
Date: Tue, 17 Apr 2012 22:31:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204172230540.27488@axis700.grange>
References: <201204171303.39744.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57763 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab2DQUbX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 16:31:23 -0400
In-Reply-To: <201204171303.39744.hartleys@visionengravers.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, svenkatr@ti.com

On Tue, 17 Apr 2012, H Hartley Sweeten wrote:

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
> Acked-by: Venkatraman S <svenkatr@ti.com>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> 
> ---
> 
> v2: add new header alphabetically
> 
> diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
> index 29de31e..2c14be7 100644
> --- a/drivers/mmc/core/cd-gpio.c
> +++ b/drivers/mmc/core/cd-gpio.c
> @@ -12,6 +12,7 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
> +#include <linux/mmc/cd-gpio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
