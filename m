Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37A3C433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 11:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF5B207D3
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 11:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFDLQk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:16:40 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:58876 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbgFDLQi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2020 07:16:38 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Jun 2020 16:45:16 +0530
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg02-blr.qualcomm.com with ESMTP; 04 Jun 2020 16:44:48 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id 9317B191B; Thu,  4 Jun 2020 16:44:47 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc-owner@vger.kernel.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, matthias@chromium.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V2 2/2] dt-bindings: mmc: sdhci-msm: Add interconnect BW scaling strings
Date:   Thu,  4 Jun 2020 16:44:43 +0530
Message-Id: <1591269283-24084-3-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1591269283-24084-1-git-send-email-ppvk@codeaurora.org>
References: <1591269283-24084-1-git-send-email-ppvk@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add interconnect bandwidth scaling supported strings for qcom-sdhci
controller.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index b8e1d2b..3b602fd 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -54,6 +54,21 @@ Required properties:
 - qcom,dll-config: Chipset and Platform specific value. Use this field to
 	specify the DLL_CONFIG register value as per Hardware Programming Guide.
 
+Optional Properties:
+* Following bus parameters are required for interconnect bandwidth scaling:
+- interconnects: Pairs of phandles and interconnect provider specifier
+		 to denote the edge source and destination ports of
+		 the interconnect path.
+
+- interconnect-names: For sdhc, we have two main paths.
+		1. Data path : sdhc to ddr
+		2. Config path : cpu to sdhc
+		For Data interconnect path the name supposed to be
+		is "sdhc-ddr" and for config interconnect path it is
+		"cpu-sdhc".
+		Please refer to Documentation/devicetree/bindings/
+		interconnect/ for more details.
+
 Example:
 
 	sdhc_1: sdhci@f9824900 {
@@ -71,6 +86,9 @@ Example:
 
 		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
 		clock-names = "core", "iface";
+		interconnects = <&qnoc MASTER_SDCC_ID &qnoc SLAVE_DDR_ID>,
+				<&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
+		interconnect-names = "sdhc-ddr","cpu-sdhc";
 
 		qcom,dll-config = <0x000f642c>;
 		qcom,ddr-config = <0x80040868>;
-- 
1.9.1

