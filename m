From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/5] drivers: mmc: sunxi: limit A64 MMC2 to 8K
 DMA buffer
Date: Mon,  2 Jan 2017 23:03:43 +0000
Message-ID: <1483398226-29321-3-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBZNYVPBQKGQELKPVA6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1483398226-29321-1-git-send-email-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Unlike the A64 user manual reports, the third MMC controller on the
A64 (and the only one capable of 8-bit HS400 eMMC transfers) has a
DMA buffer size limit of 8KB (much like the very old Allwinner SoCs).
This does not affect the other two controllers, so introduce a new
DT compatible string to let the driver use different settings for that
particular device. This will also help to enable the high-speed transfer
modes of that controller later.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
 drivers/mmc/host/sunxi-mmc.c                        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 55cdd80..3d9170f 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -14,6 +14,7 @@ Required properties:
    * "allwinner,sun7i-a20-mmc"
    * "allwinner,sun9i-a80-mmc"
    * "allwinner,sun50i-a64-mmc"
+   * "allwinner,sun50i-a64-emmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 1e156e8..165486bc 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1097,12 +1097,19 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.can_calibrate = true,
 };
 
+static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
+	.idma_des_size_bits = 13,
+	.clk_delays = sun50i_mmc_clk_delays,
+	.can_calibrate = true,
+};
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
 	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
2.8.2
