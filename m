From: Will Newton <will.newton@gmail.com>
Subject: [PATCH 2/2] dw_mmc: Enable low-power mode for the card clock.
Date: Thu, 10 Feb 2011 10:40:57 +0000
Message-ID: <AANLkTikkCeo2YSyw_w7Qny0k9iugrM59pFWDTSwQx=i2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52996 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124Ab1BJKk6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 05:40:58 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so1947000bwz.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Feb 2011 02:40:57 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Setting this bit in the clock enable register will stop the clock
when the card is in the IDLE state.

Signed-off-by: Will Newton <will.newton@imgtec.com>
---
 drivers/mmc/host/dw_mmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0b0bedd..4cf560d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -562,7 +562,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);

 		/* enable clock */
-		mci_writel(host, CLKENA, SDMMC_CLKEN_ENABLE);
+		mci_writel(host, CLKENA, SDMMC_CLKEN_ENABLE |
+			   SDMMC_CLKEN_LOW_PWR);

 		/* inform CIU */
 		mci_send_cmd(slot,
-- 
1.7.3.4
