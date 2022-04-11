Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4709C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 06:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiDKG60 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 02:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiDKG6Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 02:58:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC102A709;
        Sun, 10 Apr 2022 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649660173; x=1681196173;
  h=from:to:cc:subject:date:message-id;
  bh=aRKhlH11BYG4D30HiNuvL9KWitrjNW8cRlhyWm2s6Sg=;
  b=r5Vkc6Hn25zxcY1woyXjZM/DjGcESDU0ZnX7iyxGW94PAjVskshWO0sq
   zHiTt917zSovvQhuzXqaZkQiyYeAfITAnMfurpgoPtXM9Y7Dewz6FKnV6
   PkL5tlwITtycskVj9t1tim7C/RP2ksqeqrwse9q1OgPqOXEtXaQJqIl3l
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 23:56:13 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Apr 2022 23:56:11 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 Apr 2022 12:25:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id A84B437D9; Mon, 11 Apr 2022 12:25:50 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/7] SDX65 devicetree updates
Date:   Mon, 11 Apr 2022 12:25:36 +0530
Message-Id: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This series adds devicetree nodes for SDX65. It adds
reserved memory nodes, SDHCI, smmu and tcsr mutex support.

Thanks,
Rohit.

Rohit Agarwal (7):
  ARM: dts: qcom: sdx65: Add reserved memory nodes
  dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
  ARM: dts: qcom: sdx65: Add support for SDHCI controller
  dt-bindings: arm-smmu: Add binding for SDX65 SMMU
  ARM: dts: qcom: sdx65: Enable ARM SMMU
  ARM: dts: qcom: sdx65: Add support for TCSR Mutex
  ARM: dts: qcom: sdx65: Add Shared memory manager support

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               |  21 ++++
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 110 +++++++++++++++++++++
 4 files changed, 133 insertions(+)

-- 
2.7.4

