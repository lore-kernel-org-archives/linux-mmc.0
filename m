From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 21/31] ARM: amba: realview: get rid of private platform
 amba_device initializer
Date: Fri, 20 Jan 2012 09:29:30 +0000
Message-ID: <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/core.h            |   20 ++++-----------
 arch/arm/mach-realview/realview_eb.c     |   38 +++++++++++++++---------------
 arch/arm/mach-realview/realview_pb1176.c |   38 +++++++++++++++---------------
 arch/arm/mach-realview/realview_pb11mp.c |   38 +++++++++++++++---------------
 arch/arm/mach-realview/realview_pba8.c   |   38 +++++++++++++++---------------
 arch/arm/mach-realview/realview_pbx.c    |   38 +++++++++++++++---------------
 6 files changed, 100 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 735b57a..b1c6097 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -28,21 +28,11 @@
 #include <asm/setup.h>
 #include <asm/leds.h>
 
-#define AMBA_DEVICE(name,busid,base,plat)			\
-static struct amba_device name##_device = {			\
-	.dev		= {					\
-		.coherent_dma_mask = ~0,			\
-		.init_name = busid,				\
-		.platform_data = plat,				\
-	},							\
-	.res		= {					\
-		.start	= REALVIEW_##base##_BASE,		\
-		.end	= (REALVIEW_##base##_BASE) + SZ_4K - 1,	\
-		.flags	= IORESOURCE_MEM,			\
-	},							\
-	.dma_mask	= ~0,					\
-	.irq		= base##_IRQ,				\
-}
+#define APB_DEVICE(name, busid, base, plat)			\
+static AMBA_APB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
+
+#define AHB_DEVICE(name, busid, base, plat)			\
+static AMBA_AHB_DEVICE(name, busid, 0, base, base##_IRQ, plat)
 
 struct machine_desc;
 
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 5c810e5..fbca43c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -176,27 +176,27 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define EB_SSP_IRQ	{ IRQ_EB_SSP }
 
 /* FPGA Primecells */
-AMBA_DEVICE(aaci,  "fpga:aaci",  AACI,     NULL);
-AMBA_DEVICE(mmc0,  "fpga:mmc0",  MMCI0,    &realview_mmc0_plat_data);
-AMBA_DEVICE(kmi0,  "fpga:kmi0",  KMI0,     NULL);
-AMBA_DEVICE(kmi1,  "fpga:kmi1",  KMI1,     NULL);
-AMBA_DEVICE(uart3, "fpga:uart3", EB_UART3, NULL);
+APB_DEVICE(aaci,  "fpga:aaci",  AACI,     NULL);
+APB_DEVICE(mmc0,  "fpga:mmc0",  MMCI0,    &realview_mmc0_plat_data);
+APB_DEVICE(kmi0,  "fpga:kmi0",  KMI0,     NULL);
+APB_DEVICE(kmi1,  "fpga:kmi1",  KMI1,     NULL);
+APB_DEVICE(uart3, "fpga:uart3", EB_UART3, NULL);
 
 /* DevChip Primecells */
-AMBA_DEVICE(smc,   "dev:smc",   EB_SMC,   NULL);
-AMBA_DEVICE(clcd,  "dev:clcd",  EB_CLCD,  &clcd_plat_data);
-AMBA_DEVICE(dmac,  "dev:dmac",  DMAC,     NULL);
-AMBA_DEVICE(sctl,  "dev:sctl",  SCTL,     NULL);
-AMBA_DEVICE(wdog,  "dev:wdog",  EB_WATCHDOG, NULL);
-AMBA_DEVICE(gpio0, "dev:gpio0", EB_GPIO0, &gpio0_plat_data);
-AMBA_DEVICE(gpio1, "dev:gpio1", GPIO1,    &gpio1_plat_data);
-AMBA_DEVICE(gpio2, "dev:gpio2", GPIO2,    &gpio2_plat_data);
-AMBA_DEVICE(rtc,   "dev:rtc",   EB_RTC,   NULL);
-AMBA_DEVICE(sci0,  "dev:sci0",  SCI,      NULL);
-AMBA_DEVICE(uart0, "dev:uart0", EB_UART0, NULL);
-AMBA_DEVICE(uart1, "dev:uart1", EB_UART1, NULL);
-AMBA_DEVICE(uart2, "dev:uart2", EB_UART2, NULL);
-AMBA_DEVICE(ssp0,  "dev:ssp0",  EB_SSP,   &ssp0_plat_data);
+AHB_DEVICE(smc,   "dev:smc",   EB_SMC,   NULL);
+AHB_DEVICE(clcd,  "dev:clcd",  EB_CLCD,  &clcd_plat_data);
+AHB_DEVICE(dmac,  "dev:dmac",  DMAC,     NULL);
+AHB_DEVICE(sctl,  "dev:sctl",  SCTL,     NULL);
+APB_DEVICE(wdog,  "dev:wdog",  EB_WATCHDOG, NULL);
+APB_DEVICE(gpio0, "dev:gpio0", EB_GPIO0, &gpio0_plat_data);
+APB_DEVICE(gpio1, "dev:gpio1", GPIO1,    &gpio1_plat_data);
+APB_DEVICE(gpio2, "dev:gpio2", GPIO2,    &gpio2_plat_data);
+APB_DEVICE(rtc,   "dev:rtc",   EB_RTC,   NULL);
+APB_DEVICE(sci0,  "dev:sci0",  SCI,      NULL);
+APB_DEVICE(uart0, "dev:uart0", EB_UART0, NULL);
+APB_DEVICE(uart1, "dev:uart1", EB_UART1, NULL);
+APB_DEVICE(uart2, "dev:uart2", EB_UART2, NULL);
+APB_DEVICE(ssp0,  "dev:ssp0",  EB_SSP,   &ssp0_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 9506de9..1b6e60c 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -155,27 +155,27 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define PB1176_SSP_IRQ		{ IRQ_DC1176_SSP }
 
 /* FPGA Primecells */
-AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
-AMBA_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
-AMBA_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
-AMBA_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
-AMBA_DEVICE(uart4,	"fpga:uart4",	PB1176_UART4,	NULL);
+APB_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
+APB_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
+APB_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
+APB_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
+APB_DEVICE(uart4,	"fpga:uart4",	PB1176_UART4,	NULL);
 
 /* DevChip Primecells */
-AMBA_DEVICE(smc,	"dev:smc",	PB1176_SMC,	NULL);
-AMBA_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
-AMBA_DEVICE(wdog,	"dev:wdog",	PB1176_WATCHDOG,	NULL);
-AMBA_DEVICE(gpio0,	"dev:gpio0",	PB1176_GPIO0,	&gpio0_plat_data);
-AMBA_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
-AMBA_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
-AMBA_DEVICE(rtc,	"dev:rtc",	PB1176_RTC,	NULL);
-AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
-AMBA_DEVICE(uart0,	"dev:uart0",	PB1176_UART0,	NULL);
-AMBA_DEVICE(uart1,	"dev:uart1",	PB1176_UART1,	NULL);
-AMBA_DEVICE(uart2,	"dev:uart2",	PB1176_UART2,	NULL);
-AMBA_DEVICE(uart3,	"dev:uart3",	PB1176_UART3,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	&ssp0_plat_data);
-AMBA_DEVICE(clcd,	"dev:clcd",	PB1176_CLCD,	&clcd_plat_data);
+AHB_DEVICE(smc,		"dev:smc",	PB1176_SMC,	NULL);
+AHB_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
+APB_DEVICE(wdog,	"dev:wdog",	PB1176_WATCHDOG,	NULL);
+APB_DEVICE(gpio0,	"dev:gpio0",	PB1176_GPIO0,	&gpio0_plat_data);
+APB_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
+APB_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
+APB_DEVICE(rtc,		"dev:rtc",	PB1176_RTC,	NULL);
+APB_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
+APB_DEVICE(uart0,	"dev:uart0",	PB1176_UART0,	NULL);
+APB_DEVICE(uart1,	"dev:uart1",	PB1176_UART1,	NULL);
+APB_DEVICE(uart2,	"dev:uart2",	PB1176_UART2,	NULL);
+APB_DEVICE(uart3,	"dev:uart3",	PB1176_UART3,	NULL);
+APB_DEVICE(ssp0,	"dev:ssp0",	PB1176_SSP,	&ssp0_plat_data);
+AHB_DEVICE(clcd,	"dev:clcd",	PB1176_CLCD,	&clcd_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&uart0_device,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index cb4f2da..43b82bc 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -155,29 +155,29 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define PB11MP_SSP_IRQ		{ IRQ_PB11MP_SSP }
 
 /* FPGA Primecells */
-AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
-AMBA_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
-AMBA_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
-AMBA_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
-AMBA_DEVICE(uart3,	"fpga:uart3",	PB11MP_UART3,	NULL);
+APB_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
+APB_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
+APB_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
+APB_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
+APB_DEVICE(uart3,	"fpga:uart3",	PB11MP_UART3,	NULL);
 
 /* DevChip Primecells */
-AMBA_DEVICE(smc,	"dev:smc",	PB11MP_SMC,	NULL);
-AMBA_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
-AMBA_DEVICE(wdog,	"dev:wdog",	PB11MP_WATCHDOG, NULL);
-AMBA_DEVICE(gpio0,	"dev:gpio0",	PB11MP_GPIO0,	&gpio0_plat_data);
-AMBA_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
-AMBA_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
-AMBA_DEVICE(rtc,	"dev:rtc",	PB11MP_RTC,	NULL);
-AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
-AMBA_DEVICE(uart0,	"dev:uart0",	PB11MP_UART0,	NULL);
-AMBA_DEVICE(uart1,	"dev:uart1",	PB11MP_UART1,	NULL);
-AMBA_DEVICE(uart2,	"dev:uart2",	PB11MP_UART2,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PB11MP_SSP,	&ssp0_plat_data);
+AHB_DEVICE(smc,		"dev:smc",	PB11MP_SMC,	NULL);
+AHB_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
+APB_DEVICE(wdog,	"dev:wdog",	PB11MP_WATCHDOG, NULL);
+APB_DEVICE(gpio0,	"dev:gpio0",	PB11MP_GPIO0,	&gpio0_plat_data);
+APB_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
+APB_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
+APB_DEVICE(rtc,		"dev:rtc",	PB11MP_RTC,	NULL);
+APB_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
+APB_DEVICE(uart0,	"dev:uart0",	PB11MP_UART0,	NULL);
+APB_DEVICE(uart1,	"dev:uart1",	PB11MP_UART1,	NULL);
+APB_DEVICE(uart2,	"dev:uart2",	PB11MP_UART2,	NULL);
+APB_DEVICE(ssp0,	"dev:ssp0",	PB11MP_SSP,	&ssp0_plat_data);
 
 /* Primecells on the NEC ISSP chip */
-AMBA_DEVICE(clcd,	"issp:clcd",	PB11MP_CLCD,	&clcd_plat_data);
-AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
+AHB_DEVICE(clcd,	"issp:clcd",	PB11MP_CLCD,	&clcd_plat_data);
+AHB_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 293de21..5965017 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -145,29 +145,29 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define PBA8_SSP_IRQ		{ IRQ_PBA8_SSP }
 
 /* FPGA Primecells */
-AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
-AMBA_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
-AMBA_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
-AMBA_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
-AMBA_DEVICE(uart3,	"fpga:uart3",	PBA8_UART3,	NULL);
+APB_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
+APB_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
+APB_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
+APB_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
+APB_DEVICE(uart3,	"fpga:uart3",	PBA8_UART3,	NULL);
 
 /* DevChip Primecells */
-AMBA_DEVICE(smc,	"dev:smc",	PBA8_SMC,	NULL);
-AMBA_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
-AMBA_DEVICE(wdog,	"dev:wdog",	PBA8_WATCHDOG, NULL);
-AMBA_DEVICE(gpio0,	"dev:gpio0",	PBA8_GPIO0,	&gpio0_plat_data);
-AMBA_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
-AMBA_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
-AMBA_DEVICE(rtc,	"dev:rtc",	PBA8_RTC,	NULL);
-AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
-AMBA_DEVICE(uart0,	"dev:uart0",	PBA8_UART0,	NULL);
-AMBA_DEVICE(uart1,	"dev:uart1",	PBA8_UART1,	NULL);
-AMBA_DEVICE(uart2,	"dev:uart2",	PBA8_UART2,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PBA8_SSP,	&ssp0_plat_data);
+AHB_DEVICE(smc,		"dev:smc",	PBA8_SMC,	NULL);
+AHB_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
+APB_DEVICE(wdog,	"dev:wdog",	PBA8_WATCHDOG, NULL);
+APB_DEVICE(gpio0,	"dev:gpio0",	PBA8_GPIO0,	&gpio0_plat_data);
+APB_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
+APB_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
+APB_DEVICE(rtc,		"dev:rtc",	PBA8_RTC,	NULL);
+APB_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
+APB_DEVICE(uart0,	"dev:uart0",	PBA8_UART0,	NULL);
+APB_DEVICE(uart1,	"dev:uart1",	PBA8_UART1,	NULL);
+APB_DEVICE(uart2,	"dev:uart2",	PBA8_UART2,	NULL);
+APB_DEVICE(ssp0,	"dev:ssp0",	PBA8_SSP,	&ssp0_plat_data);
 
 /* Primecells on the NEC ISSP chip */
-AMBA_DEVICE(clcd,	"issp:clcd",	PBA8_CLCD,	&clcd_plat_data);
-AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
+AHB_DEVICE(clcd,	"issp:clcd",	PBA8_CLCD,	&clcd_plat_data);
+AHB_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 8e2a306..1cd9956 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -167,29 +167,29 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define PBX_SSP_IRQ		{ IRQ_PBX_SSP }
 
 /* FPGA Primecells */
-AMBA_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
-AMBA_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
-AMBA_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
-AMBA_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
-AMBA_DEVICE(uart3,	"fpga:uart3",	PBX_UART3,	NULL);
+APB_DEVICE(aaci,	"fpga:aaci",	AACI,		NULL);
+APB_DEVICE(mmc0,	"fpga:mmc0",	MMCI0,		&realview_mmc0_plat_data);
+APB_DEVICE(kmi0,	"fpga:kmi0",	KMI0,		NULL);
+APB_DEVICE(kmi1,	"fpga:kmi1",	KMI1,		NULL);
+APB_DEVICE(uart3,	"fpga:uart3",	PBX_UART3,	NULL);
 
 /* DevChip Primecells */
-AMBA_DEVICE(smc,	"dev:smc",	PBX_SMC,	NULL);
-AMBA_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
-AMBA_DEVICE(wdog,	"dev:wdog",	PBX_WATCHDOG, 	NULL);
-AMBA_DEVICE(gpio0,	"dev:gpio0",	PBX_GPIO0,	&gpio0_plat_data);
-AMBA_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
-AMBA_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
-AMBA_DEVICE(rtc,	"dev:rtc",	PBX_RTC,	NULL);
-AMBA_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
-AMBA_DEVICE(uart0,	"dev:uart0",	PBX_UART0,	NULL);
-AMBA_DEVICE(uart1,	"dev:uart1",	PBX_UART1,	NULL);
-AMBA_DEVICE(uart2,	"dev:uart2",	PBX_UART2,	NULL);
-AMBA_DEVICE(ssp0,	"dev:ssp0",	PBX_SSP,	&ssp0_plat_data);
+AHB_DEVICE(smc,	"dev:smc",	PBX_SMC,	NULL);
+AHB_DEVICE(sctl,	"dev:sctl",	SCTL,		NULL);
+APB_DEVICE(wdog,	"dev:wdog",	PBX_WATCHDOG, 	NULL);
+APB_DEVICE(gpio0,	"dev:gpio0",	PBX_GPIO0,	&gpio0_plat_data);
+APB_DEVICE(gpio1,	"dev:gpio1",	GPIO1,		&gpio1_plat_data);
+APB_DEVICE(gpio2,	"dev:gpio2",	GPIO2,		&gpio2_plat_data);
+APB_DEVICE(rtc,		"dev:rtc",	PBX_RTC,	NULL);
+APB_DEVICE(sci0,	"dev:sci0",	SCI,		NULL);
+APB_DEVICE(uart0,	"dev:uart0",	PBX_UART0,	NULL);
+APB_DEVICE(uart1,	"dev:uart1",	PBX_UART1,	NULL);
+APB_DEVICE(uart2,	"dev:uart2",	PBX_UART2,	NULL);
+APB_DEVICE(ssp0,	"dev:ssp0",	PBX_SSP,	&ssp0_plat_data);
 
 /* Primecells on the NEC ISSP chip */
-AMBA_DEVICE(clcd,	"issp:clcd",	PBX_CLCD,	&clcd_plat_data);
-AMBA_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
+AHB_DEVICE(clcd,	"issp:clcd",	PBX_CLCD,	&clcd_plat_data);
+AHB_DEVICE(dmac,	"issp:dmac",	DMAC,		NULL);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
-- 
1.7.4.4

