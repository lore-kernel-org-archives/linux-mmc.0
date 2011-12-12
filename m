From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 4/5] mmc: mmci: Fix PIO read for small SDIO packets
Date: Mon, 12 Dec 2011 16:36:06 +0100
Message-ID: <1323704167-10247-5-git-send-email-ulf.hansson@stericsson.com>
References: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:40067 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098Ab1LLPgj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2011 10:36:39 -0500
In-Reply-To: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Corrects a bug in MMCI host driver which silently causes
small reads (< 4 bytes as only used in SDIO) from PL-18X to fail.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
---
 drivers/mmc/host/mmci.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9ea2f13..94c04c3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -876,7 +876,24 @@ static int mmci_pio_read(struct mmci_host *host, char *buffer, unsigned int rema
 		if (count <= 0)
 			break;
 
-		readsl(base + MMCIFIFO, ptr, count >> 2);
+		/*
+		 * SDIO especially may want to send something that is
+		 * not divisible by 4 (as opposed to card sectors
+		 * etc). Therefore make sure to always read the last bytes
+		 * while only doing full 32-bit reads towards the FIFO.
+		 */
+		if (unlikely(count & 0x3)) {
+			if (count < 4) {
+				unsigned char buf[4];
+				readsl(base + MMCIFIFO, buf, 1);
+				memcpy(ptr, buf, count);
+			} else {
+				readsl(base + MMCIFIFO, ptr, count >> 2);
+				count &= ~0x3;
+			}
+		} else {
+			readsl(base + MMCIFIFO, ptr, count >> 2);
+		}
 
 		ptr += count;
 		remain -= count;
-- 
1.7.5.4

