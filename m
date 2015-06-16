From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] mmc: omap: use for_each_sg() for scatterlist parsing
Date: Tue, 16 Jun 2015 21:15:15 +0200
Message-ID: <1434482116-29583-1-git-send-email-fabf@skynet.be>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailrelay119.isp.belgacom.be ([195.238.20.146]:35324 "EHLO
	mailrelay119.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754684AbbFPTPY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2015 15:15:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

See Documentation/DMA-API.txt - Part Id

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
This is untested.

 drivers/mmc/host/omap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 68dd6c7..70dcf07 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -948,6 +948,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 {
 	struct mmc_data *data = req->data;
 	int i, use_dma = 1, block_size;
+	struct scatterlist *sg;
 	unsigned sg_len;
 
 	host->data = data;
@@ -972,8 +973,8 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 	sg_len = (data->blocks == 1) ? 1 : data->sg_len;
 
 	/* Only do DMA for entire blocks */
-	for (i = 0; i < sg_len; i++) {
-		if ((data->sg[i].length % block_size) != 0) {
+	for_each_sg(data->sg, sg, sg_len, i) {
+		if ((sg->length % block_size) != 0) {
 			use_dma = 0;
 			break;
 		}
-- 
2.4.2

