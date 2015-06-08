From: Daniel Lockyer <thisisdaniellockyer@gmail.com>
Subject: [PATCH] MMC: Fix checkpatch.pl issues
Date: Mon, 8 Jun 2015 13:04:16 +0100
Message-ID: <20150608120416.GA7771@eve.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33210 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbFHMES (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2015 08:04:18 -0400
Received: by wiwd19 with SMTP id d19so83822537wiw.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2015 05:04:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

Remove unneeded braces and fixed spacing.
Also changed include of asm/uaccess.h to linux/uaccess.h.

Signed-off-by: Daniel Lockyer <thisisdaniellockyer@gmail.com>
---
 drivers/mmc/card/block.c     | 2 +-
 drivers/mmc/card/sdio_uart.c | 2 +-
 drivers/mmc/core/mmc_ops.c   | 4 ++--
 drivers/mmc/core/sd_ops.c    | 5 ++---
 drivers/mmc/core/sdio.c      | 5 ++---
 drivers/mmc/core/sdio_cis.c  | 4 ++--
 6 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 60f7141..94d5fdb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -42,7 +42,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include "queue.h"
 
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index d2de592..ef3bf63 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -768,7 +768,7 @@ static int sdio_uart_open(struct tty_struct *tty, struct file *filp)
 	return tty_port_open(&port->port, tty, filp);
 }
 
-static void sdio_uart_close(struct tty_struct *tty, struct file * filp)
+static void sdio_uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct sdio_uart_port *port = tty->driver_data;
 	tty_port_close(&port->port, tty, filp);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0ea042d..0d4790c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -353,7 +353,7 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
 	if (ret)
 		goto err;
 
-	for (i = 0;i < 4;i++)
+	for (i = 0; i < 4; i++)
 		csd[i] = be32_to_cpu(csd_tmp[i]);
 
 err:
@@ -381,7 +381,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 	if (ret)
 		goto err;
 
-	for (i = 0;i < 4;i++)
+	for (i = 0; i < 4; i++)
 		cid[i] = be32_to_cpu(cid_tmp[i]);
 
 err:
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 48d0c93..e7ce495 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -54,7 +54,7 @@ EXPORT_SYMBOL_GPL(mmc_app_cmd);
 
 /**
  *	mmc_wait_for_app_cmd - start an application command and wait for
- 			       completion
+ *			       completion
  *	@host: MMC host to start command
  *	@card: Card to send MMC_APP_CMD to
  *	@cmd: MMC command to start
@@ -81,7 +81,7 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 	 * We have to resend MMC_APP_CMD for each attempt so
 	 * we cannot use the retries field in mmc_command.
 	 */
-	for (i = 0;i <= retries;i++) {
+	for (i = 0; i <= retries; i++) {
 		err = mmc_app_cmd(host, card);
 		if (err) {
 			/* no point in retrying; no APP commands allowed */
@@ -115,7 +115,6 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 
 	return err;
 }
-
 EXPORT_SYMBOL(mmc_wait_for_app_cmd);
 
 int mmc_app_set_bus_width(struct mmc_card *card, int width)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5bc6c7d..08c74b6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -723,9 +723,8 @@ try_again:
 		 */
 		mmc_set_clock(host, card->cis.max_dtr);
 
-		if (card->cccr.high_speed) {
+		if (card->cccr.high_speed)
 			mmc_set_timing(card->host, MMC_TIMING_SD_HS);
-		}
 
 		goto finish;
 	}
@@ -827,7 +826,7 @@ static void mmc_sdio_remove(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	for (i = 0;i < host->card->sdio_funcs;i++) {
+	for (i = 0; i < host->card->sdio_funcs; i++) {
 		if (host->card->sdio_func[i]) {
 			sdio_remove_func(host->card->sdio_func[i]);
 			host->card->sdio_func[i] = NULL;
diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 8e94e55..09e3f55 100644
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
-- 
2.4.2

