From: Xinming Hu <huxm@marvell.com>
Subject: [PATCH v6 3/4] brcmfmac: change to use mmc api for accessing host supported maximum segment count and size
Date: Tue, 19 Dec 2017 20:06:49 +0800
Message-ID: <1513685211-640-3-git-send-email-huxm@marvell.com>
References: <1513685211-640-1-git-send-email-huxm@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43410 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1762571AbdLSMHc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 07:07:32 -0500
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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index cd58732..d0e08d0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -886,19 +886,21 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev *sdiodev)
 {
 	struct sdio_func *func;
 	struct mmc_host *host;
+	unsigned short max_segs = 0;
 	uint max_blocks;
 	uint nents;
 	int err;
 
 	func = sdiodev->func[2];
 	host = func->card->host;
-	sdiodev->sg_support = host->max_segs > 1;
+
+	max_segs = sdio_get_host_max_seg_count(func);
+	sdiodev->sg_support = max_segs > 1;
 	max_blocks = min_t(uint, host->max_blk_count, 511u);
 	sdiodev->max_request_size = min_t(uint, host->max_req_size,
 					  max_blocks * func->cur_blksize);
-	sdiodev->max_segment_count = min_t(uint, host->max_segs,
-					   SG_MAX_SINGLE_ALLOC);
-	sdiodev->max_segment_size = host->max_seg_size;
+	sdiodev->max_segment_count = min_t(uint, SG_MAX_SINGLE_ALLOC, max_segs);
+	sdiodev->max_segment_size = sdio_get_host_max_seg_size(func);
 
 	if (!sdiodev->sg_support)
 		return;
-- 
1.9.1

