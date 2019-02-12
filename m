From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-tegra: drop ->get_ro() implementation
Date: Tue, 12 Feb 2019 10:11:44 +0200
Message-ID: <a4edf67c-27dd-a866-f249-c861dd2a721c@intel.com>
References: <20190211132342.31009-1-thomas.petazzoni@bootlin.com>
 <20190211132342.31009-4-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211132342.31009-4-thomas.petazzoni@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>, Thierry Reding <treding@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On 11/02/19 3:23 PM, Thomas Petazzoni wrote:
> The SDHCI core is know properly checking for the state of a WP GPIO,
> so there is no longer any need for the sdhci-tegra code to implement
> ->get_ro() using mmc_gpio_get_ro().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes since v1:
>  - Added Tested-by/Acked-by from Thierry Reding
> 
> Note: this patch has only been compiled tested, as I don't have the
> hardware to test it.
> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e6ace31e2a41..6ed7323bf030 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -237,11 +237,6 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>  	}
>  }
>  
> -static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
> -{
> -	return mmc_gpio_get_ro(host->mmc);
> -}
> -
>  static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -837,7 +832,6 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  }
>  
>  static const struct sdhci_ops tegra_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> @@ -893,7 +887,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>  };
>  
>  static const struct sdhci_ops tegra114_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_w    = tegra_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
> @@ -947,7 +940,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
>  };
>  
>  static const struct sdhci_ops tegra210_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_w    = tegra210_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
> @@ -980,7 +972,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  };
>  
>  static const struct sdhci_ops tegra186_sdhci_ops = {
> -	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> 
