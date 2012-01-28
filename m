From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: use PM QoS instead of delayed clock gating for PM
Date: Sat, 28 Jan 2012 14:11:41 +0100
Message-ID: <201201281411.41681.rjw@sisk.pl>
References: <Pine.LNX.4.64.1201191631210.12537@axis700.grange> <Pine.LNX.4.64.1201191717590.12537@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54260 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab2A1NIF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 28 Jan 2012 08:08:05 -0500
In-Reply-To: <Pine.LNX.4.64.1201191717590.12537@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org

Hi,

On Thursday, January 19, 2012, Guennadi Liakhovetski wrote:
> Using delayed clock gating to prevent too frequent gating of the clock
> is simple and efficient, but too inflexible.

I'd mention that you're working around the change made by commit
597dd9d79cfbbb1636d00a7fd0880355d9b20c41.

> We use PM QoS instead to
> let the runtime PM subsystem decide, which power states can be entered
> at any specific time, depending on the currently active governor.

Do I understand correctly that this is going to work, because
sh_mmcif_set_ios() uses pm_runtime_put() while powering off and
pm_runtime_get_sync() when powering on the device?

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/mmc/host/sh_mmcif.c |   27 ++++++++++++++++++++++++---
>  1 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 497e6f4..5a922be 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -55,6 +55,7 @@
>  #include <linux/mmc/sh_mmcif.h>
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  #include <linux/module.h>
> @@ -226,6 +227,7 @@ struct sh_mmcif_host {
>  	size_t blocksize;
>  	int sg_idx;
>  	int sg_blkidx;

The fields above are not present in the current mainline tree I have here.

> +	struct dev_pm_qos_request pm_qos;
>  	bool power;
>  	bool card_present;
>  
> @@ -977,10 +979,26 @@ static int sh_mmcif_get_cd(struct mmc_host *mmc)
>  		return p->get_cd(host->pd);
>  }
>  
> +static int sh_mmcif_enable(struct mmc_host *mmc)
> +{
> +	struct sh_mmcif_host *host = mmc_priv(mmc);
> +	dev_pm_qos_add_request(mmc->parent, &host->pm_qos, 100);

Why is the request added for the parent?

> +	return 0;
> +}
> +
> +static int sh_mmcif_disable(struct mmc_host *mmc, int lazy)
> +{
> +	struct sh_mmcif_host *host = mmc_priv(mmc);
> +	dev_pm_qos_remove_request(&host->pm_qos);
> +	return 0;
> +}
> +
>  static struct mmc_host_ops sh_mmcif_ops = {
>  	.request	= sh_mmcif_request,
>  	.set_ios	= sh_mmcif_set_ios,
>  	.get_cd		= sh_mmcif_get_cd,
> +	.enable		= sh_mmcif_enable,
> +	.disable	= sh_mmcif_disable,
>  };
>  
>  static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
> @@ -1061,7 +1079,6 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>  {
>  	struct sh_mmcif_host *host = dev_id;
>  	struct mmc_request *mrq = host->mrq;
> -	struct mmc_data *data = mrq->data;

I'm not sure why this is necessary?

>  	cancel_delayed_work_sync(&host->timeout_work);
>  
> @@ -1109,13 +1126,15 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
>  	case MMCIF_WAIT_FOR_READ_END:
>  	case MMCIF_WAIT_FOR_WRITE_END:
>  		if (host->sd_error)
> -			data->error = sh_mmcif_error_manage(host);
> +			mrq->data->error = sh_mmcif_error_manage(host);
>  		break;
>  	default:
>  		BUG();
>  	}
>  
>  	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
> +		struct mmc_data *data = mrq->data;
> +
>  		if (!mrq->cmd->error && data && !data->error)
>  			data->bytes_xfered =
>  				data->blocks * data->blksz;
> @@ -1303,12 +1322,14 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>  		mmc->f_min = mmc->f_max / 512;
>  	if (pd->ocr)
>  		mmc->ocr_avail = pd->ocr;
> -	mmc->caps = MMC_CAP_MMC_HIGHSPEED | pd->caps;
> +	mmc->caps = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_DISABLE | pd->caps;
>  	mmc->max_segs = 32;
>  	mmc->max_blk_size = 512;
>  	mmc->max_req_size = PAGE_CACHE_SIZE * mmc->max_segs;
>  	mmc->max_blk_count = mmc->max_req_size / mmc->max_blk_size;
>  	mmc->max_seg_size = mmc->max_req_size;
> +	/* disable delayed clock gating, we use PM QoS for precise PM */
> +	mmc->clkgate_delay = 0;

This isn't sufficient, because clkgate_delay may be changed by user space
at any time later.

>  	sh_mmcif_sync_reset(host);
>  	platform_set_drvdata(pdev, host);
> 

Thanks,
Rafael
