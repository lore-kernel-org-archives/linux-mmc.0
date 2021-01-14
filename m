Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D559C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B36F23A24
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbhANP3a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:29:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:7044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP3a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:30 -0500
IronPort-SDR: /biz+3lnOHLOpJ4URRA8JMMHPSrlCC5lcxktsKDv7tfJ2VSvCqrFp/F5kvXeuWYgpXIbS63TkX
 c6/iCXRx96GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604671"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604671"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:43 -0800
IronPort-SDR: t3gUSsbPz4eDs4XJpMxRkNzkvPA3g4Cay+7UOr6avSj8H+sFzbFlU6QOv5GOq1tqGA7EBwKFxH
 6Stg8Dmhsclw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193613"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:40 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 5/9] firmware: keembay: Add support for Trusted Firmware Service call
Date:   Thu, 14 Jan 2021 23:26:56 +0800
Message-Id: <20210114152700.21916-6-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Export inline function to encapsulate AON_CFG1 for controling the I/O Rail
supplied voltage levels which communicate with Trusted Firmware.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 include/linux/firmware/intel/keembay.h | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 include/linux/firmware/intel/keembay.h

diff --git a/include/linux/firmware/intel/keembay.h b/include/linux/firmware/intel/keembay.h
new file mode 100644
index 000000000000..f5a8dbfdb63b
--- /dev/null
+++ b/include/linux/firmware/intel/keembay.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Intel Keembay SOC Firmware API Layer
+ *
+ *  Copyright (C) 2020, Intel Corporation
+ *
+ *  Author: Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+ */
+
+#ifndef __FIRMWARE_KEEMBAY_SMC_H__
+#define __FIRMWARE_KEEMBAY_SMC_H__
+
+#include <linux/arm-smccc.h>
+
+/*
+ * This file defines an API function that can be called by a device driver in order to
+ * communicate with Trusted Firmware - A profile(TF-A) or Trusted Firmware - M profile (TF-M).
+ */
+
+#define KEEMBAY_SET_1V8_IO_RAIL	1
+#define KEEMBAY_SET_3V3_IO_RAIL	0
+
+#define KEEMBAY_IOV_1_8V_uV	1800000
+#define KEEMBAY_IOV_3_3V_uV	3300000
+
+#define KEEMBAY_SET_SD_VOLTAGE_ID 0xFF26
+#define KEEMBAY_GET_SD_VOLTAGE_ID 0xFF2A
+
+#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_32,		\
+			   ARM_SMCCC_OWNER_SIP,		\
+			   KEEMBAY_SET_SD_VOLTAGE_ID)
+
+#define ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_32,		\
+			   ARM_SMCCC_OWNER_SIP,		\
+			   KEEMBAY_GET_SD_VOLTAGE_ID)
+
+#define KEEMBAY_REG_NUM_CONSUMERS 2
+
+struct keembay_reg_supply {
+	struct regulator *consumer;
+};
+
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
+/*
+ * Voltage applied on the IO Rail is controlled from the Always On Register using specific
+ * bits in AON_CGF1 register. This is a secure register. Keem Bay SOC cannot exposed this
+ * register address to the outside world.
+ */
+static inline int keembay_set_io_rail_supplied_voltage(int volt)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE, volt, &res);
+
+	return res.a0;
+}
+
+static inline int keembay_get_io_rail_supplied_voltage(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_GET_SD_VOLTAGE, &res);
+
+	return res.a1;
+}
+#else
+static inline int keembay_set_io_rail_supplied_voltage(int volt)
+{
+	return -ENODEV;
+}
+
+static inline int keembay_get_io_rail_supplied_voltage(void)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
-- 
2.17.1

