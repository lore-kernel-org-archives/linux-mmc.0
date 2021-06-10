Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C0C47094
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Jun 2021 07:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD3D613C9
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Jun 2021 07:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhFJHOp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:14:45 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33170 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFJHOo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2021 03:14:44 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 10 Jun 2021 00:12:48 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Jun 2021 00:12:46 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 10 Jun 2021 12:41:53 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 54D914DC2; Thu, 10 Jun 2021 12:41:52 +0530 (IST)
From:   Shaik Sajida Bhanu <sbhanu@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, rampraka@codeaurora.org,
        sayalil@codeaurora.org, sartgarg@codeaurora.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        sibis@codeaurora.org, okukatla@codeaurora.org, djakov@kernel.org,
        cang@codeaurora.org, pragalla@codeaurora.org,
        nitirawa@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Subject: [PATCH V1] arm64: dts: qcom: sc7180: Added xo clock for eMMC and Sd card
Date:   Thu, 10 Jun 2021 12:41:47 +0530
Message-Id: <1623309107-27833-1-git-send-email-sbhanu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Added xo clock for eMMC and Sd card.

Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 295844e..5bb6bd4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -701,8 +701,9 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-					<&gcc GCC_SDCC1_AHB_CLK>;
-			clock-names = "core", "iface";
+					<&gcc GCC_SDCC1_AHB_CLK>,
+					<&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "core", "iface","xo";
 			interconnects = <&aggre1_noc MASTER_EMMC 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_EMMC_CFG 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
@@ -2666,8 +2667,9 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-					<&gcc GCC_SDCC2_AHB_CLK>;
-			clock-names = "core", "iface";
+					<&gcc GCC_SDCC2_AHB_CLK>,
+					<&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "core", "iface", "xo";
 
 			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

