From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 4/5] mmc: msm_sdcc: Fix bug in PIO mode when data size is not word aligned
Date: Wed,  8 Dec 2010 15:03:06 +0530
Message-ID: <1291800787-24757-4-git-send-email-stummala@codeaurora.org>
References: <1291800787-24757-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:2055 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab0LHJeE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 04:34:04 -0500
In-Reply-To: <1291800787-24757-1-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, dwalker@codeaurora.org, linux-mmc@vger.kernel.org
Cc: san@google.com, linux-arm-msm@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>

The current code for PIO doesn't transfer whole data when data size
is not in multiple of 4 bytes. The last few bytes are not written to
the card resulting in no DATAEND interrupt from SDCC. This patch
allows data transfer for non-aligned data size in PIO mode.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 81ed16f..9badc51 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -613,6 +613,9 @@ msmsdcc_pio_read(struct msmsdcc_host *host, char *buffer, unsigned int remain)
 	uint32_t	*ptr = (uint32_t *) buffer;
 	int		count = 0;
 
+	if (remain % 4)
+		remain = ((remain >> 2) + 1) << 2;
+
 	while (msmsdcc_readl(host, MMCISTATUS) & MCI_RXDATAAVLBL) {
 		*ptr = msmsdcc_readl(host, MMCIFIFO + (count % MCI_FIFOSIZE));
 		ptr++;
@@ -633,13 +636,14 @@ msmsdcc_pio_write(struct msmsdcc_host *host, char *buffer,
 	char *ptr = buffer;
 
 	do {
-		unsigned int count, maxcnt;
+		unsigned int count, maxcnt, sz;
 
 		maxcnt = status & MCI_TXFIFOEMPTY ? MCI_FIFOSIZE :
 						    MCI_FIFOHALFSIZE;
 		count = min(remain, maxcnt);
 
-		writesl(base + MMCIFIFO, ptr, count >> 2);
+		sz = count % 4 ? (count >> 2) + 1 : (count >> 2);
+		writesl(base + MMCIFIFO, ptr, sz);
 		ptr += count;
 		remain -= count;
 
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
