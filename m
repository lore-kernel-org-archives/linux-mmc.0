From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] mmc: sdio: bind acpi with sdio function device
Date: Wed, 20 Mar 2013 14:00:45 +0800
Message-ID: <5149508D.8040507@intel.com>
References: <1362453892-13304-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1362453892-13304-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Any comments on this patch?

Thanks,
Aaron

On 03/05/2013 11:24 AM, Aaron Lu wrote:
> ACPI spec 5 defined the _ADR encoding for sdio bus as:
> High word - slot number (0 based)
> Low word  - function number
> 
> This patch adds support for binding sdio function device with acpi node,
> and if successful, involve acpi into its power management.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/sdio_bus.c  | 20 +++++++++++++++++++-
>  drivers/mmc/host/sdhci-pci.c |  1 +
>  include/linux/mmc/host.h     |  2 ++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 5e57048..8d6bb18 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -16,6 +16,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/acpi.h>
>  
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> @@ -299,6 +300,19 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card)
>  	return func;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static void sdio_acpi_set_handle(struct sdio_func *func)
> +{
> +	struct mmc_host *host = func->card->host;
> +	u64 addr = (host->slotno << 16) | func->num;
> +
> +	ACPI_HANDLE_SET(&func->dev,
> +			acpi_get_child(ACPI_HANDLE(host->parent), addr));
> +}
> +#else
> +static inline void sdio_acpi_set_handle(struct sdio_func *func) {}
> +#endif
> +
>  /*
>   * Register a new SDIO function with the driver model.
>   */
> @@ -308,9 +322,12 @@ int sdio_add_func(struct sdio_func *func)
>  
>  	dev_set_name(&func->dev, "%s:%d", mmc_card_id(func->card), func->num);
>  
> +	sdio_acpi_set_handle(func);
>  	ret = device_add(&func->dev);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		sdio_func_set_present(func);
> +		acpi_dev_pm_attach(&func->dev, false);
> +	}
>  
>  	return ret;
>  }
> @@ -326,6 +343,7 @@ void sdio_remove_func(struct sdio_func *func)
>  	if (!sdio_func_present(func))
>  		return;
>  
> +	acpi_dev_pm_detach(&func->dev, false);
>  	device_del(&func->dev);
>  	put_device(&func->dev);
>  }
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index c7ccf30..3dee22d 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1279,6 +1279,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	}
>  
>  	host->mmc->pm_caps = MMC_PM_KEEP_POWER | MMC_PM_WAKE_SDIO_IRQ;
> +	host->mmc->slotno = slotno;
>  
>  	ret = sdhci_add_host(host);
>  	if (ret)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index d6f20cc..17d7148 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -361,6 +361,8 @@ struct mmc_host {
>  
>  	unsigned int		actual_clock;	/* Actual HC clock rate */
>  
> +	unsigned int		slotno;	/* used for sdio acpi binding */
> +
>  	unsigned long		private[0] ____cacheline_aligned;
>  };
>  
> 

