Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA08C4363D
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 02:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D695E207C3
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 02:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgJHCMv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 22:12:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:31771 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgJHCMu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 22:12:50 -0400
IronPort-SDR: CVggJL8xD0YKojGyN7vrQEN9QYDD0aKliuwjKM3PrIVw9OkHbT9Av+8SNftZChGyyELJWnY/9L
 TgD+ebHqD++Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152154696"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="152154696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 19:12:50 -0700
IronPort-SDR: RI3H4YlVez3FTpUwAKN5Ree7BlzDKmNaSBkf7Qfd9k9NTu646p9CpSVkANAieLYhYCwC820XE5
 N+MHdsGTdQLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355211184"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 19:12:47 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted Firmware Service call
Date:   Thu,  8 Oct 2020 10:09:33 +0800
Message-Id: <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add header file to handle API function for device driver to communicate
with Arm Trusted Firmware.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 .../linux/firmware/intel/keembay_firmware.h   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 include/linux/firmware/intel/keembay_firmware.h

diff --git a/include/linux/firmware/intel/keembay_firmware.h b/include/linux/firmware/intel/keembay_firmware.h
new file mode 100644
index 000000000000..8a62abcdfead
--- /dev/null
+++ b/include/linux/firmware/intel/keembay_firmware.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Intel Keembay SOC Firmware API Layer
+ *
+ *  Copyright (C) 2020-2021, Intel Corporation
+ *
+ *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+ */
+
+#ifndef __FIRMWARE_KEEMBAY_SMC_H__
+#define __FIRMWARE_KEEMBAY_SMC_H__
+
+#include <linux/arm-smccc.h>
+
+/*
+ * This file defines API function that can be called by device driver in order to
+ * communicate with Arm Trusted Firmware.
+ */
+
+/* Setting for Keem Bay IO Pad Line Voltage Selection */
+#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_32,		\
+			   ARM_SMCCC_OWNER_SIP,		\
+			   0xFF26)
+
+#define KEEMBAY_SET_1V8_VOLT	1
+#define KEEMBAY_SET_3V3_VOLT	0
+
+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
+static inline int keembay_sd_voltage_selection(int volt)
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
+static inline int keembay_sd_voltage_selection(int volt)
+{
+	return -ENODEV;
+}
+#endif
+#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
-- 
2.17.1

