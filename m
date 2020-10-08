Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24CCC433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C40322203
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 18:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgJHSWF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:22:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:32109 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJHSWE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 14:22:04 -0400
IronPort-SDR: TE/m4OkSgaT/t2pJDnUSSOolqJQ/4V/1j5L+aIsRE+ki8OxEO6qxTtucQ+9Hbd6zi2xEZqLblZ
 yQg0Ayaug8rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250078401"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="250078401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 11:22:03 -0700
IronPort-SDR: tTWZA1hY9EMh9skBW5psikHF8FM8NkX4s7kMCbozh2EpAitrejR4xYgk4F6EZOiQ+7pvRYEQyZ
 Zy/LbIX+liKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="349572559"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2020 11:22:01 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v5 2/4] dt-bindings: mmc: Add uhs-gpio for Keem Bay UHS-1 Support
Date:   Fri,  9 Oct 2020 02:18:42 +0800
Message-Id: <20201008181844.27947-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
References: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add DT bindings of uhs-gpio for Keem Bay SOC UHS Mode Support

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 58fe9d02a781..320566a673f0 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -83,7 +83,7 @@ properties:
       - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD controller
         description:
           For this device it is strongly suggested to include
-          arasan,soc-ctl-syscon.
+          arasan,soc-ctl-syscon and uhs-gpio.
       - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO controller
         description:
           For this device it is strongly suggested to include
@@ -152,6 +152,11 @@ properties:
     description:
       The MIO bank number in which the command and data lines are configured.
 
+  uhs-gpio:
+    description:
+      The power mux input will be configure using the GPIO provided
+      to generate either 1.8v or 3.3v output.
+
 dependencies:
   clock-output-names: [ '#clock-cells' ]
   '#clock-cells': [ clock-output-names ]
@@ -300,4 +305,5 @@ examples:
           clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
                    <&scmi_clk KEEM_BAY_PSS_SD0>;
           arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
+          uhs-gpio = <&pca0 17 0>;
     };
-- 
2.17.1

