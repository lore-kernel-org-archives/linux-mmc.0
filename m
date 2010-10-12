From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Mon, 11 Oct 2010 20:06:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010112005300.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:41403 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab0JLAGJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 20:06:09 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0LA5004V9HM83K70@VL-MO-MR005.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 11 Oct 2010 20:06:09 -0400 (EDT)
In-reply-to: <loom.20101011T202734-842@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 11 Oct 2010, Dmitry Shmidt wrote:

> Hi,
> 
> While working with "permanent" mmc/sdio devices we may want to skip new 
> suspend/resume functionality.

Why ??



> 
> commit 4c40080bb1d4f68000b7a4c397c1bc8a623668fa
> Author: Dmitry Shmidt <dimitrysh@android.com>
> Date:   Mon Oct 11 11:28:54 2010 -0700
> 
>     mmc: Add "ignore mmc pm notify" functionality
>     
>     Signed-off-by: Dmitry Shmidt <dimitrysh@android.com>
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index d80cfdc..ba684e6 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -137,7 +137,8 @@ int mmc_add_host(struct mmc_host *host)
>  #endif
>  
>  	mmc_start_host(host);
> -	register_pm_notifier(&host->pm_notify);
> +	if (!(host->pm_flags & MMC_PM_IGNORE_PM_NOTIFY))
> +		register_pm_notifier(&host->pm_notify);
>  
>  	return 0;
>  }
> @@ -154,7 +155,9 @@ EXPORT_SYMBOL(mmc_add_host);
>   */
>  void mmc_remove_host(struct mmc_host *host)
>  {
> -	unregister_pm_notifier(&host->pm_notify);
> +	if (!(host->pm_flags & MMC_PM_IGNORE_PM_NOTIFY))
> +		unregister_pm_notifier(&host->pm_notify);
> +
>  	mmc_stop_host(host);
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
> index d37aac4..3903823 100644
> --- a/include/linux/mmc/pm.h
> +++ b/include/linux/mmc/pm.h
> @@ -26,5 +26,6 @@ typedef unsigned int mmc_pm_flag_t;
>  
>  #define MMC_PM_KEEP_POWER	(1 << 0)	/* preserve card power during 
> suspend */
>  #define MMC_PM_WAKE_SDIO_IRQ	(1 << 1)	/* wake up host system on SDIO 
> IRQ assertion */
> +#define MMC_PM_IGNORE_PM_NOTIFY	(1 << 2)	/* ignore mmc pm notify 
> */
>  
>  #endif
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
