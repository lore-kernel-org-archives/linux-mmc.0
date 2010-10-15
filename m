From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Fri, 15 Oct 2010 12:21:04 +0200
Message-ID: <1287138064-21385-7-git-send-email-w.sang@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58922 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab0JOKVU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Oct 2010 06:21:20 -0400
In-Reply-To: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

This driver adds basic support for the esdhc-core found on e.g.
imx35/51. It adds up to the pltfm-core.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
Tested-by : Eric B=C3=A9nard <eric@eukrea.com>
---

Change since last version:

* Add Kconfig dependency for imx-archs

 drivers/mmc/host/Kconfig           |   10 +++
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c |  143 ++++++++++++++++++++++++++++=
++++++++
 drivers/mmc/host/sdhci-pltfm.c     |    3 +
 drivers/mmc/host/sdhci-pltfm.h     |    1 +
 5 files changed, 158 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0b7024a..c9c2520 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -130,6 +130,16 @@ config MMC_SDHCI_CNS3XXX
=20
 	  If unsure, say N.
=20
+config MMC_SDHCI_ESDHC_IMX
+	bool "SDHCI platform support for the Freescale eSDHC i.MX controller"
+	depends on MMC_SDHCI_PLTFM && (ARCH_MX25 || ARCH_MX35 || ARCH_MX5)
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the Freescale eSDHC controller support on the platform
+	  bus, found on platforms like mx35/51.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
 	depends on MMC_SDHCI && PLAT_SAMSUNG
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index eae5d62..6c4ac67 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_MMC_USHC)		+=3D ushc.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)			+=3D sdhci-platform.o
 sdhci-platform-y				:=3D sdhci-pltfm.o
 sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+=3D sdhci-cns3xxx.o
+sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+=3D sdhci-esdhc-imx.o
=20
 obj-$(CONFIG_MMC_SDHCI_OF)	+=3D sdhci-of.o
 sdhci-of-y				:=3D sdhci-of-core.o
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
new file mode 100644
index 0000000..2e9cca1
--- /dev/null
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -0,0 +1,143 @@
+/*
+ * Freescale eSDHC i.MX controller driver for the platform bus.
+ *
+ * derived from the OF-version.
+ *
+ * Copyright (c) 2010 Pengutronix e.K.
+ *   Author: Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License.
+ */
+
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdhci-pltfm.h>
+#include "sdhci.h"
+#include "sdhci-pltfm.h"
+#include "sdhci-esdhc.h"
+
+static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, =
u32 val, int reg)
+{
+	void __iomem *base =3D host->ioaddr + (reg & ~0x3);
+	u32 shift =3D (reg & 0x3) * 8;
+
+	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
+}
+
+static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
+{
+	if (unlikely(reg =3D=3D SDHCI_HOST_VERSION))
+		reg ^=3D 2;
+
+	return readw(host->ioaddr + reg);
+}
+
+static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+
+	switch (reg) {
+	case SDHCI_TRANSFER_MODE:
+		/*
+		 * Postpone this write, we must do it together with a
+		 * command write that is down below.
+		 */
+		pltfm_host->scratchpad =3D val;
+		return;
+	case SDHCI_COMMAND:
+		writel(val << 16 | pltfm_host->scratchpad,
+			host->ioaddr + SDHCI_TRANSFER_MODE);
+		return;
+	case SDHCI_BLOCK_SIZE:
+		val &=3D ~SDHCI_MAKE_BLKSZ(0x7, 0);
+		break;
+	}
+	esdhc_clrset_le(host, 0xffff, val, reg);
+}
+
+static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
+{
+	u32 new_val;
+
+	switch (reg) {
+	case SDHCI_POWER_CONTROL:
+		/*
+		 * FSL put some DMA bits here
+		 * If your board has a regulator, code should be here
+		 */
+		return;
+	case SDHCI_HOST_CONTROL:
+		/* FSL messed up here, so we can just keep those two */
+		new_val =3D val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
+		/* ensure the endianess */
+		new_val |=3D ESDHC_HOST_CONTROL_LE;
+		/* DMA mode bits are shifted */
+		new_val |=3D (val & SDHCI_CTRL_DMA_MASK) << 5;
+
+		esdhc_clrset_le(host, 0xffff, new_val, reg);
+		return;
+	}
+	esdhc_clrset_le(host, 0xff, val, reg);
+}
+
+static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk);
+}
+
+static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+
+	return clk_get_rate(pltfm_host->clk) / 256 / 16;
+}
+
+static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltf=
m_data *pdata)
+{
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct clk *clk;
+
+	clk =3D clk_get(mmc_dev(host->mmc), NULL);
+	if (IS_ERR(clk)) {
+		dev_err(mmc_dev(host->mmc), "clk err\n");
+		return PTR_ERR(clk);
+	}
+	clk_enable(clk);
+	pltfm_host->clk =3D clk;
+
+	return 0;
+}
+
+static void esdhc_pltfm_exit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+
+	clk_disable(pltfm_host->clk);
+	clk_put(pltfm_host->clk);
+}
+
+static struct sdhci_ops sdhci_esdhc_ops =3D {
+	.read_w =3D esdhc_readw_le,
+	.write_w =3D esdhc_writew_le,
+	.write_b =3D esdhc_writeb_le,
+	.set_clock =3D esdhc_set_clock,
+	.get_max_clock =3D esdhc_pltfm_get_max_clock,
+	.get_min_clock =3D esdhc_pltfm_get_min_clock,
+};
+
+struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D {
+	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_MULTIBLOCK
+			| SDHCI_QUIRK_BROKEN_ADMA,
+	/* ADMA has issues. Might be fixable */
+	/* NO_MULTIBLOCK might be MX35 only (Errata: ENGcm07207) */
+	.ops =3D &sdhci_esdhc_ops,
+	.init =3D esdhc_pltfm_init,
+	.exit =3D esdhc_pltfm_exit,
+};
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pl=
tfm.c
index 00e8a8a..0502f89 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -167,6 +167,9 @@ static const struct platform_device_id sdhci_pltfm_=
ids[] =3D {
 #ifdef CONFIG_MMC_SDHCI_CNS3XXX
 	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
 #endif
+#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
+	{ "sdhci-esdhc-imx", (kernel_ulong_t)&sdhci_esdhc_imx_pdata },
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pl=
tfm.h
index 562b929..c1bfe48 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -21,5 +21,6 @@ struct sdhci_pltfm_host {
 };
=20
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
+extern struct sdhci_pltfm_data sdhci_esdhc_imx_pdata;
=20
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
--=20
1.7.1

