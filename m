From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V3 10/10] ARM: Kirkwood: add DT support for Sheevaplug and Sheevaplug eSATA
Date: Tue, 21 May 2013 01:01:51 +0200
Message-ID: <1369090911-1479-11-git-send-email-gmbnomis@gmail.com>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:9349 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757094Ab3ETXCq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2013 19:02:46 -0400
In-Reply-To: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/mach-kirkwood/Kconfig            |    7 +++++++
 arch/arm/mach-kirkwood/Makefile           |    1 +
 arch/arm/mach-kirkwood/board-dt.c         |    4 ++++
 arch/arm/mach-kirkwood/board-sheevaplug.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h           |    5 +++++
 5 files changed, 44 insertions(+)
 create mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7509a89..58518a2 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -296,6 +296,13 @@ config MACH_READYNAS_DT
 	  Say 'Y' here if you want your kernel to support the
 	  NETGEAR ReadyNAS Duo v2 using Fattened Device Tree.
 
+config MACH_SHEEVAPLUG_DT
+	bool "Marvell (eSATA) SheevaPlug (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell (eSATA) SheevaPlug (Flattened Device Tree).
+
 config MACH_TOPKICK_DT
 	bool "USI Topkick (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index e1f3735..8846abf 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -40,5 +40,6 @@ obj-$(CONFIG_MACH_NETSPACE_V2_DT)	+= board-ns2.o
 obj-$(CONFIG_MACH_NSA310_DT)		+= board-nsa310.o
 obj-$(CONFIG_MACH_OPENBLOCKS_A6_DT)	+= board-openblocks_a6.o
 obj-$(CONFIG_MACH_READYNAS_DT)		+= board-readynas.o
+obj-$(CONFIG_MACH_SHEEVAPLUG_DT)	+= board-sheevaplug.o
 obj-$(CONFIG_MACH_TOPKICK_DT)		+= board-usi_topkick.o
 obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e9647b8..a09dbac 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -112,6 +112,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("globalscale,guruplug"))
 		guruplug_dt_init();
 
+	if (of_machine_is_compatible("globalscale,sheevaplug"))
+		sheevaplug_dt_init();
+
 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
 		dnskw_init();
 
@@ -165,6 +168,7 @@ static void __init kirkwood_dt_init(void)
 static const char * const kirkwood_dt_board_compat[] = {
 	"globalscale,dreamplug",
 	"globalscale,guruplug",
+	"globalscale,sheevaplug",
 	"dlink,dns-320",
 	"dlink,dns-325",
 	"iom,iconnect",
diff --git a/arch/arm/mach-kirkwood/board-sheevaplug.c b/arch/arm/mach-kirkwood/board-sheevaplug.c
new file mode 100644
index 0000000..fa38937
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-sheevaplug.c
@@ -0,0 +1,27 @@
+/*
+ * arch/arm/mach-kirkwood/board-sheevaplug.c
+ *
+ * Marvell Sheevaplug Reference Board Init for drivers not converted to
+ * flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mv643xx_eth.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data sheevaplug_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+void __init sheevaplug_dt_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_ge00_init(&sheevaplug_ge00_data);
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 21da3b1..974442e 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -65,6 +65,11 @@ void guruplug_dt_init(void);
 #else
 static inline void guruplug_dt_init(void) {};
 #endif
+#ifdef CONFIG_MACH_SHEEVAPLUG_DT
+void sheevaplug_dt_init(void);
+#else
+static inline void sheevaplug_dt_init(void) {};
+#endif
 #ifdef CONFIG_MACH_TS219_DT
 void qnap_dt_ts219_init(void);
 #else
-- 
1.7.9.5

