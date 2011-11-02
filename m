From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci: remove "state" argument from sdhci_suspend_host
Date: Wed, 02 Nov 2011 16:21:29 +0200
Message-ID: <4EB151E9.8080607@intel.com>
References: <1320242806-2365-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46383 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab1KBOVd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Nov 2011 10:21:33 -0400
In-Reply-To: <1320242806-2365-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 02/11/11 16:06, Manuel Lauss wrote:
> Drop the "state" argument from sdhci_suspend_host.  It's only user
> is the PCI glue;  this allows to move all SDHCI glues to use
> dev_pm_ops instead.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> V2: sdhci-s3c does not use sdhci-pltfm.c and gets its own dev_pm_ops.
> 
>  drivers/mmc/host/sdhci-cns3xxx.c   |    5 +----
>  drivers/mmc/host/sdhci-dove.c      |    5 +----
>  drivers/mmc/host/sdhci-esdhc-imx.c |    5 +----
>  drivers/mmc/host/sdhci-of-esdhc.c  |    5 +----
>  drivers/mmc/host/sdhci-of-hlwd.c   |    5 +----
>  drivers/mmc/host/sdhci-pci.c       |   25 +++++++++++++------------
>  drivers/mmc/host/sdhci-pltfm.c     |   18 +++++++++++-------
>  drivers/mmc/host/sdhci-pltfm.h     |    6 ++++--
>  drivers/mmc/host/sdhci-pxav2.c     |    5 +----
>  drivers/mmc/host/sdhci-pxav3.c     |    5 +----
>  drivers/mmc/host/sdhci-s3c.c       |   21 ++++++++++++++-------
>  drivers/mmc/host/sdhci-tegra.c     |    5 +----
>  drivers/mmc/host/sdhci.c           |    2 +-
>  drivers/mmc/host/sdhci.h           |    2 +-
>  14 files changed, 52 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
> index 4b920b7..fbd0638 100644
> --- a/drivers/mmc/host/sdhci-cns3xxx.c
> +++ b/drivers/mmc/host/sdhci-cns3xxx.c
> @@ -108,13 +108,10 @@ static struct platform_driver sdhci_cns3xxx_driver = {
>  	.driver		= {
>  		.name	= "sdhci-cns3xxx",
>  		.owner	= THIS_MODULE,
> +		.pm	= SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe		= sdhci_cns3xxx_probe,
>  	.remove		= __devexit_p(sdhci_cns3xxx_remove),
> -#ifdef CONFIG_PM
> -	.suspend	= sdhci_pltfm_suspend,
> -	.resume		= sdhci_pltfm_resume,
> -#endif
>  };
>  
>  static int __init sdhci_cns3xxx_init(void)
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> index f2d29dc..a81312c 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -82,13 +82,10 @@ static struct platform_driver sdhci_dove_driver = {
>  	.driver		= {
>  		.name	= "sdhci-dove",
>  		.owner	= THIS_MODULE,
> +		.pm	= SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe		= sdhci_dove_probe,
>  	.remove		= __devexit_p(sdhci_dove_remove),
> -#ifdef CONFIG_PM
> -	.suspend	= sdhci_pltfm_suspend,
> -	.resume		= sdhci_pltfm_resume,
> -#endif
>  };
>  
>  static int __init sdhci_dove_init(void)
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ae57769..8fc8006 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -591,14 +591,11 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
>  		.name	= "sdhci-esdhc-imx",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = imx_esdhc_dt_ids,
> +		.pm	= SDHCI_PLTFM_PMOPS,
>  	},
>  	.id_table	= imx_esdhc_devtype,
>  	.probe		= sdhci_esdhc_imx_probe,
>  	.remove		= __devexit_p(sdhci_esdhc_imx_remove),
> -#ifdef CONFIG_PM
> -	.suspend	= sdhci_pltfm_suspend,
> -	.resume		= sdhci_pltfm_resume,
> -#endif
>  };
>  
>  static int __init sdhci_esdhc_imx_init(void)
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 59e9d00..01e5f62 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -125,13 +125,10 @@ static struct platform_driver sdhci_esdhc_driver = {
>  		.name = "sdhci-esdhc",
>  		.owner = THIS_MODULE,
>  		.of_match_table = sdhci_esdhc_of_match,
> +		.pm = SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe = sdhci_esdhc_probe,
>  	.remove = __devexit_p(sdhci_esdhc_remove),
> -#ifdef CONFIG_PM
> -	.suspend = sdhci_pltfm_suspend,
> -	.resume = sdhci_pltfm_resume,
> -#endif
>  };
>  
>  static int __init sdhci_esdhc_init(void)
> diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
> index 9b0d794..3619adc 100644
> --- a/drivers/mmc/host/sdhci-of-hlwd.c
> +++ b/drivers/mmc/host/sdhci-of-hlwd.c
> @@ -87,13 +87,10 @@ static struct platform_driver sdhci_hlwd_driver = {
>  		.name = "sdhci-hlwd",
>  		.owner = THIS_MODULE,
>  		.of_match_table = sdhci_hlwd_of_match,
> +		.pm = SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe = sdhci_hlwd_probe,
>  	.remove = __devexit_p(sdhci_hlwd_remove),
> -#ifdef CONFIG_PM
> -	.suspend = sdhci_pltfm_suspend,
> -	.resume = sdhci_pltfm_resume,
> -#endif
>  };
>  
>  static int __init sdhci_hlwd_init(void)
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index d833d9c..e786d3f 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -54,8 +54,7 @@ struct sdhci_pci_fixes {
>  	int			(*probe_slot) (struct sdhci_pci_slot *);
>  	void			(*remove_slot) (struct sdhci_pci_slot *, int);
>  
> -	int			(*suspend) (struct sdhci_pci_chip *,
> -					pm_message_t);
> +	int			(*suspend) (struct sdhci_pci_chip *);
>  	int			(*resume) (struct sdhci_pci_chip *);
>  };
>  
> @@ -549,7 +548,7 @@ static void jmicron_remove_slot(struct sdhci_pci_slot *slot, int dead)
>  		jmicron_enable_mmc(slot->host, 0);
>  }
>  
> -static int jmicron_suspend(struct sdhci_pci_chip *chip, pm_message_t state)
> +static int jmicron_suspend(struct sdhci_pci_chip *chip)
>  {
>  	int i;
>  
> @@ -993,8 +992,9 @@ static struct sdhci_ops sdhci_pci_ops = {
>  
>  #ifdef CONFIG_PM
>  
> -static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int sdhci_pci_suspend(struct device *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_pci_slot *slot;
>  	mmc_pm_flag_t slot_pm_flags;
> @@ -1010,7 +1010,7 @@ static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
>  		if (!slot)
>  			continue;
>  
> -		ret = sdhci_suspend_host(slot->host, state);
> +		ret = sdhci_suspend_host(slot->host);
>  
>  		if (ret) {
>  			for (i--; i >= 0; i--)
> @@ -1026,7 +1026,7 @@ static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
>  	}
>  
>  	if (chip->fixes && chip->fixes->suspend) {
> -		ret = chip->fixes->suspend(chip, state);
> +		ret = chip->fixes->suspend(chip);
>  		if (ret) {
>  			for (i = chip->num_slots - 1; i >= 0; i--)
>  				sdhci_resume_host(chip->slots[i]->host);
> @@ -1042,16 +1042,17 @@ static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
>  		}
>  		pci_set_power_state(pdev, PCI_D3hot);
>  	} else {
> -		pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
> +		pci_enable_wake(pdev, PCI_D3hot, 0);
>  		pci_disable_device(pdev);
> -		pci_set_power_state(pdev, pci_choose_state(pdev, state));
> +		pci_set_power_state(pdev, PCI_D3hot);
>  	}
>  
>  	return 0;
>  }
>  
> -static int sdhci_pci_resume(struct pci_dev *pdev)
> +static int sdhci_pci_resume(struct device *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_pci_slot *slot;
>  	int i, ret;
> @@ -1121,7 +1122,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
>  	}
>  
>  	if (chip->fixes && chip->fixes->suspend) {
> -		ret = chip->fixes->suspend(chip, state);
> +		ret = chip->fixes->suspend(chip);

Also need to remove "pm_message_t state = { .event = PM_EVENT_SUSPEND };"
e.g.

	drivers/mmc/host/sdhci-pci.c: In function 'sdhci_pci_runtime_suspend':
	drivers/mmc/host/sdhci-pci.c:1103:15: warning: unused variable 'state' [-Wunused-variable]


>  		if (ret) {
>  			for (i = chip->num_slots - 1; i >= 0; i--)
>  				sdhci_runtime_resume_host(chip->slots[i]->host);
> @@ -1176,6 +1177,8 @@ static int sdhci_pci_runtime_idle(struct device *dev)
>  #endif
>  
>  static const struct dev_pm_ops sdhci_pci_pm_ops = {
> +	.suspend = sdhci_pci_suspend,
> +	.resume = sdhci_pci_resume,
>  	.runtime_suspend = sdhci_pci_runtime_suspend,
>  	.runtime_resume = sdhci_pci_runtime_resume,
>  	.runtime_idle = sdhci_pci_runtime_idle,
> @@ -1428,8 +1431,6 @@ static struct pci_driver sdhci_driver = {
>  	.id_table =	pci_ids,
>  	.probe =	sdhci_pci_probe,
>  	.remove =	__devexit_p(sdhci_pci_remove),
> -	.suspend =	sdhci_pci_suspend,
> -	.resume	=	sdhci_pci_resume,
>  	.driver =	{
>  		.pm =   &sdhci_pci_pm_ops
>  	},
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a9e12ea..03970bc 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -194,21 +194,25 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
>  
>  #ifdef CONFIG_PM
> -int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state)
> +static int sdhci_pltfm_suspend(struct device *dev)
>  {
> -	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct sdhci_host *host = dev_get_drvdata(dev);
>  
> -	return sdhci_suspend_host(host, state);
> +	return sdhci_suspend_host(host);
>  }
> -EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);
>  
> -int sdhci_pltfm_resume(struct platform_device *dev)
> +static int sdhci_pltfm_resume(struct device *dev)
>  {
> -	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct sdhci_host *host = dev_get_drvdata(dev);
>  
>  	return sdhci_resume_host(host);
>  }
> -EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);
> +
> +const struct dev_pm_ops sdhci_pltfm_pmops = {
> +	.suspend	= sdhci_pltfm_suspend,
> +	.resume		= sdhci_pltfm_resume,
> +};
> +EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
>  #endif	/* CONFIG_PM */
>  
>  static int __init sdhci_pltfm_drv_init(void)
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 3a9fc3f..700bdf7 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -99,8 +99,10 @@ extern int sdhci_pltfm_register(struct platform_device *pdev,
>  extern int sdhci_pltfm_unregister(struct platform_device *pdev);
>  
>  #ifdef CONFIG_PM
> -extern int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state);
> -extern int sdhci_pltfm_resume(struct platform_device *dev);
> +extern struct dev_pm_ops sdhci_pltfm_pmops;
> +#define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
> +#else
> +#define SDHCI_PLTFM_PMOPS NULL
>  #endif
>  
>  #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index d4bf6d3..7a039c3 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -218,13 +218,10 @@ static struct platform_driver sdhci_pxav2_driver = {
>  	.driver		= {
>  		.name	= "sdhci-pxav2",
>  		.owner	= THIS_MODULE,
> +		.pm	= SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe		= sdhci_pxav2_probe,
>  	.remove		= __devexit_p(sdhci_pxav2_remove),
> -#ifdef CONFIG_PM
> -	.suspend	= sdhci_pltfm_suspend,
> -	.resume		= sdhci_pltfm_resume,
> -#endif
>  };
>  static int __init sdhci_pxav2_init(void)
>  {
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index cff4ad3..15673a7 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -264,13 +264,10 @@ static struct platform_driver sdhci_pxav3_driver = {
>  	.driver		= {
>  		.name	= "sdhci-pxav3",
>  		.owner	= THIS_MODULE,
> +		.pm	= SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe		= sdhci_pxav3_probe,
>  	.remove		= __devexit_p(sdhci_pxav3_remove),
> -#ifdef CONFIG_PM
> -	.suspend	= sdhci_pltfm_suspend,
> -	.resume		= sdhci_pltfm_resume,
> -#endif
>  };
>  static int __init sdhci_pxav3_init(void)
>  {
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 3d00e72..c992e4f 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -622,23 +622,29 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
>  
>  #ifdef CONFIG_PM
>  
> -static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
> +static int sdhci_s3c_suspend(struct device *dev)
>  {
> -	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct sdhci_host *host = dev_get_drvdata(dev);
>  
> -	return sdhci_suspend_host(host, pm);
> +	return sdhci_suspend_host(host);
>  }
>  
> -static int sdhci_s3c_resume(struct platform_device *dev)
> +static int sdhci_s3c_resume(struct device *dev)
>  {
> -	struct sdhci_host *host = platform_get_drvdata(dev);
> +	struct sdhci_host *host = dev_get_drvdata(dev);
>  
>  	return sdhci_resume_host(host);
>  }
>  
> +static const struct dev_pm_ops sdhci_s3c_pmops = {
> +	.suspend	= sdhci_s3c_suspend,
> +	.resume		= sdhci_s3c_resume,
> +};
> +
> +#define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
> +
>  #else
> -#define sdhci_s3c_suspend NULL
> -#define sdhci_s3c_resume NULL
> +#define SDHCI_S3C_PMOPS NULL
>  #endif
>  
>  static struct platform_driver sdhci_s3c_driver = {
> @@ -649,6 +655,7 @@ static struct platform_driver sdhci_s3c_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "s3c-sdhci",
> +		.pm	= SDHCI_S3C_PMOPS,
>  	},
>  };
>  
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 067a4cd..ea77df7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -317,13 +317,10 @@ static struct platform_driver sdhci_tegra_driver = {
>  		.name	= "sdhci-tegra",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = sdhci_tegra_dt_match,
> +		.pm	= SDHCI_PLTFM_PMOPS,
>  	},
>  	.probe		= sdhci_tegra_probe,
>  	.remove		= __devexit_p(sdhci_tegra_remove),
> -#ifdef CONFIG_PM
> -	.suspend	= sdhci_pltfm_suspend,
> -	.resume		= sdhci_pltfm_resume,
> -#endif
>  };
>  
>  static int __init sdhci_tegra_init(void)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6d8eea3..19ed580 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2327,7 +2327,7 @@ out:
>  
>  #ifdef CONFIG_PM
>  
> -int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
> +int sdhci_suspend_host(struct sdhci_host *host)
>  {
>  	int ret;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0a5b654..a04d4d0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -374,7 +374,7 @@ extern int sdhci_add_host(struct sdhci_host *host);
>  extern void sdhci_remove_host(struct sdhci_host *host, int dead);
>  
>  #ifdef CONFIG_PM
> -extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
> +extern int sdhci_suspend_host(struct sdhci_host *host);
>  extern int sdhci_resume_host(struct sdhci_host *host);
>  extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
>  #endif

