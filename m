From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v5 06/12] mmc: sdhci-msm: Enable few quirks
Date: Wed,  5 Oct 2016 20:10:34 +0530
Message-ID: <1475678440-3525-7-git-send-email-riteshh@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49941 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbcJEOl6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2016 10:41:58 -0400
In-Reply-To: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com
Cc: david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>

sdhc-msm controller needs this SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
& SDHCI_QUIRK2_PRESET_VALUE_BROKEN to be set. Hence setting it.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4e17201..542ddad 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -609,7 +609,9 @@ static const struct sdhci_ops sdhci_msm_ops = {
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_NO_CARD_NO_RESET |
-		  SDHCI_QUIRK_SINGLE_POWER_WRITE,
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_msm_ops,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

