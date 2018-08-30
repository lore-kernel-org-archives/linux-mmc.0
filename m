From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 10/38] soc/tegra: pmc: Implement pad configuration via pinctrl
Date: Thu, 30 Aug 2018 18:06:11 +0300
Message-ID: <20180830150639.21048-11-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Register a pinctrl device and implement get and set functions for
PIN_CONFIG_LOW_POWER_MODE and PIN_CONFIG_POWER_SOURCE parameters.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 187 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index de6832df2e9a..f66699579e95 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -33,6 +33,9 @@
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/reboot.h>
@@ -164,6 +167,9 @@ struct tegra_pmc_soc {
 	const struct tegra_io_pad_soc *io_pads;
 	unsigned int num_io_pads;
 
+	const struct pinctrl_pin_desc *pin_descs;
+	unsigned int num_pin_descs;
+
 	const struct tegra_pmc_regs *regs;
 	void (*init)(struct tegra_pmc *pmc);
 	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
@@ -222,6 +228,8 @@ struct tegra_pmc {
 	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
 
 	struct mutex powergates_lock;
+
+	struct pinctrl_dev *pctl_dev;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1399,6 +1407,142 @@ static void tegra_pmc_init_tsense_reset(struct tegra_pmc *pmc)
 	of_node_put(np);
 }
 
+static int tegra_io_pad_pinctrl_get_groups_count(struct pinctrl_dev *pctl_dev)
+{
+	return pmc->soc->num_io_pads;
+}
+
+static const char *tegra_io_pad_pinctrl_get_group_name(
+		struct pinctrl_dev *pctl, unsigned int group)
+{
+	return pmc->soc->io_pads[group].name;
+}
+
+static int tegra_io_pad_pinctrl_get_group_pins(struct pinctrl_dev *pctl_dev,
+					       unsigned int group,
+					       const unsigned int **pins,
+					       unsigned int *num_pins)
+{
+	*pins = &pmc->soc->io_pads[group].id;
+	*num_pins = 1;
+	return 0;
+}
+
+static const struct pinctrl_ops tegra_io_pad_pinctrl_ops = {
+	.get_groups_count = tegra_io_pad_pinctrl_get_groups_count,
+	.get_group_name = tegra_io_pad_pinctrl_get_group_name,
+	.get_group_pins = tegra_io_pad_pinctrl_get_group_pins,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map = pinconf_generic_dt_free_map,
+};
+
+static int tegra_io_pad_pinconf_get(struct pinctrl_dev *pctl_dev,
+				    unsigned int pin, unsigned long *config)
+{
+	const struct tegra_io_pad_soc *pad = tegra_io_pad_find(pmc, pin);
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	int ret;
+	u32 arg;
+
+	if (!pad)
+		return -EINVAL;
+
+	switch (param) {
+	case PIN_CONFIG_POWER_SOURCE:
+		ret = tegra_io_pad_get_voltage(pad->id);
+		if (ret < 0)
+			return ret;
+		arg = ret;
+		break;
+	case PIN_CONFIG_LOW_POWER_MODE:
+		ret = tegra_io_pad_is_powered(pad->id);
+		if (ret < 0)
+			return ret;
+		arg = !ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int tegra_io_pad_pinconf_set(struct pinctrl_dev *pctl_dev,
+				    unsigned int pin, unsigned long *configs,
+				    unsigned int num_configs)
+{
+	const struct tegra_io_pad_soc *pad = tegra_io_pad_find(pmc, pin);
+	enum pin_config_param param;
+	unsigned int i;
+	int err;
+	u32 arg;
+
+	if (!pad)
+		return -EINVAL;
+
+	for (i = 0; i < num_configs; ++i) {
+		param = pinconf_to_config_param(configs[i]);
+		arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_LOW_POWER_MODE:
+			if (arg)
+				err = tegra_io_pad_power_disable(pad->id);
+			else
+				err = tegra_io_pad_power_enable(pad->id);
+			if (err)
+				return err;
+			break;
+		case PIN_CONFIG_POWER_SOURCE:
+			if (arg != TEGRA_IO_PAD_VOLTAGE_1V8 &&
+			    arg != TEGRA_IO_PAD_VOLTAGE_3V3)
+				return -EINVAL;
+			err = tegra_io_pad_set_voltage(pad->id, arg);
+			if (err)
+				return err;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops tegra_io_pad_pinconf_ops = {
+	.pin_config_get = tegra_io_pad_pinconf_get,
+	.pin_config_set = tegra_io_pad_pinconf_set,
+	.is_generic = true,
+};
+
+static struct pinctrl_desc tegra_pmc_pctl_desc = {
+	.pctlops = &tegra_io_pad_pinctrl_ops,
+	.confops = &tegra_io_pad_pinconf_ops,
+};
+
+static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
+{
+	int err = 0;
+
+	if (!pmc->soc->num_pin_descs)
+		return 0;
+
+	tegra_pmc_pctl_desc.name = dev_name(pmc->dev);
+	tegra_pmc_pctl_desc.pins = pmc->soc->pin_descs;
+	tegra_pmc_pctl_desc.npins = pmc->soc->num_pin_descs;
+
+	pmc->pctl_dev = devm_pinctrl_register(pmc->dev, &tegra_pmc_pctl_desc,
+					      pmc);
+	if (IS_ERR(pmc->pctl_dev)) {
+		err = PTR_ERR(pmc->pctl_dev);
+		dev_err(pmc->dev, "unable to register pinctrl, %d\n", err);
+	}
+
+	return err;
+}
+
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -1476,18 +1620,27 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 
 	err = register_restart_handler(&tegra_pmc_restart_handler);
 	if (err) {
-		debugfs_remove(pmc->debugfs);
 		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
 			err);
-		return err;
+		goto cleanup_debugfs;
 	}
 
+	err = tegra_pmc_pinctrl_init(pmc);
+	if (err)
+		goto cleanup_restart_handler;
+
 	mutex_lock(&pmc->powergates_lock);
 	iounmap(pmc->base);
 	pmc->base = base;
 	mutex_unlock(&pmc->powergates_lock);
 
 	return 0;
+
+cleanup_restart_handler:
+	unregister_restart_handler(&tegra_pmc_restart_handler);
+cleanup_debugfs:
+	debugfs_remove(pmc->debugfs);
+	return err;
 }
 
 #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
@@ -1577,6 +1730,8 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.has_gpu_clamps = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
+	.num_pin_descs = 0,
+	.pin_descs = NULL,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1616,6 +1771,8 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
+	.num_pin_descs = 0,
+	.pin_descs = NULL,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1659,6 +1816,8 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.has_impl_33v_pwr = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
+	.num_pin_descs = 0,
+	.pin_descs = NULL,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1705,6 +1864,12 @@ static const u8 tegra124_cpu_powergates[] = {
 		.name	= (_name),			\
 	})
 
+#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
+	((struct pinctrl_pin_desc) {			\
+		.number = (_id),			\
+		.name	= (_name)			\
+	})
+
 #define TEGRA124_IO_PAD_TABLE(_pad)					\
 	/* .id                          .dpd    .voltage  .name	*/	\
 	_pad(TEGRA_IO_PAD_AUDIO,	17,	UINT_MAX, "audio"),	\
@@ -1742,6 +1907,10 @@ static const struct tegra_io_pad_soc tegra124_io_pads[] = {
 	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
+static const struct pinctrl_pin_desc tegra124_pin_descs[] = {
+	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
+};
+
 static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_powergates = ARRAY_SIZE(tegra124_powergates),
 	.powergates = tegra124_powergates,
@@ -1752,6 +1921,8 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.has_impl_33v_pwr = false,
 	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
 	.io_pads = tegra124_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra124_pin_descs),
+	.pin_descs = tegra124_pin_descs,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1836,6 +2007,10 @@ static const struct tegra_io_pad_soc tegra210_io_pads[] = {
 	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
+static const struct pinctrl_pin_desc tegra210_pin_descs[] = {
+	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
+};
+
 static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_powergates = ARRAY_SIZE(tegra210_powergates),
 	.powergates = tegra210_powergates,
@@ -1847,6 +2022,8 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.needs_mbist_war = true,
 	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
 	.io_pads = tegra210_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra210_pin_descs),
+	.pin_descs = tegra210_pin_descs,
 	.regs = &tegra20_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
@@ -1897,6 +2074,10 @@ static const struct tegra_io_pad_soc tegra186_io_pads[] = {
 	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PAD)
 };
 
+static const struct pinctrl_pin_desc tegra186_pin_descs[] = {
+	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
+};
+
 static const struct tegra_pmc_regs tegra186_pmc_regs = {
 	.scratch0 = 0x2000,
 	.dpd_req = 0x74,
@@ -1950,6 +2131,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.has_impl_33v_pwr = true,
 	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
 	.io_pads = tegra186_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra186_pin_descs),
+	.pin_descs = tegra186_pin_descs,
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
-- 
2.18.0
