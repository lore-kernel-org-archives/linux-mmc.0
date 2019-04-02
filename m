From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Clear HISPD_ENA in some lower speed
 modes
Date: Tue, 2 Apr 2019 10:42:22 +0300
Message-ID: <356a8af6-03ab-2827-03c9-a386c8cfaec8@intel.com>
References: <20190401125804.5665-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401125804.5665-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 1/04/19 3:58 PM, Faiz Abbas wrote:
> According to the AM654x Data Manual[1], the setup timing in lower speed
> modes can only be met if the controller uses a falling edge data launch.
> 
> To ensure this, the HIGH_SPEED_ENA (HOST_CONTROL[2]) bit should be
> cleared in default speed, SD high speed, MMC high speed, SDR12 and SDR25
> speed modes.
> 
> Use the sdhci writeb callback to implement this condition.
> 
> [1] http://www.ti.com/lit/gpn/am6546 Section 5.10.5.16.1
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> v2: Dropped QUIRK in favour of writeb callback
> 
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 28fcd8f580a1..6379fba8b122 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -993,6 +993,7 @@ config MMC_SDHCI_OMAP
>  config MMC_SDHCI_AM654
>  	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>  	depends on MMC_SDHCI_PLTFM && OF
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's AM654 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index eea183e90f1b..a91c0b45c48d 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -158,6 +158,27 @@ static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
>  	sdhci_set_power_noreg(host, mode, vdd);
>  }
>  
> +static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
> +{
> +	unsigned char timing = host->mmc->ios.timing;
> +
> +	if (reg == SDHCI_HOST_CONTROL) {
> +		switch (timing) {
> +		/*
> +		 * According to the data manual, HISPD bit
> +		 * should not be set in these speed modes.
> +		 */
> +		case MMC_TIMING_SD_HS:
> +		case MMC_TIMING_MMC_HS:
> +		case MMC_TIMING_UHS_SDR12:
> +		case MMC_TIMING_UHS_SDR25:
> +			val &= ~SDHCI_CTRL_HISPD;
> +		}
> +	}
> +
> +	writeb(val, host->ioaddr + reg);
> +}
> +
>  static struct sdhci_ops sdhci_am654_ops = {
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -165,6 +186,7 @@ static struct sdhci_ops sdhci_am654_ops = {
>  	.set_bus_width = sdhci_set_bus_width,
>  	.set_power = sdhci_am654_set_power,
>  	.set_clock = sdhci_am654_set_clock,
> +	.write_b = sdhci_am654_write_b,
>  	.reset = sdhci_reset,
>  };
>  
> 
