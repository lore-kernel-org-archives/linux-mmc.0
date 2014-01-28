From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 7/8] mmc: dw_mmc: remove the dw_mci_of_cd_gpio()
Date: Tue, 28 Jan 2014 17:24:58 +0900
Message-ID: <52E7695A.8070206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:61891 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbaA1IY3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 03:24:29 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0300LUCRCS6320@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jan 2014 17:24:28 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

If mmc_of_parse() is used, dw_mci_of_get_cd_gpio didn't need.
Already implemented into mmc_of_parse().

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 947859f..983560d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2048,26 +2048,6 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 
 	return gpio;
 }
-
-/* find the cd gpio for a given slot */
-static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
-					struct mmc_host *mmc)
-{
-	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
-	int gpio;
-
-	if (!np)
-		return;
-
-	gpio = of_get_named_gpio(np, "cd-gpios", 0);
-
-	/* Having a missing entry is valid; return silently */
-	if (!gpio_is_valid(gpio))
-		return;
-
-	if (mmc_gpio_request_cd(mmc, gpio, 0))
-		dev_warn(dev, "gpio [%d] request failed\n", gpio);
-}
 #else /* CONFIG_OF */
 static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
 {
@@ -2081,11 +2061,6 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 {
 	return -EINVAL;
 }
-static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
-					struct mmc_host *mmc)
-{
-	return;
-}
 #endif /* CONFIG_OF */
 
 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
@@ -2165,7 +2140,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	}
 
 	slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
-	dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-- 
1.7.9.5
