Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6AC2BAEE
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 17:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8E2072F
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 17:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xH1ikMiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgCKRO6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:14:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:19541 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730341AbgCKRO6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 13:14:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583946897; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hwl+XmvG5JG30mi1BrH5GWZRUzawJld2P9BWiACejEE=; b=xH1ikMiANN4CmROM0qV5icpd89G/1lOprKDw/vrCAzEA1If4oaVzLFYrD7E12DgRQrg8YJ56
 7kH7r/82VN0zhswJr06+ErCk2b1eJ2ZTxBtx980XhxF6h/x/mG32KnAbK66dJybvBBgRG+lJ
 p2maLXbG71QEw93Qj9iDtol05xg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e691c8c.7f03b675b228-smtp-out-n01;
 Wed, 11 Mar 2020 17:14:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7923C43636; Wed, 11 Mar 2020 17:14:51 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FB72C433BA;
        Wed, 11 Mar 2020 17:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FB72C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     bjorn.andersson@linaro.org, vkoul@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH] arm64: dts: qcom: sc7180: Update reg names for SDHC
Date:   Wed, 11 Mar 2020 22:44:22 +0530
Message-Id: <1583946863-24308-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583946863-24308-1-git-send-email-vbadigan@codeaurora.org>
References: <1583946863-24308-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Remove the redundant _mem suffix for SDHC reg names.

For SDcard instance, no need supply reg names since hc reg map
is accessed with index. So remove reg names for SDcard.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 253274d..efca50a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -394,7 +394,7 @@
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x7c4000 0 0x1000>,
 				<0 0x07c5000 0 0x1000>;
-			reg-names = "hc_mem", "cqhci_mem";
+			reg-names = "hc", "cqhci";
 
 			iommus = <&apps_smmu 0x60 0x0>;
 			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
@@ -1234,7 +1234,6 @@
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-			reg-names = "hc_mem";
 
 			iommus = <&apps_smmu 0x80 0>;
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
