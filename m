From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 09/12] power: pwrseq: pwrseq_usb_generic: add generic power sequence support for USB deivces
Date: Fri, 17 Jun 2016 18:09:22 +0800
Message-ID: <1466158165-9380-10-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, javier@osg.samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
List-Id: linux-mmc@vger.kernel.org

Add driver for generic power sequence support for USB deivces
which handles below things:

- Clock and its frequencies
- GPIO for reset and the duration time
- GPIO for enable
- Regulator for power

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/power/pwrseq/Kconfig              |  11 ++
 drivers/power/pwrseq/Makefile             |   1 +
 drivers/power/pwrseq/pwrseq_usb_generic.c | 202 ++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/power/pwrseq/pwrseq_usb_generic.c

diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
index c7e9271..9749c6d 100644
--- a/drivers/power/pwrseq/Kconfig
+++ b/drivers/power/pwrseq/Kconfig
@@ -29,4 +29,15 @@ config POWER_SEQ_SIMPLE
 	  This driver can also be built as a module. If so, the module
 	  will be called pwrseq_simple.
 
+config POWER_SEQ_USB_GENERIC
+	tristate "Generic power sequence support for USB devices"
+	default y
+	depends on OF || COMPILE_TEST
+	help
+	  This selects generic power sequence support for USB devices.
+	  By default this option is set to y.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pwrseq_usb_generic.
+
 endif
diff --git a/drivers/power/pwrseq/Makefile b/drivers/power/pwrseq/Makefile
index d475e01..230bb45 100644
--- a/drivers/power/pwrseq/Makefile
+++ b/drivers/power/pwrseq/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_POWER_SEQ)		+= core.o
 obj-$(CONFIG_POWER_SEQ_SIMPLE)	+= pwrseq_mmc_simple.o
 obj-$(CONFIG_POWER_SEQ_EMMC)	+= pwrseq_emmc.o
