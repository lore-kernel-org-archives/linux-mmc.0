From: "George G. Davis" <gdavis@mvista.com>
Subject: [PATCH] mmc: sdhci: Make consistent use of CONFIG_MMC_DEBUG for "DEBUG"ging
Date: Thu, 18 Feb 2010 12:32:12 -0500
Message-ID: <1266514332-19876-1-git-send-email-gdavis@mvista.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:52408 "EHLO
	qmta04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758142Ab0BRRcY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Feb 2010 12:32:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "George G. Davis" <gdavis@mvista.com>, Ben Dooks <ben-linux@fluff.org>

The "6882a8c sdhci: Add better ADMA error reporting" commit added
sdhci_show_adma_error() which is built when DEBUG is defined.
Since we already have CONFIG_MMC_DEBUG used elsewhere in this driver,
may as well make consistent use of that config knob instead.

Signed-off-by: George G. Davis <gdavis@mvista.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c279fbc..6c2978c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1398,7 +1398,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		sdhci_finish_command(host);
 }
 
-#ifdef DEBUG
+#ifdef CONFIG_MMC_DEBUG
 static void sdhci_show_adma_error(struct sdhci_host *host)
 {
 	const char *name = mmc_hostname(host->mmc);
-- 
1.6.3.3.311.g43dd

