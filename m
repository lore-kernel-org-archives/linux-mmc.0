From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/5] arm/imx: explicitly includes mach/hardware.h in mach-kzm_arm11_01.c
Date: Mon, 17 Oct 2011 14:15:07 +0800
Message-ID: <1318832110-29289-3-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39479 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1JQGLo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 02:11:44 -0400
Received: by gyb13 with SMTP id 13so2641603gyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 16 Oct 2011 23:11:43 -0700 (PDT)
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The mach-kzm_arm11_01.c references a number of things requiring the
explicit inclusion of mach/hardware.h.  Otherwise, when indirect
inclusion to mach/hardware.h gets cleaned up, we will see the following
compile error.

  CC      arch/arm/mach-imx/mach-kzm_arm11_01.o
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:3: error: implicit declaration=
 of function =E2=80=98IOMEM=E2=80=99
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:3: error: implicit declaration=
 of function =E2=80=98IMX_IO_P2V_MODULE=E2=80=99
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:14: error: =E2=80=98MX31_CS4=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:14: error: =E2=80=98MX31_CS5=E2=
=80=99 undeclared here (not in a function)
arch/arm/mach-imx/mach-kzm_arm11_01.c:71:3: error: implicit declaration=
 of function =E2=80=98IMX_IO_P2V=E2=80=99

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-kzm_arm11_01.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/=
mach-kzm_arm11_01.c
index 4288e8f..5f37f89 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -36,6 +36,7 @@
=20
 #include <mach/clock.h>
 #include <mach/common.h>
+#include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
=20
 #include "devices-imx31.h"
--=20
1.7.4.1

