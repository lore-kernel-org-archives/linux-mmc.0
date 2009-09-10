From: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
Subject: [PATCH] sdio: recognize io card without powercycle
Date: Thu, 10 Sep 2009 14:56:41 +0200
Message-ID: <1252587402-7382-1-git-send-email-albert_herranz@yahoo.es>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bcm43xx-dev-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SDIO Simplified Specification V2.00 states that it is strongly recommended
that the host executes either a power reset or issues a CMD52 (I/O Reset) to
re-initialize an I/O only card or the I/O portion of a combo card.
Additionally, the CMD52 must be issued first because it cannot be issued
after a CMD0.

With this patch the Nintendo Wii SDIO-based WLAN card is detected after a
system reset, without requiring a complete system powercycle.

Signed-off-by: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
---
v1
- reworded commit message
- CC'd akpm as suggested by mb

 drivers/mmc/core/core.c     |    1 +
 drivers/mmc/core/sdio_ops.c |   36 ++++++++++++++++++++++++++++++------
 drivers/mmc/core/sdio_ops.h |    1 +
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d84c880..c768f70 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -890,6 +890,7 @@ void mmc_rescan(struct work_struct *work)
 	mmc_claim_host(host);
 
 	mmc_power_up(host);
+	sdio_go_idle(host);
 	mmc_go_idle(host);
 
 	mmc_send_if_cond(host, host->ocr_avail);
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index 4eb7825..14d3204 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -67,13 +67,13 @@ int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	return err;
 }
 
-int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
-	unsigned addr, u8 in, u8* out)
+static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
+	unsigned addr, u8 in, u8 *out)
 {
 	struct mmc_command cmd;
 	int err;
 
-	BUG_ON(!card);
+	BUG_ON(!host);
 	BUG_ON(fn > 7);
 
 	/* sanity check */
@@ -90,11 +90,11 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 	cmd.arg |= in;
 	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
 
-	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
 		return err;
 
-	if (mmc_host_is_spi(card->host)) {
+	if (mmc_host_is_spi(host)) {
 		/* host driver already reported errors */
 	} else {
 		if (cmd.resp[0] & R5_ERROR)
@@ -106,7 +106,7 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 	}
 
 	if (out) {
-		if (mmc_host_is_spi(card->host))
+		if (mmc_host_is_spi(host))
 			*out = (cmd.resp[0] >> 8) & 0xFF;
 		else
 			*out = cmd.resp[0] & 0xFF;
@@ -115,6 +115,13 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 	return 0;
 }
 
+int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
+	unsigned addr, u8 in, u8 *out)
+{
+	BUG_ON(!card);
+	return mmc_io_rw_direct_host(card->host, write, fn, addr, in, out);
+}
+
 int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz)
 {
@@ -182,3 +189,20 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	return 0;
 }
 
+int sdio_go_idle(struct mmc_host *host)
+{
+	int ret;
+	u8 abort;
+
+	/* SDIO Simplified Specification V2.0, 4.4 Reset for SDIO */
+
+	ret = mmc_io_rw_direct_host(host, 0, 0, SDIO_CCCR_ABORT, 0, &abort);
+	if (ret)
+		abort = 0x08;
+	else
+		abort |= 0x08;
+
+	ret = mmc_io_rw_direct_host(host, 1, 0, SDIO_CCCR_ABORT, abort, NULL);
+	return ret;
+}
+
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index e2e74b0..9b546c7 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -17,6 +17,7 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, u8 in, u8* out);
 int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
+int sdio_go_idle(struct mmc_host *host);
 
 #endif
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
