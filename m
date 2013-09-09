From: <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: fix oops in atmci_tasklet_func
Date: Mon, 9 Sep 2013 17:31:59 +0200
Message-ID: <1378740719-25164-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:5299 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab3IIPcE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2013 11:32:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: giometti@enneenne.com, nicolas.ferre@atmel.com, cjb@laptop.org

From: Rodolfo Giometti <giometti@enneenne.com>

In some cases, a NULL pointer dereference happens because data is NULL when
STATE_END_REQUEST case is reached in atmci_tasklet_func.

Cc: <stable@vger.kernel.org> #3.9+
Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e9ea2fc..78d7e47 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1792,12 +1792,14 @@ static void atmci_tasklet_func(unsigned long priv)
 			if (unlikely(status)) {
 				host->stop_transfer(host);
 				host->data = NULL;
-				if (status & ATMCI_DTOE) {
-					data->error = -ETIMEDOUT;
-				} else if (status & ATMCI_DCRCE) {
-					data->error = -EILSEQ;
-				} else {
-					data->error = -EIO;
+				if (data) {
+					if (status & ATMCI_DTOE) {
+						data->error = -ETIMEDOUT;
+					} else if (status & ATMCI_DCRCE) {
+						data->error = -EILSEQ;
+					} else {
+						data->error = -EIO;
+					}
 				}
 			}
 
-- 
1.7.11.3

