Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC78C433F4
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB0620792
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGUKom (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:44:42 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2552 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgGUKof (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2020 06:44:35 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Jul 2020 03:44:35 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jul 2020 03:44:33 -0700
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jul 2020 16:14:31 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id DD1533FFA; Tue, 21 Jul 2020 16:14:30 +0530 (IST)
From:   Shaik Sajida Bhanu <sbhanu@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Subject: [PATCH V2] arm64: dts: qcom: sc7180: Include xo clock to sdhc clocks list
Date:   Tue, 21 Jul 2020 16:14:28 +0530
Message-Id: <1595328268-29398-1-git-send-email-sbhanu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Include xo clock to sdhc clocks list which will be used
in calculating MCLK_FREQ field of DLL_CONFIG2 register.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index d78a066..7ccb780 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -682,8 +682,9 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-					<&gcc GCC_SDCC1_AHB_CLK>;
-			clock-names = "core", "iface";
+					<&gcc GCC_SDCC1_AHB_CLK>,
+					<&xo_board>;
+			clock-names = "core", "iface", "xo";
 			interconnects = <&aggre1_noc MASTER_EMMC &mc_virt SLAVE_EBI1>,
 				<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_EMMC_CFG>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
@@ -2481,8 +2482,9 @@
 			interrupt-names = "hc_irq", "pwr_irq";
 
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-					<&gcc GCC_SDCC2_AHB_CLK>;
-			clock-names = "core", "iface";
+					<&gcc GCC_SDCC2_AHB_CLK>,
+					<&xo_board>;
+			clock-names = "core", "iface", "xo";
 
 			interconnects = <&aggre1_noc MASTER_SDCC_2 &mc_virt SLAVE_EBI1>,
 				<&gem_noc MASTER_APPSS_PROC &config_noc	SLAVE_SDCC_2>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

