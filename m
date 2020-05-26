Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81589C433E2
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 06:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6930520870
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 06:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgEZG33 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 02:29:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:47652 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgEZG33 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 02:29:29 -0400
IronPort-SDR: bZeYXU+6hgSDDPtGKY/eKu8su8pmPavZ83qnvRj08pEMcjN+8rEzedvUVjdKJtuWaJQfNffwdS
 JK6n3PjQ/nxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:29:29 -0700
IronPort-SDR: OweOOeantlvlUMv/baVhTmp0bp0o5eiuSEMug6MhXEGqZh2VoTX+J4hEnVLYFqHdA3HMgW4VA8
 dGJS1DpeiWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="255301183"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga007.jf.intel.com with ESMTP; 25 May 2020 23:29:27 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 1/3] dt-bindings: mmc: arasan: Add compatible strings for Intel Keem Bay
Date:   Tue, 26 May 2020 14:27:56 +0800
Message-Id: <20200526062758.17642-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible strings in sdhci-of-arasan.c to support Intel Keem Bay
eMMC/SD/SDIO controller, based on Arasan SDHCI 5.1.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 630fe707f5c4..f29bf7dd2ece 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -27,6 +27,12 @@ Required Properties:
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
     - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel Keem Bay eMMC
+      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "intel,keembay-sdhci-5.1-sd": Intel Keem Bay SD controller
+      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "intel,keembay-sdhci-5.1-sdio": Intel Keem Bay SDIO controller
+      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
 
   [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 
@@ -148,3 +154,39 @@ Example:
 		phy-names = "phy_arasan";
 		arasan,soc-ctl-syscon = <&sysconf>;
 	};
+
+	mmc: mmc@33000000 {
+		compatible = "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1";
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x0 0x33000000 0x0 0x300>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
+			 <&scmi_clk KEEM_BAY_PSS_EMMC>;
+		phys = <&emmc_phy>;
+		phy-names = "phy_arasan";
+		assigned-clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
+		assigned-clock-rates = <200000000>;
+		clock-output-names = "emmc_cardclock";
+		#clock-cells = <0>;
+		arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
+	};
+
+	sd0: mmc@31000000 {
+		compatible = "intel,keembay-sdhci-5.1-sd";
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x0 0x31000000 0x0 0x300>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
+			 <&scmi_clk KEEM_BAY_PSS_SD0>;
+		arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
+	};
+
+	sd1: mmc@32000000 {
+		compatible = "intel,keembay-sdhci-5.1-sdio";
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x0 0x32000000 0x0 0x300>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
+			 <&scmi_clk KEEM_BAY_PSS_SD1>;
+		arasan,soc-ctl-syscon = <&sd1_phy_syscon>;
+	};
-- 
2.17.1

