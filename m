From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 1/3] mmc: Rename mmc_is_io_op to mmc_is_rw_io_op
Date: Wed, 25 Nov 2015 12:28:45 +0100
Message-ID: <1448450927-13682-2-git-send-email-carlo@caione.org>
References: <1448450927-13682-1-git-send-email-carlo@caione.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33184 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbKYL3T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 06:29:19 -0500
Received: by wmec201 with SMTP id c201so251659144wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 03:29:18 -0800 (PST)
In-Reply-To: <1448450927-13682-1-git-send-email-carlo@caione.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, hdegoede@redhat.com, linux-mmc@vger.kernel.org, drake@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>

From: Carlo Caione <carlo@endlessm.com>

This function is used only to filter on sd-io-rw-* operations. Rename it
to reflect this behaviour.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/mmc/core/core.c     | 2 +-
 drivers/mmc/core/sdio_ops.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e4..2e8b24d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -208,7 +208,7 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	 * For sdio rw commands we must wait for card busy otherwise some
 	 * sdio devices won't work properly.
 	 */
-	if (mmc_is_io_op(mrq->cmd->opcode) && host->ops->card_busy) {
+	if (mmc_is_rw_io_op(mrq->cmd->opcode) && host->ops->card_busy) {
 		int tries = 500; /* Wait aprox 500ms at maximum */
 
 		while (host->ops->card_busy(host) && --tries)
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index 5660c7f..e4b5ceb 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -21,7 +21,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz);
 int sdio_reset(struct mmc_host *host);
 
-static inline bool mmc_is_io_op(u32 opcode)
+static inline bool mmc_is_rw_io_op(u32 opcode)
 {
 	return opcode == SD_IO_RW_DIRECT || opcode == SD_IO_RW_EXTENDED;
 }
-- 
2.5.0

