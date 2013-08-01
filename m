From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] mmc: vub300: Staticize vub300_init_card()
Date: Thu, 01 Aug 2013 15:32:37 +0900
Message-ID: <004e01ce8e80$e9fa5be0$bdef13a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:19046 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab3HAGcj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 02:32:39 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQU004SRA677JI0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 Aug 2013 15:32:37 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Tony Olech' <tony.olech@elandigitalsystems.com>, Jingoo Han <jg1.han@samsung.com>

vub300_init_card() is used only in this file.
Fix the following sparse warning:

drivers/mmc/host/vub300.c:2082:6: warning: symbol 'vub300_init_card' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/vub300.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index cb9f361..e9028ad 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2079,7 +2079,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	kref_put(&vub300->kref, vub300_delete);
 }
 
-void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
+static void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {				/* NOT irq */
 	struct vub300_mmc_host *vub300 = mmc_priv(mmc);
 	dev_info(&vub300->udev->dev, "NO host QUIRKS for this card\n");
-- 
1.7.10.4


