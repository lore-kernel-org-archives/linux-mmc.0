From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 3/3] mmc: sdhci_am654: Add Initial Support for AM654 SDHCI
 driver
Date: Wed, 5 Dec 2018 20:37:06 +0530
Message-ID: <dfe6c97a-6383-c697-88e5-279f6ca8136e@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
 <20181129161513.31734-4-faiz_abbas@ti.com>
 <2618ec91-09d1-26f3-361e-34a073b1e5ea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2618ec91-09d1-26f3-361e-34a073b1e5ea@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 05/12/18 7:12 PM, Adrian Hunter wrote:
> On 29/11/18 6:15 PM, Faiz Abbas wrote:
>> The host controllers on TI's AM654 SOCs are not compatible with
>> the phy and consumer model of the sdhci-of-arasan driver. It turns out
>> that for optimal operation at higher speeds, a special tuning procedure
>> needs to be implemented which involves configuration of platform
>> specific phy registers.
>>
>> Therefore, branch out to a new sdhci_am654 driver and add the phy
>> register space with all phy configurations to it. Populate AM654
>> specific callbacks to sdhci_ops and add SDHCI_QUIRKS wherever
>> applicable.
>>
>> Only add support for upto High Speed for SD card and upto DDR52 speed
>> mode for eMMC. Higher speeds will be added in subsequent patches.
>>
...
>> +		sdhci_am654->dll_on = true;
>> +	}
>> +}
>> +
>> +
> 
> Double blank line

Will fix.

> 
>> +static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
>> +				  unsigned short vdd)
>> +{
>> +	if (!IS_ERR(host->mmc->supply.vmmc)) {
>> +		struct mmc_host *mmc = host->mmc;
>> +
>> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>> +	}
>> +	sdhci_set_power_noreg(host, mode, vdd);
>> +}
>> +
>> +struct sdhci_ops sdhci_am654_ops = {
>> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
>> +	.set_bus_width = sdhci_set_bus_width,
>> +	.set_power = sdhci_am654_set_power,
>> +	.set_clock = sdhci_am654_set_clock,
>> +	.reset = sdhci_reset,
>> +};
>> +
>> +static const struct sdhci_pltfm_data sdhci_am654_pdata = {
>> +	.ops = &sdhci_am654_ops,
>> +	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
>> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>> +};
>> +
>> +static int sdhci_am654_init(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +	u32 ctl_cfg_2 = 0;
>> +	u32 val;
>> +	int ret;
>> +
>> +	regmap_read(sdhci_am654->base, PHY_STAT1, &val);
>> +	if (~val & CALDONE_MASK) {
>> +		/* Calibrate IO lines */
>> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>> +				   PDB_MASK, PDB_MASK);
>> +		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
>> +					       val, val & CALDONE_MASK, 1, 20);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Enable pins by setting IO mux to 0 */
>> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>> +			   IOMUX_ENABLE_MASK, 0);
>> +
>> +	/* Set slot type based on SD or eMMC */
>> +	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>> +		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
>> +
>> +	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
>> +			   ctl_cfg_2, SLOTTYPE_MASK);
>> +
>> +	return sdhci_add_host(host);
>> +}
>> +
>> +static int sdhci_am654_get_of_property(struct platform_device *pdev,
>> +					struct sdhci_am654_data *sdhci_am654)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int drv_strength;
>> +	int ret;
>> +
>> +	ret = device_property_read_u32(dev, "ti,trm-icp",
>> +				       &sdhci_am654->trm_icp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = device_property_read_u32(dev, "ti,otap-del-sel",
>> +				       &sdhci_am654->otap_del_sel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = device_property_read_u32(dev, "ti,driver-strength-ohm",
>> +				       &drv_strength);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (drv_strength) {
>> +	case 50:
>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_50_OHM;
>> +		break;
>> +	case 33:
>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_33_OHM;
>> +		break;
>> +	case 66:
>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_66_OHM;
>> +		break;
>> +	case 100:
>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_100_OHM;
>> +		break;
>> +	case 40:
>> +		sdhci_am654->drv_strength = DRIVER_STRENGTH_40_OHM;
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid driver strength\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	sdhci_get_of_property(pdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sdhci_am654_probe(struct platform_device *pdev)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host;
>> +	struct sdhci_am654_data *sdhci_am654;
>> +	struct sdhci_host *host;
>> +	struct resource *res;
>> +	struct clk *clk_xin;
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *base;
>> +	int ret;
>> +
>> +	host = sdhci_pltfm_init(pdev, &sdhci_am654_pdata, sizeof(*sdhci_am654));
>> +	if (IS_ERR(host))
>> +		return PTR_ERR(host);
>> +
>> +	pltfm_host = sdhci_priv(host);
>> +	sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	clk_xin = devm_clk_get(dev, "clk_xin");
>> +	if (IS_ERR(clk_xin)) {
>> +		dev_err(dev, "clk_xin clock not found.\n");
>> +		ret = PTR_ERR(clk_xin);
>> +		goto err_pltfm_free;
>> +	}
>> +
>> +	sdhci_am654->clk_ahb = devm_clk_get(dev, "clk_ahb");
>> +	if (IS_ERR(sdhci_am654->clk_ahb)) {
>> +		dev_err(dev, "clk_ahb clock not found.\n");
>> +		ret = PTR_ERR(sdhci_am654->clk_ahb);
>> +		goto err_pltfm_free;
>> +	}
> 
> Did you intend not to enable clks?

Yes. Clocks get enabled as a part of pm_runtime calls.
> 
>> +
>> +	pltfm_host->clk = clk_xin;
>> +
>> +	pm_runtime_enable(dev);
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret > 0) {
> 
> Did you intend 'ret > 0'?

Sorry. That was intended to be < 0.

Thanks,
Faiz
