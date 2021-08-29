Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1E8C432BE
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Aug 2021 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010B60F23
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Aug 2021 18:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhH2SZv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Aug 2021 14:25:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:63344 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhH2SZv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 29 Aug 2021 14:25:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="197736756"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="197736756"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 11:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="445519095"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2021 11:24:54 -0700
From:   rashmi.a@intel.com
To:     michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, rashmi.a@intel.com
Subject: [PATCH v2 2/4] dt-bindings: mmc: Add bindings for Intel Thunder Bay SoC
Date:   Sun, 29 Aug 2021 23:54:41 +0530
Message-Id: <20210829182443.30802-3-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210829182443.30802-1-rashmi.a@intel.com>
References: <20210829182443.30802-1-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

Add documentation for Arasan SDHCI controller in Thunder Bay SOC.

Signed-off-by: Rashmi A <rashmi.a@intel.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 37a5fe7b26dc..23abb7e8b9d8 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -88,6 +88,12 @@ properties:
         description:
           For this device it is strongly suggested to include
           arasan,soc-ctl-syscon.
+      - items:
+          - const: intel,thunderbay-sdhci-5.1   # Intel Thunder Bay eMMC PHY
+          - const: arasan,sdhci-5.1
+        description:
+          For this device it is strongly suggested to include
+          clock-output-names and '#clock-cells'.
 
   reg:
     maxItems: 1
@@ -301,3 +307,22 @@ examples:
                    <&scmi_clk KEEM_BAY_PSS_SD0>;
           arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
     };
+
+  - |
+    #define EMMC_XIN_CLK
+    #define EMMC_AXI_CLK
+    #define TBH_PSS_EMMC_RST_N
+    mmc@80420000 {
+          compatible = "intel,thunderbay-sdhci-5.1", "arasan,sdhci-5.1";
+          interrupts = <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>;
+          reg = <0x80420000 0x400>;
+          clocks = <&scmi_clk EMMC_XIN_CLK>,
+                   <&scmi_clk EMMC_AXI_CLK>;
+          clock-names = "clk_xin", "clk_ahb";
+          phys = <&emmc_phy>;
+          phy-names = "phy_arasan";
+          assigned-clocks = <&scmi_clk EMMC_XIN_CLK>;
+          clock-output-names = "emmc_cardclock";
+          resets = <&rst_pss1 TBH_PSS_EMMC_RST_N>;
+          #clock-cells = <0x0>;
+    };
-- 
2.17.1

