From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] mmc: sdhci-pxav2: No need to clear CLK_GATE_SETTING_BITS
 before setting it
Date: Mon, 05 Dec 2011 11:36:10 +0800
Message-ID: <1323056170.2672.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63215 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab1LEDgX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Dec 2011 22:36:23 -0500
Received: by ywa9 with SMTP id 9so3966563ywa.19
        for <linux-mmc@vger.kernel.org>; Sun, 04 Dec 2011 19:36:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Viresh Kumar <viresh.kumar@st.com>, Chris Ball <cjb@laptop.org>

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/mmc/host/sdhci-pxav2.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index dbb75bf..a0ec9d2 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -78,7 +78,6 @@ static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
 			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
 		} else {
 			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
-			tmp &= ~CLK_GATE_SETTING_BITS;
 			tmp |= CLK_GATE_SETTING_BITS;
 			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
 		}
-- 
1.7.5.4



