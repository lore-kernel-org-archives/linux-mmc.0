From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/2] mmci: fixup sg buffer handling in mmci_pio_irq.
Date: Thu, 5 May 2011 13:14:23 +0200
Message-ID: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:39513 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753793Ab1EELOj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 07:14:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>

Earlier code was expecting that mmci_pio_write() returns
not more than 'remain' bytes transferred. It is not the case
for buffers which are not multiple of 4 bytes length.

The patch fix the problem by checking result of mmci_pio_write().

The fault was introduced in the change:
	I2e506ec1f5a7fadf9780c18d8d31573eaf048273
	MMCI: Fixup sg buffer handling in pio_write

Signed-off-by: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 6e27433..e238462 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -753,7 +753,10 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (status & MCI_TXACTIVE)
 			len = mmci_pio_write(host, buffer, remain, status);
 
-		sg_miter->consumed = len;
+		if (len > sg_miter->consumed)
+			len = sg_miter->consumed;
+		else
+			sg_miter->consumed = len;
 
 		host->size -= len;
 		remain -= len;
-- 
1.7.3.2

