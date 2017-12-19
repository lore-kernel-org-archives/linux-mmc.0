From: Xinming Hu <huxm@marvell.com>
Subject: [PATCH v6 2/4] ath6kl: change to use mmc api for accessing host supported maximum segment count and size
Date: Tue, 19 Dec 2017 20:06:48 +0800
Message-ID: <1513685211-640-2-git-send-email-huxm@marvell.com>
References: <1513685211-640-1-git-send-email-huxm@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43402 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1762565AbdLSMHX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 07:07:23 -0500
In-Reply-To: <1513685211-640-1-git-send-email-huxm@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@qca.qualcomm.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Zhiyuan Yang <yangzy@marvell.com>, Tim Song <songtao@marvell.com>, Cathy Luo <cluo@marvell.com>, James Cao <jcao@marvell.com>, Ganapathi Bhat <gbhat@marvell.com>, Xu Wang <xwang4@marvell.com>, Bob Tan <tanbo@marvell.com>, Xinming Hu <huxm@marvell.com>

Using mmc standard api to get the host sg capability.

Signed-off-by: Xinming Hu <huxm@marvell.com>
---
v6: separate driver patch from patch 1/4.
---
 drivers/net/wireless/ath/ath6kl/sdio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/ath/ath6kl/sdio.c
index 2195b1b..3217698 100644
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -734,17 +734,18 @@ static int ath6kl_sdio_enable_scatter(struct ath6kl *ar)
 	struct htc_target *target = ar->htc_target;
 	int ret = 0;
 	bool virt_scat = false;
+	unsigned short max_segs = 0;
 
 	if (ar_sdio->scatter_enabled)
 		return 0;
 
 	ar_sdio->scatter_enabled = true;
 
+	max_segs = sdio_get_host_max_seg_count(ar_sdio->func);
 	/* check if host supports scatter and it meets our requirements */
-	if (ar_sdio->func->card->host->max_segs < MAX_SCATTER_ENTRIES_PER_REQ) {
+	if (max_segs < MAX_SCATTER_ENTRIES_PER_REQ) {
 		ath6kl_err("host only supports scatter of :%d entries, need: %d\n",
-			   ar_sdio->func->card->host->max_segs,
-			   MAX_SCATTER_ENTRIES_PER_REQ);
+			   max_segs, MAX_SCATTER_ENTRIES_PER_REQ);
 		virt_scat = true;
 	}
 
-- 
1.9.1

