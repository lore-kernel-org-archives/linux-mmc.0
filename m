From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 1/2] sdhci: add quirk for lack of 1.8v support
Date: Sun, 25 Nov 2012 13:01:19 -0500 (EST)
Message-ID: <20121125180121.31FB3FACF5@dev.laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from swan.laptop.org ([18.85.2.166]:52689 "EHLO swan.laptop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab2KYSJV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 13:09:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, jrudholm@gmail.com, prakity@nvidia.com, devicetree-discuss@lists.ozlabs.org

The OLPC XO-1.75 laptop includes a SDHCI controller which is 1.8v
capable, and it truthfully reports so in its capabilities. This
alternate voltage is used for driving new "UHS-I" SD cards at their
full speed.

However, what the controller doesn't know is that the motherboard
physically doesn't have a 1.8v supply available.

Add a quirk so that systems such as this one can override disable
1.8v support, adding support for UHS-I cards (by running them at
3.3v).

This avoids a problem where the system would first try to run the
card at 1.8v, fail, and then not be able to fully reset the card
to retry at the normal 3.3v voltage.

This is more appropriate than using the MISSING_CAPS quirk, which
is intended for cases where the SDHCI controller is actually lying
about its capabilities, and would force us to somehow override both
caps words from another source.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/host/sdhci.c  | 4 ++++
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c7851c0..7273523 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2865,6 +2865,10 @@ int sdhci_add_host(struct sdhci_host *host)
 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50);
 
+	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
+		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+		       SDHCI_SUPPORT_DDR50);
+
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50))
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1edcb4d..1a42747 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -92,6 +92,8 @@ struct sdhci_host {
 
 #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
 #define SDHCI_QUIRK2_HOST_NO_CMD23			(1<<1)
+/* The system physically doesn't support 1.8v, even if the host does */
+#define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.11.7

