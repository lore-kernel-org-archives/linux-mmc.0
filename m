From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 5/5] mmc:esdhc: eSDHC host don't have highspeed bit
Date: Tue, 3 Sep 2013 15:33:17 +0800
Message-ID: <1378193597-29059-5-git-send-email-Haijun.Zhang@freescale.com>
References: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.13] ([216.32.180.13]:50278 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932300Ab3ICHiP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 03:38:15 -0400
In-Reply-To: <1378193597-29059-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cbouatmailru@gmail.com, galak@kernel.crashing.org
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>

eSDHC host is not a standand host, there is no
SDHCI_CTRL_HISPD bit in SDHCI_HOST_CONTROL register.
Add this quirk to avoid changing the Data transfer width
bit of eSDHC host.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index a2a0642..6de001e 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -23,6 +23,7 @@
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
+				SDHCI_QUIRK_NO_HISPD_BIT | \
 				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 
 #define ESDHC_SYSTEM_CONTROL	0x2c
-- 
1.8.0


