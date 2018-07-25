From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 2/7] mmc: tegra: Reconfigure pad voltages during voltage
 switching
Date: Wed, 25 Jul 2018 11:35:24 +0300
Message-ID: <20180725113524.7bc2623b@dhcp-10-21-25-168>
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
        <1532090746-15863-3-git-send-email-avienamo@nvidia.com>
        <45dff1ef-c86e-0265-3386-fe95251b9130@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45dff1ef-c86e-0265-3386-fe95251b9130@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 25 Jul 2018 09:41:05 +0300
Mikko Perttunen <cyndis@kapsi.fi> wrote:

> On 20.07.2018 15:45, Aapo Vienamo wrote:
> > Parse the pinctrl states from the device tree and implement pad voltage
> > state reconfiguration in the mmc start_signal_voltage_switch() callback.
> > This is done in the mmc callback because the order of pad
> > reconfiguration and sdhci voltage switch depend on the voltage to which
> > the transition occurs.
> > 
> > Add NVQUIRK_NEEDS_PAD_CONTROL and add set it for Tegra210 and Tegra186.
> > 
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > ---
> >   drivers/mmc/host/sdhci-tegra.c | 91 +++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 85 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> > index ddf00166..f108c48 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -21,6 +21,7 @@
> >   #include <linux/io.h>
> >   #include <linux/of.h>
> >   #include <linux/of_device.h>
> > +#include <linux/pinctrl/consumer.h>
> >   #include <linux/reset.h>
> >   #include <linux/mmc/card.h>
> >   #include <linux/mmc/host.h>
> > @@ -55,6 +56,7 @@
> >   #define NVQUIRK_ENABLE_SDR104		BIT(4)
> >   #define NVQUIRK_ENABLE_DDR50		BIT(5)
> >   #define NVQUIRK_HAS_PADCALIB		BIT(6)
> > +#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
> >   
> >   struct sdhci_tegra_soc_data {
> >   	const struct sdhci_pltfm_data *pdata;
> > @@ -66,8 +68,12 @@ struct sdhci_tegra {
> >   	struct gpio_desc *power_gpio;
> >   	bool ddr_signaling;
> >   	bool pad_calib_required;
> > +	bool pad_control_required;
> >   
> >   	struct reset_control *rst;
> > +	struct pinctrl *pinctrl_sdmmc;
> > +	struct pinctrl_state *pinctrl_state_3v3;
> > +	struct pinctrl_state *pinctrl_state_1v8;
> >   };
> >   
> >   static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> > @@ -286,14 +292,80 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> >   	return mmc_send_tuning(host->mmc, opcode, NULL);
> >   }
> >   
> > -static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
> > +static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
> >   {
> >   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >   	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> > -	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> > +	int ret;
> > +
> > +	if (!tegra_host->pad_control_required)
> > +		return 0;
> > +
> > +	if (voltage == MMC_SIGNAL_VOLTAGE_180) {
> > +		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> > +					   tegra_host->pinctrl_state_1v8);
> > +		if (ret < 0)
> > +			dev_err(mmc_dev(host->mmc),
> > +				"setting 1.8V failed, ret: %d\n", ret);
> > +	} else {
> > +		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
> > +					   tegra_host->pinctrl_state_3v3);
> > +		if (ret < 0)
> > +			dev_err(mmc_dev(host->mmc),
> > +				"setting 3.3V failed, ret: %d\n", ret);
> > +	}
> >   
> > -	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> > -		tegra_host->pad_calib_required = true;
> > +	return ret;
> > +}
> > +
> > +static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
> > +						   struct mmc_ios *ios)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	int ret = 0;
> > +
> > +	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> > +		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> > +		if (ret < 0)
> > +			return ret;
> > +		ret = sdhci_start_signal_voltage_switch(mmc, ios);
> > +	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> > +		ret = sdhci_start_signal_voltage_switch(mmc, ios);
> > +		if (ret < 0)
> > +			return ret;
> > +		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void tegra_sdhci_init_pinctrl_info(struct device *dev,
> > +					  struct sdhci_tegra *tegra_host)
> > +{
> > +	tegra_host->pinctrl_sdmmc = devm_pinctrl_get(dev);
> > +	if (IS_ERR_OR_NULL(tegra_host->pinctrl_sdmmc)) {  
> 
> Can this ever return NULL, considering ARCH_TEGRA selects PINCTRL? 
> IS_ERR is probably better. Same for the two other checks in this function.
> 
> > +		dev_dbg(dev, "No pinctrl info, err: %ld\n",
> > +			PTR_ERR(tegra_host->pinctrl_sdmmc));
> > +		return;
> > +	}
> > +
> > +	tegra_host->pinctrl_state_3v3 =
> > +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> > +	if (IS_ERR_OR_NULL(tegra_host->pinctrl_state_3v3)) {
> > +		dev_err(dev, "Missing 3.3V pad state, err: %ld\n",
> > +			PTR_ERR(tegra_host->pinctrl_state_3v3));
> > +		return;
> > +	}
> > +
> > +	tegra_host->pinctrl_state_1v8 =
> > +		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
> > +	if (IS_ERR_OR_NULL(tegra_host->pinctrl_state_1v8)) {
> > +		dev_err(dev, "Missing 1.8V pad state, err: %ld\n",
> > +			  PTR_ERR(tegra_host->pinctrl_state_3v3));
> > +		return;
> > +	}
> > +
> > +	tegra_host->pad_control_required = true; >   }
> >   
> >   static const struct sdhci_ops tegra_sdhci_ops = {
> > @@ -305,7 +377,6 @@ static const struct sdhci_ops tegra_sdhci_ops = {
> >   	.reset      = tegra_sdhci_reset,
> >   	.platform_execute_tuning = tegra_sdhci_execute_tuning,
> >   	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> > -	.voltage_switch = tegra_sdhci_voltage_switch,
> >   	.get_max_clock = tegra_sdhci_get_max_clock,
> >   };
> >   
> > @@ -362,7 +433,6 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
> >   	.reset      = tegra_sdhci_reset,
> >   	.platform_execute_tuning = tegra_sdhci_execute_tuning,
> >   	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
> > -	.voltage_switch = tegra_sdhci_voltage_switch,
> >   	.get_max_clock = tegra_sdhci_get_max_clock,
> >   };
> >   
> > @@ -419,6 +489,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
> >   
> >   static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
> >   	.pdata = &sdhci_tegra210_pdata,
> > +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
> >   };
> >   
> >   static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> > @@ -442,6 +513,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> >   
> >   static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
> >   	.pdata = &sdhci_tegra186_pdata,
> > +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
> >   };
> >   
> >   static const struct of_device_id sdhci_tegra_dt_match[] = {
> > @@ -478,8 +550,15 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
> >   	tegra_host = sdhci_pltfm_priv(pltfm_host);
> >   	tegra_host->ddr_signaling = false;
> >   	tegra_host->pad_calib_required = false;
> > +	tegra_host->pad_control_required = false;
> >   	tegra_host->soc_data = soc_data;
> >   
> > +	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
> > +		host->mmc_host_ops.start_signal_voltage_switch =
> > +			sdhci_tegra_start_signal_voltage_switch;
> > +		tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
> > +	}
> > +  
> 
> Do we know here if the controller is for eMMC or SD? If it's for SD we 
> should probably print a warning if the pinctrl info is not available. 
> Later we would also need to disable 1.8V modes if we fail to get the 
> pinctrl info.

As far as I can tell the controllers themselves are the same from the
software interface standpoint regardless whether they are connected to
an SD or eMMC device. The differences among the controllers arise from
the way they are attached to rest of the SoC. The controllers which are
hooked to an SD card slot are usually supplied from an adjustable
regulator, whereas the regulator for eMMC controllers is fixed. Also
the SD controllers have configurable pad voltages and the eMMC ones
don't.

The driver probably should check whether the regulator capabilities
align with the available pinctrl configurations and act accordingly to
avoid invalid configurations.

 -Aapo
