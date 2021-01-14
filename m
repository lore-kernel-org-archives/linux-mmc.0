Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E80C43333
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90F22311F
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbhANP3n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:29:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:7042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP3m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:42 -0500
IronPort-SDR: IcdR0hcYSYGyfw3sJm/7nSsjHIvZ95PncPXUKzm8blExxC6MK6rOTsWGmmHvuOC1iaW0W5i6Uq
 1Ki1IehR7gzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604681"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604681"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:49 -0800
IronPort-SDR: GgEXR1TDmSQIN/VeeHEXLTSIjiGQges5iS4s+jjM6tB5QkKjkcNMAtatnvzW3b8T9XDcc/EqCK
 YkA9ljMdxogA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193633"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:46 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 7/9] dt-bindings: regulator: keembay: Add DT binding documentation
Date:   Thu, 14 Jan 2021 23:26:58 +0800
Message-Id: <20210114152700.21916-8-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add DT Binding Documentation for Keem Bay SD Regulator.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 .../bindings/regulator/keembay-regulator.yaml | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/keembay-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/keembay-regulator.yaml b/Documentation/devicetree/bindings/regulator/keembay-regulator.yaml
new file mode 100644
index 000000000000..a32e87c9eeed
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/keembay-regulator.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/keembay-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Keem Bay SD regulator
+
+maintainers:
+  - Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: regulator-keembay-sd
+
+  regulator-name: true
+
+required:
+  - compatible
+  - regulator-name
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    regulator_rail {
+      compatible = "regulator-keembay-sd";
+
+      regulator-name = "sd-volt-rail";
+      regulator-min-microvolt = <1800000>;
+      regulator-max-microvolt = <3300000>;
+    };
+...
-- 
2.17.1

