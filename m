From: <r66093@freescale.com>
Subject: [PATCH 3/3 v5] ESDHC: add callback esdhc_of_get_cd to detect card
Date: Mon, 19 Nov 2012 13:27:26 +0800
Message-ID: <1353302846-19514-3-git-send-email-r66093@freescale.com>
References: <1353302846-19514-1-git-send-email-r66093@freescale.com>
 <1353302846-19514-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:3713 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752018Ab2KSGNx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 01:13:53 -0500
In-Reply-To: <1353302846-19514-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

In order to check if the card is present, we will read the PRESENT STATE
register and check the bit13(Card detect pin level) and bit15(CINS).

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- add new callback for esdhc to detect the card state
	- add the CC
changes for v3:
	- enable the controller clock when detect the card state, not core
changes for v4:
	- based on the latest version
changes for v5:
	- modify codes according to Anton's suggest and add reviewed-by.

 drivers/mmc/host/sdhci-of-esdhc.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 63d219f..f50f7b0 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -179,6 +179,31 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 }
 
+/* Return: none zero - the card is presetn; 0 - card is absent */
+static int esdhc_of_get_cd(struct sdhci_host *host)
+{
+	int present;
+	int sysctl;
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		return 0;
+
+	sysctl = sdhci_be32bs_readl(host, SDHCI_CLOCK_CONTROL);
+
+	/* Enable the controller clock to update the present state */
+	sdhci_be32bs_writel(host, sysctl | SDHCI_CLOCK_INT_EN,
+			SDHCI_CLOCK_CONTROL);
+
+	/* Detect the card present or absent */
+	present = sdhci_be32bs_readl(host, SDHCI_PRESENT_STATE);
+	present &= (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL);
+
+	/* Resve the previous to System control register */
+	sdhci_be32bs_writel(host, sysctl, SDHCI_CLOCK_CONTROL);
+
+	return present;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -191,6 +216,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
 	.platform_init = esdhc_of_platform_init,
+	.get_cd = esdhc_of_get_cd,
 #ifdef CONFIG_PM
 	.platform_suspend = esdhc_of_suspend,
 	.platform_resume = esdhc_of_resume,
-- 
1.7.9.5


