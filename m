From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci-esdhc-imx: add missing inclusion of linux/module.h
Date: Mon, 15 Aug 2011 10:28:18 +0800
Message-ID: <1313375298-18546-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:65001 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab1HOCOo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Aug 2011 22:14:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

There are following warning and error when compiling the driver.
The patch adds the missing inclusion of linux/module.h to fix them.

drivers/mmc/host/sdhci-esdhc-imx.c:87:1: warning: data definition has n=
o type or storage class
drivers/mmc/host/sdhci-esdhc-imx.c:87:1: warning: type defaults to =E2=80=
=98int=E2=80=99 in declaration of =E2=80=98MODULE_DEVICE_TABLE=E2=80=99
drivers/mmc/host/sdhci-esdhc-imx.c:87:1: warning: parameter names (with=
out types) in function declaration
drivers/mmc/host/sdhci-esdhc-imx.c:96:1: warning: data definition has n=
o type or storage class
drivers/mmc/host/sdhci-esdhc-imx.c:96:1: warning: type defaults to =E2=80=
=98int=E2=80=99 in declaration of =E2=80=98MODULE_DEVICE_TABLE=E2=80=99
drivers/mmc/host/sdhci-esdhc-imx.c:96:1: warning: parameter names (with=
out types) in function declaration
drivers/mmc/host/sdhci-esdhc-imx.c:563:12: error: =E2=80=98THIS_MODULE=E2=
=80=99 undeclared here (not in a function)
drivers/mmc/host/sdhci-esdhc-imx.c:587:20: error: expected declaration =
specifiers or =E2=80=98...=E2=80=99 before string constant
drivers/mmc/host/sdhci-esdhc-imx.c:587:1: warning: data definition has =
no type or storage class
drivers/mmc/host/sdhci-esdhc-imx.c:587:1: warning: type defaults to =E2=
=80=98int=E2=80=99 in declaration of =E2=80=98MODULE_DESCRIPTION=E2=80=99
drivers/mmc/host/sdhci-esdhc-imx.c:587:20: warning: function declaratio=
n isn=E2=80=99t a prototype
drivers/mmc/host/sdhci-esdhc-imx.c:588:15: error: expected declaration =
specifiers or =E2=80=98...=E2=80=99 before string constant
drivers/mmc/host/sdhci-esdhc-imx.c:588:1: warning: data definition has =
no type or storage class
drivers/mmc/host/sdhci-esdhc-imx.c:588:1: warning: type defaults to =E2=
=80=98int=E2=80=99 in declaration of =E2=80=98MODULE_AUTHOR=E2=80=99
drivers/mmc/host/sdhci-esdhc-imx.c:588:15: warning: function declaratio=
n isn=E2=80=99t a prototype
drivers/mmc/host/sdhci-esdhc-imx.c:589:16: error: expected declaration =
specifiers or =E2=80=98...=E2=80=99 before string constant
drivers/mmc/host/sdhci-esdhc-imx.c:589:1: warning: data definition has =
no type or storage class
drivers/mmc/host/sdhci-esdhc-imx.c:589:1: warning: type defaults to =E2=
=80=98int=E2=80=99 in declaration of =E2=80=98MODULE_LICENSE=E2=80=99
drivers/mmc/host/sdhci-esdhc-imx.c:589:16: warning: function declaratio=
n isn=E2=80=99t a prototype

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
---
Hi Stephen,

I spot this on linux-next-20110812.

Regards,
Shawn

 drivers/mmc/host/sdhci-esdhc-imx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-esdhc-imx.c
index 2a1ba84..4557aa1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
--=20
1.7.4.1

