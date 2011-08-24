From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCHv2 2/2] mmc: fix integer assignments to pointer
Date: Thu, 25 Aug 2011 00:30:50 +0530
Message-ID: <1314212450-18500-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59189 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab1HXTBV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Aug 2011 15:01:21 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7OJ1Kc3011755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2011 14:01:20 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7OJ1KTd022941
	for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2011 14:01:20 -0500 (CDT)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7OJ1KHh004404
	for <linux-mmc@vger.kernel.org>; Wed, 24 Aug 2011 14:01:20 -0500 (CDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>

Fix the sparse warning output
"warning: Using plain integer as NULL pointer"

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
Update since v1:
	Rebased on top of today's mmc-next and fixed
more instances of the same warning

 drivers/mmc/card/block.c    |    4 ++--
 drivers/mmc/core/core.c     |    2 +-
 drivers/mmc/core/mmc_ops.c  |    4 ++--
 drivers/mmc/core/sd_ops.c   |    8 ++++----
 drivers/mmc/core/sdio_ops.c |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

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
index eb3069d..557856b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -371,7 +371,7 @@ EXPORT_SYMBOL(mmc_wait_for_req);
  */
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries)
 {
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 
 	WARN_ON(!host->claimed);
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 770c3d0..7aa13d0 100644
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
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 021fed1..46a7854 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -67,7 +67,7 @@ EXPORT_SYMBOL_GPL(mmc_app_cmd);
 int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 	struct mmc_command *cmd, int retries)
 {
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 
 	int i, err;
 
@@ -244,7 +244,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
 int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 {
 	int err;
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -303,7 +303,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp)
 {
-	struct mmc_request mrq = {0};
+	struct mmc_request mrq = {NULL};
 	struct mmc_command cmd = {0};
 	struct mmc_data data = {0};
 	struct scatterlist sg;
@@ -348,7 +348,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 {
 	int err;
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

