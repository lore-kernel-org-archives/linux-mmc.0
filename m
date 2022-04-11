Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC3DC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 09:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbiDKJyH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345020AbiDKJxM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 05:53:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195541992;
        Mon, 11 Apr 2022 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649670653; x=1681206653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4sArmmPqK1fpsAra+ctcw1Mg8/kPFO/JwQ40cELNy00=;
  b=jNY70JwcHlYuriIrgeCYlJM8++mvOKSW1mAOUzMOcGSlWpNG1KMo07ph
   xP+0IJmnZrHWnlGbAPC4SaBJaAsqS2f7Ttex2OMCjy9N+MDZd71iLw/hz
   TGZUPlbZhONPQi+GQYCCybXPAYxK7jc4m2eZKNhZOVDp0U1783nOOjW5t
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 02:50:53 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Apr 2022 02:50:51 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 11 Apr 2022 15:20:25 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id CAC7D3AB8; Mon, 11 Apr 2022 15:20:24 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 4/7] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
Date:   Mon, 11 Apr 2022 15:20:12 +0530
Message-Id: <1649670615-21268-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add devicetree binding for Qualcomm SDX65 SMMU.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index da5381c..1f99bff 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,sc8180x-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
+              - qcom,sdx65-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
-- 
2.7.4

