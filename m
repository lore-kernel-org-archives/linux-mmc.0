Return-Path: <SRS0=Kjhy=DI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1745C4727C
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC44C20B1F
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 14:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgJAOZG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Oct 2020 10:25:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:5353 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbgJAOZF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Oct 2020 10:25:05 -0400
IronPort-SDR: 9pn/hEP4bk+q1RZVO0gApyye7bqwCK9IhJV0D05Fqwnu1XaABnptJmoe8GvgFGRC1VY83KilXQ
 KWa7COFYwDHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="161975965"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="161975965"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 07:24:59 -0700
IronPort-SDR: RlCVCnM2Hi8yLl1EO7S8zFBbKgaRn/68oIAIPjhK0nRWZKRATwoCnf948k7KMCj1ofBqToaQli
 fv9AB5y5Df0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="294992512"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2020 07:24:56 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted Firmware Service call
Date:   Thu,  1 Oct 2020 22:21:48 +0800
Message-Id: <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add generic firmware driver for Keem Bay SOC to support
Arm Trusted Firmware Services call.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/firmware/Kconfig                   |   1 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/intel/Kconfig             |  14 +++
 drivers/firmware/intel/Makefile            |   4 +
 drivers/firmware/intel/keembay_smc.c       | 119 +++++++++++++++++++++
 include/linux/firmware/intel/keembay_smc.h |  27 +++++
 6 files changed, 166 insertions(+)
 create mode 100644 drivers/firmware/intel/Kconfig
 create mode 100644 drivers/firmware/intel/Makefile
 create mode 100644 drivers/firmware/intel/keembay_smc.c
 create mode 100644 include/linux/firmware/intel/keembay_smc.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index fbd785dd0513..41de77d2720e 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -305,5 +305,6 @@ source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
 source "drivers/firmware/xilinx/Kconfig"
+source "drivers/firmware/intel/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 99510be9f5ed..00f295ab9860 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -33,3 +33,4 @@ obj-y				+= psci/
 obj-y				+= smccc/
 obj-y				+= tegra/
 obj-y				+= xilinx/
+obj-y				+= intel/
diff --git a/drivers/firmware/intel/Kconfig b/drivers/firmware/intel/Kconfig
new file mode 100644
index 000000000000..b2b7a4e5410b
--- /dev/null
+++ b/drivers/firmware/intel/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Intel Firmware Drivers"
+
+config KEEMBAY_FIRMWARE
+	bool "Enable Keem Bay firmware interface support"
+	depends on HAVE_ARM_SMCCC
+	default n
+	help
+	  Firmware interface driver is used by device drivers
+	  to communicate with the arm-trusted-firmware
+	  for platform management services.
+	  If in doubt, say "N".
+
+endmenu
diff --git a/drivers/firmware/intel/Makefile b/drivers/firmware/intel/Makefile
new file mode 100644
index 000000000000..e6d2e1ea69a7
--- /dev/null
+++ b/drivers/firmware/intel/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Intel firmwares
+
+obj-$(CONFIG_KEEMBAY_FIRMWARE) = keembay_smc.o
diff --git a/drivers/firmware/intel/keembay_smc.c b/drivers/firmware/intel/keembay_smc.c
new file mode 100644
index 000000000000..24013cd1f5da
--- /dev/null
+++ b/drivers/firmware/intel/keembay_smc.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020-2021, Intel Corporation
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+
+#include <linux/firmware/intel/keembay_smc.h>
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1)
+{
+	return -ENODEV;
+}
+
+/**
+ * Simple wrapper functions to be able to use a function pointer
+ * Invoke do_fw_call_smc or others in future, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ *
+ * Invoke platform management function via SMC call.
+ *
+ * Return: Returns status, either success or error
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+/**
+ * keembay_sd_voltage_selection() - Set the IO Pad voltage
+ * @volt: voltage selection either 1.8V or 3.3V
+ *
+ * This function is used to set the IO Line Voltage
+ *
+ * Return: 0 for success, Invalid for failure
+ */
+int keembay_sd_voltage_selection(int volt)
+{
+	return do_fw_call(KEEMBAY_SIP_FUNC_ID, volt);
+}
+EXPORT_SYMBOL_GPL(keembay_sd_voltage_selection);
+
+/**
+ * keembay_get_invoke_func() - method of call
+ * @np:	Pointer to the device_node structure
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int keembay_get_invoke_func(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int keembay_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = keembay_get_invoke_func(dev->of_node);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get method of call\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int keembay_firmware_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id keembay_firmware_of_match[] = {
+	{.compatible = "keembay,firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, keembay_firmware_of_match);
+
+static struct platform_driver keembay_firmware_driver = {
+	.driver = {
+		.name = "keembay_firmware",
+		.of_match_table = keembay_firmware_of_match,
+	},
+	.probe = keembay_firmware_probe,
+	.remove = keembay_firmware_remove,
+};
+module_platform_driver(keembay_firmware_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Keembay SOC Firmware Layer");
+MODULE_AUTHOR("Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>");
diff --git a/include/linux/firmware/intel/keembay_smc.h b/include/linux/firmware/intel/keembay_smc.h
new file mode 100644
index 000000000000..87b1417f7e4e
--- /dev/null
+++ b/include/linux/firmware/intel/keembay_smc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Intel Keembay SOC Firmware Layer
+ *
+ *  Copyright (C) 2020-2021, Intel Corporation
+ *
+ *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+ */
+
+#ifndef __FIRMWARE_KEEMBAY_SMC_H__
+#define __FIRMWARE_KEEMBAY_SMC_H__
+
+/* Setting for Keem Bay IO Pad Line Voltage Selection */
+#define KEEMBAY_SIP_FUNC_ID	0x8200ff26
+#define KEEMBAY_SET_1V8_VOLT	0x01
+#define KEEMBAY_SET_3V3_VOLT	0x00
+
+#if IS_ENABLED(CONFIG_KEEMBAY_FIRMWARE)
+int keembay_sd_voltage_selection(int volt);
+#else
+static inline int keembay_sd_voltage_selection(int volt)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
-- 
2.17.1

