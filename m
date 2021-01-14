Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F9C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561B223A7E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhANP3q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:29:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:7044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbhANP3p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:45 -0500
IronPort-SDR: Jl2xFrqheOeKddsK+a5lEmOWQAg6Cs4fVK3VrIv1jcrwEFro2VJkcT5s8xKKCacnThdxdY9vfH
 36qFRBYxYw4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604692"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604692"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:53 -0800
IronPort-SDR: n8WtdzCxkPnQSeK/wKKdtTwG8ZI3l8+r6A+xD/yK2JMx13OioFVDfYqbks3Hb6xFMNMGozoMR6
 0VNl1uwsGRug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193650"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:50 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 8/9] regulator: keembay: Add regulator for Keem Bay SoC
Date:   Thu, 14 Jan 2021 23:26:59 +0800
Message-Id: <20210114152700.21916-9-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Keem Bay SD regulator driver module is added to encapsulate ARM
Secure Monitor Call Calling Convention (SMCCC) during set voltage
operations to control I/O Rail supplied voltage levels which communicate
with Trusted Firmware.

I/O Rail voltage need to be configure through AON_CFG1 Register by
setting specific bit in the AON_CFG1 Register. AON_CFG1 Register is
a secure register. Direct access to AON_CFG1 register bit will cause
firewall violation in secure system.

Modelling using standard regulator abstraction during voltage operation
make things easier for device driver to consume it.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/regulator/Kconfig                |  10 ++
 drivers/regulator/Makefile               |   1 +
 drivers/regulator/keembay-sd-regulator.c | 112 +++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 drivers/regulator/keembay-sd-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5abdd29fb9f3..72cfd0d14066 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -436,6 +436,16 @@ config REGULATOR_ISL6271A
 	help
 	  This driver supports ISL6271A voltage regulator chip.
 
+config REGULATOR_KEEMBAY_SD
+	tristate "Intel Keem Bay SD Regulator"
+	depends on HAVE_ARM_SMCCC && (OF || COMPILE_TEST)
+	help
+	  This driver provides support for the voltage regulators of the
+	  Keem Bay SOC to encapsulate ARM Secure Monitor Call Calling Convention
+	  to change the voltage rail output.
+	  This is specific for Keem Bay hardware design only.
+	  The module name will be called keembay-sd-regulator.
+
 config REGULATOR_LM363X
 	tristate "TI LM363X voltage regulators"
 	depends on MFD_TI_LMU
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 680e539f6579..0d2392441b66 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_REGULATOR_HI6421V530) += hi6421v530-regulator.o
 obj-$(CONFIG_REGULATOR_HI655X) += hi655x-regulator.o
 obj-$(CONFIG_REGULATOR_ISL6271A) += isl6271a-regulator.o
 obj-$(CONFIG_REGULATOR_ISL9305) += isl9305.o
+obj-$(CONFIG_REGULATOR_KEEMBAY_SD) += keembay-sd-regulator.o
 obj-$(CONFIG_REGULATOR_LM363X) += lm363x-regulator.o
 obj-$(CONFIG_REGULATOR_LOCHNAGAR) += lochnagar-regulator.o
 obj-$(CONFIG_REGULATOR_LP3971) += lp3971.o
diff --git a/drivers/regulator/keembay-sd-regulator.c b/drivers/regulator/keembay-sd-regulator.c
new file mode 100644
index 000000000000..7f90c08de283
--- /dev/null
+++ b/drivers/regulator/keembay-sd-regulator.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Keem Bay SD Regulator
+ *
+ * Copyright (C) 2020, Intel Corporation
+ * Author: Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+ */
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <linux/firmware/intel/keembay.h>
+
+static int keembay_regulator_set_voltage(struct regulator_dev *dev,
+					int min_uV, int max_uV,
+					unsigned *selector)
+{
+	int tmp_volt;
+
+	if (min_uV == KEEMBAY_IOV_1_8V_uV && max_uV == KEEMBAY_IOV_1_8V_uV)
+		tmp_volt = KEEMBAY_SET_1V8_IO_RAIL;
+	else
+		tmp_volt = KEEMBAY_SET_3V3_IO_RAIL;
+
+	return keembay_set_io_rail_supplied_voltage(tmp_volt);
+}
+
+static int keembay_regulator_get_voltage(struct regulator_dev *dev)
+{
+	int ret;
+
+	ret = keembay_get_io_rail_supplied_voltage();
+
+	return ret ? KEEMBAY_IOV_1_8V_uV : KEEMBAY_IOV_3_3V_uV;
+}
+
+static const struct regulator_ops keembay_regulator_voltage_ops = {
+	.get_voltage = keembay_regulator_get_voltage,
+	.set_voltage = keembay_regulator_set_voltage,
+};
+
+static int keembay_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_desc *desc;
+	struct regulator_init_data *init_data;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct device *dev = &pdev->dev;
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	init_data = of_get_regulator_init_data(dev, dev->of_node, desc);
+	if (!init_data)
+		return -EINVAL;
+
+	desc->name = dev_name(dev);
+	desc->type = REGULATOR_VOLTAGE;
+	desc->owner = THIS_MODULE;
+	desc->ops = &keembay_regulator_voltage_ops;
+
+	config.dev = dev;
+	config.init_data = init_data;
+	config.of_node = dev->of_node;
+
+	rdev = devm_regulator_register(dev, desc, &config);
+	if (IS_ERR(rdev))
+		return dev_err_probe(dev, PTR_ERR(rdev),
+				     "Failed to register Keem Bay SD regulator.\n");
+
+	return 0;
+}
+
+static const struct of_device_id regulator_keembay_of_match[] = {
+	{ .compatible = "regulator-keembay-sd" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, regulator_keembay_of_match);
+
+static struct platform_driver keembay_regulator_driver = {
+	.probe		= keembay_regulator_probe,
+	.driver		= {
+		.name		= "keembay-sd-regulator",
+		.of_match_table = regulator_keembay_of_match,
+	},
+};
+
+static int __init keembay_regulator_init(void)
+{
+	return platform_driver_register(&keembay_regulator_driver);
+}
+
+/*
+ * Using subsys_initcall to ensure that Keem Bay regulator platform driver
+ * is initialized before device driver try to utilize it.
+ */
+subsys_initcall(keembay_regulator_init);
+
+static void __exit keembay_regulator_exit(void)
+{
+	platform_driver_unregister(&keembay_regulator_driver);
+}
+module_exit(keembay_regulator_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Keem Bay SD Regulator");
+MODULE_AUTHOR("Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>");
-- 
2.17.1

