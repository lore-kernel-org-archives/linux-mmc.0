From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 07/12] clk: sunxi: Move mod0 clock to a file of its own
Date: Thu, 11 Sep 2014 22:18:21 +0200
Message-ID: <1410466706-27386-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49762 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756911AbaIKUWn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Sep 2014 16:22:43 -0400
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Since we know have the ability to declare factors clock outside of clk-=
sunxi,
create a new mod0 driver to deal with the mod0 clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/Makefile    |  1 +
 drivers/clk/sunxi/clk-mod0.c  | 82 +++++++++++++++++++++++++++++++++++=
++++++++
 drivers/clk/sunxi/clk-sunxi.c |  1 -
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi/clk-mod0.c

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 6850cba35871..833f086d4a52 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -5,6 +5,7 @@
 obj-y +=3D clk-sunxi.o clk-factors.o
 obj-y +=3D clk-a10-hosc.o
 obj-y +=3D clk-a20-gmac.o
+obj-y +=3D clk-mod0.o
=20
 obj-$(CONFIG_MFD_SUN6I_PRCM) +=3D \
 	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.=
c
new file mode 100644
index 000000000000..bce09a84ab4f
--- /dev/null
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright 2013 Emilio L=C3=B3pez
+ *
+ * Emilio L=C3=B3pez <emilio@elopez.com.ar>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+#include "clk-factors.h"
+
+/**
+ * sun4i_get_mod0_factors() - calculates m, n factors for MOD0-style c=
locks
+ * MOD0 rate is calculated as follows
+ * rate =3D (parent_rate >> p) / (m + 1);
+ */
+
+static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div, calcm, calcp;
+
+	/* These clocks can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency */
+	if (*freq > parent_rate)
+		*freq =3D parent_rate;
+
+	div =3D DIV_ROUND_UP(parent_rate, *freq);
+
+	if (div < 16)
+		calcp =3D 0;
+	else if (div / 2 < 16)
+		calcp =3D 1;
+	else if (div / 4 < 16)
+		calcp =3D 2;
+	else
+		calcp =3D 3;
+
+	calcm =3D DIV_ROUND_UP(div, 1 << calcp);
+
+	*freq =3D (parent_rate >> calcp) / calcm;
+
+	/* we were called to round the frequency, we can now return */
+	if (n =3D=3D NULL)
+		return;
+
+	*m =3D calcm - 1;
+	*p =3D calcp;
+}
+
+/* user manual says "n" but it's really "p" */
+static struct clk_factors_config sun4i_a10_mod0_config =3D {
+	.mshift =3D 0,
+	.mwidth =3D 4,
+	.pshift =3D 16,
+	.pwidth =3D 2,
+};
+
+static const struct factors_data sun4i_a10_mod0_data __initconst =3D {
+	.enable =3D 31,
+	.mux =3D 24,
+	.table =3D &sun4i_a10_mod0_config,
+	.getter =3D sun4i_a10_get_mod0_factors,
+};
+
+static DEFINE_SPINLOCK(sun4i_a10_mod0_lock);
+
+static void __init sun4i_a10_mod0_setup(struct device_node *node)
+{
+	sunxi_factors_register(node, &sun4i_a10_mod0_data, &sun4i_a10_mod0_lo=
ck);
+}
+CLK_OF_DECLARE(sun4i_a10_mod0, "allwinner,sun4i-a10-mod0-clk", sun4i_a=
10_mod0_setup);
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunx=
i.c
index a3d8c633c2d6..6eec82b29bb4 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1111,7 +1111,6 @@ static const struct of_device_id clk_factors_matc=
h[] __initconst =3D {
 	{.compatible =3D "allwinner,sun6i-a31-pll6-clk", .data =3D &sun6i_a31=
_pll6_data,},
 	{.compatible =3D "allwinner,sun4i-a10-apb1-clk", .data =3D &sun4i_apb=
1_data,},
 	{.compatible =3D "allwinner,sun5i-a13-mbus-clk", .data =3D &sun4i_mod=
0_data,},
-	{.compatible =3D "allwinner,sun4i-a10-mod0-clk", .data =3D &sun4i_mod=
0_data,},
 	{.compatible =3D "allwinner,sun7i-a20-out-clk", .data =3D &sun7i_a20_=
out_data,},
 	{}
 };
--=20
2.1.0

