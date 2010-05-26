From: akpm@linux-foundation.org
Subject: [patch 004/203] sdhci-pltfm: implement platform data passing
Date: Wed, 26 May 2010 14:41:55 -0700
Message-ID: <201005262141.o4QLftr3015315@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47064 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753517Ab0EZVmz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 17:42:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, ben@simtec.co.uk, david.vrabel@csr.com, linux-mmc@vger.kernel.org, pierre@ossman.eu, richard.rojfors@pelagicore.com

=46rom: Anton Vorontsov <avorontsov@ru.mvista.com>

This includes platform ops, quirks and (de)initialization callbacks.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Richard R=F6jfors <richard.rojfors@pelagicore.com>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-pltfm.c |   24 +++++++++++++++++----
 include/linux/sdhci-pltfm.h    |   35 +++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff -puN drivers/mmc/host/sdhci-pltfm.c~sdhci-pltfm-implement-platform=
-data-passing drivers/mmc/host/sdhci-pltfm.c
--- a/drivers/mmc/host/sdhci-pltfm.c~sdhci-pltfm-implement-platform-dat=
a-passing
+++ a/drivers/mmc/host/sdhci-pltfm.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/host.h>
=20
 #include <linux/io.h>
+#include <linux/sdhci-pltfm.h>
=20
 #include "sdhci.h"
=20
@@ -49,12 +50,11 @@ static struct sdhci_ops sdhci_pltfm_ops=20
=20
 static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 {
+	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	int ret;
=20
-	BUG_ON(pdev =3D=3D NULL);
-
 	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
 		ret =3D -ENOMEM;
@@ -76,7 +76,12 @@ static int __devinit sdhci_pltfm_probe(s
 	}
=20
 	host->hw_name =3D "platform";
-	host->ops =3D &sdhci_pltfm_ops;
+	if (pdata && pdata->ops)
+		host->ops =3D pdata->ops;
+	else
+		host->ops =3D &sdhci_pltfm_ops;
+	if (pdata)
+		host->quirks =3D pdata->quirks;
 	host->irq =3D platform_get_irq(pdev, 0);
=20
 	if (!request_mem_region(iomem->start, resource_size(iomem),
@@ -93,6 +98,12 @@ static int __devinit sdhci_pltfm_probe(s
 		goto err_remap;
 	}
=20
+	if (pdata && pdata->init) {
+		ret =3D pdata->init(host);
+		if (ret)
+			goto err_plat_init;
+	}
+
 	ret =3D sdhci_add_host(host);
 	if (ret)
 		goto err_add_host;
@@ -102,6 +113,9 @@ static int __devinit sdhci_pltfm_probe(s
 	return 0;
=20
 err_add_host:
+	if (pdata && pdata->exit)
+		pdata->exit(host);
+err_plat_init:
 	iounmap(host->ioaddr);
 err_remap:
 	release_mem_region(iomem->start, resource_size(iomem));
@@ -114,6 +128,7 @@ err:
=20
 static int __devexit sdhci_pltfm_remove(struct platform_device *pdev)
 {
+	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
 	struct sdhci_host *host =3D platform_get_drvdata(pdev);
 	struct resource *iomem =3D platform_get_resource(pdev, IORESOURCE_MEM=
, 0);
 	int dead;
@@ -125,6 +140,8 @@ static int __devexit sdhci_pltfm_remove(
 		dead =3D 1;
=20
 	sdhci_remove_host(host, dead);
+	if (pdata && pdata->exit)
+		pdata->exit(host);
 	iounmap(host->ioaddr);
 	release_mem_region(iomem->start, resource_size(iomem));
 	sdhci_free_host(host);
@@ -165,4 +182,3 @@ MODULE_DESCRIPTION("Secure Digital Host=20
 MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:sdhci");
-
diff -puN /dev/null include/linux/sdhci-pltfm.h
--- /dev/null
+++ a/include/linux/sdhci-pltfm.h
@@ -0,0 +1,35 @@
+/*
+ * Platform data declarations for the sdhci-pltfm driver.
+ *
+ * Copyright (c) 2010 MontaVista Software, LLC.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or (=
at
+ * your option) any later version.
+ */
+
+#ifndef _SDHCI_PLTFM_H
+#define _SDHCI_PLTFM_H
+
+struct sdhci_ops;
+struct sdhci_host;
+
+/**
+ * struct sdhci_pltfm_data - SDHCI platform-specific information & hoo=
ks
+ * @ops: optional pointer to the platform-provided SDHCI ops
+ * @quirks: optional SDHCI quirks
+ * @init: optional hook that is called during device probe, before the
+ *        driver tries to access any SDHCI registers
+ * @exit: optional hook that is called during device removal
+ */
+struct sdhci_pltfm_data {
+	struct sdhci_ops *ops;
+	unsigned int quirks;
+	int (*init)(struct sdhci_host *host);
+	void (*exit)(struct sdhci_host *host);
+};
+
+#endif /* _SDHCI_PLTFM_H */
_
