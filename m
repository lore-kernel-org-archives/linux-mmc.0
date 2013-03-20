From: <Chang-Ming.Huang@freescale.com>
Subject: [PATCH 3/3 v6] ESDHC: add callback esdhc_of_get_cd to detect card
Date: Wed, 20 Mar 2013 13:41:35 +0800
Message-ID: <1363758095-32378-3-git-send-email-Chang-Ming.Huang@freescale.com>
References: <1363758095-32378-1-git-send-email-Chang-Ming.Huang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:55244
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810Ab3CTGQf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 02:16:35 -0400
In-Reply-To: <1363758095-32378-1-git-send-email-Chang-Ming.Huang@freescale.com>
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
changes for v6:
	- change the variable to u32 and change the retrun value.

 drivers/mmc/host/sdhci-of-esdhc.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index f32526d..dbb32a5 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -230,6 +230,31 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
+/* Return: 1 - the card is present; 0 - card is absent */
+static int esdhc_of_get_cd(struct sdhci_host *host)
+{
+	u32 present;
+	u32 sysctl;
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
+	/* Resave the previous to System control register */
+	sdhci_be32bs_writel(host, sysctl, SDHCI_CLOCK_CONTROL);
+
+	return !!present;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -242,6 +267,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
 	.platform_init = esdhc_of_platform_init,
+	.get_cd = esdhc_of_get_cd,
 #ifdef CONFIG_PM
 	.platform_suspend = esdhc_of_suspend,
 	.platform_resume = esdhc_of_resume,
-- 
1.7.9.5


