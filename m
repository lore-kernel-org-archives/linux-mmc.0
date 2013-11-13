From: Jackey Shen <jackey.shen@amd.com>
Subject: Re: [PATCH V2] mmc: sdhci: supporting PCI MSI
Date: Wed, 13 Nov 2013 13:55:08 +0800
Message-ID: <20131113055508.GA3755@ubuntu.amd.com>
References: <1384239413-7027-1-git-send-email-Jackey.Shen@amd.com>
 <5281DC68.3080606@intel.com>
 <20131112092716.GA7285@ubuntu.amd.com>
 <5282CDE2.60500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:5842 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751247Ab3KMFz4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2013 00:55:56 -0500
Content-Disposition: inline
In-Reply-To: <5282CDE2.60500@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: alexander.stein@systec-electronic.com, manuel.lauss@googlemail.com, hanfi@spahan.ch, linux-mmc@vger.kernel.org, mcuos.com@gmail.com, Ray.Huang@amd.com

On Wed, Nov 13, 2013 at 08:54:58AM +0800, Aaron Lu wrote:
> On 11/12/2013 05:27 PM, Jackey Shen wrote:
> > On Tue, Nov 12, 2013 at 03:44:40PM +0800, Aaron Lu wrote:
> >> On 11/12/2013 02:56 PM, Jackey Shen wrote:
> >>> Enable MSI support in sdhci-pci driver and provide the mechanism
> >>> to fall back to Legacy Pin-based Interrupt if MSI register fails.
> >>>
> >>> Tested with SD cards on AMD platform.
> >>>
> >>
> >> ->
> >>
> >>> Change from V1:
> >>> - implement this PCI MSI feature in sdhci-pci.c instead of sdhci.c
> >>
> >> Such words can be placed under the --- below so that it will not appear
> >> in git log.
> >>
> >>>
> >>> Signed-off-by: Jackey Shen <Jackey.Shen@amd.com>
> >>> Reviewed-by: Huang Rui <ray.huang@amd.com>
> >>> ---
> >>
> >> ->
> >> Put change related info Here.
> > 
> > OK. I will update my patch.
> > 
> >>
> >>>  drivers/mmc/host/Kconfig     | 11 +++++++++
> >>>  drivers/mmc/host/sdhci-pci.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
> >>>  drivers/mmc/host/sdhci.c     | 42 ++++++++++++++++++++++++++------
> >>>  drivers/mmc/host/sdhci.h     |  2 ++
> >>>  include/linux/mmc/sdhci.h    |  2 ++
> >>>  5 files changed, 107 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>> index 7fc5099..a56cf27 100644
> >>> --- a/drivers/mmc/host/Kconfig
> >>> +++ b/drivers/mmc/host/Kconfig
> >>> @@ -68,6 +68,17 @@ config MMC_SDHCI_PCI
> >>>  
> >>>  	  If unsure, say N.
> >>>  
> >>> +config MMC_SDHCI_PCI_MSI
> >>> +	bool "SDHCI support with MSI on PCI bus"
> >>> +	depends on MMC_SDHCI_PCI && PCI_MSI
> >>> +	help
> >>> +	  This enables PCI MSI (Message Signaled Interrupts) for Secure
> >>> +	  Digital Host Controller Interface.
> >>> +
> >>> +	  If you have a controller with this capability, say Y or M here.
> >>> +
> >>> +	  If unsure, say N.
> >>> +
> >>>  config MMC_RICOH_MMC
> >>>  	bool "Ricoh MMC Controller Disabler"
> >>>  	depends on MMC_SDHCI_PCI
> >>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> >>> index 8f75381..2ca29c0 100644
> >>> --- a/drivers/mmc/host/sdhci-pci.c
> >>> +++ b/drivers/mmc/host/sdhci-pci.c
> >>> @@ -1143,10 +1143,68 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
> >>>  		slot->hw_reset(host);
> >>>  }
> >>>  
> >>> +#ifdef CONFIG_MMC_SDHCI_PCI_MSI
> >>> +static int sdhci_pci_setup_msi(struct sdhci_host *host, irq_handler_t handler)
> >>> +{
> >>> +	int ret;
> >>> +	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
> >>> +
> >>> +	host->msi_enabled = false;
> >>> +
> >>> +	ret = pci_enable_msi(pdev);
> >>> +	if (ret) {
> >>> +		pr_warn("%s: Failed to allocate MSI entry\n",
> >>> +			mmc_hostname(host->mmc));
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	ret = request_irq(pdev->irq, handler, 0,
> >>> +		mmc_hostname(host->mmc), host);
> >>> +	if (ret) {
> >>> +		pr_warn("%s: Failed to request MSI IRQ %d: %d\n",
> >>> +		       mmc_hostname(host->mmc), pdev->irq, ret);
> >>> +		pci_disable_msi(pdev);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	host->irq = pdev->irq;
> >>> +	host->msi_enabled = true;
> >>> +	return ret;
> >>> +}
> >>
> >> What about we only call pci_enable_msi in sdhci-pci.c and then assign
> >> host->irq appropriately before calling sdhci_add_host, will that work?
> >> The only difference would be, request_irq will have SHARED flag, but I
> >> suppose that's not a problem.
> >>
> > There are 2 points for this part:
> > 1. fall back to legacy interrupt right after MSI request fails;
> 
> If we call pci_enable_msi somewhere in sdhci_pci_probe_slot, then if it
> failed, we can also fall back I suppose?
> 
Yes, it is. 
Also, sdhci_pci_disable_msi should be kept since pci_disable_msi is
pci bus releted and better not used in sdhci.c.
So, enable msi and disable msi are symmetric in style.
What's your opinion?

> > 2. prompt user more information about where error/warning occur.
> > 
> >>> +
> >>> +static int sdhci_pci_enable_msi(struct sdhci_host *host, irq_handler_t handler)
> >>> +{
> >>> +	return sdhci_pci_setup_msi(host, handler);
> >>> +}
> >>> +
> >>> +static void sdhci_pci_disable_msi(struct sdhci_host *host)
> >>> +{
> >>> +	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
> >>> +
> >>> +	if (host->msi_enabled) {
> >>> +		pci_disable_msi(pdev);
> >>> +		host->msi_enabled = false;
> >>> +	}
> >>> +}
> >>> +
> >>> +#else
> >>> +
> >>> +static int sdhci_pci_enable_msi(struct sdhci_host *host, irq_handler_t handler)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void sdhci_pci_disable_msi(struct sdhci_host *host)
> >>> +{
> >>> +}
> >>> +#endif /* CONFIG_MMC_SDHCI_PCI_MSI */
> >>> +
> >>>  static const struct sdhci_ops sdhci_pci_ops = {
> >>>  	.enable_dma	= sdhci_pci_enable_dma,
> >>>  	.platform_bus_width	= sdhci_pci_bus_width,
> >>>  	.hw_reset		= sdhci_pci_hw_reset,
> >>> +	.enable_msi		= sdhci_pci_enable_msi,
> >>> +	.disable_msi		= sdhci_pci_disable_msi,
> >>>  };
> >>>  
> >>>  /*****************************************************************************\
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 6785fb1..4c2a1ac 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -2554,6 +2554,31 @@ void sdhci_disable_irq_wakeups(struct sdhci_host *host)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
> >>>  
> >>> +static int sdhci_request_irq(struct sdhci_host *host)
> >>> +{
> >>> +	int ret = 0;
> >>> +
> >>> +	/* try to enable MSI */
> >>> +	if (host->ops->enable_msi) {
> >>> +		ret = host->ops->enable_msi(host, sdhci_irq);
> >>> +		if (ret)
> >>> +			pr_warn("%s: Fall back to Pin-based Interrupt: %d\n",
> >>> +				mmc_hostname(host->mmc), ret);
> >>> +	}
> >>> +
> >>> +	if (!host->msi_enabled) {
> >>> +		/* fall back to legacy pin-based interrupt */
> >>> +		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> >>> +				mmc_hostname(host->mmc), host);
> >>> +		if (ret) {
> >>> +			pr_err("%s: Failed to request IRQ %d: %d\n",
> >>> +				 mmc_hostname(host->mmc), host->irq, ret);
> >>> +			return ret;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return ret;
> >>> +}
> >>>  int sdhci_suspend_host(struct sdhci_host *host)
> >>>  {
> >>>  	if (host->ops->platform_suspend)
> >>> @@ -2570,6 +2595,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
> >>>  	if (!device_may_wakeup(mmc_dev(host->mmc))) {
> >>>  		sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
> >>>  		free_irq(host->irq, host);
> >>> +		if (host->ops->disable_msi)
> >>> +			host->ops->disable_msi(host);
> >>
> >> What would happen if we do not disable/enable msi in suspend/resume host?
> >> We have already masked all irqs with sdhci_mask_irqs anyway.
> >>
> > We should also remove request|free_irq at the same time, right?
> > I will do some tests.
> 
> The comments above free_irq says:
> 
>  *      on the card it drives before calling this function. The function
>  *      does not return until any executing interrupts for this IRQ
>  *      have completed.
> 
> It feels like a guard for the interrupt handler: after we call free_irq,
> we are sure no interrupt hander is running(and since we have masked irq,
> no more interrupt will occur either), so I suggest we keep it.
> 
I did some tests according to your suggestion and it works fine.

Thanks,
Jackey

> Thanks,
> Aaron
> 
> >>>  	} else {
> >>>  		sdhci_enable_irq_wakeups(host);
> >>>  		enable_irq_wake(host->irq);
> >>> @@ -2589,8 +2616,7 @@ int sdhci_resume_host(struct sdhci_host *host)
> >>>  	}
> >>>  
> >>>  	if (!device_may_wakeup(mmc_dev(host->mmc))) {
> >>> -		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> >>> -				  mmc_hostname(host->mmc), host);
> >>> +		ret = sdhci_request_irq(host);
> >>>  		if (ret)
> >>>  			return ret;
> >>>  	} else {
> >>> @@ -3212,13 +3238,9 @@ int sdhci_add_host(struct sdhci_host *host)
> >>>  
> >>>  	sdhci_init(host, 0);
> >>>  
> >>> -	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> >>> -		mmc_hostname(mmc), host);
> >>> -	if (ret) {
> >>> -		pr_err("%s: Failed to request IRQ %d: %d\n",
> >>> -		       mmc_hostname(mmc), host->irq, ret);
> >>> +	ret = sdhci_request_irq(host);
> >>> +	if (ret)
> >>>  		goto untasklet;
> >>> -	}
> >>>  
> >>>  #ifdef CONFIG_MMC_DEBUG
> >>>  	sdhci_dumpregs(host);
> >>> @@ -3258,6 +3280,8 @@ reset:
> >>>  	sdhci_reset(host, SDHCI_RESET_ALL);
> >>>  	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
> >>>  	free_irq(host->irq, host);
> >>> +	if (host->ops->disable_msi)
> >>> +		host->ops->disable_msi(host);
> >>>  #endif
> >>>  untasklet:
> >>>  	tasklet_kill(&host->card_tasklet);
> >>> @@ -3301,6 +3325,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> >>>  
> >>>  	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
> >>>  	free_irq(host->irq, host);
> >>> +	if (host->ops->disable_msi)
> >>> +		host->ops->disable_msi(host);
> >>>  
> >>>  	del_timer_sync(&host->timer);
> >>>  
> >>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >>> index 0a3ed01..cbee843 100644
> >>> --- a/drivers/mmc/host/sdhci.h
> >>> +++ b/drivers/mmc/host/sdhci.h
> >>> @@ -296,6 +296,8 @@ struct sdhci_ops {
> >>>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
> >>>  	void	(*platform_init)(struct sdhci_host *host);
> >>>  	void    (*card_event)(struct sdhci_host *host);
> >>> +	int	(*enable_msi)(struct sdhci_host *host, irq_handler_t handler);
> >>> +	void	(*disable_msi)(struct sdhci_host *host);
> >>>  };
> >>>  
> >>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> >>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> >>> index 3e781b8..3812479 100644
> >>> --- a/include/linux/mmc/sdhci.h
> >>> +++ b/include/linux/mmc/sdhci.h
> >>> @@ -99,6 +99,8 @@ struct sdhci_host {
> >>>  /* Controller has a non-standard host control register */
> >>>  #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
> >>>  
> >>> +	bool msi_enabled;	/* SD host controller with PCI MSI enabled */
> >>> +
> >>>  	int irq;		/* Device IRQ */
> >>>  	void __iomem *ioaddr;	/* Mapped address */
> >>>  
> >>>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > 
> 
> 

