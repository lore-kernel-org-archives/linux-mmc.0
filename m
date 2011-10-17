From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 4/5] arm/imx: explicitly includes mach/hardware.h in pm-imx27.c
Date: Mon, 17 Oct 2011 14:15:09 +0800
Message-ID: <1318832110-29289-5-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57030 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1JQGMd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 02:12:33 -0400
Received: by yxp4 with SMTP id 4so3355962yxp.5
        for <linux-mmc@vger.kernel.org>; Sun, 16 Oct 2011 23:12:33 -0700 (PDT)
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The pm-imx27.c references a number of things requiring the explicit
inclusion of mach/hardware.h.  Otherwise, when indirect inclusion
to mach/hardware.h gets cleaned up, we will see the following
compile error.

  CC      arch/arm/mach-imx/pm-imx27.o
arch/arm/mach-imx/pm-imx27.c: In function =E2=80=98mx27_suspend_enter=E2=
=80=99:
arch/arm/mach-imx/pm-imx27.c:22:3: error: implicit declaration of funct=
ion =E2=80=98IOMEM=E2=80=99
arch/arm/mach-imx/pm-imx27.c:22:3: error: implicit declaration of funct=
ion =E2=80=98IMX_IO_P2V=E2=80=99
arch/arm/mach-imx/pm-imx27.c: In function =E2=80=98mx27_pm_init=E2=80=99=
:
arch/arm/mach-imx/pm-imx27.c:42:2: error: implicit declaration of funct=
ion =E2=80=98cpu_is_mx27=E2=80=99

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/pm-imx27.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.=
c
index acf1769..e455d2f 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -11,7 +11,7 @@
 #include <linux/suspend.h>
 #include <linux/io.h>
 #include <mach/system.h>
-#include <mach/mx27.h>
+#include <mach/hardware.h>
=20
 static int mx27_suspend_enter(suspend_state_t state)
 {
--=20
1.7.4.1

