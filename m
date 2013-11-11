From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] mmc: sdhci: supporting PCI MSI
Date: Mon, 11 Nov 2013 16:35:28 +0800
Message-ID: <528096D0.2020300@intel.com>
References: <1383299119-3952-1-git-send-email-Jackey.Shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44157 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab3KKIeq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Nov 2013 03:34:46 -0500
In-Reply-To: <1383299119-3952-1-git-send-email-Jackey.Shen@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jackey Shen <Jackey.Shen@amd.com>, linux-mmc@vger.kernel.org
Cc: mcuos.com@gmail.com, Ray.Huang@amd.com, jackey.shen.bo@gmail.com

On 11/01/2013 05:45 PM, Jackey Shen wrote:
> Enable MSI support in sdhci-pci driver and provide the mechanism
> to fall back to Legacy Pin-based Interrupt if MSI register fails.

Also note the following thread:
http://marc.info/?l=linux-mmc&m=133346937412708&w=2

Thanks,
Aaron

> 
> Signed-off-by: Jackey Shen <Jackey.Shen@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/mmc/host/Kconfig  |  11 +++++
>  drivers/mmc/host/sdhci.c  | 108 ++++++++++++++++++++++++++++++++++++++++------
>  include/linux/mmc/sdhci.h |   2 +
>  3 files changed, 109 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..a56cf27 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -68,6 +68,17 @@ config MMC_SDHCI_PCI
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_PCI_MSI
> +	bool "SDHCI support with MSI on PCI bus"
> +	depends on MMC_SDHCI_PCI && PCI_MSI
> +	help
> +	  This enables PCI MSI (Message Signaled Interrupts) for Secure
> +	  Digital Host Controller Interface.
> +
> +	  If you have a controller with this capability, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_RICOH_MMC
>  	bool "Ricoh MMC Controller Disabler"
>  	depends on MMC_SDHCI_PCI
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6785fb1..de509bc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -13,6 +13,10 @@
>   *     - JMicron (hardware and technical support)
>   */
>  
> +#ifdef CONFIG_MMC_SDHCI_PCI_MSI
> +#include <linux/pci.h>
> +#endif
> +
>  #include <linux/delay.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> @@ -2520,6 +2524,64 @@ out:
>  	return result;
>  }
>  
> +#ifdef CONFIG_MMC_SDHCI_PCI_MSI
> +static int sdhci_setup_msi(struct sdhci_host *host)
> +{
> +	int ret;
> +	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
> +
> +	host->msi_enabled = false;
> +
> +	ret = pci_enable_msi(pdev);
> +	if (ret) {
> +		pr_warn("%s: Failed to allocate MSI entry\n",
> +			mmc_hostname(host->mmc));
> +		return ret;
> +	}
> +
> +	ret = request_irq(pdev->irq, sdhci_irq, 0,
> +		mmc_hostname(host->mmc), host);
> +	if (ret) {
> +		pr_warn("%s: Failed to request MSI IRQ %d: %d\n",
> +		       mmc_hostname(host->mmc), pdev->irq, ret);
> +		pci_disable_msi(pdev);
> +		return ret;
> +	}
> +
> +	host->irq = pdev->irq;
> +	host->msi_enabled = true;
> +	return ret;
> +}
> +
> +static int sdhci_try_enable_msi(struct sdhci_host *host)
> +{
> +	return sdhci_setup_msi(host);
> +}
> +
> +static void sdhci_cleanup_msi(struct sdhci_host *host)
> +{
> +	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
> +
> +	free_irq(host->irq, host);
> +	if (host->msi_enabled) {
> +		pci_disable_msi(pdev);
> +		host->msi_enabled = false;
> +	}
> +}
> +
> +#else
> +
> +static int sdhci_try_enable_msi(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +
> +static void sdhci_cleanup_msi(struct sdhci_host *host)
> +{
> +	free_irq(host->irq, host);
> +}
> +#endif /* CONFIG_MMC_SDHCI_PCI_MSI */
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Suspend/resume                                                            *
> @@ -2569,7 +2631,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  
>  	if (!device_may_wakeup(mmc_dev(host->mmc))) {
>  		sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
> -		free_irq(host->irq, host);
> +		/* free any IRQ and disable MSI */
> +		sdhci_cleanup_msi(host);
>  	} else {
>  		sdhci_enable_irq_wakeups(host);
>  		enable_irq_wake(host->irq);
> @@ -2589,10 +2652,22 @@ int sdhci_resume_host(struct sdhci_host *host)
>  	}
>  
>  	if (!device_may_wakeup(mmc_dev(host->mmc))) {
> -		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> -				  mmc_hostname(host->mmc), host);
> +		/* try to enable MSI */
> +		ret = sdhci_try_enable_msi(host);
>  		if (ret)
> -			return ret;
> +			pr_warn("%s: Fall back to Legacy Pin-based Interrupt: %d\n",
> +				mmc_hostname(host->mmc), ret);
> +
> +		if (!host->msi_enabled) {
> +			/* fall back to legacy pin-based interrupt */
> +			ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> +					mmc_hostname(host->mmc), host);
> +			if (ret) {
> +				pr_err("%s: Failed to request IRQ %d: %d\n",
> +					 mmc_hostname(host->mmc), host->irq, ret);
> +				return ret;
> +			}
> +		}
>  	} else {
>  		sdhci_disable_irq_wakeups(host);
>  		disable_irq_wake(host->irq);
> @@ -3212,12 +3287,21 @@ int sdhci_add_host(struct sdhci_host *host)
>  
>  	sdhci_init(host, 0);
>  
> -	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> -		mmc_hostname(mmc), host);
> -	if (ret) {
> -		pr_err("%s: Failed to request IRQ %d: %d\n",
> -		       mmc_hostname(mmc), host->irq, ret);
> -		goto untasklet;
> +	/* try to enable MSI */
> +	ret = sdhci_try_enable_msi(host);
> +	if (ret)
> +		pr_warn("%s: Fall back to Legacy Pin-based Interrupt: %d\n",
> +			mmc_hostname(host->mmc), ret);
> +
> +	if (!host->msi_enabled) {
> +		/* fall back to legacy pin-based interrupt */
> +		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> +				mmc_hostname(host->mmc), host);
> +		if (ret) {
> +			pr_err("%s: Failed to request IRQ %d: %d\n",
> +				 mmc_hostname(host->mmc), host->irq, ret);
> +			goto untasklet;
> +		}
>  	}
>  
>  #ifdef CONFIG_MMC_DEBUG
> @@ -3257,7 +3341,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  reset:
>  	sdhci_reset(host, SDHCI_RESET_ALL);
>  	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
> -	free_irq(host->irq, host);
> +	sdhci_cleanup_msi(host);
>  #endif
>  untasklet:
>  	tasklet_kill(&host->card_tasklet);
> @@ -3300,7 +3384,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  		sdhci_reset(host, SDHCI_RESET_ALL);
>  
>  	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
> -	free_irq(host->irq, host);
> +	sdhci_cleanup_msi(host);
>  
>  	del_timer_sync(&host->timer);
>  
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 3e781b8..3812479 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -99,6 +99,8 @@ struct sdhci_host {
>  /* Controller has a non-standard host control register */
>  #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
>  
> +	bool msi_enabled;	/* SD host controller with PCI MSI enabled */
> +
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
>  
> 

