From: Sebastian Rasmussen <sebras@gmail.com>
Subject: [PATCH 1/3] MMC: Fix checkpatch errors
Date: Sat, 18 Jun 2011 19:50:23 +0200
Message-ID: <1308419423-18234-1-git-send-email-sebras@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53543 "EHLO mail.df.lth.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab1FRRu3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 13:50:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sebastian Rasmussen <sebras@gmail.com>

Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
---
 drivers/mmc/card/block.c    |   14 ++++++--------
 drivers/mmc/card/mmc_test.c |   34 +++++++++++++++++-----------------
 drivers/mmc/card/queue.c    |   14 +++++++-------
 drivers/mmc/core/core.c     |    2 +-
 drivers/mmc/core/mmc.c      |    2 +-
 drivers/mmc/core/mmc_ops.c  |    4 ++--
 drivers/mmc/core/sd.c       |    2 +-
 drivers/mmc/core/sd_ops.c   |    4 ++--
 drivers/mmc/core/sdio.c     |    4 ++--
 drivers/mmc/core/sdio_bus.c |    2 +-
 drivers/mmc/core/sdio_cis.c |   18 ++++++++++--------
 drivers/mmc/core/sdio_ops.h |    2 +-
 12 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 71da564..1c7049a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -908,10 +908,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 	return 1;
 
  cmd_err:
