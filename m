Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72DDC1975A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 09:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41E920663
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 09:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgCPJNr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:13:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:54785 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbgCPJNr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Mar 2020 05:13:47 -0400
IronPort-SDR: azwGH6Hu2lqR9Q0F2cy1VwX2myzz5o1FL4ILRHP5dQyVl9N63EwUDFVixwm56n2rLpFMjHT7sR
 MR6H6zZoGKkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 02:13:47 -0700
IronPort-SDR: tElAKkpvC6r5Yb0R7pDd6uU6Xydbcd7uwuP1h6K8xtVjFWqDyk1wfF4jimoAu6Kjs5rYv2u/r6
 PbbmqqTXufqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="267499677"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 02:13:45 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 1/2] dt-bindings: mmc: arasan: Add compatible strings for Intel Keem Bay
Date:   Mon, 16 Mar 2020 17:13:23 +0800
Message-Id: <20200316091324.15968-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316091324.15968-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200316091324.15968-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible strings in sdhci-of-arasan.c to support Intel Keem Bay
eMMC/SD/SDIO controller, based on Arasan SDHCI 5.1.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 428685eb2ded..50f9cc0eff2a 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -24,6 +24,10 @@ Required Properties:
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
     - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1": Keem Bay eMMC PHY
+      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "intel,keembay-sdhci-5.1-sd": Keem Bay SD controller
+    - "intel,keembay-sdhci-5.1-sdio": Keem Bay SDIO controller
 
   [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 
@@ -133,3 +137,38 @@ Example:
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
+		clock-output-names = "emmc_cardclock";
+		#clock-cells = <0>;
+		arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
+	};
+
+	sd0: sdhci@31000000 {
+		compatible = "intel,keembay-sdhci-5.1-sd";
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x0 0x31000000 0x0 0x300>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
+			 <&scmi_clk KEEM_BAY_PSS_SD0>;
+		arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
+	};
+
+	sd1: sdhci@32000000 {
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

