From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: toshsd: Fix unbalanced locking
Date: Thu, 11 Dec 2014 11:10:44 +0800
Message-ID: <1418267444.21421.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64579 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933176AbaLKDKs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Dec 2014 22:10:48 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so4113425pab.34
        for <linux-mmc@vger.kernel.org>; Wed, 10 Dec 2014 19:10:48 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Fix returning IRQ_HANDLED with spin_lock held.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/toshsd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index 4666262..a5aa539 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -176,7 +176,8 @@ static irqreturn_t toshsd_thread_irq(int irq, void *dev_id)
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (!sg_miter_next(sg_miter))
-		return IRQ_HANDLED;
+		goto done;
+
 	buf = sg_miter->addr;
 
 	/* Ensure we dont read more than one block. The chip will interrupt us
@@ -198,6 +199,7 @@ static irqreturn_t toshsd_thread_irq(int irq, void *dev_id)
 	sg_miter->consumed = count;
 	sg_miter_stop(sg_miter);
 
+done:
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	return IRQ_HANDLED;
-- 
1.9.1



