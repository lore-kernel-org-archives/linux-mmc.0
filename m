From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] omap_hsmmc: Remove unused state variable
Date: Tue, 08 Jun 2010 22:57:58 +0100
Message-ID: <87vd9t426x.fsf@linux-g6p1.site>
References: <1276029700-27900-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:35564 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756704Ab0FHV6A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2010 17:58:00 -0400
In-Reply-To: <1276029700-27900-1-git-send-email-saaguirre@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>, linux-mmc@vger.kernel.org

On Tue,  8 Jun 2010 15:41:40 -0500, Sergio Aguirre <saaguirre@ti.com> wrote:
> This fixes the following warning:
> 
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
> drivers/mmc/host/omap_hsmmc.c:2275: warning: unused variable 'state'
> 
> Introduced by commit ID:
> 
>   commit 1a13f8fa76c880be41d6b1e6a2b44404bcbfdf9e
>   Author: Matt Fleming <matt@console-pimps.org>
>   Date:   Wed May 26 14:42:08 2010 -0700
> 
>       mmc: remove the "state" argument to mmc_suspend_host()
> 
> The unique usage of this var was removed there, and missed
> removing the respective declaration aswell.
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b032828..d50e917 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2272,7 +2272,6 @@ static int omap_hsmmc_suspend(struct device *dev)
>  	int ret = 0;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
> -	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
>  
>  	if (host && host->suspended)
>  		return 0;
> -- 
> 1.6.3.3
> 

Oops. Thanks for catching that.

Acked-by: Matt Fleming <matt@console-pimps.org>