+obj-$(CONFIG_POWER_SEQ_USB_GENERIC)	+= pwrseq_usb_generic.o
diff --git a/drivers/power/pwrseq/pwrseq_usb_generic.c b/drivers/power/pwrseq/pwrseq_usb_generic.c
new file mode 100644
index 0000000..6017636
--- /dev/null
+++ b/drivers/power/pwrseq/pwrseq_usb_generic.c
@@ -0,0 +1,202 @@
+/*
+ * usb_generic.c	The generic power sequence driver for USB device
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Author: Peter Chen <peter.chen@nxp.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/pwrseq.h>
+
+struct usb_pwrseq_generic {
+	struct pwrseq pwrseq;
+	struct gpio_desc *gpiod_reset;
+	struct gpio_desc *gpiod_enable;
+	struct clk *clk;
+	struct regulator *reg_power;
+};
+
+#define to_pwrseq_generic(p) container_of(p, struct usb_pwrseq_generic, pwrseq)
+
+static void usb_pwrseq_power_off(struct pwrseq *_pwrseq)
+{
+	struct usb_pwrseq_generic *pwrseq = to_pwrseq_generic(_pwrseq);
+
+	if (pwrseq->clk)
+		clk_disable_unprepare(pwrseq->clk);
+
+	if (pwrseq->gpiod_enable)
+		gpiod_set_value(pwrseq->gpiod_enable, 0);
+
+	if (pwrseq->reg_power)
+		regulator_disable(pwrseq->reg_power);
+}
+
+static int usb_pwrseq_power_on(struct pwrseq *_pwrseq)
+{
+	struct usb_pwrseq_generic *pwrseq = to_pwrseq_generic(_pwrseq);
+	struct gpio_desc *gpiod_reset = pwrseq->gpiod_reset;
+	struct gpio_desc *gpiod_enable = pwrseq->gpiod_enable;
+	struct device *dev = _pwrseq->dev;
+	struct device_node *node = dev->of_node;
+	u32 duration_us = 50, clk_rate = 0;
+	int ret;
+
+	if (pwrseq->clk) {
+		ret = clk_prepare_enable(pwrseq->clk);
+		if (ret) {
+			dev_err(dev,
+				"Can't enable external clock: %d\n",
+				ret);
+			return ret;
+		}
+
+		of_property_read_u32(node, "clock-frequency", &clk_rate);
+		if (clk_rate) {
+			ret = clk_set_rate(pwrseq->clk, clk_rate);
+			if (ret) {
+				dev_err(dev, "Error setting clock rate\n");
+				goto disable_clk;
+			}
+		}
+	}
+
+	if (gpiod_reset) {
+		of_property_read_u32(node, "reset-duration-us", &duration_us);
+		gpiod_direction_output(gpiod_reset, 1);
+
+		gpiod_set_value(gpiod_reset, 1);
+		usleep_range(duration_us, duration_us + 10);
+		gpiod_set_value(gpiod_reset, 0);
+	}
+
+	if (gpiod_enable) {
+		gpiod_direction_output(gpiod_enable, 1);
+		gpiod_set_value(gpiod_enable, 1);
+	}
+
+	if (pwrseq->reg_power) {
+		ret = regulator_enable(pwrseq->reg_power);
+		if (ret) {
+			dev_err(dev, "Failed to power regulator, ret=%d\n",
+					ret);
+			goto disable_gpio;
+		}
+	}
+
+	return 0;
+
+disable_gpio:
+	if (gpiod_enable)
+		gpiod_set_value(gpiod_enable, 0);
+
+disable_clk:
+	if (pwrseq->clk)
+		clk_disable_unprepare(pwrseq->clk);
+	return ret;
+}
+
+static const struct pwrseq_ops usb_pwrseq_generic_ops = {
+	.pre_power_on = usb_pwrseq_power_on,
+	.power_off = usb_pwrseq_power_off,
+};
+
+static const struct of_device_id usb_pwrseq_generic_of_match[] = {
+	{ .compatible = "usb-pwrseq-generic",},
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, usb_pwrseq_generic_of_match);
+
+static int usb_pwrseq_generic_probe(struct platform_device *pdev)
+{
+	struct usb_pwrseq_generic *pwrseq;
+	struct device *dev = &pdev->dev;
+	struct regulator *reg;
+	int ret;
+
+	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
+	if (!pwrseq)
+		return -ENOMEM;
+
+	pwrseq->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwrseq->clk)) {
+		dev_dbg(dev, "Can't get clock: %ld\n",
+			PTR_ERR(pwrseq->clk));
+		pwrseq->clk = NULL;
+	}
+
+	pwrseq->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
+			GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(pwrseq->gpiod_reset);
+	if (ret) {
+		dev_err(dev, "Failed to get reset gpio, err = %d\n", ret);
+		return ret;
+	}
+
+	pwrseq->gpiod_enable = devm_gpiod_get_optional(dev, "enable",
+			GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(pwrseq->gpiod_enable);
+	if (ret) {
+		dev_err(dev, "Failed to get enable gpio, err = %d\n", ret);
+		return ret;
+	}
+
+	reg = devm_regulator_get(dev, "power");
+	if (PTR_ERR(reg) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (PTR_ERR(reg) == -ENODEV)
+		/* no power regulator is needed */
+		reg = NULL;
+	else if (IS_ERR(reg))
+		return PTR_ERR(reg);
+	pwrseq->reg_power = reg;
+
+	pwrseq->pwrseq.dev = dev;
+	pwrseq->pwrseq.ops = &usb_pwrseq_generic_ops;
+	pwrseq->pwrseq.owner = THIS_MODULE;
+	platform_set_drvdata(pdev, pwrseq);
+
+	return pwrseq_register(&pwrseq->pwrseq);
+}
+
+static int usb_pwrseq_generic_remove(struct platform_device *pdev)
+{
+	struct usb_pwrseq_generic *pwrseq = platform_get_drvdata(pdev);
+
+	pwrseq_unregister(&pwrseq->pwrseq);
+
+	return 0;
+}
+
+static struct platform_driver usb_pwrseq_generic_driver = {
+	.probe = usb_pwrseq_generic_probe,
+	.remove = usb_pwrseq_generic_remove,
+	.driver = {
+		.name = "usb_pwrseq_generic",
+		.of_match_table = usb_pwrseq_generic_of_match,
+	},
+};
+
+module_platform_driver(usb_pwrseq_generic_driver);
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

