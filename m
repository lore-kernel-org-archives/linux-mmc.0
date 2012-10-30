From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH v2] mmc: mxcmmc: fix SD cards not being detected sometimes.
Date: Tue, 30 Oct 2012 16:54:07 +0100
Message-ID: <1351612447-18982-1-git-send-email-javier.martin@vista-silicon.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43337 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab2J3PyU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 11:54:20 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so195034wey.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Oct 2012 08:54:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, cjb@laptop.org, Javier Martin <javier.martin@vista-silicon.com>

When a SD card is initialized some data transfers of 64 and 8 bytes
are issued. It seems the DMA has some problems dealing with these kind
of "short" transfers, leading sometimes to the SD card not being detected.

In order to solve this problem, do not use DMA for transfer sizes lower
than the sector size.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
Changes since v1:
 - Do not remove the check "sg->length & 3".

---
 drivers/mmc/host/mxcmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index fc42a2e..a09637f 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -240,7 +240,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 		return 0;
 
 	for_each_sg(data->sg, sg, data->sg_len, i) {
-		if (sg->offset & 3 || sg->length & 3) {
+		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
 			host->do_dma = 0;
 			return 0;
 		}
-- 
1.7.9.5

