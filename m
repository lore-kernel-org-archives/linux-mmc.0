From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] mmc: dw_mmc: poll if CD is broken
Date: Wed, 30 Apr 2014 15:44:43 +0200
Message-ID: <1398865484-527-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51462 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbaD3Noz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 09:44:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

My CD pin is not available at all (DW_MCI_QUIRK_BROKEN_CARD_DETECTION is
set). The result was in v3.12 that if MMC card was inserted at load
time, then the MMC card was detected. If it wasn't, it wasn't detected
since nobody polled for it and I no irq was wired up.
I haven't noticed any change in that area, therefore I'm adding the
MMC_CAP_NEEDS_POLL flag in case the detection is broken so the core will
check for the MMC card.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mmc/host/dw_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cced599..82f5ea2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2227,6 +2227,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	}
 
 	slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
+
+	if (host->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
 	dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);
 
 	ret = mmc_add_host(mmc);
-- 
1.9.2

