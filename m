From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] mmc: sirf: update sdhci_sirf_execute_tuning procedure
Date: Sun, 15 Feb 2015 23:43:51 +0800
Message-ID: <1424015031-24676-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48412 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbBOPoI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Feb 2015 10:44:08 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so21365050wid.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Feb 2015 07:44:07 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, weijun yang <york.yang@csr.com>, Barry Song <baohua.song@csr.com>

From: weijun yang <york.yang@csr.com>

For the original tuning code, delay value is set to SD Bus Clock Delay
Register (SD_CLK_DELAY_SETTING) as (val | (Val << 7) | (val << 16)),
which means CLK_DELAY_IN1, CLK_DELAY_IN2 and CLK_DELAY_OUT are the
same and with 128 steps. This is doubtful. In CSR design specification
documents CS-304575-DR-3H, this issue is clarified, the delay[13:0] in
SD_CLK_DELAY_SETTING is simplied to the concatenation of {CLK_DELAY_IN2,
CLK_DELAY_IN1}.
Besides, for CMD19 tuning, no need to set CLK_DELAY_OUT([22,16]
of SD_CLK_DELAY_SETTING).

Signed-off-by: weijun yang <york.yang@csr.com>
Signed-off-by: Barry Song <baohua.song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index f6f82ec..4331409 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -56,7 +56,7 @@ static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
 	int tuning_seq_cnt = 3;
 	u8 phase, tuned_phases[SIRF_TUNING_COUNT];
 	u8 tuned_phase_cnt = 0;
-	int rc, longest_range = 0;
+	int rc = 0, longest_range = 0;
 	int start = -1, end = 0, tuning_value = -1, range = 0;
 	u16 clock_setting;
 	struct mmc_host *mmc = host->mmc;
@@ -68,7 +68,7 @@ retry:
 	phase = 0;
 	do {
 		sdhci_writel(host,
-			clock_setting | phase | (phase << 7) | (phase << 16),
+			clock_setting | phase,
 			SDHCI_CLK_DELAY_SETTING);
 
 		if (!mmc_send_tuning(mmc)) {
@@ -102,7 +102,7 @@ retry:
 		 */
 		phase = tuning_value;
 		sdhci_writel(host,
-			clock_setting | phase | (phase << 7) | (phase << 16),
+			clock_setting | phase,
 			SDHCI_CLK_DELAY_SETTING);
 
 		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
-- 
1.9.1

