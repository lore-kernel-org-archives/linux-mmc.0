From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 3/7] regulator: add pbias regulator support
Date: Mon, 6 Jan 2014 18:16:47 +0000
Message-ID: <20140106181647.GJ24664@e106331-lin.cambridge.arm.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1387560955-6547-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387560955-6547-4-git-send-email-balajitk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "broonie@kernel.org" <broonie@kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Dec 20, 2013 at 05:35:51PM +0000, Balaji T K wrote:
> pbias register controls internal power supply to sd card i/o pads
> in most OMAPs (OMAP2-5, DRA7).
> Control bits for selecting voltage level and
> enabling/disabling are in the same PBIAS register.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  .../bindings/regulator/pbias-regulator.txt         |   16 ++
>  drivers/regulator/Kconfig                          |    9 +
>  drivers/regulator/Makefile                         |    1 +
>  drivers/regulator/pbias-regulator.c                |  261 ++++++++++++++++++++
>  4 files changed, 287 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
>  create mode 100644 drivers/regulator/pbias-regulator.c
> 
> diff --git a/Documentation/devicetree/bindings/regulator/pbias-regulator.txt b/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
> new file mode 100644
> index 0000000..359d3f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
> @@ -0,0 +1,16 @@
> +PBIAS internal regulator for SD card dual voltage i/o pads on OMAP SoCs.
> +
> +Required properties:
> +- compatible:
> +  - "ti,pbias-omap" for OMAP2, OMAP3, OMAP4, OMAP5, DRA7
> +
> +Optional properties:
> +- Any optional property defined in bindings/regulator/regulator.txt
> +
> +Example:
> +
> +		pbias_regulator: pbias_regulator {
> +			regulator-name = "pbias_mmc_omap4";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3000000>;
> +	};

This doesn't look like a full example. I don't see the required
compatible string.

[...]

> +static struct of_regulator_match pbias_matches[] = {
> +	{ .name = "pbias_mmc_omap2430", .driver_data = (void *)&pbias_mmc_omap2430},
> +	{ .name = "pbias_sim_omap3", .driver_data = (void *)&pbias_sim_omap3},
> +	{ .name = "pbias_mmc_omap4", .driver_data = (void *)&pbias_mmc_omap4},
> +	{ .name = "pbias_mmc_omap5", .driver_data = (void *)&pbias_mmc_omap5},
> +};

These weren't documented.

[...]

> +static int pbias_regulator_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *dev_node;
> +	struct pbias_regulator_data *drvdata;
> +	struct resource *res;
> +	struct regulator_config cfg = { };
> +	struct regmap *syscon;
> +	const struct pbias_reg_info *info;
> +	int ret = 0;
> +	int count, idx, data_idx = 0;
> +
> +	count = of_regulator_match(&pdev->dev, np, pbias_matches,
> +						PBIAS_NUM_REGS);
> +	if (count < 0)
> +		return count;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct pbias_regulator_data)
> +			       * count, GFP_KERNEL);
> +	if (drvdata == NULL) {
> +		dev_err(&pdev->dev, "Failed to allocate device data\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev_node = of_get_parent(np);
> +	if (!dev_node)
> +		return -ENODEV;
> +
> +	syscon = syscon_node_to_regmap(dev_node);

If we're relying on a particular parent node, that _must_ be described
in the binding.

> +	of_node_put(dev_node);
> +	if (IS_ERR(syscon))
> +		return PTR_ERR(syscon);
> +
> +	cfg.dev = &pdev->dev;
> +
> +	for (idx = 0; idx < PBIAS_NUM_REGS, data_idx < count; idx++) {
> +		if (!pbias_matches[idx].init_data ||
> +			!pbias_matches[idx].of_node)
> +			continue;
> +
> +		info = pbias_matches[idx].driver_data;
> +		if (!info)
> +			return -ENODEV;
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

A reg entry was not mentioned in the binding.

Why is this inside the loop? It's grabbing the reg from the parent, not
each of the children it's walking over.

Thanks,
Mark.
