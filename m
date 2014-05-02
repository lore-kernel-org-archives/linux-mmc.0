From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v10 2/5] mmc: omap_hsmmc: bug: abort runtime suspend if
 pending sdio irq detected
Date: Fri, 2 May 2014 20:25:40 +0530
Message-ID: <5363B1EC.9040206@ti.com>
References: <1398670860-30695-1-git-send-email-afenkart@gmail.com> <1398670860-30695-3-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38375 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaEBOzu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 May 2014 10:55:50 -0400
In-Reply-To: <1398670860-30695-3-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 28 April 2014 01:10 PM, Andreas Fenkart wrote:
> on multicores, an sdio irq handler could be running in parallel to
> runtime suspend. In the worst case it could be waiting for the spinlock
> held by the runtime suspend. When runtime suspend is complete and the
> functional clock (fclk) turned off, the irq handler will continue and
> cause a SIGBUS on the first register access.
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 700fb91..e675042 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -56,6 +56,7 @@
>   #define OMAP_HSMMC_RSP54	0x0118
>   #define OMAP_HSMMC_RSP76	0x011C
>   #define OMAP_HSMMC_DATA		0x0120
> +#define OMAP_HSMMC_PSTATE	0x0124
>   #define OMAP_HSMMC_HCTL		0x0128
>   #define OMAP_HSMMC_SYSCTL	0x012C
>   #define OMAP_HSMMC_STAT		0x0130
> @@ -2400,6 +2401,7 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
>   {
>   	struct omap_hsmmc_host *host;
>   	unsigned long flags;
> +	int ret = 0;
>
>   	host = platform_get_drvdata(to_platform_device(dev));
>   	omap_hsmmc_context_save(host);
> @@ -2411,14 +2413,29 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
>   		/* disable sdio irq handling to prevent race */
>   		OMAP_HSMMC_WRITE(host->base, ISE, 0);
>   		OMAP_HSMMC_WRITE(host->base, IE, 0);
> -		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +
> +		if (!(OMAP_HSMMC_READ(host->base, PSTATE) & BIT(21))) {

Please use #define for BIT(21), something like DLEV_DAT1

