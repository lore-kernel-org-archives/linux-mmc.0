From: =?UTF-8?q?Steffen=20K=C3=BChn?= <sk@ammonit.com>
Subject: [PATCH] mmc: atmel-mci: fix deadlock
Date: Wed,  9 May 2012 11:23:36 +0200
Message-ID: <1336555416-14640-1-git-send-email-sk@ammonit.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53315 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab2EIJYh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 05:24:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Steffen=20K=C3=BChn?= <sk@ammonit.com>

solves a deadlock problem which appears when a mmc card is
removing and a process is reading from the card at the same time.
---
 drivers/mmc/host/atmel-mci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e94476b..effdc36 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1499,8 +1499,10 @@ static void atmci_tasklet_func(unsigned long priv)
			}

			if (!atmci_test_and_clear_pending(host,
-						EVENT_XFER_COMPLETE))
+						EVENT_XFER_COMPLETE)) {
+				host->stop_transfer(host);
				break;
+            }

			atmci_set_completed(host, EVENT_XFER_COMPLETE);
			prev_state = state = STATE_DATA_BUSY;
--
1.7.2.5
