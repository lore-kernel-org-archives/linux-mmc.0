Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B8C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 11:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350336AbiDLLu6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355007AbiDLLtJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 07:49:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3D2193;
        Tue, 12 Apr 2022 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649759555; x=1681295555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2HueON56JbqPuKljYuCapeExQ/BmLqOCss/TXcZPavo=;
  b=i6EPpNJ9ZX4Kac3UfuAXf8p7aLyg7zOwo43UYpfYYDkXSu8i6Nh3Hj/W
   89gdVrmavhM9BrdaghdIWJ7yEy7PY4UxVz7vf4H4my78QiVrhkj2a5bLu
   N+4oZRQb3J7W8iUc8UWgaEKgFvmwAm3qkKkk6xZyLg5MiWY1OqCGJpDre
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 12 Apr 2022 03:32:34 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Apr 2022 03:32:32 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Apr 2022 16:02:14 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id E48665963; Tue, 12 Apr 2022 16:02:13 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V4 2/2] arm64: dts: qcom: sc7280: Add reset entries for SDCC controllers
Date:   Tue, 12 Apr 2022 16:02:08 +0530
Message-Id: <1649759528-15125-3-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add gcc hardware reset entries for eMMC and SD card.

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index f0b64be..e2393d1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -881,6 +881,8 @@
 			mmc-hs400-1_8v;
 			mmc-hs400-enhanced-strobe;
 
+			resets = <&gcc GCC_SDCC1_BCR>;
+
 			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
@@ -2686,6 +2688,8 @@
 
 			qcom,dll-config = <0x0007642c>;
 
+			resets = <&gcc GCC_SDCC2_BCR>;
+
 			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

