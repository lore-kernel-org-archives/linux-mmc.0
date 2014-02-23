From: Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH] mmc: sdhci: add quirk for broken write protect detection
Date: Mon, 24 Feb 2014 01:32:25 +0200
Message-ID: <1393198345-8365-1-git-send-email-eli.billauer@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from leviathan.tchmachines.com ([208.76.85.180]:59942 "EHLO
	leviathan.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaBXABI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Feb 2014 19:01:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: michal.simek@xilinx.com, linux-mmc@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>

The write protection signal is absent on a board based upon Xilinx' Zynq
processor ("ZyBo"). This leads the kernel to think that the MicroSD card is
write protected, and causes a kernel panic during boot, as root fails to
mount RW.

This patch adds a quirk and an optional OF property, sdhci,wp-broken to
work around this issue.

Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
 drivers/mmc/host/sdhci-pltfm.c                |    4 +++-
 drivers/mmc/host/sdhci.c                      |    2 ++
 include/linux/mmc/sdhci.h                     |    2 ++
 4 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 458b57f..a3aab97 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -21,6 +21,8 @@ Optional properties:
   below for the case, when a GPIO is used for the CD line
 - wp-inverted: when present, polarity on the WP line is inverted. See the note
   below for the case, when a GPIO is used for the WP line
+- wp-broken: when present, no indication of write protection is available,
+  and write protection is assumed always off.
 - max-frequency: maximum operating clock frequency
 - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
   this system, even if the controller claims it is.
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bef250e..7b433a2 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -80,7 +80,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		    bus_width == 1))
 			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
-		if (sdhci_of_wp_inverted(np))
+		if (of_get_property(np, "sdhci,wp-broken", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_BROKEN_WRITE_PROTECT;
+		else if (sdhci_of_wp_inverted(np))
 			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
 		if (of_get_property(np, "broken-cd", NULL))
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ddef47..6c77f2e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1657,6 +1657,8 @@ static int sdhci_check_ro(struct sdhci_host *host)
 		is_readonly = 0;
 	else if (host->ops->get_ro)
 		is_readonly = host->ops->get_ro(host);
+	else if (host->quirks2 & SDHCI_QUIRK2_BROKEN_WRITE_PROTECT)
+		is_readonly = 0;
 	else
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 362927c4..0f6ef9d 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -100,6 +100,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
 /* Controller does not support HS200 */
 #define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
+/* There is no indication for write protection at all, assume RW */
+#define SDHCI_QUIRK2_BROKEN_WRITE_PROTECT		(1<<7)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.2.3

