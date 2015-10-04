From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3 2/3] mmc: sdhci: enable tuning for DDR50
Date: Sun,  4 Oct 2015 12:04:12 +0000
Message-ID: <1443960253-4082-2-git-send-email-21cnbao@gmail.com>
References: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33260 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbJDLzt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Oct 2015 07:55:49 -0400
Received: by pacex6 with SMTP id ex6so148928104pac.0
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2015 04:55:49 -0700 (PDT)
In-Reply-To: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: workgroup.linux@csr.com, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Weijun Yang <york.yang@csr.com>

CMD19 tuning is also available for DDR50 mode.

Signed-off-by: Weijun Yang <york.yang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64b7fdb..2ea30fa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1893,9 +1893,9 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		tuning_count = host->tuning_count;
 
 	/*
-	 * The Host Controller needs tuning only in case of SDR104 mode
-	 * and for SDR50 mode when Use Tuning for SDR50 is set in the
-	 * Capabilities register.
+	 * The Host Controller needs tuning in case of SDR104 and DDR5
+	 * mode, and for SDR50 mode when Use Tuning for SDR50 is set in
+	 * the Capabilities register.
 	 * If the Host Controller supports the HS200 mode then the
 	 * tuning function has to be executed.
 	 */
@@ -1915,6 +1915,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		break;
 
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_DDR50:
 		break;
 
 	case MMC_TIMING_UHS_SDR50:
-- 
1.9.1

