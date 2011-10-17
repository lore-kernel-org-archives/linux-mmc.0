From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/5] arm/imx: remove mx31_setup_weimcs() from mx31.h
Date: Mon, 17 Oct 2011 14:15:06 +0800
Message-ID: <1318832110-29289-2-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64054 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab1JQGLY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 02:11:24 -0400
Received: by pzk36 with SMTP id 36so4653778pzk.1
        for <linux-mmc@vger.kernel.org>; Sun, 16 Oct 2011 23:11:24 -0700 (PDT)
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The helper function mx31_setup_weimcs() references IOMEM() and
IMX_IO_P2V() but without required header mach/hardware.h included
in mx31.h.  This will break the build of those mx31 based board file
with no direct inclusion of mach/hardware.h, or when indirect inclusion
to mach/hardware.h breaks.

=46or example, when the inclusion of mach/hardware.h gets removed from
mach/gpio.h, we will see the following compile error.

  CC      arch/arm/mach-imx/mach-pcm037_eet.o
In file included from arch/arm/mach-imx/devices-imx31.h:9:0,
                 from arch/arm/mach-imx/mach-pcm037_eet.c:20:
arch/arm/plat-mxc/include/mach/mx31.h: In function =E2=80=98mx31_setup_=
weimcs=E2=80=99:
arch/arm/plat-mxc/include/mach/mx31.h:129:2: error: implicit declaratio=
n of function =E2=80=98IOMEM=E2=80=99
arch/arm/plat-mxc/include/mach/mx31.h:129:2: error: implicit declaratio=
n of function =E2=80=98IMX_IO_P2V=E2=80=99

This patch removes mx31_setup_weimcs() from mx31.h and makes it local
to mach-qong.c, which is the only user for this helper.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-qong.c         |    5 ++++-
 arch/arm/plat-mxc/include/mach/mx31.h |   14 --------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qon=
g.c
index 1c4822b..4ff5faf 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -190,7 +190,10 @@ static struct platform_device qong_nand_device =3D=
 {
 static void __init qong_init_nand_mtd(void)
 {
 	/* init CS */
-	mx31_setup_weimcs(3, 0x00004f00, 0x20013b31, 0x00020800);
+	__raw_writel(0x00004f00, MX31_IO_ADDRESS(MX31_WEIM_CSCRxU(3)));
+	__raw_writel(0x20013b31, MX31_IO_ADDRESS(MX31_WEIM_CSCRxL(3)));
+	__raw_writel(0x00020800, MX31_IO_ADDRESS(MX31_WEIM_CSCRxA(3)));
+
 	mxc_iomux_set_gpr(MUX_SDCTL_CSD1_SEL, true);
=20
 	/* enable pin */
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/=
include/mach/mx31.h
index 79e7fc0..e27619e 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -1,10 +1,6 @@
 #ifndef __MACH_MX31_H__
 #define __MACH_MX31_H__
=20
-#ifndef __ASSEMBLER__
-#include <linux/io.h>
-#endif
-
 /*
  * IRAM
  */
@@ -122,16 +118,6 @@
 #define MX31_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX31_IO_ADDRESS(x)		IOMEM(MX31_IO_P2V(x))
=20
-#ifndef __ASSEMBLER__
-static inline void mx31_setup_weimcs(size_t cs,
-		unsigned upper, unsigned lower, unsigned addional)
-{
-	__raw_writel(upper, MX31_IO_ADDRESS(MX31_WEIM_CSCRxU(cs)));
-	__raw_writel(lower, MX31_IO_ADDRESS(MX31_WEIM_CSCRxL(cs)));
-	__raw_writel(addional, MX31_IO_ADDRESS(MX31_WEIM_CSCRxA(cs)));
-}
-#endif
-
 #define MX31_INT_I2C3		3
 #define MX31_INT_I2C2		4
 #define MX31_INT_MPEG4_ENCODER	5
--=20
1.7.4.1

