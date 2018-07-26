From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 03/10] mmc: tegra: Reconfigure pad voltages during
 voltage switching
Date: Thu, 26 Jul 2018 15:33:11 +0200
Message-ID: <2f0684610c182fd007a152a903994d62@agner.ch>
References: <1532607560-11253-1-git-send-email-avienamo@nvidia.com>
 <1532607560-11253-4-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532607560-11253-4-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 26.07.2018 14:19, Aapo Vienamo wrote:
> Parse the pinctrl state and nvidia,only-1-8-v properties from the device
> tree and implement pad voltage state reconfiguration in the mmc
> start_signal_voltage_switch() callback. Validate the pinctrl and
> regulator configuration before unmasking UHS modes. Add
> NVQUIRK_NEEDS_PAD_CONTROL and add set it for Tegra210 and Tegra186.
> 
> The pad configuration is done in the mmc callback because the order of
> pad reconfiguration and sdhci voltage switch depend on the voltage to
> which the transition occurs.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 140 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 127 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index ddf00166..9587365 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> @@ -55,6 +56,7 @@
>  #define NVQUIRK_ENABLE_SDR104		BIT(4)
>  #define NVQUIRK_ENABLE_DDR50		BIT(5)
>  #define NVQUIRK_HAS_PADCALIB		BIT(6)
> +#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
>  
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> @@ -66,8 +68,13 @@ struct sdhci_tegra {
>  	struct gpio_desc *power_gpio;
>  	bool ddr_signaling;
>  	bool pad_calib_required;
> +	bool pad_control_available;
> +	bool only_1v8;
>  
>  	struct reset_control *rst;
> +	struct pinctrl *pinctrl_sdmmc;
> +	struct pinctrl_state *pinctrl_state_3v3;
> +	struct pinctrl_state *pinctrl_state_1v8;
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -138,12 +145,47 @@ static unsigned int tegra_sdhci_get_ro(struct
> sdhci_host *host)
>  	return mmc_gpio_get_ro(host->mmc);
>  }
>  
> +static bool tegra_sdhci_is_uhs_valid(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +
> +	/*
> +	 * The 1.8 V only host controllers don't need to have configurable
> +	 * regulators and pad voltages. In this case the UHS modes can be
> +	 * enabled regardless.
> +	 */
> +	if (tegra_host->only_1v8)
> +		return true;

Hm, SD always needs 3.3V capabilities, not?

So if the controller is 1.8V only, then only eMMC modes are allowed.

You can use MMC_CAP2_HSX00_1_8V in caps2.

So far the Tegra SDHCI driver did not use device tree to indicate modes,
but maybe we should start doing that. In this case you can use
mmc-hs200-1_8v/mmc-hs400-1_8v to indicate higher eMMC speed modes.

> +
> +	/*
> +	 * If the board does not define a regulator for the SDHCI IO voltage,
> +	 * then don't advertise support for UHS modes even if the device
> +	 * supports it because the IO voltage cannot be configured.
> +	 */
> +	if (IS_ERR(host->mmc->supply.vqmmc))
> +		return false;

The stack should already check that and mask caps1 accordingly (see
sdhci_setup_host).

> +
> +	/*
> +	 * Later SoC generations require software pad voltage configuration.
> +	 * The UHS modes should only be enabled if the pad configuration states
> +	 * are available on platforms where they are required in order to switch
> +	 * the signaling voltage.
> +	 */
> +	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL)
> +		return tegra_host->pad_control_available;
> +
> +	return false;
> +}
> +
>  static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>  	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
>  	u32 misc_ctrl, clk_ctrl;
> +	bool uhs_valid;
>  
>  	sdhci_reset(host, mask);
>  
> @@ -160,13 +202,8 @@ static void tegra_sdhci_reset(struct sdhci_host
> *host, u8 mask)
>  
>  	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
>  
> -	/*
> -	 * If the board does not define a regulator for the SDHCI
> -	 * IO voltage, then don't advertise support for UHS modes
> -	 * even if the device supports it because the IO voltage
> -	 * cannot be configured.
> -	 */
> -	if (!IS_ERR(host->mmc->supply.vqmmc)) {
> +	uhs_valid = tegra_sdhci_is_uhs_valid(host);
> +	if (uhs_valid) {
>  		/* Erratum: Enable SDHCI spec v3.00 support */
>  		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
>  			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
> @@ -286,14 +323,80 @@ static int tegra_sdhci_execute_tuning(struct
> sdhci_host *host, u32 opcode)
>  	return mmc_send_tuning(host->mmc, opcode, NULL);
>  }
>  
> -static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
> +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> -	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +	int ret;
> +
> +	if (!tegra_host->pad_control_available)
> +		return 0;
> +
> +	if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +					   tegra_host->pinctrl_state_1v8);
> +		if (ret < 0)
> +			dev_err(mmc_dev(host->mmc),
> +				"setting 1.8V failed, ret: %d\n", ret);
> +	} else {
> +		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> +					   tegra_host->pinctrl_state_3v3);
> +		if (ret < 0)
> +			dev_err(mmc_dev(host->mmc),
> +				"setting 3.3V failed, ret: %d\n", ret);
> +	}
>  
> -	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> -		tegra_host->pad_calib_required = true;
> +	return ret;
> +}
> +
> +static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
> +						   struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret = 0;
> +
> +	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> +		if (ret < 0)
> +			return ret;
> +		ret = sdhci_start_signal_voltage_switch(mmc, ios);
> +	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		ret = sdhci_start_signal_voltage_switch(mmc, ios);
> +		if (ret < 0)
> +			return ret;
> +		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);

