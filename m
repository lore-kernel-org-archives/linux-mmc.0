From: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
Subject: [PATCH] at91_mci: Enable 4-bit bus mode for AT91SAM9RL64 CPU
Date: Thu, 24 Dec 2009 15:37:11 +0200
Message-ID: <1261661831-750-1-git-send-email-yauhen.kharuzhy@promwad.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:58170 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbZLXNhd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Dec 2009 08:37:33 -0500
Received: by fxm25 with SMTP id 25so2789808fxm.21
        for <linux-mmc@vger.kernel.org>; Thu, 24 Dec 2009 05:37:31 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ivan Kuten <ivan.kuten@promwad.com>, Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>

AT91SAM9RL64 CPU has 4-bit SD/MMC mode support, so enable them.

Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
---
 drivers/mmc/host/at91_mci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 63924e0..cb4a63b 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -1017,7 +1017,8 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	host->bus_mode = 0;
 	host->board = pdev->dev.platform_data;
 	if (host->board->wire4) {
-		if (cpu_is_at91sam9260() || cpu_is_at91sam9263())
+		if (cpu_is_at91sam9260() || cpu_is_at91sam9263()
+			|| cpu_is_at91sam9rl())
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
 		else
 			dev_warn(&pdev->dev, "4 wire bus mode not supported"
-- 
1.6.5.7

