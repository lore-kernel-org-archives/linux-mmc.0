Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9BEC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A3420723
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 09:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgEVJgO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 05:36:14 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:20154 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728424AbgEVJgN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 05:36:13 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 May 2020 15:06:09 +0530
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg01-blr.qualcomm.com with ESMTP; 22 May 2020 15:06:09 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id B6EBB179E; Fri, 22 May 2020 15:06:07 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH V2 2/8] dt-bindings: mmc: Add information for DLL register properties
Date:   Fri, 22 May 2020 15:02:24 +0530
Message-Id: <1590139950-7288-3-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590139950-7288-1-git-send-email-sartgarg@codeaurora.org>
References: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
 <1590139950-7288-1-git-send-email-sartgarg@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add information regarding DLL register properties for getting board
specific configurations. These DLL register settings may vary from
board to board.

Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 481f692f..b8e1d2b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -47,6 +47,13 @@ Required properties:
 	"cal"	- reference clock for RCLK delay calibration (optional)
 	"sleep"	- sleep clock for RCLK delay calibration (optional)
 
+- qcom,ddr-config: Certain chipsets and platforms require particular settings
+	for the DDR_CONFIG register. Use this field to specify the register
+	value as per the Hardware Programming Guide.
+
+- qcom,dll-config: Chipset and Platform specific value. Use this field to
+	specify the DLL_CONFIG register value as per Hardware Programming Guide.
+
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -64,6 +71,9 @@ Example:
 
 		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 		clock-names = "core", "iface";
+
+		qcom,dll-config = <0x000f642c>;
+		qcom,ddr-config = <0x80040868>;
 	};
 
 	sdhc_2: sdhci@f98a4900 {
@@ -81,4 +91,7 @@ Example:
 
 		clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
 		clock-names = "core", "iface";
+
+		qcom,dll-config = <0x0007642c>;
+		qcom,ddr-config = <0x80040868>;
 	};
-- 
2.7.4

