Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0B8C43334
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jun 2022 11:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiFBLpQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jun 2022 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiFBLpP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2022 07:45:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429923E81B;
        Thu,  2 Jun 2022 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654170313; x=1685706313;
  h=from:to:cc:subject:date:message-id;
  bh=jZs+r52Mv7mXvxyvHC1ypo2alqQAFg/mwfpNHeYvRlM=;
  b=bF7F9OHeILnn0kwREym0LM6QTQ1uRM5o3WwZgnkWkYwQ3RN95z20HGod
   m9QQ76LniJt1BqH5K0S5Syqt4FrOOtCqjKQ53R2/UMfGaG/azGwFcX1es
   lsCl5X3l3hX8CxjuZ0lFrACKNcaTnuHk4SdPqUHs3URahBg6Cgar2cMy6
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 04:45:12 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Jun 2022 04:45:11 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 02 Jun 2022 17:14:53 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 1B8351733; Thu,  2 Jun 2022 17:14:52 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhupesh.sharma@linaro.org
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V5] dt-bindings: mmc: sdhci-msm: Add gcc resets strings
Date:   Thu,  2 Jun 2022 17:14:51 +0530
Message-Id: <1654170291-29910-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add gcc hardware reset supported strings for qcom-sdhci controller

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since V4:
	- Updated Dt bindings changes YAML format as suggested by
	  Ulf Hansson.

Changes since V3:
	- Removed reset-names from DT bindings as suggested by
	  Stephen Boyd.
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index e423633..5548c35 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -121,6 +121,9 @@ properties:
     description: A phandle to sdhci power domain node
     maxItems: 1
 
+  resets:
+    description: Phandle and reset specifier for the device's reset.
+
 patternProperties:
   '^opp-table(-[a-z0-9]+)?$':
     if:
@@ -157,6 +160,8 @@ examples:
                    <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
       interrupt-names = "hc_irq", "pwr_irq";
 
+      resets = <&gcc GCC_SDCC2_BCR>;
+
       clocks = <&gcc GCC_SDCC2_AHB_CLK>,
                <&gcc GCC_SDCC2_APPS_CLK>,
                <&rpmhcc RPMH_CXO_CLK>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

