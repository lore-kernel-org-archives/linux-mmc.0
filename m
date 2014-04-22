From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 02/17] clk: sunxi: Implement MMC phase control
Date: Tue, 22 Apr 2014 13:01:22 +0200
Message-ID: <1398164497-14212-3-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBIUY3GNAKGQEQBUKN3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>

HdG: add header exporting clk_sunxi_mmc_phase_control

Signed-off-by: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/clk/sunxi.h     | 22 ++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 include/linux/clk/sunxi.h

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index bd7dc73..7ee5eff 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -507,6 +507,41 @@ CLK_OF_DECLARE(sun7i_a20_gmac, "allwinner,sun7i-a20-gm=
ac-clk",
=20
=20
 /**
+ * clk_sunxi_mmc_phase_control() - configures MMC clock phase control
+ */
+
+void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output)
+{
+	#define to_clk_composite(_hw) container_of(_hw, struct clk_composite, hw)
+	#define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
+
+	struct clk_composite *composite =3D to_clk_composite(hw);
+	struct clk_hw *rate_hw =3D composite->rate_hw;
+	struct clk_factors *factors =3D to_clk_factors(rate_hw);
+	unsigned long flags =3D 0;
+	u32 reg;
+
+	if (factors->lock)
+		spin_lock_irqsave(factors->lock, flags);
+
+	reg =3D readl(factors->reg);
+
+	/* set sample clock phase control */
+	reg &=3D ~(0x7 << 20);
+	reg |=3D ((sample & 0x7) << 20);
+
+	/* set output clock phase control */
+	reg &=3D ~(0x7 << 8);
+	reg |=3D ((output & 0x7) << 8);
+
+	writel(reg, factors->reg);
+
+	if (factors->lock)
+		spin_unlock_irqrestore(factors->lock, flags);
+}
+
+
+/**
  * sunxi_factors_clk_setup() - Setup function for factor clocks
  */
=20
diff --git a/include/linux/clk/sunxi.h b/include/linux/clk/sunxi.h
new file mode 100644
index 0000000..1ef5c89
--- /dev/null
+++ b/include/linux/clk/sunxi.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2013 - Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_CLK_SUNXI_H_
+#define __LINUX_CLK_SUNXI_H_
+
+#include <linux/clk.h>
+
+void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output);
+
+#endif
--=20
1.9.0

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
