From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 1/7] pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
Date: Fri, 19 Feb 2016 21:16:37 +0100
Message-ID: <1455913003-6140-2-git-send-email-wsa@the-dreams.de>
References: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

All the SHDIs can operate with either 3.3V or 1.8V signals, depending
on negotiation with the card.

Implement the {get,set}_io_voltage operations and set the related
capability flag for the associated pins.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulrich Hecht <ulrich.hecht@gmail.com>
---

The get/set-functions introduced here are the same for all Gen2, except for
the pin-sanity checks at the beginning. Somehow a generic function might be
nice for consistency reasons (I don't care so much about the code savings).
But not sure if it is worth the hazzle.

@Uli, Geert: Since bias support is probably similar, what do you think? Does
it make sense to add gen{2,3}.c?


 drivers/pinctrl/sh-pfc/core.c        |  2 +-
 drivers/pinctrl/sh-pfc/core.h        |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 60 +++++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 181ea98a63b7ab..315f9db9f5affe 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -88,7 +88,7 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
 	return 0;
 }
 
-static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
+void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
 {
 	struct sh_pfc_window *window;
 	phys_addr_t address = reg;
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 62f53b22ae8500..ca041a753a2521 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -59,6 +59,7 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
 int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
 
+void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 address);
 u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
 void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
 			  u32 data);
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 0f4d48f9400ba0..ed51d67609050d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -21,16 +21,21 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/io.h>
 #include <linux/kernel.h>
 
 #include "core.h"
 #include "sh_pfc.h"
 
+/*
+ * All pins assigned to GPIO bank 3 can be used for SD interfaces in
+ * which case they support both 3.3V and 1.8V signalling.
+ */
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_30(1, fn, sfx),						\
 	PORT_GP_30(2, fn, sfx),						\
-	PORT_GP_32(3, fn, sfx),						\
+	PORT_GP_CFG_32(3, fn, sfx, SH_PFC_PIN_CFG_IO_VOLTAGE),		\
 	PORT_GP_32(4, fn, sfx),						\
 	PORT_GP_32(5, fn, sfx)
 
@@ -4691,6 +4696,53 @@ static const char * const vin3_groups[] = {
 	"vin3_clk",
 };
 
+#define IOCTRL6 0xe606008c
+
+static int r8a7790_get_io_voltage(struct sh_pfc *pfc, unsigned int pin)
+{
+	void __iomem *reg;
+	u32 data, mask;
+
+	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31), "invalid pin %#x", pin))
+		return -EINVAL;
+
+	reg = sh_pfc_phys_to_virt(pfc, IOCTRL6);
+	data = ioread32(reg);
+
+	/* Bits in IOCTRL6 are numbered in opposite order to pins */
+	mask = 0x80000000 >> (pin & 0x1f);
+
+	return (data & mask) ? 3300 : 1800;
+}
+
+static int r8a7790_set_io_voltage(struct sh_pfc *pfc, unsigned int pin, u16 mV)
+{
+	void __iomem *reg;
+	u32 data, mask;
+
+	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31), "invalid pin %#x", pin))
+		return -EINVAL;
+
+	if (mV != 1800 && mV != 3300)
+		return -EINVAL;
+
+	reg = sh_pfc_phys_to_virt(pfc, IOCTRL6);
+	data = ioread32(reg);
+
+	/* Bits in IOCTRL6 are numbered in opposite order to pins */
+	mask = 0x80000000 >> (pin & 0x1f);
+
+	if (mV == 3300)
+		data |= mask;
+	else
+		data &= ~mask;
+
+	iowrite32(~data, sh_pfc_phys_to_virt(pfc, pfc->info->unlock_reg));
+	iowrite32(data, reg);
+
+	return 0;
+}
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
@@ -5690,8 +5742,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+static const struct sh_pfc_soc_operations pinmux_ops = {
+	.get_io_voltage = r8a7790_get_io_voltage,
+	.set_io_voltage = r8a7790_set_io_voltage,
+};
+
 const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 	.name = "r8a77900_pfc",
+	.ops = &pinmux_ops,
 	.unlock_reg = 0xe6060000, /* PMMR */
 
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
-- 
2.7.0
