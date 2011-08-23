From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 21:16:03 +0530
Message-ID: <1314114363-6767-3-git-send-email-svenkatr@ti.com>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37220 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab1HWPqi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Aug 2011 11:46:38 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7NFkcY9020105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 10:46:38 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7NFkcip001713
	for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 10:46:38 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7NFkcQL028706
	for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2011 10:46:38 -0500 (CDT)
In-Reply-To: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>

Fix the sparse warning output
"warning: Using plain integer as NULL pointer"

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/card/block.c    |    4 ++--
 drivers/mmc/core/core.c     |    2 +-
 drivers/mmc/core/mmc_ops.c  |    4 ++--
 drivers/mmc/core/sdio_ops.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1ff5486..e702c61 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -291,7 +291,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	struct mmc_card *card;
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 	struct scatterlist sg;
 	int err;
 
@@ -466,7 +466,7 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
 	u32 result;
 	__be32 *blocks;
 
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	unsigned int timeout_us;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 89bdeae..11fcf20 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -330,7 +330,7 @@ EXPORT_SYMBOL(mmc_wait_for_req);
  */
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries)
 {
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 
 	WARN_ON(!host->claimed);
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 845ce7c..8f1d372 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -233,7 +233,7 @@ static int
 mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 		u32 opcode, void *buf, unsigned len)
 {
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -454,7 +454,7 @@ static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
 {
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index f087d87..4addbe9 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -121,7 +121,7 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
 int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz)
 {
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
-- 
1.7.1

