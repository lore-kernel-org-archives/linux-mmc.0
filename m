Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5438DC83012
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026EE2222E
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 07:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbgLBHDY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:03:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:44053 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbgLBHDX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 02:03:23 -0500
IronPort-SDR: gi3F/nHIkVLVGvxzwGKumLfWf1ijjD3JdGFA+/BDFLmILerdpCaMuKUkqGQft75Ye1BT616/UY
 /hQIjy7fHreQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169461819"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="169461819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 23:02:40 -0800
IronPort-SDR: xGCi6diPNCBrGM35qkldCzqGw+ThAG9oKKVcLhKfCinmU4DENwHx9uBRVI+YMEwOty3TCYAgVY
 aEJKlbsDk4fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="481430026"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2020 23:02:38 -0800
From:   muhammad.husaini.zulkifli@intel.com
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, mgross@linux.intel.com
Subject: [PATCH v6 2/4] firmware: keembay: Add support for Trusted Firmware Service call
Date:   Wed,  2 Dec 2020 23:02:02 +0800
Message-Id: <20201202150205.20150-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Export inline function to encapsulate AON_CFG1 for controling the
I/O Rail supplied voltage levels which communicate with Trusted Firmware.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/firmware/intel/keembay.h | 54 ++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 include/linux/firmware/intel/keembay.h

diff --git a/include/linux/firmware/intel/keembay.h b/include/linux/firmware/intel/keembay.h
new file mode 100644
index 000000000000..b5e3e490807e
--- /dev/null
+++ b/include/linux/firmware/intel/keembay.h
@@ -0,0 +1,54 @@
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
+#define IOV_1V8			1800000
+#define IOV_3V3			3300000
+
+#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_32,		\
+			   ARM_SMCCC_OWNER_SIP,		\
+			   0xFF26)
+
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
+/*
+ * Voltage applied on the IO Rail is controlled from the Always On Register using specific
+ * bits in AON_CGF1 register. This is a secure register. Keem Bay SOC cannot exposed this
+ * register address to the outside world.
+ */
+static inline int keembay_io_rail_supplied_voltage(int volt)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE, volt, &res);
+	if ((int)res.a0 < 0)
+		return -EINVAL;
+
+	return 0;
+}
+#else
+static inline int keembay_io_rail_supplied_voltage(int volt)
+{
+	return -ENODEV;
+}
+#endif
+#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
-- 
2.17.1