- 	/*
- 	 * If this is an SD card and we're writing, we can first
- 	 * mark the known good sectors as ok.
- 	 *
+	/*
+	 * If this is an SD card and we're writing, we can first
+	 * mark the known good sectors as ok.
+	 *
 	 * If the card is not SD, we can still ok written sectors
 	 * as reported by the controller (which might be less than
 	 * the real number of written sectors, but never more).
@@ -1003,8 +1003,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (!subname) {
 		md->name_idx = find_first_zero_bit(name_use, max_devices);
 		__set_bit(md->name_idx, name_use);
-	}
-	else
+	} else
 		md->name_idx = ((struct mmc_blk_data *)
 				dev_to_disk(parent)->private_data)->name_idx;
 
@@ -1220,8 +1219,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	return ret;
 }
 
-static const struct mmc_fixup blk_fixups[] =
-{
+static const struct mmc_fixup blk_fixups[] = {
 	MMC_FIXUP("SEM02G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
 	MMC_FIXUP("SEM04G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
 	MMC_FIXUP("SEM08G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 233cdfa..67c82b9 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -593,11 +593,11 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
 	if (write)
 		memset(test->buffer, 0xDF, 512);
 	else {
-		for (i = 0;i < 512;i++)
+		for (i = 0; i < 512; i++)
 			test->buffer[i] = i;
 	}
 
-	for (i = 0;i < BUFFER_SIZE / 512;i++) {
+	for (i = 0; i < BUFFER_SIZE / 512; i++) {
 		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
@@ -626,7 +626,7 @@ static int mmc_test_cleanup(struct mmc_test_card *test)
 
 	memset(test->buffer, 0, 512);
 
-	for (i = 0;i < BUFFER_SIZE / 512;i++) {
+	for (i = 0; i < BUFFER_SIZE / 512; i++) {
 		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
@@ -787,7 +787,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 	unsigned long flags;
 
 	if (write) {
-		for (i = 0;i < blocks * blksz;i++)
+		for (i = 0; i < blocks * blksz; i++)
 			test->scratch[i] = i;
 	} else {
 		memset(test->scratch, 0, BUFFER_SIZE);
@@ -821,7 +821,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 
 		memset(test->buffer, 0, sectors * 512);
 
-		for (i = 0;i < sectors;i++) {
+		for (i = 0; i < sectors; i++) {
 			ret = mmc_test_buffer_transfer(test,
 				test->buffer + i * 512,
 				dev_addr + i, 512, 0);
@@ -829,12 +829,12 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 				return ret;
 		}
 
-		for (i = 0;i < blocks * blksz;i++) {
+		for (i = 0; i < blocks * blksz; i++) {
 			if (test->buffer[i] != (u8)i)
 				return RESULT_FAIL;
 		}
 
-		for (;i < sectors * 512;i++) {
+		for (; i < sectors * 512; i++) {
 			if (test->buffer[i] != 0xDF)
 				return RESULT_FAIL;
 		}
@@ -842,7 +842,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 		local_irq_save(flags);
 		sg_copy_to_buffer(sg, sg_len, test->scratch, BUFFER_SIZE);
 		local_irq_restore(flags);
-		for (i = 0;i < blocks * blksz;i++) {
+		for (i = 0; i < blocks * blksz; i++) {
 			if (test->scratch[i] != (u8)i)
 				return RESULT_FAIL;
 		}
@@ -987,7 +987,7 @@ static int mmc_test_pow2_write(struct mmc_test_card *test)
 	if (!test->card->csd.write_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 1; i < 512;i <<= 1) {
+	for (i = 1; i < 512; i <<= 1) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 1);
 		if (ret)
@@ -1005,7 +1005,7 @@ static int mmc_test_pow2_read(struct mmc_test_card *test)
 	if (!test->card->csd.read_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 1; i < 512;i <<= 1) {
+	for (i = 1; i < 512; i <<= 1) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 0);
 		if (ret)
@@ -1023,7 +1023,7 @@ static int mmc_test_weird_write(struct mmc_test_card *test)
 	if (!test->card->csd.write_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 3; i < 512;i += 7) {
+	for (i = 3; i < 512; i += 7) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 1);
 		if (ret)
@@ -1041,7 +1041,7 @@ static int mmc_test_weird_read(struct mmc_test_card *test)
 	if (!test->card->csd.read_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 3; i < 512;i += 7) {
+	for (i = 3; i < 512; i += 7) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 0);
 		if (ret)
@@ -1056,7 +1056,7 @@ static int mmc_test_align_write(struct mmc_test_card *test)
 	int ret, i;
 	struct scatterlist sg;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < 4; i++) {
 		sg_init_one(&sg, test->buffer + i, 512);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 1);
 		if (ret)
@@ -1071,7 +1071,7 @@ static int mmc_test_align_read(struct mmc_test_card *test)
 	int ret, i;
 	struct scatterlist sg;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < 4; i++) {
 		sg_init_one(&sg, test->buffer + i, 512);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 0);
 		if (ret)
@@ -1098,7 +1098,7 @@ static int mmc_test_align_multi_write(struct mmc_test_card *test)
 	if (size < 1024)
 		return RESULT_UNSUP_HOST;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < 4; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
 		ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
 		if (ret)
@@ -1125,7 +1125,7 @@ static int mmc_test_align_multi_read(struct mmc_test_card *test)
 	if (size < 1024)
 		return RESULT_UNSUP_HOST;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < 4; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
 		ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
 		if (ret)
@@ -2236,7 +2236,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
 
 	mmc_claim_host(test->card->host);
 
-	for (i = 0;i < ARRAY_SIZE(mmc_test_cases);i++) {
+	for (i = 0; i < ARRAY_SIZE(mmc_test_cases); i++) {
 		struct mmc_test_general_result *gr;
 
 		if (testcase && ((i + 1) != testcase))
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index c07322c..185314c 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -219,11 +219,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
 
 	return 0;
  free_bounce_sg:
- 	if (mq->bounce_sg)
- 		kfree(mq->bounce_sg);
- 	mq->bounce_sg = NULL;
+	if (mq->bounce_sg)
+		kfree(mq->bounce_sg);
+	mq->bounce_sg = NULL;
  cleanup_queue:
- 	if (mq->sg)
+	if (mq->sg)
 		kfree(mq->sg);
 	mq->sg = NULL;
 	if (mq->bounce_buf)
@@ -250,9 +250,9 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
- 	if (mq->bounce_sg)
- 		kfree(mq->bounce_sg);
- 	mq->bounce_sg = NULL;
+	if (mq->bounce_sg)
+		kfree(mq->bounce_sg);
+	mq->bounce_sg = NULL;
 
 	kfree(mq->sg);
 	mq->sg = NULL;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 68091dd..25a9aeb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1217,7 +1217,7 @@ void mmc_init_erase(struct mmc_card *card)
 }
 
 static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
-				          unsigned int arg, unsigned int qty)
+					unsigned int arg, unsigned int qty)
 {
 	unsigned int erase_timeout;
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2a7e43b..20f1ec3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -41,7 +41,7 @@ static const unsigned int tacc_mant[] = {
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-#define UNSTUFF_BITS(resp,start,size)					\
+#define UNSTUFF_BITS(resp, start, size)					\
 	({								\
 		const int __size = size;				\
 		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 845ce7c..c9cfce2 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -302,7 +302,7 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
 	if (ret)
 		return ret;
 
-	for (i = 0;i < 4;i++)
+	for (i = 0; i < 4; i++)
 		csd[i] = be32_to_cpu(csd[i]);
 
 	return 0;
@@ -323,7 +323,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 	if (ret)
 		return ret;
 
-	for (i = 0;i < 4;i++)
+	for (i = 0; i < 4; i++)
 		cid[i] = be32_to_cpu(cid[i]);
 
 	return 0;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ff27741..d4a4fda 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -43,7 +43,7 @@ static const unsigned int tacc_mant[] = {
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-#define UNSTUFF_BITS(resp,start,size)					\
+#define UNSTUFF_BITS(resp, start, size)					\
 	({								\
 		const int __size = size;				\
 		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 021fed1..6b0dc37 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -53,7 +53,7 @@ EXPORT_SYMBOL_GPL(mmc_app_cmd);
 
 /**
  *	mmc_wait_for_app_cmd - start an application command and wait for
- 			       completion
+			       completion
  *	@host: MMC host to start command
  *	@card: Card to send MMC_APP_CMD to
  *	@cmd: MMC command to start
@@ -80,7 +80,7 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 	 * We have to resend MMC_APP_CMD for each attempt so
 	 * we cannot use the retries field in mmc_command.
 	 */
