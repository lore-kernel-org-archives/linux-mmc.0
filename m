From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: use the dev_pm_ops for dw_mmc controller
Date: Thu, 22 Dec 2011 14:33:01 +0000
Message-ID: <4EF33F9D.6070604@imgtec.com>
References: <4EE09007.6030800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:27362 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273Ab1LVOdH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Dec 2011 09:33:07 -0500
In-Reply-To: <4EE09007.6030800@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

On 12/08/2011 10:23 AM, Jaehoon Chung wrote:
> Dw_mmc controller didn't use dev_pm_ops.
> This patch modified to use the dev_pm_ops for dw_mmc controller
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Thanks

Acked-by: James Hogan <james.hogan@imgtec.com>

> ---
> Changelog v3:
> 	- Change CONFIG_PM_SLEEP instead of CONFIG_PM
> 	- using static for SIMPLE_DEV_PM_OPS
> Changelog v2:
> 	- Use the Macro for dev_pm_ops
> 
>  drivers/mmc/host/dw_mmc.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3aaeb08..44bc11e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2062,14 +2062,14 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
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
> @@ -2131,14 +2131,15 @@ static int dw_mci_resume(struct platform_device *pdev)
>  #else
>  #define dw_mci_suspend	NULL
>  #define dw_mci_resume	NULL
> -#endif /* CONFIG_PM */
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(dw_mci_pmops, dw_mci_suspend, dw_mci_resume);
>  
>  static struct platform_driver dw_mci_driver = {
>  	.remove		= __exit_p(dw_mci_remove),
> -	.suspend	= dw_mci_suspend,
> -	.resume		= dw_mci_resume,
>  	.driver		= {
>  		.name		= "dw_mmc",
> +		.pm		= &dw_mci_pmops,
>  	},
>  };
> 
>  -- 
> 1.7.4.1

