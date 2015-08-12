From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] mmc: sirf: corrent quirk according to real chips
Date: Wed, 12 Aug 2015 06:59:33 +0000
Message-ID: <1439362773-32515-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34528 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbbHLGwx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2015 02:52:53 -0400
Received: by pdbfa8 with SMTP id fa8so4115736pdb.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2015 23:52:53 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

the current quirk set is for an old FPGA, and this patch corrects
quirks according to real SoC.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 0110bae..8842945 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -161,8 +161,8 @@ static struct sdhci_pltfm_data sdhci_sirf_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-		SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
-		SDHCI_QUIRK_DELAY_AFTER_POWER,
+		SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
 static int sdhci_sirf_probe(struct platform_device *pdev)
-- 
1.9.1

