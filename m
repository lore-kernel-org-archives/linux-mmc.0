From: Per Forlin <per.forlin@stericsson.com>
Subject: [PATCH v2 2/2] sdio: report error if pending IRQ but none CCCR_INTx bits
Date: Wed, 1 Jun 2011 10:48:33 +0200
Message-ID: <1306918113-23872-3-git-send-email-per.forlin@stericsson.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
 <1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:52493 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1162434Ab1FAIuO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 04:50:14 -0400
In-Reply-To: <1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Linus
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

From: Per Forlin <per.forlin@linaro.org>

Return error in case of pending IRQ but none functions bits
in CCCR_INTx are set.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/core/sdio_irq.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index df1e946..4288d92 100644
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

