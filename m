From: <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: fix data timeout issue
Date: Wed, 23 May 2012 15:52:15 +0200
Message-ID: <1337781135-23722-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:11906 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab2EWNwY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 May 2012 09:52:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The data timeout timer was configured after mmc_add_host call. So, with bad
timings, it was possible to have a mmc request causing mod_timer call on a
non setup timer.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 93a1012..a25e23a 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2396,6 +2396,8 @@ static int __init atmci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
+	setup_timer(&host->timer, atmci_timeout_timer, (unsigned long)host);
+
 	/* We need at least one slot to succeed */
 	nr_slots = 0;
 	ret = -ENODEV;
@@ -2434,8 +2436,6 @@ static int __init atmci_probe(struct platform_device *pdev)
 		}
 	}
 
-	setup_timer(&host->timer, atmci_timeout_timer, (unsigned long)host);
-
 	dev_info(&pdev->dev,
 			"Atmel MCI controller at 0x%08lx irq %d, %u slots\n",
 			host->mapbase, irq, nr_slots);
-- 
1.7.5.4

