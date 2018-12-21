From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 2/2] mmc: sdhci: Moving sdhci_o2 into
 sdhci-pci-o2micro.c
Date: Fri, 21 Dec 2018 15:30:13 +0200
Message-ID: <0c94a3c1-570e-16fb-fa5f-0f439c35dee4@intel.com>
References: <20181218114003.10002-1-ernest.zhang@bayhubtech.com>
 <20181218114003.10002-2-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218114003.10002-2-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Ernest Zhang(WH)" <ernest.zhang@bayhubtech.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Andy Dai (WH)" <andy.dai@bayhubtech.com>, "Xiaoguang Yu (WH)" <xiaoguang.yu@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>, "Mike Li (WH)" <mike.li@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 18/12/18 1:40 PM, Ernest Zhang(WH) wrote:
> Moving sdhci_o2 into sdhci-pci-o2micro.c
> 
> Signed-off-by: Ernest Zhang <ernest.zhang@bayhubtech.com>

It would be more logical to make this the first patch, rather than put the
ops in one file, and then move them to another.

> ---
> Change in V2:
> 	1. Moving sdhci_o2 into sdhci-pci-o2micro.c
> 
> Change in V1:
> 	N/A
> ---
>  drivers/mmc/host/sdhci-pci-core.c    | 19 -------------------
>  drivers/mmc/host/sdhci-pci-o2micro.c | 19 +++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h         |  1 +
>  3 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index fc4f35653602..99b0fec2836b 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1257,25 +1257,6 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
>  }
>  #endif
>  
> -static const struct sdhci_ops sdhci_pci_o2_ops = {
> -	.set_clock = sdhci_pci_o2_set_clock,
> -	.enable_dma = sdhci_pci_enable_dma,
> -	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> -	.set_uhs_signaling = sdhci_set_uhs_signaling,
> -};
> -
> -static const struct sdhci_pci_fixes sdhci_o2 = {
> -	.probe = sdhci_pci_o2_probe,
> -	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> -	.quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
> -	.probe_slot = sdhci_pci_o2_probe_slot,
> -#ifdef CONFIG_PM_SLEEP
> -	.resume = sdhci_pci_o2_resume,
> -#endif
> -	.ops = &sdhci_pci_o2_ops,
> -};
> -
>  static const struct sdhci_pci_fixes sdhci_jmicron = {
>  	.probe		= jmicron_probe,
>  
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 506b93e5dcd8..7f11cee71db1 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -665,3 +665,22 @@ int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
>  	return sdhci_pci_resume_host(chip);
>  }
>  #endif
> +
> +static const struct sdhci_ops sdhci_pci_o2_ops = {
> +	.set_clock = sdhci_pci_o2_set_clock,
> +	.enable_dma = sdhci_pci_enable_dma,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_o2 = {
> +	.probe = sdhci_pci_o2_probe,
> +	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
> +	.probe_slot = sdhci_pci_o2_probe_slot,
> +#ifdef CONFIG_PM_SLEEP
> +	.resume = sdhci_pci_o2_resume,
> +#endif
> +	.ops = &sdhci_pci_o2_ops,
> +};
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index e41a85f0b40a..0e08021179a8 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -188,5 +188,6 @@ void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock);
>  
>  extern const struct sdhci_pci_fixes sdhci_arasan;
>  extern const struct sdhci_pci_fixes sdhci_snps;
> +extern const struct sdhci_pci_fixes sdhci_o2;

Then the other o2 declarations in sdhci-pci.h are not needed.
i.e. these ones:
 int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
 int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip);
 #endif
 void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock);

>  
>  #endif /* __SDHCI_PCI_H */
> 
