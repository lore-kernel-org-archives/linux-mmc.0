From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 06/31] ARM: amba: make irq 0 invalid
Date: Fri, 20 Jan 2012 09:24:25 +0000
Message-ID: <E1RoAht-0005Ed-Pn@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37444 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab2ATJYy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:24:54 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Chris Ball <cjb@laptop.org>

Fix core bus and MMCI such that irq 0 means that there is no IRQ
attached.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/amba/bus.c      |    4 ++--
 drivers/mmc/host/mmci.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 82b65e1..d15acbb 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -564,9 +564,9 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 	if (ret)
 		goto err_release;
 
-	if (dev->irq[0] != NO_IRQ)
+	if (dev->irq[0] && dev->irq[0] != NO_IRQ)
 		ret = device_create_file(&dev->dev, &dev_attr_irq0);
-	if (ret == 0 && dev->irq[1] != NO_IRQ)
+	if (ret == 0 && dev->irq[1] && dev->irq[1] != NO_IRQ)
 		ret = device_create_file(&dev->dev, &dev_attr_irq1);
 	if (ret == 0)
 		return ret;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0d955ff..304f2f9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1325,7 +1325,7 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	if (ret)
 		goto unmap;
 
-	if (dev->irq[1] == NO_IRQ)
+	if (dev->irq[1] == NO_IRQ || !dev->irq[1])
 		host->singleirq = true;
 	else {
 		ret = request_irq(dev->irq[1], mmci_pio_irq, IRQF_SHARED,
-- 
1.7.4.4

