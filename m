From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: tmio: eliminate unused variable 'mmc' warning
Date: Wed, 3 Aug 2011 09:26:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108030924440.28502@axis700.grange>
References: <1312354138.14329.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50469 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab1HCH0u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Aug 2011 03:26:50 -0400
In-Reply-To: <1312354138.14329.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, 3 Aug 2011, Axel Lin wrote:

> Fix below compile warning:
>   CC      drivers/mmc/host/tmio_mmc.o
> drivers/mmc/host/tmio_mmc.c: In function 'tmio_mmc_suspend':
> drivers/mmc/host/tmio_mmc.c:30: warning: unused variable 'mmc'
> drivers/mmc/host/tmio_mmc.c: In function 'tmio_mmc_resume':
> drivers/mmc/host/tmio_mmc.c:45: warning: unused variable 'mmc'
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Good for 3.1, do we also push such "harmless" compiler warning fixes to 
stable?

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/mmc/host/tmio_mmc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 8d185de..44a9668 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -27,7 +27,6 @@
>  static int tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
>  {
>  	const struct mfd_cell *cell = mfd_get_cell(dev);
> -	struct mmc_host *mmc = platform_get_drvdata(dev);
>  	int ret;
>  
>  	ret = tmio_mmc_host_suspend(&dev->dev);
> @@ -42,7 +41,6 @@ static int tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
>  static int tmio_mmc_resume(struct platform_device *dev)
>  {
>  	const struct mfd_cell *cell = mfd_get_cell(dev);
> -	struct mmc_host *mmc = platform_get_drvdata(dev);
>  	int ret = 0;
>  
>  	/* Tell the MFD core we are ready to be enabled */
> -- 
> 1.7.4.1
> 
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
