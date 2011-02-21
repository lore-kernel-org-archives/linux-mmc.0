From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 4/5] mm: sdhci-esdhc: remove SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
Date: Mon, 21 Feb 2011 17:54:54 +0800
Message-ID: <1298282095-2279-4-git-send-email-richard.zhao@freescale.com>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:2828
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753186Ab1BUJzL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 04:55:11 -0500
Received: from mail207-ch1 (localhost.localdomain [127.0.0.1])	by
 mail207-ch1-R.bigfish.com (Postfix) with ESMTP id 939FC17902B9	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 09:55:09 +0000 (UTC)
Received: from CH1EHSMHS008.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.243])	by mail207-ch1.bigfish.com (Postfix) with ESMTP id
 64C8AE9804B	for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 09:55:09 +0000
 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id p1L9t0fK012542	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 02:55:01 -0700 (MST)
Received: from b20223-02 (B20223-02.ap.freescale.net [10.192.242.48])	by
 de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id p1L9sx2Y022455	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 03:55:00 -0600 (CST)
In-Reply-To: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, r65037@freescale.com, Richard Zhao <richard.zhao@freescale.com>, Richard Zhu <Hong-Xing.Zhu@freescale.com>

sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET.
Make it OF-specific.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index afaf1bc..303cde0 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -24,8 +24,7 @@
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
-				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET | \
-				SDHCI_QUIRK_NO_CARD_NO_RESET)
+				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 
 #define ESDHC_SYSTEM_CONTROL	0x2c
 #define ESDHC_CLOCK_MASK	0x0000fff0
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fcd0e1f..6337607 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -73,7 +73,7 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 }
 
 struct sdhci_of_data sdhci_esdhc = {
-	.quirks = ESDHC_DEFAULT_QUIRKS,
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_CARD_NO_RESET,
 	.ops = {
 		.read_l = sdhci_be32bs_readl,
 		.read_w = esdhc_readw,
-- 
1.7.1


