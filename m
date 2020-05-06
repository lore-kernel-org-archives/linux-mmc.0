Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9B4C47256
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 13:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789DC20746
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 13:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgEFNyF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 09:54:05 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:21794 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728662AbgEFNyF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 09:54:05 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 May 2020 19:24:00 +0530
Received: from minint-dvc2thc.qualcomm.com (HELO sartgarg-linux.qualcomm.com) ([10.206.24.245])
  by ironmsg01-blr.qualcomm.com with ESMTP; 06 May 2020 19:23:56 +0530
Received: by sartgarg-linux.qualcomm.com (Postfix, from userid 2339771)
        id 0E0162654; Wed,  6 May 2020 19:23:56 +0530 (IST)
From:   Sarthak Garg <sartgarg@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH V1 2/2] mmc: sdhci-msm: Use maximum possible data timeout value
Date:   Wed,  6 May 2020 19:14:31 +0530
Message-Id: <1588772671-19675-3-git-send-email-sartgarg@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588772671-19675-1-git-send-email-sartgarg@codeaurora.org>
References: <1588772671-19675-1-git-send-email-sartgarg@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MSM SD controller defines the usage of 0xF in data
timeout counter register (0x2E) which is actually a reserved
bit as per specification. This would result in maximum of 21.26 secs
timeout value.

Some SDcard taking more time than 2.67secs (timeout value corresponding
to 0xE) and with that observed data timeout errors.
So increasing the timeout value to max possible timeout.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8a055dd..909855b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1888,7 +1888,8 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		SDHCI_QUIRK2_USE_RESERVED_MAX_TIMEOUT,
 	.ops = &sdhci_msm_ops,
 };
 
-- 
2.7.4

