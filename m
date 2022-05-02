Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86802C4167D
	for <linux-mmc@archiver.kernel.org>; Mon,  2 May 2022 08:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383819AbiEBIlo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 May 2022 04:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383811AbiEBIlm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2022 04:41:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284D186C6;
        Mon,  2 May 2022 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651480695; x=1683016695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bVbPOiK0y82rmhyKlFrtAgGmGuURv7LBQSfEtrPIoNU=;
  b=b8EDs9Z6dzQu+RoE0IR9ASNKsToHdNLkw9VzqHRsE7UC0S7kLijl2Pm9
   OruROcNJYms4qkdvKbfg3a83Z5D/48HaoSxQ+9Pbv3HA6zOWK9CsW1EYh
   +SPcutuNq6KSojwnjVZ/6uY0c5cafiyxzVFXEU34i77tgbnWHMf5EvuPC
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 02 May 2022 01:38:15 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 May 2022 01:38:13 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:07:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 0B32B3BED; Mon,  2 May 2022 14:07:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, adrian.hunter@intel.com,
        bhupesh.sharma@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 4/4] ARM: dts: qcom: sdx65: Add Shared memory manager support
Date:   Mon,  2 May 2022 14:07:45 +0530
Message-Id: <1651480665-14978-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add smem node to support shared memory manager on SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 210e55c..57bda62 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -87,8 +87,10 @@
 		};
 
 		smem_mem: memory@8fe20000 {
-			no-map;
+			compatible = "qcom,smem";
 			reg = <0x8fe20000 0xc0000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
 		};
 
 		cmd_db: reserved-memory@8fee0000 {
-- 
2.7.4

