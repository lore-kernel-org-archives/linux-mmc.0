From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: use the dev_pm_ops for dw_mmccontroller
Date: Wed, 30 Nov 2011 10:06:41 +0000
Message-ID: <4ED60031.6040307@imgtec.com>
References: <4ED5B7DD.1060609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:10954 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660Ab1K3KWa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Nov 2011 05:22:30 -0500
In-Reply-To: <4ED5B7DD.1060609@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Thanks for the patch,

On 11/30/2011 04:58 AM, Jaehoon Chung wrote:
> Dw_mmc controller didn't use dev_pm_ops.
> This patch modified to use the dev_mp_ops for dw_mmc controller
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   24 +++++++++++++++---------
>  1 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3aaeb08..fc9beea 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2066,10 +2066,10 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
>  /*
>   * TODO: we should probably disable the clock to the card in the suspend path.
>   */
> -static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
> +static int dw_mci_suspend(struct device *dev)
>  {
>  	int i, ret;
> -	struct dw_mci *host = platform_get_drvdata(pdev);
> +	struct dw_mci *host = dev_get_drvdata(dev);
>  
>  	for (i = 0; i < host->num_slots; i++) {
>  		struct dw_mci_slot *slot = host->slot[i];
> @@ -2092,10 +2092,10 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
>  	return 0;
>  }
>  
> -static int dw_mci_resume(struct platform_device *pdev)
> +static int dw_mci_resume(struct device *dev)
>  {
>  	int i, ret;
> -	struct dw_mci *host = platform_get_drvdata(pdev);
> +	struct dw_mci *host = dev_get_drvdata(dev);
>  
>  	if (host->vmmc)
>  		regulator_enable(host->vmmc);
> @@ -2103,7 +2103,7 @@ static int dw_mci_resume(struct platform_device *pdev)
>  	if (host->dma_ops->init)
>  		host->dma_ops->init(host);
>  
> -	if (!mci_wait_reset(&pdev->dev, host)) {
> +	if (!mci_wait_reset(dev, host)) {
>  		ret = -ENODEV;
>  		return ret;
>  	}
> @@ -2128,17 +2128,23 @@ static int dw_mci_resume(struct platform_device *pdev)
>  
>  	return 0;
>  }
> +
> +static const struct dev_pm_ops dw_mci_pmops = {
> +	.suspend	= dw_mci_suspend,
> +	.resume		= dw_mci_resume,
> +};

If I understand the dev_pm_ops stuff right, the other callbacks will
need setting also so as not to break hibernation. It looks like there
are macros in include/linux/pm.h (such as SIMPLE_DEV_PM_OPS) which are
used in other drivers (e.g. see commit bdda821). Note how it can be used
outside the #ifdef (no need for DW_MCI_PMOPS), and the #ifdef is changed
to CONFIG_PM_SLEEP.

Other than that it looks fine.

Cheers
James

> +
> +#define DW_MCI_PMOPS	(&dw_mci_pmops)
> +
>  #else
> -#define dw_mci_suspend	NULL
> -#define dw_mci_resume	NULL
> +#define DW_MCI_PMOPS	NULL
>  #endif /* CONFIG_PM */
>  
>  static struct platform_driver dw_mci_driver = {
>  	.remove		= __exit_p(dw_mci_remove),
> -	.suspend	= dw_mci_suspend,
> -	.resume		= dw_mci_resume,
>  	.driver		= {
>  		.name		= "dw_mmc",
> +		.pm		= DW_MCI_PMOPS,
>  	},
>  };
>  

