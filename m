From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/9] mmc: core: Re-factor code for sending CID
Date: Thu,  8 Jun 2017 15:27:43 +0200
Message-ID: <1496928465-25004-8-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36297 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdFHN2G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:28:06 -0400
Received: by mail-lf0-f45.google.com with SMTP id o83so18028479lff.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:28:05 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Instead of having the caller to check for SPI mode, let's leave that to
internals of mmc_send_cid(). In this way the code gets cleaner and it
becomes clear what is specific to SPI and non-SPI mode.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c     |  5 +----
 drivers/mmc/core/mmc_ops.c | 12 ++++++++++--
 drivers/mmc/core/mmc_ops.h |  1 -
 drivers/mmc/core/sd.c      |  6 +-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ff6cdc3..e504b66 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1556,10 +1556,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Fetch CID from card.
 	 */
-	if (mmc_host_is_spi(host))
-		err = mmc_send_cid(host, cid);
-	else
-		err = mmc_all_send_cid(host, cid);
+	err = mmc_send_cid(host, cid);
 	if (err)
 		goto err;
 
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 9994840..50571a6 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -207,7 +207,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	return err;
 }
 
-int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
+static int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
 {
 	int err;
 	struct mmc_command cmd = {};
@@ -334,7 +334,7 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
 	return ret;
 }
 
-int mmc_send_cid(struct mmc_host *host, u32 *cid)
+static int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
 {
 	int ret, i;
 	__be32 *cid_tmp;
@@ -355,6 +355,14 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 	return ret;
 }
 
+int mmc_send_cid(struct mmc_host *host, u32 *cid)
+{
+	if (mmc_host_is_spi(host))
+		return mmc_spi_send_cid(host, cid);
+
+	return mmc_all_send_cid(host, cid);
+}
+
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 {
 	int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 9d6b15b..d3d5d68 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -22,7 +22,6 @@ int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
-int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
 int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 1d7542d..a1b0aa1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -788,11 +788,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 		}
 	}
 
-	if (mmc_host_is_spi(host))
-		err = mmc_send_cid(host, cid);
-	else
-		err = mmc_all_send_cid(host, cid);
-
+	err = mmc_send_cid(host, cid);
 	return err;
 }
 
-- 
2.7.4

