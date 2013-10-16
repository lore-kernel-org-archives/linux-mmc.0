From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] mmc: atmel-mci: add vmmc-supply support
Date: Wed, 16 Oct 2013 16:32:04 +0200
Message-ID: <1381933924-32437-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45141 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934104Ab3JPOcI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 10:32:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Other MMC hosts handle a regulator named vmmc-supply that allows to power the
MMC card or SDIO device before communicating on the bus.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/mmc/host/atmel-mci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 69e438e..deffa1f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -2355,6 +2356,7 @@ static int __init atmci_probe(struct platform_device *pdev)
 	struct mci_platform_data	*pdata;
 	struct atmel_mci		*host;
 	struct resource			*regs;
+	struct regulator		*reg_vmmc;
 	unsigned int			nr_slots;
 	int				irq;
 	int				ret;
@@ -2371,6 +2373,16 @@ static int __init atmci_probe(struct platform_device *pdev)
 		}
 	}
 
+	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
+	if (!IS_ERR(reg_vmmc)) {
+		ret = regulator_enable(reg_vmmc);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable vmmc regulator: %d\n", ret);
+			return ret;
+		}
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
1.8.1.2

