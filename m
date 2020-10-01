Return-Path: <SRS0=Kjhy=DI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8707AC4727C
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E25A2087D
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Oct 2020 14:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgJAOZG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Oct 2020 10:25:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:5353 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732207AbgJAOZF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Oct 2020 10:25:05 -0400
IronPort-SDR: 9o3XsY6BuAU5jSIJ1HPXFcO8x+o3G0kgSQ/KMlmCjkXhaFjDr7oWjbgtYDh/C7+nhkX4SvFAQG
 tldCSCl2Rjpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="161975958"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="161975958"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 07:24:56 -0700
IronPort-SDR: 2vrrK1q5PUNNl6kwZPWlQsp/8WXdeiW1rrgXqKHOAgXpNyQ28d+KLB2kzFwqh89kH88zVjP7j+
 8SpAxKm6aZiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="294992500"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2020 07:24:54 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v2 1/3] dt-bindings: arm: firmware: Add binding for Keem Bay Firmware Support
Date:   Thu,  1 Oct 2020 22:21:47 +0800
Message-Id: <20201001142149.23445-2-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add bindings for Keem Bay implementation of Arm Trusted Firmware
Services call.

Update the MAINTAINERS list.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 .../arm/firmware/keembay,firmware.yaml        | 36 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++++
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/keembay,firmware.yaml

diff --git a/Documentation/devicetree/bindings/arm/firmware/keembay,firmware.yaml b/Documentation/devicetree/bindings/arm/firmware/keembay,firmware.yaml
new file mode 100644
index 000000000000..9bb5a15f1e3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/firmware/keembay,firmware.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/firmware/keembay,firmware.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Keem Bay Device Tree Bindings
+
+maintainers:
+  - Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+
+properties:
+  $nodename:
+    const: keembay_firmware
+
+  compatible:
+    enum:
+      - keembay,firmware
+
+  method:
+   $ref: '/schemas/types.yaml#/definitions/string'
+   oneOf:
+      - enum:
+          - smc
+
+required:
+  - compatible
+  - method
+
+examples:
+  - |
+    keembay_firmware {
+        compatible = "keembay,firmware";
+        method = "smc";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 190c7fa2ea01..33b8ded820f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19278,6 +19278,13 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+KEEMBAY FIRMWARE
+M:	Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/firmware/keembay,firmware.yaml
+F:	drivers/firmware/intel/keembay_smc.c
+F:	linux/include/linux/firmware/intel/keembay_smc.h
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.17.1

