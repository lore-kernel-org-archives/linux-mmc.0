From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC, PATCHv3 1/3] mmc: sdhci-pci: Enable runtime PM
 support
Date: Tue, 1 Mar 2011 14:46:56 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103011433110.2034-100000@iolanthe.rowland.org>
References: <1c071e206d0d02e07d3872f20268fba6b101a6b4.1298820826.git.tardyp@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c071e206d0d02e07d3872f20268fba6b101a6b4.1298820826.git.tardyp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, Pierre Tardy <pierre.tardy@intel.com>, Yunpeng Gao <yunpeng.gao@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 1 Mar 2011, Pierre Tardy wrote:

> From: Yunpeng Gao <yunpeng.gao@intel.com>
> 
> Follow the kernel runtime PM framework, enable runtime PM support of the
> sdhci host controller with pci interface.
> 
> Note that this patch implements runtime_pm but now actually detects
> activity.
> It relies on higher level (childrens) to do actual waking up
> Activity detection is put in a following patch
> 
> This patch also does not enable wakeups, so card insertion will not work
> if runtime_pm is activated.
> This is also dealt in a following patch
> 
> Original version from: Yunpeng Gao <yunpeng.gao@intel.com>
> with modifications by: Pierre Tardy <pierre.tardy@intel.com>
> 
> Signed-off-by: Pierre Tardy <pierre.tardy@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci.c |  120 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c     |   31 +++++++++++
>  drivers/mmc/host/sdhci.h     |    5 ++
>  3 files changed, 155 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 2f8d468..f167a55 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -18,6 +18,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/mmc/host.h>
>  
> @@ -1031,6 +1032,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> +	pm_runtime_set_active(&pdev->dev);

This line is redundant.  It won't do anything, and the PCI core already 
does it.

> +
>  	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
>  	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
>  	if (slots == 0)
> @@ -1086,7 +1089,7 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  
>  		chip->slots[i] = slot;
>  	}
> -
> +	pm_runtime_put_noidle(&pdev->dev);
>  	return 0;
>  
>  free:
> @@ -1114,8 +1117,120 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
>  	}
>  
>  	pci_disable_device(pdev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +
> +}
> +
> +#ifdef CONFIG_PM_RUNTIME
> +
> +static int sdhci_pci_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct sdhci_pci_chip *chip;
> +	struct sdhci_pci_slot *slot;
> +	int i, ret;
> +	mmc_pm_flag_t pm_flags = 0;
> +	pm_message_t state;
> +
> +	chip = pci_get_drvdata(pdev);
> +	if (!chip)
> +		return 0;
> +
> +	for (i = 0; i < chip->num_slots; i++) {
> +		slot = chip->slots[i];
> +		if (!slot)
> +			continue;
> +
> +		ret = sdhci_runtime_suspend(slot->host);
> +
> +		if (ret) {
> +			for (i--; i >= 0; i--)
> +				sdhci_runtime_resume(chip->slots[i]->host);
> +			return ret;
> +		}
> +
> +		pm_flags |= slot->host->mmc->pm_flags;
> +	}
> +
> +	state.event = PM_EVENT_AUTO_SUSPEND;
> +	if (chip->fixes && chip->fixes->suspend) {
> +		ret = chip->fixes->suspend(chip, state);
> +		if (ret) {
> +			for (i = chip->num_slots - 1; i >= 0; i--)
> +				sdhci_runtime_resume(chip->slots[i]->host);
> +			return ret;
> +		}
> +	}

You probably should call synchronize_irq() here.  Otherwise a delayed
IRQ might get delivered after the device has changed to D3.

> +
> +	pci_save_state(pdev);
> +	if (pm_flags & MMC_PM_KEEP_POWER) {
> +		if (pm_flags & MMC_PM_WAKE_SDIO_IRQ)
> +			pci_enable_wake(pdev, PCI_D3hot, 1);
> +	} else {
> +		pci_enable_wake(pdev, PCI_D3hot, 0);
> +		pci_disable_device(pdev);
> +	}
> +	pci_set_power_state(pdev, PCI_D3hot);

Most of this isn't needed.  The PCI core does pci_save_state(), 
pci_enable_wake(), and pci_set_power_state().

Of course, you might want to override the wakeup setting selected by
the core.  This is determined by pci_dev_run_wake(), for which you may 
need to call device_set_run_wake().

> +
> +	return 0;
>  }
>  
> +static int sdhci_pci_runtime_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct sdhci_pci_chip *chip;
> +	struct sdhci_pci_slot *slot;
> +	int i, ret;
> +
> +	chip = pci_get_drvdata(pdev);
> +	if (!chip)
> +		return 0;
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);

The PCI core does pci_set_power_state() and pci_restore_state().

> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	if (chip->fixes && chip->fixes->resume) {
> +		ret = chip->fixes->resume(chip);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < chip->num_slots; i++) {
> +		slot = chip->slots[i];
> +		if (!slot)
> +			continue;
> +
> +		ret = sdhci_runtime_resume(slot->host);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_pci_runtime_idle(struct device *dev)
> +{
> +	pm_runtime_autosuspend(dev);
> +	return -EAGAIN;
> +}

Alan Stern
