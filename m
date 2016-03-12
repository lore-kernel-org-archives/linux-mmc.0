From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 01/10] pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
Date: Sat, 12 Mar 2016 10:15:03 +0100
Message-ID: <1457774112-16958-2-git-send-email-wsa@the-dreams.de>
References: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, linux-gpio@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

All the SHDIs can operate with either 3.3V or 1.8V signals, depending
on negotiation with the card.

Implement the {get,set}_io_voltage operations and set the related
capability flag for the associated pins.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-gpio@vger.kernel.org
---

Changes since RFC:

* Don't export sh_pfc_phys_to_virt but use pfc->windows->virt directly.

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 54 +++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 0f4d48f9400ba0..eed8daa464cc1e 100644
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
 
@@ -4691,6 +4696,47 @@ static const char * const vin3_groups[] = {
 	"vin3_clk",
 };
 
+#define IOCTRL6 0x8c
+
+static int r8a7790_get_io_voltage(struct sh_pfc *pfc, unsigned int pin)
+{
+	u32 data, mask;
+
+	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31), "invalid pin %#x", pin))
+		return -EINVAL;
+
+	data = ioread32(pfc->windows->virt + IOCTRL6),
+	/* Bits in IOCTRL6 are numbered in opposite order to pins */
+	mask = 0x80000000 >> (pin & 0x1f);
+
+	return (data & mask) ? 3300 : 1800;
+}
+
+static int r8a7790_set_io_voltage(struct sh_pfc *pfc, unsigned int pin, u16 mV)
+{
+	u32 data, mask;
+
+	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31), "invalid pin %#x", pin))
+		return -EINVAL;
+
+	if (mV != 1800 && mV != 3300)
+		return -EINVAL;
+
+	data = ioread32(pfc->windows->virt + IOCTRL6);
+	/* Bits in IOCTRL6 are numbered in opposite order to pins */
+	mask = 0x80000000 >> (pin & 0x1f);
+
+	if (mV == 3300)
+		data |= mask;
+	else
+		data &= ~mask;
+
+	iowrite32(~data, pfc->windows->virt); /* unlock reg */
+	iowrite32(data, pfc->windows->virt + IOCTRL6);
+
+	return 0;
+}
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
@@ -5690,8 +5736,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
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

