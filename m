From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/9] mmc: core: Move mmc_interrupt_hpi() from core.c to mmc_ops.c
Date: Thu,  8 Jun 2017 15:27:39 +0200
Message-ID: <1496928465-25004-4-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35425 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbdFHN14 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:27:56 -0400
Received: by mail-lf0-f49.google.com with SMTP id p189so18037933lfe.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:27:55 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The mmc_interrupt_hpi() is a eMMC specific function, let's move it to
mmc_ops.c to make that clear. The move also enables us to make
mmc_send_hpi_cmd() static, so let's do that change as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    | 64 --------------------------------------------
 drivers/mmc/core/mmc_ops.c | 66 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/mmc_ops.h |  1 -
 3 files changed, 65 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d7c934c..de31f30 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -675,70 +675,6 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 EXPORT_SYMBOL(mmc_wait_for_req);
 
 /**
- *	mmc_interrupt_hpi - Issue for High priority Interrupt
- *	@card: the MMC card associated with the HPI transfer
- *
- *	Issued High Priority Interrupt, and check for card status
- *	until out-of prg-state.
- */
-int mmc_interrupt_hpi(struct mmc_card *card)
-{
-	int err;
-	u32 status;
-	unsigned long prg_wait;
-
-	if (!card->ext_csd.hpi_en) {
-		pr_info("%s: HPI enable bit unset\n", mmc_hostname(card->host));
-		return 1;
-	}
-
-	mmc_claim_host(card->host);
-	err = mmc_send_status(card, &status);
-	if (err) {
-		pr_err("%s: Get card status fail\n", mmc_hostname(card->host));
-		goto out;
-	}
-
-	switch (R1_CURRENT_STATE(status)) {
-	case R1_STATE_IDLE:
-	case R1_STATE_READY:
-	case R1_STATE_STBY:
-	case R1_STATE_TRAN:
-		/*
-		 * In idle and transfer states, HPI is not needed and the caller
-		 * can issue the next intended command immediately
-		 */
-		goto out;
-	case R1_STATE_PRG:
-		break;
-	default:
-		/* In all other states, it's illegal to issue HPI */
-		pr_debug("%s: HPI cannot be sent. Card state=%d\n",
-			mmc_hostname(card->host), R1_CURRENT_STATE(status));
-		err = -EINVAL;
-		goto out;
-	}
-
-	err = mmc_send_hpi_cmd(card, &status);
-	if (err)
-		goto out;
-
-	prg_wait = jiffies + msecs_to_jiffies(card->ext_csd.out_of_int_time);
-	do {
-		err = mmc_send_status(card, &status);
-
-		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
-			break;
-		if (time_after(jiffies, prg_wait))
-			err = -ETIMEDOUT;
-	} while (!err);
-
-out:
-	mmc_release_host(card->host);
-	return err;
-}
-
-/**
  *	mmc_wait_for_cmd - start a command and wait for completion
  *	@host: MMC host to start command
  *	@cmd: MMC command to start
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0648fae..53e4da48 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -807,7 +807,7 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
 	return mmc_send_bus_test(card, card->host, MMC_BUS_TEST_R, width);
 }
 
-int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
+static int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 {
 	struct mmc_command cmd = {};
 	unsigned int opcode;
@@ -841,6 +841,70 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 	return 0;
 }
 
+/**
+ *	mmc_interrupt_hpi - Issue for High priority Interrupt
+ *	@card: the MMC card associated with the HPI transfer
+ *
+ *	Issued High Priority Interrupt, and check for card status
+ *	until out-of prg-state.
+ */
+int mmc_interrupt_hpi(struct mmc_card *card)
+{
+	int err;
+	u32 status;
+	unsigned long prg_wait;
+
+	if (!card->ext_csd.hpi_en) {
+		pr_info("%s: HPI enable bit unset\n", mmc_hostname(card->host));
+		return 1;
+	}
+
+	mmc_claim_host(card->host);
+	err = mmc_send_status(card, &status);
+	if (err) {
+		pr_err("%s: Get card status fail\n", mmc_hostname(card->host));
+		goto out;
+	}
+
+	switch (R1_CURRENT_STATE(status)) {
+	case R1_STATE_IDLE:
+	case R1_STATE_READY:
+	case R1_STATE_STBY:
+	case R1_STATE_TRAN:
+		/*
+		 * In idle and transfer states, HPI is not needed and the caller
+		 * can issue the next intended command immediately
+		 */
+		goto out;
+	case R1_STATE_PRG:
+		break;
+	default:
+		/* In all other states, it's illegal to issue HPI */
+		pr_debug("%s: HPI cannot be sent. Card state=%d\n",
+			mmc_hostname(card->host), R1_CURRENT_STATE(status));
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = mmc_send_hpi_cmd(card, &status);
+	if (err)
+		goto out;
+
+	prg_wait = jiffies + msecs_to_jiffies(card->ext_csd.out_of_int_time);
+	do {
+		err = mmc_send_status(card, &status);
+
+		if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
+			break;
+		if (time_after(jiffies, prg_wait))
+			err = -ETIMEDOUT;
+	} while (!err);
+
+out:
+	mmc_release_host(card->host);
+	return err;
+}
+
 int mmc_can_ext_csd(struct mmc_card *card)
 {
 	return (card && card->csd.mmca_vsn > CSD_SPEC_VER_3);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index b8d0552..063500c 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -31,7 +31,6 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
-int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
 int mmc_interrupt_hpi(struct mmc_card *card);
 int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
-- 
2.7.4

