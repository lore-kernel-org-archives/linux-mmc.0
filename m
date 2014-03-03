From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH  v4 7/7] mmc: dw_mmc: restore the card-present checking point
Date: Mon, 03 Mar 2014 11:36:48 +0900
Message-ID: <5313EAC0.9040600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:15961 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbaCCCgY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Mar 2014 21:36:24 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1U008FD9WMJMC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Mar 2014 11:36:23 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Restore the card-present cheching point.
(The following part was removed from commit bf626e5(mmc: dw_mmc: use slot-gpio to handle cd pin).)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 22184c1..ab4c86d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2113,6 +2113,11 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 #endif /* CONFIG_MMC_DW_IDMAC */
 	}
 
+	if (dw_mci_get_cd(mmc))
+		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+	else
+		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto err_setup_bus;
-- 
1.7.9.5
