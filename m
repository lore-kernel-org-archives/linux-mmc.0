From: Seunguk Shin <seunguk.shin@samsung.com>
Subject: [PATCH] mmc: sdhci: remove delay during tuning command for mmc
Date: Fri, 04 Apr 2014 21:07:19 +0900
Message-ID: <000001cf4ffe$6f8fdb60$4eaf9220$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31082 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaDDMHX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Apr 2014 08:07:23 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3I008KZ9O9C3A0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Apr 2014 21:07:21 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, cpgs@samsung.com

This change removes delay during tuning command for mmc.
Because mmc does not need delay between tuning commands,
and it could cause performance degradation.

---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a79fc4..bd266fa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1992,7 +1992,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc,
u32 opcode)
                ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
                tuning_loop_counter--;
                timeout--;
-               mdelay(1);
+               if (mmc->card->type != MMC_TYPE_MMC)
+                       mdelay(1);
        } while (ctrl & SDHCI_CTRL_EXEC_TUNING);

        /*
--
1.8.3.2


