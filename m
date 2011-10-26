From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Subject: [PATCH] mmc: mmci: Fix PIO read for small SDIO packets
Date: Wed, 26 Oct 2011 10:45:27 +0200
Message-ID: <1319618727-16969-1-git-send-email-stefan.xk.nilsson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:57999 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932331Ab1JZI4f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2011 04:56:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Corrects a bug in MMCI host driver which silently causes
small reads (< 4 bytes as only used in SDIO) from PL-18X to fail.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 56e9a41..5c3a517 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -776,7 +776,18 @@ static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int rema
 		if (count <= 0)
 			break;
 
-		readsl(base + MMCIFIFO, ptr, count >> 2);
+		/*
+		 * SDIO especially may want to send something that is
+		 * not divisible by 4 (as opposed to card sectors
+		 * etc). Therefore make sure to to always read the last bytes
+		 * while only doing full 32-bit reads towards the FIFO.
+		 */
+		if (count < 4) {
+			unsigned char buf[4];
+			readsl(base + MMCIFIFO, buf, 1);
+			memcpy(ptr, buf, count);
+		} else
+			readsl(base + MMCIFIFO, ptr, count >> 2);
 
 		ptr += count;
 		remain -= count;
-- 
1.7.7

