From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM
 SDXC
Date: Tue, 8 Oct 2019 16:44:19 +0300
Message-ID: <2cbda555-42d2-392c-0887-09cae4a35dce@intel.com>
References: <20191003040032.37696-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191003040032.37696-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003040032.37696-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramuthevar,Vadivel MuruganX" <vadivel.muruganx.ramuthevar@linux.intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
List-Id: linux-mmc@vger.kernel.org

On 3/10/19 7:00 AM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
> 
> Therefore, add a new compatible, to adapt the Intel's LGM
> SDXC PHY with arasan-sdhc controller to configure the PHY.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 7023cbec4017..55de839a8a5e 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -120,6 +120,12 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_emmc_soc_ctl_map = {
>  	.hiword_update = false,
>  };
>  
> +static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
> +	.baseclkfreq = { .reg = 0x80, .width = 8, .shift = 2 },
> +	.clockmultiplier = { .reg = 0, .width = -1, .shift = -1 },
> +	.hiword_update = false,
> +};
> +
>  /**
>   * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
>   *
> @@ -384,6 +390,11 @@ static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
>  	.pdata = &sdhci_arasan_cqe_pdata,
>  };
>  
> +static struct sdhci_arasan_of_data intel_lgm_sdxc_data = {
> +	.soc_ctl_map = &intel_lgm_sdxc_soc_ctl_map,
> +	.pdata = &sdhci_arasan_cqe_pdata,
> +};
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -489,6 +500,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>  		.compatible = "intel,lgm-sdhci-5.1-emmc",
>  		.data = &intel_lgm_emmc_data,
>  	},
> +	{
> +		.compatible = "intel,lgm-sdhci-5.1-sdxc",
> +		.data = &intel_lgm_sdxc_data,
> +	},
>  	/* Generic compatible below here */
>  	{
>  		.compatible = "arasan,sdhci-8.9a",
> 