So depending on voltage you first set the pads setting and then do the
signaling voltage switch. Is this necessary? Why?

> +	}
> +
> +	return ret;
> +}
> +
> +static void tegra_sdhci_init_pinctrl_info(struct device *dev,
> +					  struct sdhci_tegra *tegra_host)
> +{
> +	tegra_host->pinctrl_sdmmc = devm_pinctrl_get(dev);
> +	if (IS_ERR(tegra_host->pinctrl_sdmmc)) {
> +		dev_dbg(dev, "No pinctrl info, err: %ld\n",
> +			PTR_ERR(tegra_host->pinctrl_sdmmc));
> +		return;
> +	}
> +
> +	tegra_host->pinctrl_state_3v3 =
> +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> +	if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
> +		dev_err(dev, "Missing 3.3V pad state, err: %ld\n",
> +			PTR_ERR(tegra_host->pinctrl_state_3v3));
> +		return;
> +	}
> +
> +	tegra_host->pinctrl_state_1v8 =
> +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
> +	if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
> +		dev_err(dev, "Missing 1.8V pad state, err: %ld\n",
> +			  PTR_ERR(tegra_host->pinctrl_state_3v3));

Is missing pad states considered as error? If yes, we should return a
error code and make the probe function fail.

If it is ok to run it without the states, then this should be dev_warn
or dev_info.

--
Stefan

> +		return;
> +	}
> +
> +	tegra_host->pad_control_available = true;
>  }
>  
>  static const struct sdhci_ops tegra_sdhci_ops = {
> @@ -305,7 +408,6 @@ static const struct sdhci_ops tegra_sdhci_ops = {
>  	.reset      = tegra_sdhci_reset,
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> -	.voltage_switch = tegra_sdhci_voltage_switch,
>  	.get_max_clock = tegra_sdhci_get_max_clock,
>  };
>  
> @@ -362,7 +464,6 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
>  	.reset      = tegra_sdhci_reset,
>  	.platform_execute_tuning = tegra_sdhci_execute_tuning,
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> -	.voltage_switch = tegra_sdhci_voltage_switch,
>  	.get_max_clock = tegra_sdhci_get_max_clock,
>  };
>  
> @@ -419,6 +520,7 @@ static const struct sdhci_pltfm_data
> sdhci_tegra210_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  	.pdata = &sdhci_tegra210_pdata,
> +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> @@ -442,6 +544,7 @@ static const struct sdhci_pltfm_data
> sdhci_tegra186_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>  	.pdata = &sdhci_tegra186_pdata,
> +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
>  };
>  
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> @@ -478,12 +581,23 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	tegra_host = sdhci_pltfm_priv(pltfm_host);
>  	tegra_host->ddr_signaling = false;
>  	tegra_host->pad_calib_required = false;
> +	tegra_host->pad_control_available = false;
> +	tegra_host->only_1v8 = false;
>  	tegra_host->soc_data = soc_data;
>  
> +	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
> +		host->mmc_host_ops.start_signal_voltage_switch =
> +			sdhci_tegra_start_signal_voltage_switch;
> +		tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
> +	}
> +
>  	rc = mmc_of_parse(host->mmc);
>  	if (rc)
>  		goto err_parse_dt;
>  
> +	if (of_get_property(pdev->dev.of_node, "nvidia,only-1-8-v", NULL))
> +		tegra_host->only_1v8 = true;
> +
>  	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
>  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
