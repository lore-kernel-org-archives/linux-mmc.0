From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] tmio_mmc / PM: Use PM QoS latency constraint
Date: Thu, 08 Mar 2012 10:02:34 +0200
Message-ID: <4F58679A.6060202@intel.com>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl> <201203080027.27435.rjw@sisk.pl> <201203080029.51225.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56263 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab2CHIC1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 03:02:27 -0500
In-Reply-To: <201203080029.51225.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>

On 08/03/12 01:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make tmio_mmc call dev_pm_qos_expose_latency_limit() to expose
> the PM QoS latency limit to user space and specify the initial
> value of it as 100 microseconds.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/mmc/host/tmio_mmc_pio.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux/drivers/mmc/host/tmio_mmc_pio.c
> ===================================================================
> --- linux.orig/drivers/mmc/host/tmio_mmc_pio.c
> +++ linux/drivers/mmc/host/tmio_mmc_pio.c
> @@ -39,6 +39,7 @@
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
> @@ -955,6 +956,8 @@ int __devinit tmio_mmc_host_probe(struct
>  
>  	mmc_add_host(mmc);
>  
> +	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
> +
>  	/* Unmask the IRQs we want to know about */
>  	if (!_host->chan_rx)
>  		irq_mask |= TMIO_MASK_READOP;
> @@ -993,6 +996,8 @@ void tmio_mmc_host_remove(struct tmio_mm
>  		|| host->mmc->caps & MMC_CAP_NONREMOVABLE)
>  		pm_runtime_get_sync(&pdev->dev);
>  
> +	dev_pm_qos_hide_latency_limit(&pdev->dev);

Is it really necessary to hide the latency limit before destroying the
device?  Presumably QoS code could (or does) take care of it.

> +
>  	mmc_remove_host(host->mmc);
>  	cancel_work_sync(&host->done);
>  	cancel_delayed_work_sync(&host->delayed_reset_work);
> 
> 

