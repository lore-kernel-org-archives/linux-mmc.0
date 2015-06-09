From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH v2 3/6] pinctrl: sh-pfc: r8a7790: Add separate functions for
 SDHI 1.8V operation
Date: Wed, 10 Jun 2015 00:23:31 +0100
Message-ID: <1433892211.12074.52.camel@codethink.co.uk>
References: <1433892104.12074.49.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34346 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbbFIXXh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2015 19:23:37 -0400
In-Reply-To: <1433892104.12074.49.camel@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

All the SHDIs can operate with either 3.3V or 1.8V signals, depending
on negotiation with the card.

Add separate functions for the 1.8V mode, and implement the set_mux
operation on all SDHI functions to configure the voltage for each
group of pins.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/pinctrl/sh-pfc/core.c        |  2 +-
 drivers/pinctrl/sh-pfc/core.h        |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 70 +++++++++++++++++++++++++++++++++---
 3 files changed, 68 insertions(+), 5 deletions(-)

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
index 22a5470889f5..baba3151687f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -4472,6 +4472,8 @@ static const char * const sdhi0_groups[] = {
 	"sdhi0_wp",
 };
 
+#define sdhi0_1v8_groups sdhi0_groups
+
 static const char * const sdhi1_groups[] = {
 	"sdhi1_data1",
 	"sdhi1_data4",
@@ -4480,6 +4482,8 @@ static const char * const sdhi1_groups[] = {
 	"sdhi1_wp",
 };
 
+#define sdhi1_1v8_groups sdhi1_groups
+
 static const char * const sdhi2_groups[] = {
 	"sdhi2_data1",
 	"sdhi2_data4",
@@ -4488,6 +4492,8 @@ static const char * const sdhi2_groups[] = {
 	"sdhi2_wp",
 };
 
+#define sdhi2_1v8_groups sdhi2_groups
+
 static const char * const sdhi3_groups[] = {
 	"sdhi3_data1",
 	"sdhi3_data4",
@@ -4496,6 +4502,8 @@ static const char * const sdhi3_groups[] = {
 	"sdhi3_wp",
 };
 
+#define sdhi3_1v8_groups sdhi3_groups
+
 static const char * const ssi_groups[] = {
 	"ssi0_data",
 	"ssi0129_ctrl",
@@ -4595,6 +4603,56 @@ static const char * const vin3_groups[] = {
 	"vin3_clk",
 };
 
+static void sdhi_set_voltage(struct sh_pfc *pfc,
+			     const struct sh_pfc_function *func,
+			     const struct sh_pfc_pin_group *grp)
+{
+	void __iomem *mapped_reg;
+	u32 data, mask;
+	int index;
+
+	if (WARN_ON(strncmp(func->name, "sdhi", 4)))
+		return;
+	if (WARN_ON(strncmp(func->name, grp->name, 5)))
+		return;
+
+	/* Calculate mask in IOCTRL6 based on the group */
+	index = func->name[4] - '0';
+	if (WARN_ON(index < 0 || index > 3))
+		return;
+	if (!strcmp(grp->name + 5, "_data1"))
+		mask = 0x20;
+	else if (!strcmp(grp->name + 5, "_data4"))
+		mask = 0x3c;
+	else if (!strcmp(grp->name + 5, "_ctrl"))
+		mask = 0xc0;
+	else if (!strcmp(grp->name + 5, "_cd"))
+		mask = 0x02;
+	else if (!strcmp(grp->name + 5, "_wp"))
+		mask = 0x01;
+	else {
+		WARN_ON(1);
+		return;
+	}
+	mask <<= 8 * (3 - index);
+
+	/* Map IOCTRL6 */
+	mapped_reg = sh_pfc_phys_to_virt(pfc, 0xe606008c);
+
+	data = sh_pfc_read_raw_reg(mapped_reg, 32);
+
+	/* Set for 3.3V (high) or 1.8V (low) depending on the function name */
+	if (strcmp(func->name + 5, "_1v8"))
+		data |= mask;
+	else
+		data &= ~mask;
+
+	sh_pfc_write_raw_reg(
+		sh_pfc_phys_to_virt(pfc, pfc->info->unlock_reg), 32,
+		~data);
+	sh_pfc_write_raw_reg(mapped_reg, 32, data);
+}
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
@@ -4631,10 +4689,14 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scifb0),
 	SH_PFC_FUNCTION(scifb1),
 	SH_PFC_FUNCTION(scifb2),
-	SH_PFC_FUNCTION(sdhi0),
-	SH_PFC_FUNCTION(sdhi1),
-	SH_PFC_FUNCTION(sdhi2),
-	SH_PFC_FUNCTION(sdhi3),
+	SH_PFC_FUNCTION_SPECIAL(sdhi0, sdhi_set_voltage),
+	SH_PFC_FUNCTION_SPECIAL(sdhi0_1v8, sdhi_set_voltage),
+	SH_PFC_FUNCTION_SPECIAL(sdhi1, sdhi_set_voltage),
+	SH_PFC_FUNCTION_SPECIAL(sdhi1_1v8, sdhi_set_voltage),
+	SH_PFC_FUNCTION_SPECIAL(sdhi2, sdhi_set_voltage),
+	SH_PFC_FUNCTION_SPECIAL(sdhi2_1v8, sdhi_set_voltage),
+	SH_PFC_FUNCTION_SPECIAL(sdhi3, sdhi_set_voltage),
+	SH_PFC_FUNCTION_SPECIAL(sdhi3_1v8, sdhi_set_voltage),
 	SH_PFC_FUNCTION(ssi),
 	SH_PFC_FUNCTION(tpu0),
 	SH_PFC_FUNCTION(usb0),
-- 
2.1.4




