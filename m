From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH v4 2/8] pinctrl: sh-pfc: r8a7790: Implement voltage
 switching for SDHI
Date: Tue, 30 Jun 2015 17:54:09 +0100
Message-ID: <1435683249.23818.62.camel@codethink.co.uk>
References: <1435683177.23818.60.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435683177.23818.60.camel@codethink.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

All the SHDIs can operate with either 3.3V or 1.8V signals, depending
on negotiation with the card.

Implement the {get,set}_io_voltage operations and set the related
capability flag for the associated pins.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/pinctrl/sh-pfc/core.c        |  2 +-
 drivers/pinctrl/sh-pfc/core.h        |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 71 +++++++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 7b2c9495c383..7d51f96afc9a 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -92,7 +92,7 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
 	return 0;
 }
 
-static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
+void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
 {
 	struct sh_pfc_window *window;
 	phys_addr_t address = reg;
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 6dc8a6fc2746..af355629c5d2 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -57,6 +57,7 @@ int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
 int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc);
 
+void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 address);
 u32 sh_pfc_read_raw_reg(void __iomem *mapped_reg, unsigned int reg_width);
 void sh_pfc_write_raw_reg(void __iomem *mapped_reg, unsigned int reg_width,
 			  u32 data);
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 22a5470889f5..ec6657de6a46 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -21,6 +21,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/platform_data/gpio-rcar.h>
 
@@ -1739,10 +1740,20 @@ static const u16 pinmux_data[] = {
 #define PIN_NUMBER(r, c) (((r) - 'A') * 31 + (c) + 200)
 #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
 
+#define PIN_IO_VOLTAGE(bank, _pin, _name, sfx)		\
+	[RCAR_GP_PIN(bank, _pin)].configs = SH_PFC_PIN_CFG_IO_VOLTAGE
+
 static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 
-	/* Pins not associated with a GPIO port */
+	/*
+	 * All pins assigned to GPIO bank 3 can be used for SD interfaces
+	 * in which case they support both 3.3V and 1.8V signalling.
+	 */
+	PORT_GP_32(3, PIN_IO_VOLTAGE, unused),
+
+	/* Pins not associated with a GPIO port, placed after all the GPIOs */
+	[RCAR_GP_PIN(5, 31) + 1] =
 	SH_PFC_PIN_NAMED(ROW_GROUP_A('F'), 15, AF15),
 	SH_PFC_PIN_NAMED(ROW_GROUP_A('G'), 15, AG15),
 	SH_PFC_PIN_NAMED(ROW_GROUP_A('H'), 15, AH15),
@@ -4595,6 +4606,58 @@ static const char * const vin3_groups[] = {
 	"vin3_clk",
 };
 
+static int sdhi_get_io_voltage(struct sh_pfc *pfc, unsigned int pin)
+{
+	void __iomem *mapped_reg;
+	u32 data, mask;
+
+	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31),
+		 "sdhi_get_low_voltage: invalid pin %#x", pin))
+		return -EIO;
+
+	/* Map IOCTRL6 */
+	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
+
+	/* Bits in IOCTRL6 are numbered in opposite order to pins */
+	mask = 0x80000000 >> (pin & 0x1f);
+
+	data = ioread32(mapped_reg);
+
+	return (data & mask) ? 3300 : 1800;
+}
+
+static int
+sdhi_set_io_voltage(struct sh_pfc *pfc, unsigned int pin, u16 voltage_mV)
+{
+	void __iomem *mapped_reg;
+	u32 data, mask;
+
+	if (WARN(pin < RCAR_GP_PIN(3, 0) || pin > RCAR_GP_PIN(3, 31),
+		 "invalid pin %#x", pin))
+		return -EIO;
+
+	if (voltage_mV != 1800 && voltage_mV != 3300)
+		return -EINVAL;
+
+	/* Map IOCTRL6 */
+	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
+
+	/* Bits in IOCTRL6 are numbered in opposite order to pins */
+	mask = 0x80000000 >> (pin & 0x1f);
+
+	data = ioread32(mapped_reg);
+
+	if (voltage_mV == 3300)
+		data |= mask;
+	else
+		data &= ~mask;
+
+	iowrite32(~data, sh_pfc_phys_to_virt(pfc, pfc->info->unlock_reg));
+	iowrite32(data, mapped_reg);
+
+	return 0;
+}
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
@@ -5586,8 +5649,14 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+static const struct sh_pfc_soc_operations pinmux_ops = {
+	.get_io_voltage = sdhi_get_io_voltage,
+	.set_io_voltage = sdhi_set_io_voltage,
+};
+
 const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 	.name = "r8a77900_pfc",
+	.ops = &pinmux_ops,
 	.unlock_reg = 0xe6060000, /* PMMR */
 
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
-- 
2.1.4




