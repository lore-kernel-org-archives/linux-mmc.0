From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 09/10] mmc: tegra: Perform pad calibration after voltage
 switch
Date: Wed, 25 Jul 2018 10:25:16 +0300
Message-ID: <b44d6ae5-7965-16db-7ad3-39ff682755ca@kapsi.fi>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-8-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532442865-6391-8-git-send-email-avienamo@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 24.07.2018 17:34, Aapo Vienamo wrote:
> Run the automatic pad calibration after voltage switching if
> tegra_host->pad_calib_required is set.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 78781bd..529aa4e7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -537,6 +537,8 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>   						   struct mmc_ios *ios)
>   {
>   	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>   	int ret = 0;
>   
>   	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> @@ -551,6 +553,9 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
>   		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
>   	}
>   
> +	if (tegra_host->pad_calib_required)
> +		tegra_sdhci_pad_autocalib(host);

What if the autocalibration fails? Should we return an error?

> +
>   	return ret;
>   }
>   
> 
