From: Rabin Vincent <rabin.vincent@axis.com>
Subject: [PATCH 3/3] mmc: usdhi6rol0: fix ack register write
Date: Wed, 19 Aug 2015 15:41:36 +0200
Message-ID: <1439991696-28488-3-git-send-email-rabin.vincent@axis.com>
References: <1439991696-28488-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:33744 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbbHSNlt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Aug 2015 09:41:49 -0400
In-Reply-To: <1439991696-28488-1-git-send-email-rabin.vincent@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, Rabin Vincent <rabinv@axis.com>

The intent appears to be to clear only the bits which are set in status
(by setting them to zero in the ack write), like in the other interrupt
handlers, and not to always clear everything (by always writing zero).
Use the correct not operator.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 4188e84e..b505cbc2 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1611,7 +1611,7 @@ static irqreturn_t usdhi6_cd(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	/* Ack */
-	usdhi6_write(host, USDHI6_SD_INFO1, !status);
+	usdhi6_write(host, USDHI6_SD_INFO1, ~status);
 
 	if (!work_pending(&mmc->detect.work) &&
 	    (((status & USDHI6_SD_INFO1_CARD_INSERT) &&
-- 
1.7.10.4

