From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: omap: Use DIV_ROUND_UP instead of open coded
Date: Sun, 01 Sep 2013 15:07:14 +0800
Message-ID: <1378019234.6087.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:56347 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3IAHHT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Sep 2013 03:07:19 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so3507304pdj.18
        for <linux-mmc@vger.kernel.org>; Sun, 01 Sep 2013 00:07:19 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

This patch makes the intention of the code more clear.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/omap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b94f38e..3187af0 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -189,7 +189,7 @@ static void mmc_omap_fclk_offdelay(struct mmc_omap_slot *slot)
 	unsigned long tick_ns;
 
 	if (slot != NULL && slot->host->fclk_enabled && slot->fclk_freq > 0) {
-		tick_ns = (1000000000 + slot->fclk_freq - 1) / slot->fclk_freq;
+		tick_ns = DIV_ROUND_UP(1000000000, slot->fclk_freq);
 		ndelay(8 * tick_ns);
 	}
 }
@@ -444,7 +444,7 @@ static void mmc_omap_send_stop_work(struct work_struct *work)
 	struct mmc_data *data = host->stop_data;
 	unsigned long tick_ns;
 
-	tick_ns = (1000000000 + slot->fclk_freq - 1)/slot->fclk_freq;
+	tick_ns = DIV_ROUND_UP(1000000000, slot->fclk_freq);
 	ndelay(8*tick_ns);
 
 	mmc_omap_start_command(host, data->stop);
@@ -486,7 +486,7 @@ mmc_omap_send_abort(struct mmc_omap_host *host, int maxloops)
 	u16 stat = 0;
 
 	/* Sending abort takes 80 clocks. Have some extra and round up */
-	timeout = (120*1000000 + slot->fclk_freq - 1)/slot->fclk_freq;
+	timeout = DIV_ROUND_UP(120 * 1000000, slot->fclk_freq);
 	restarts = 0;
 	while (restarts < maxloops) {
 		OMAP_MMC_WRITE(host, STAT, 0xFFFF);
@@ -686,8 +686,8 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
 
-	nwords = n / 2;
-	nwords += n & 1; /* handle odd number of bytes to transfer */
+	/* Round up to handle odd number of bytes to transfer */
+	nwords = DIV_ROUND_UP(n, 2);
 
 	host->buffer_bytes_left -= n;
 	host->total_bytes_left -= n;
-- 
1.8.1.2



