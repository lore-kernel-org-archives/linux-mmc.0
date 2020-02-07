Return-Path: <SRS0=5kc2=33=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBF5C352A4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 12:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8451D22B48
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 12:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gINpfR/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgBGMFW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:05:22 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:11118 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgBGMFW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Feb 2020 07:05:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581077121; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hWmlFBsM4U/DDRAOyION49Dndp398XL993b80Izz4ng=; b=gINpfR/5WdJLTUQtk/+7MOygoJ3XokC3g/1Z5xn8rxOT+LnzIfLq6KHrzW130jrtoCZbuTbZ
 LdhAr8FxDlDQCw7PWnrWQj/XOtDl2Xh5JutcxbJRRVz3I2UiA/JUx1JR33cYsgtBHx9EBVRm
 kN6XrzuGaFYrZqLIzlE7zCzWexQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3d527b.7f59189786f8-smtp-out-n02;
 Fri, 07 Feb 2020 12:05:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7E583C447AE; Fri,  7 Feb 2020 12:05:15 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FDC7C433CB;
        Fri,  7 Feb 2020 12:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FDC7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH V2] mmc: sdhci-msm: Don't enable PWRSAVE_DLL for certain sdhc hosts
Date:   Fri,  7 Feb 2020 17:34:28 +0530
Message-Id: <1581077075-26011-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581062518-11655-1-git-send-email-vbadigan@codeaurora.org>
References: <1581062518-11655-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ritesh Harjani <riteshh@codeaurora.org>

SDHC core with new 14lpp and later tech DLL should not enable
PWRSAVE_DLL since such controller's internal gating cannot meet
following MCLK requirement:
When MCLK is gated OFF, it is not gated for less than 0.5us and MCLK
must be switched on for at-least 1us before DATA starts coming.

Adding support for this requirement.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
--

Changes since V1:
  Condition was not correct in V1, which is corrected in V2

--
---
 drivers/mmc/host/sdhci-msm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c3a160c..aa5b610 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -977,9 +977,21 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
 		goto out;
 	}
 
-	config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec3);
-	config |= CORE_PWRSAVE_DLL;
-	writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec3);
+	/*
+	 * Set CORE_PWRSAVE_DLL bit in CORE_VENDOR_SPEC3.
+	 * When MCLK is gated OFF, it is not gated for less than 0.5us
+	 * and MCLK must be switched on for at-least 1us before DATA
+	 * starts coming. Controllers with 14lpp and later tech DLL cannot
+	 * guarantee above requirement. So PWRSAVE_DLL should not be
+	 * turned on for host controllers using this DLL.
+	 */
+	if (!msm_host->use_14lpp_dll_reset) {
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_vendor_spec3);
+		config |= CORE_PWRSAVE_DLL;
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_vendor_spec3);
+	}
 
 	/*
 	 * Drain writebuffer to ensure above DLL calibration
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
