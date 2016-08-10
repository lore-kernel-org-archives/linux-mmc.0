From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 10/10] arm64: dts: qcom: msm8916: Add ddr support to sdhc1
Date: Wed, 10 Aug 2016 20:31:59 +0530
Message-ID: <1470841319-6091-11-git-send-email-riteshh@codeaurora.org>
References: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53458 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936298AbcHJSlG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2016 14:41:06 -0400
In-Reply-To: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

This adds mmc-ddr-1_8v support to DT for sdhc1 of msm8916.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5161740..514c61e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -390,6 +390,7 @@
 			clock-names = "core", "iface";
 			clk-rates = <400000 25000000 50000000 100000000
 					177770000>;
+			mmc-ddr-1_8v;
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

