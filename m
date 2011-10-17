From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 5/5] mmc: mxcmmc: explicitly includes mach/hardware.h
Date: Mon, 17 Oct 2011 14:15:10 +0800
Message-ID: <1318832110-29289-6-git-send-email-shawn.guo@linaro.org>
References: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43428 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1JQGM4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 02:12:56 -0400
Received: by pzk36 with SMTP id 36so4656382pzk.1
        for <linux-mmc@vger.kernel.org>; Sun, 16 Oct 2011 23:12:55 -0700 (PDT)
In-Reply-To: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

When indirect inclusion to <mach/hardware.h> via <mach/gpio.h> gets
removed, we will see the following compile error.

  CC      drivers/mmc/host/mxcmmc.o
drivers/mmc/host/mxcmmc.c: In function =E2=80=98mxcmci_init_card=E2=80=99=
:
drivers/mmc/host/mxcmmc.c:811:2: error: implicit declaration of functio=
n =E2=80=98cpu_is_mx3=E2=80=99

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxcmmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 14aa213..6632e38 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -40,6 +40,7 @@
 #include <mach/mmc.h>
=20
 #include <mach/dma.h>
+#include <mach/hardware.h>
=20
 #define DRIVER_NAME "mxc-mmc"
=20
--=20
1.7.4.1

