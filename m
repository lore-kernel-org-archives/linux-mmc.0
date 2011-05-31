From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH 2/2] sdio: report error if pending IRQ but none function bits
Date: Tue, 31 May 2011 22:33:28 +0200
Message-ID: <1306874008-28867-3-git-send-email-per.forlin@linaro.org>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62419 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758244Ab1EaUeI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 16:34:08 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1794491eyx.19
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2011 13:34:08 -0700 (PDT)
In-Reply-To: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

Return error in case of pending IRQ but none functions bits
in CCCR_INTx is set.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/core/sdio_irq.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 2f81ddc..8184b6e 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -50,6 +50,11 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 		return ret;
 	}
 
+	if (!pending) {
+		printk(KERN_WARNING "%s: pending IRQ but none function bits\n",
+		       mmc_card_id(card));
+		ret = -EINVAL;
+	}
 	count = 0;
 	for (i = 1; i <= 7; i++) {
 		if (pending & (1 << i)) {
-- 
1.7.4.1

