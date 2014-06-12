From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: add 0x600 IP version
Date: Thu, 12 Jun 2014 09:47:45 +0200
Message-ID: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:7114 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbaFLHrv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jun 2014 03:47:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 1b4b064..9c4c191 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2306,6 +2306,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 
 	/* keep only major version number */
 	switch (version & 0xf00) {
+	case 0x600:
 	case 0x500:
 		host->caps.has_odd_clk_div = 1;
 	case 0x400:
-- 
1.7.9.5