-	for (i = 0;i <= retries;i++) {
+	for (i = 0; i <= retries; i++) {
 		err = mmc_app_cmd(host, card);
 		if (err) {
 			/* no point in retrying; no APP commands allowed */
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4d0c15b..acfa56d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -540,7 +540,7 @@ static void mmc_sdio_remove(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	for (i = 0;i < host->card->sdio_funcs;i++) {
+	for (i = 0; i < host->card->sdio_funcs; i++) {
 		if (host->card->sdio_func[i]) {
 			sdio_remove_func(host->card->sdio_func[i]);
 			host->card->sdio_func[i] = NULL;
@@ -813,7 +813,7 @@ int mmc_attach_sdio(struct mmc_host *host)
 	/*
 	 * ...then the SDIO functions.
 	 */
-	for (i = 0;i < funcs;i++) {
+	for (i = 0; i < funcs; i++) {
 		err = sdio_add_func(host->card->sdio_func[i]);
 		if (err)
 			goto remove_added;
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d29b9c3..e43e9d0 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -104,7 +104,7 @@ sdio_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			"SDIO_CLASS=%02X", func->class))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, 
+	if (add_uevent_var(env,
 			"SDIO_ID=%04X:%04X", func->vendor, func->device))
 		return -ENOMEM;
 
diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 541bdb8..0bab3d4 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -47,11 +47,11 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 
 	size = i;
 
-	buffer = kzalloc(sizeof(char*) * nr_strings + size, GFP_KERNEL);
+	buffer = kzalloc(sizeof(char *) * nr_strings + size, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
-	string = (char*)(buffer + nr_strings);
+	string = (char *)(buffer + nr_strings);
 
 	for (i = 0; i < nr_strings; i++) {
 		buffer[i] = string;
@@ -62,10 +62,10 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 
 	if (func) {
 		func->num_info = nr_strings;
-		func->info = (const char**)buffer;
+		func->info = (const char **)buffer;
 	} else {
 		card->num_info = nr_strings;
-		card->info = (const char**)buffer;
+		card->info = (const char **)buffer;
 	}
 
 	return 0;
@@ -93,10 +93,12 @@ static int cistpl_manfid(struct mmc_card *card, struct sdio_func *func,
 	return 0;
 }
 
-static const unsigned char speed_val[16] =
-	{ 0, 10, 12, 13, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80 };
-static const unsigned int speed_unit[8] =
-	{ 10000, 100000, 1000000, 10000000, 0, 0, 0, 0 };
+static const unsigned char speed_val[16] = {
+	0, 10, 12, 13, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80
+};
+static const unsigned int speed_unit[8] = {
+	10000, 100000, 1000000, 10000000, 0, 0, 0, 0
+};
 
 
 typedef int (tpl_parse_t)(struct mmc_card *, struct sdio_func *,
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index 12a4d3a..27ec1b6 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -14,7 +14,7 @@
 
 int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
-	unsigned addr, u8 in, u8* out);
+	unsigned addr, u8 in, u8 *out);
 int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
 int sdio_reset(struct mmc_host *host);
-- 
1.7.4.1

