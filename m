From: Alistair Popple <alistair@popple.id.au>
Subject: =?UTF-8?q?=5BPATCH=202/7=5D=20IBM=20Akebono=3A=20Add=20a=20SDHCI=20platform=20driver?=
Date: Tue,  5 Nov 2013 16:31:06 +1100
Message-ID: <1383629471-16979-2-git-send-email-alistair@popple.id.au>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:36262 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309Ab3KEFbn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Nov 2013 00:31:43 -0500
In-Reply-To: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

This patch adds a SDHCI platform driver for the new IBM Akebono board.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/Kconfig            |   12 +++++++
 drivers/mmc/host/Makefile           |    1 +
 drivers/mmc/host/sdhci-of-akebono.c |   60 +++++++++++++++++++++++++++=
++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-akebono.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..d7a1414 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -130,6 +130,18 @@ config MMC_SDHCI_OF_HLWD
=20
 	  If unsure, say N.
=20
+config MMC_SDHCI_OF_AKEBONO
+	tristate "SDHCI OF support for the IBM Akebono board"
+	depends on MMC_SDHCI_PLTFM
+	depends on PPC_OF
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  found on the Akebono 476FP SoC.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_CNS3XXX
 	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
 	depends on ARCH_CNS3XXX
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index c41d0c3..ea7e757 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+=3D sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+=3D sdhci-tegra.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+=3D sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+=3D sdhci-of-hlwd.o
+obj-$(CONFIG_MMC_SDHCI_OF_AKEBONO)	+=3D sdhci-of-akebono.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+=3D sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+=3D sdhci-bcm2835.o
=20
diff --git a/drivers/mmc/host/sdhci-of-akebono.c b/drivers/mmc/host/sdh=
ci-of-akebono.c
new file mode 100644
index 0000000..20041c1
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-akebono.c
@@ -0,0 +1,60 @@
+/*
+ * drivers/mmc/host/sdhci-of-akebono.c
+ *
+ * Copyright =C2=A9 2013 Alistair Popple <alistair@popple.id.au> IBM C=
orporation
+ *
+ * Based on sdhci-of-hlwd.c
+ *
+ * Copyright (C) 2009 The GameCube Linux Team
+ * Copyright (C) 2009 Albert Herranz
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
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mmc/host.h>
+#include "sdhci-pltfm.h"
+
+static const struct sdhci_ops sdhci_akebono_ops =3D {
+};
+
+static const struct sdhci_pltfm_data sdhci_akebono_pdata =3D {
+	.ops =3D &sdhci_akebono_ops,
+};
+
+static int sdhci_akebono_probe(struct platform_device *pdev)
+{
+	return sdhci_pltfm_register(pdev, &sdhci_akebono_pdata, 0);
+}
+
+static int sdhci_akebono_remove(struct platform_device *pdev)
+{
+	return sdhci_pltfm_unregister(pdev);
+}
+
+static const struct of_device_id sdhci_akebono_of_match[] =3D {
+	{ .compatible =3D "ibm,akebono-sdhci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_akebono_of_match);
+
+static struct platform_driver sdhci_akebono_driver =3D {
+	.driver =3D {
+		.name =3D "sdhci-akebono",
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D sdhci_akebono_of_match,
+		.pm =3D SDHCI_PLTFM_PMOPS,
+	},
+	.probe =3D sdhci_akebono_probe,
+	.remove =3D sdhci_akebono_remove,
+};
+
+module_platform_driver(sdhci_akebono_driver);
+
+MODULE_DESCRIPTION("Akebono SDHCI OF driver");
+MODULE_AUTHOR("Alistair Popple");
+MODULE_LICENSE("GPL v2");
--=20
1.7.10.4

