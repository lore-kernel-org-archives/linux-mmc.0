From: Saeed Bishara <saeed@marvell.com>
Subject: RE: [PATCH v3 1/2] MMC: add support for the Marvell Dove SDHCI
 controller
Date: Thu, 28 Oct 2010 14:28:40 +0200
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FE14774394D@IL-MB01.marvell.com>
References: <cover.1288268453.git.mike@compulab.co.il>
 <ea487c43c1aff1d07355e0e0699e739c8617b96f.1288268453.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35349 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754250Ab0J1M27 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Oct 2010 08:28:59 -0400
In-Reply-To: <ea487c43c1aff1d07355e0e0699e739c8617b96f.1288268453.git.mike@compulab.co.il>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>

 

>-----Original Message-----
>From: Mike Rapoport [mailto:mike@compulab.co.il] 
>Sent: Thursday, October 28, 2010 2:25 PM
>To: linux-mmc@vger.kernel.org
>Cc: linux-arm-kernel@lists.infradead.org; Chris Ball; Saeed 
>Bishara; Mike Rapoport
>Subject: [PATCH v3 1/2] MMC: add support for the Marvell Dove 
>SDHCI controller
>
>Implement an sdhci-pltfm driver for the controller found on Marvell
>Dove SoC
>
>Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>CC: Saeed Bishara <saeed@marvell.com>
>---
> drivers/mmc/host/Kconfig       |   13 +++++++
> drivers/mmc/host/Makefile      |    1 +
> drivers/mmc/host/sdhci-dove.c  |   70 
>++++++++++++++++++++++++++++++++++++++++
> drivers/mmc/host/sdhci-pltfm.c |    3 ++
> drivers/mmc/host/sdhci-pltfm.h |    1 +
> 5 files changed, 88 insertions(+), 0 deletions(-)
> create mode 100644 drivers/mmc/host/sdhci-dove.c
>
>diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>index 68d1279..4958839 100644
>--- a/drivers/mmc/host/Kconfig
>+++ b/drivers/mmc/host/Kconfig
>@@ -130,6 +130,19 @@ config MMC_SDHCI_CNS3XXX
> 
> 	  If unsure, say N.
> 
>+config MMC_SDHCI_DOVE
>+	bool "SDHCI support on Marvell's Dove SoC"
>+	depends on ARCH_DOVE
>+	depends on MMC_SDHCI_PLTFM
>+	select MMC_SDHCI_IO_ACCESSORS
>+	help
>+	  This selects the Secure Digital Host Controller Interface in
>+	  Marvell's Dove SoC.
>+
>+	  If you have a controller with this interface, say Y or M here.
>+
>+	  If unsure, say N.
>+
> config MMC_SDHCI_S3C
> 	tristate "SDHCI support on Samsung S3C SoC"
> 	depends on MMC_SDHCI && PLAT_SAMSUNG
>diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>index 840bcb5..9e1c418 100644
>--- a/drivers/mmc/host/Makefile
>+++ b/drivers/mmc/host/Makefile
>@@ -40,6 +40,7 @@ obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
> obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
> sdhci-platform-y				:= sdhci-pltfm.o
> sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
>+sdhci-platform-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
> 
> obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
> sdhci-of-y				:= sdhci-of-core.o
>diff --git a/drivers/mmc/host/sdhci-dove.c 
>b/drivers/mmc/host/sdhci-dove.c
>new file mode 100644
>index 0000000..561167c
>--- /dev/null
>+++ b/drivers/mmc/host/sdhci-dove.c
>@@ -0,0 +1,70 @@
>+/*
>+ * sdhci-dove.c Support for SDHCI on Marvell's Dove SoC
>+ *
>+ * Author: Saeed Bishara <saeed@marvell.com>
>+ *	   Mike Rapoport <mike@compulab.co.il>
>+ * Based on  sdhci-cns3xxx.c
>+ *
>+ * This program is free software; you can redistribute it 
>and/or modify
>+ * it under the terms of the GNU General Public License version 2 as
>+ * published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, write to the Free Software
>+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>+ */
>+
>+#include <linux/io.h>
>+#include <linux/mmc/host.h>
>+
>+#include "sdhci.h"
>+#include "sdhci-pltfm.h"
>+
>+static u16 sdhci_dove_readw(struct sdhci_host *host, int reg)
>+{
>+	u16 ret;
>+
>+	switch (reg) {
>+	case SDHCI_HOST_VERSION:
>+	case SDHCI_SLOT_INT_STATUS:
>+		/* those registers don't exist */
>+		return 0;
>+	default:
>+		ret = readw(host->ioaddr + reg);
>+	}
>+	return ret;
>+}
>+
>+static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
>+{
>+	u32 ret;
>+
>+	switch (reg) {
>+	case SDHCI_CAPABILITIES:
>+		ret = readl(host->ioaddr + reg);
>+		/* Mask the support for 3.0V */
>+		ret &= ~SDHCI_CAN_VDD_300;
>+		break;
>+	default:
>+		ret = readl(host->ioaddr + reg);
>+	}
>+	return ret;
>+}
>+
>+static struct sdhci_ops sdhci_dove_ops = {
>+	.read_w	= sdhci_dove_readw,
>+	.read_l	= sdhci_dove_readl,
>+};
>+
>+struct sdhci_pltfm_data sdhci_dove_pdata = {
>+	.ops	= &sdhci_dove_ops,
>+	.quirks	= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
>+		  SDHCI_QUIRK_NO_BUSY_IRQ |
>+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
>+		  SDHCI_QUIRK_FORCE_DMA,
>+};
>diff --git a/drivers/mmc/host/sdhci-pltfm.c 
>b/drivers/mmc/host/sdhci-pltfm.c
>index e045e3c..28d818e 100644
>--- a/drivers/mmc/host/sdhci-pltfm.c
>+++ b/drivers/mmc/host/sdhci-pltfm.c
>@@ -161,6 +161,9 @@ static const struct platform_device_id 
>sdhci_pltfm_ids[] = {
> #ifdef CONFIG_MMC_SDHCI_CNS3XXX
> 	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
> #endif
>+#ifdef CONFIG_MMC_SDHCI_DOVE
>+	{ "sdhci-dove", (kernel_ulong_t)&sdhci_dove_pdata },
>+#endif
> 	{ },
> };
> MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
>diff --git a/drivers/mmc/host/sdhci-pltfm.h 
>b/drivers/mmc/host/sdhci-pltfm.h
>index 900f329..718d837 100644
>--- a/drivers/mmc/host/sdhci-pltfm.h
>+++ b/drivers/mmc/host/sdhci-pltfm.h
>@@ -14,5 +14,6 @@
> #include <linux/sdhci-pltfm.h>
> 
> extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
>+extern struct sdhci_pltfm_data sdhci_dove_pdata;
> 
> #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
>-- 
>1.7.3.1
>
>
Looks fine to me