Return-Path: <SRS0=Uv8K=7S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD16C433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 09:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D04207D5
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 09:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgFEJbG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:31:06 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:26194 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgFEJbG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2020 05:31:06 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Jun 2020 15:01:01 +0530
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Jun 2020 15:00:34 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id D7F7E48CC; Fri,  5 Jun 2020 15:00:33 +0530 (IST)
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
Subject: =?y?q?=5BPATCH=C2=A0V3=202/2=5D=20dt-bindings=3A=20mmc=3A=20sdhci-msm=3A=20Add=20interconnect=20BW=20scaling=20strings?=
Date:   Fri,  5 Jun 2020 15:00:27 +0530
Message-Id: <1591349427-27004-3-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1591349427-27004-1-git-send-email-ppvk@codeaurora.org>
References: <1591269283-24084-1-git-send-email-ppvk@codeaurora.org>
 <1591349427-27004-1-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
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

