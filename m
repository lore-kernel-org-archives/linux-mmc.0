From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] mmc: core: Make mmc_switch_status() available for mmc core
Date: Thu, 20 Oct 2016 10:19:36 +0200
Message-ID: <1476951579-26125-2-git-send-email-ulf.hansson@linaro.org>
References: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35362 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcJTIT4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2016 04:19:56 -0400
Received: by mail-lf0-f52.google.com with SMTP id l131so67871630lfl.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 01:19:55 -0700 (PDT)
In-Reply-To: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

Following changes needs mmc_switch_status() to be available both from mmc.c
and mmc_ops.c. Allow that by moving its implementation to mmc_ops.c and
make it available via mmc_ops.h.

Moving mmc_switch_status() to mmc_ops.c, also enables us to turn
mmc_switch_status_error() into static function. So let's take the
opportunity to change this as well.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c     | 13 -------------
 drivers/mmc/core/mmc_ops.c | 15 ++++++++++++++-
 drivers/mmc/core/mmc_ops.h |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 39fc5b2..e811bd9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1000,19 +1000,6 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	return err;
 }
 
-/* Caller must hold re-tuning */
-static int mmc_switch_status(struct mmc_card *card)
-{
-	u32 status;
-	int err;
-
-	err = mmc_send_status(card, &status);
-	if (err)
-		return err;
-
-	return mmc_switch_status_error(card->host, status);
-}
-
 /*
  * Switch to the high-speed mode
  */
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ad6e979..f9af1c0 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -440,7 +440,7 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
 	return err;
 }
 
-int mmc_switch_status_error(struct mmc_host *host, u32 status)
+static int mmc_switch_status_error(struct mmc_host *host, u32 status)
 {
 	if (mmc_host_is_spi(host)) {
 		if (status & R1_SPI_ILLEGAL_COMMAND)
@@ -455,6 +455,19 @@ int mmc_switch_status_error(struct mmc_host *host, u32 status)
 	return 0;
 }
 
+/* Caller must hold re-tuning */
+int mmc_switch_status(struct mmc_card *card)
+{
+	u32 status;
+	int err;
+
+	err = mmc_send_status(card, &status);
+	if (err)
+		return err;
+
+	return mmc_switch_status_error(card->host, status);
+}
+
 /**
  *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index f1b8e81..7f6c0e9 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -27,7 +27,7 @@
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
 int mmc_can_ext_csd(struct mmc_card *card);
-int mmc_switch_status_error(struct mmc_host *host, u32 status);
+int mmc_switch_status(struct mmc_card *card);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, bool use_busy_signal, bool send_status,
 		bool ignore_crc);
-- 
1.9.1

