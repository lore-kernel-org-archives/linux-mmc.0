From: <ludovic.desroches@atmel.com>
Subject: [PATCH v2] ARM: at91: add atmel-mci support for chips and boards which can use it
Date: Mon, 21 May 2012 12:23:27 +0200
Message-ID: <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
References: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:16820 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592Ab2EUKXz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 06:23:55 -0400
In-Reply-To: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
use it instead of at91_mci driver.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
V2: add several boards I missed

 arch/arm/mach-at91/at91rm9200_devices.c  |   99 ++++++++++++++++++
 arch/arm/mach-at91/at91sam9261_devices.c |   67 ++++++++++++
 arch/arm/mach-at91/at91sam9263.c         |    2 +
 arch/arm/mach-at91/at91sam9263_devices.c |  164 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9rl_devices.c  |   70 +++++++++++++
 arch/arm/mach-at91/board-afeb-9260v1.c   |   14 +++
 arch/arm/mach-at91/board-carmeva.c       |   14 +++
 arch/arm/mach-at91/board-cpu9krea.c      |   14 +++
 arch/arm/mach-at91/board-cpuat91.c       |   14 +++
 arch/arm/mach-at91/board-csb337.c        |   14 +++
 arch/arm/mach-at91/board-eb9200.c        |   14 +++
 arch/arm/mach-at91/board-ecbat91.c       |   14 +++
 arch/arm/mach-at91/board-eco920.c        |   14 +++
 arch/arm/mach-at91/board-flexibity.c     |   14 +++
 arch/arm/mach-at91/board-foxg20.c        |   16 +++-
 arch/arm/mach-at91/board-kb9202.c        |   14 +++
 arch/arm/mach-at91/board-neocore926.c    |   14 +++
 arch/arm/mach-at91/board-picotux200.c    |   14 +++
 arch/arm/mach-at91/board-qil-a9260.c     |   14 +++
 arch/arm/mach-at91/board-rm9200dk.c      |   14 +++
 arch/arm/mach-at91/board-rm9200ek.c      |   14 +++
 arch/arm/mach-at91/board-rsi-ews.c       |   14 +++
 arch/arm/mach-at91/board-sam9-l9260.c    |   16 +++-
 arch/arm/mach-at91/board-sam9260ek.c     |   16 +++-
 arch/arm/mach-at91/board-sam9261ek.c     |   14 +++
 arch/arm/mach-at91/board-sam9263ek.c     |   14 +++
 arch/arm/mach-at91/board-sam9rlek.c      |   14 +++
 arch/arm/mach-at91/board-usb-a926x.c     |    2 +-
 arch/arm/mach-at91/board-yl-9200.c       |   14 +++
 29 files changed, 728 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 05774e5..2c13783 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -374,6 +374,105 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
 
 
 /* --------------------------------------------------------------------
+ *  MMC / SD
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static u64 mmc_dmamask = DMA_BIT_MASK(32);
+static struct mci_platform_data mmc_data;
+
+static struct resource mmc_resources[] = {
+	[0] = {
+		.start	= AT91RM9200_BASE_MCI,
+		.end	= AT91RM9200_BASE_MCI + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91RM9200_ID_MCI,
+		.end	= AT91RM9200_ID_MCI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91rm9200_mmc_device = {
+	.name		= "atmel_mci",
+	.id		= -1,
+	.dev		= {
+				.dma_mask		= &mmc_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &mmc_data,
+	},
+	.resource	= mmc_resources,
+	.num_resources	= ARRAY_SIZE(mmc_resources),
+};
+
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
+{
+	unsigned int i;
+	unsigned int slot_count = 0;
+
+	if (!data)
+		return;
+
+	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
+
+		if (!data->slot[i].bus_width)
+			continue;
+
+		/* input/irq */
+		if (gpio_is_valid(data->slot[i].detect_pin)) {
+			at91_set_gpio_input(data->slot[i].detect_pin, 1);
+			at91_set_deglitch(data->slot[i].detect_pin, 1);
+		}
+		if (gpio_is_valid(data->slot[i].wp_pin))
+			at91_set_gpio_input(data->slot[i].wp_pin, 1);
+
+		switch (i) {
+		case 0:                                 /* slot A */
+			/* CMD */
+			at91_set_A_periph(AT91_PIN_PA28, 1);
+			/* DAT0, maybe DAT1..DAT3 */
+			at91_set_A_periph(AT91_PIN_PA29, 1);
+			if (data->slot[i].bus_width == 4) {
+				at91_set_B_periph(AT91_PIN_PB3, 1);
+				at91_set_B_periph(AT91_PIN_PB4, 1);
+				at91_set_B_periph(AT91_PIN_PB5, 1);
+			}
+			slot_count++;
+			break;
+		case 1:					/* slot B */
+			/* CMD */
+			at91_set_B_periph(AT91_PIN_PA8, 1);
+			/* DAT0, maybe DAT1..DAT3 */
+			at91_set_B_periph(AT91_PIN_PA9, 1);
+			if (data->slot[i].bus_width == 4) {
+				at91_set_B_periph(AT91_PIN_PA10, 1);
+				at91_set_B_periph(AT91_PIN_PA11, 1);
+				at91_set_B_periph(AT91_PIN_PA12, 1);
+			}
+			slot_count++;
+			break;
+		default:
+			printk(KERN_ERR
+			       "AT91: SD/MMC slot %d not available\n", i);
+			break;
+		}
+		if (slot_count) {
+			/* CLK */
+			at91_set_A_periph(AT91_PIN_PA27, 0);
+
+			mmc_data = *data;
+			platform_device_register(&at91rm9200_mmc_device);
+		}
+	}
+
+}
+#else
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
+#endif
+
+
+/* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 4db961a..0817854 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -202,7 +202,74 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  MMC / SD Slot for Atmel MCI Driver
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static u64 mmc_dmamask = DMA_BIT_MASK(32);
+static struct mci_platform_data mmc_data;
+
+static struct resource mmc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9261_BASE_MCI,
+		.end	= AT91SAM9261_BASE_MCI + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9261_ID_MCI,
+		.end	= AT91SAM9261_ID_MCI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9261_mmc_device = {
+	.name		= "atmel_mci",
+	.id		= -1,
+	.dev		= {
+				.dma_mask		= &mmc_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &mmc_data,
+	},
+	.resource	= mmc_resources,
+	.num_resources	= ARRAY_SIZE(mmc_resources),
+};
+
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
+{
+	if (!data)
+		return;
 
+	if (data->slot[0].bus_width) {
+		/* input/irq */
+		if (gpio_is_valid(data->slot[0].detect_pin)) {
+			at91_set_gpio_input(data->slot[0].detect_pin, 1);
+			at91_set_deglitch(data->slot[0].detect_pin, 1);
+		}
+		if (gpio_is_valid(data->slot[0].wp_pin))
+			at91_set_gpio_input(data->slot[0].wp_pin, 1);
+
+		/* CLK */
+		at91_set_B_periph(AT91_PIN_PA2, 0);
+
+		/* CMD */
+		at91_set_B_periph(AT91_PIN_PA1, 1);
+
+		/* DAT0, maybe DAT1..DAT3 */
+		at91_set_B_periph(AT91_PIN_PA0, 1);
+		if (data->slot[0].bus_width == 4) {
+			at91_set_B_periph(AT91_PIN_PA4, 1);
+			at91_set_B_periph(AT91_PIN_PA5, 1);
+			at91_set_B_periph(AT91_PIN_PA6, 1);
+		}
+
+		mmc_data = *data;
+		platform_device_register(&at91sam9261_mmc_device);
+	}
+}
+#else
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
+#endif
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index ef301be..053e47a 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -189,6 +189,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.0", &mmc0_clk),
 	CLKDEV_CON_DEV_ID("mci_clk", "at91_mci.1", &mmc1_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.0", &mmc0_clk),
+	CLKDEV_CON_DEV_ID("mci_clk", "atmel_mci.1", &mmc1_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index fe99206..617fbfc 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -354,6 +354,170 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
 #endif
 
 /* --------------------------------------------------------------------
+ *  MMC / SD
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static u64 mmc_dmamask = DMA_BIT_MASK(32);
+static struct mci_platform_data mmc0_data, mmc1_data;
+
+static struct resource mmc0_resources[] = {
+	[0] = {
+		.start	= AT91SAM9263_BASE_MCI0,
+		.end	= AT91SAM9263_BASE_MCI0 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9263_ID_MCI0,
+		.end	= AT91SAM9263_ID_MCI0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9263_mmc0_device = {
+	.name		= "atmel_mci",
+	.id		= 0,
+	.dev		= {
+				.dma_mask		= &mmc_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &mmc0_data,
+	},
+	.resource	= mmc0_resources,
+	.num_resources	= ARRAY_SIZE(mmc0_resources),
+};
+
+static struct resource mmc1_resources[] = {
+	[0] = {
+		.start	= AT91SAM9263_BASE_MCI1,
+		.end	= AT91SAM9263_BASE_MCI1 + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9263_ID_MCI1,
+		.end	= AT91SAM9263_ID_MCI1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9263_mmc1_device = {
+	.name		= "atmel_mci",
+	.id		= 1,
+	.dev		= {
+				.dma_mask		= &mmc_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &mmc1_data,
+	},
+	.resource	= mmc1_resources,
+	.num_resources	= ARRAY_SIZE(mmc1_resources),
+};
+
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
+{
+	unsigned int i;
+	unsigned int slot_count = 0;
+
+	if (!data)
+		return;
+
+	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
+
+		if (!data->slot[i].bus_width)
+			continue;
+
+		/* input/irq */
+		if (gpio_is_valid(data->slot[i].detect_pin)) {
+			at91_set_gpio_input(data->slot[i].detect_pin,
+					1);
+			at91_set_deglitch(data->slot[i].detect_pin,
+					1);
+		}
+		if (gpio_is_valid(data->slot[i].wp_pin))
+			at91_set_gpio_input(data->slot[i].wp_pin, 1);
+
+		if (mmc_id == 0) {				/* MCI0 */
+			switch (i) {
+			case 0:					/* slot A */
+				/* CMD */
+				at91_set_A_periph(AT91_PIN_PA1, 1);
+				/* DAT0, maybe DAT1..DAT3 */
+				at91_set_A_periph(AT91_PIN_PA0, 1);
+				if (data->slot[i].bus_width == 4) {
+					at91_set_A_periph(AT91_PIN_PA3, 1);
+					at91_set_A_periph(AT91_PIN_PA4, 1);
+					at91_set_A_periph(AT91_PIN_PA5, 1);
+				}
+				slot_count++;
+				break;
+			case 1:					/* slot B */
+				/* CMD */
+				at91_set_A_periph(AT91_PIN_PA16, 1);
+				/* DAT0, maybe DAT1..DAT3 */
+				at91_set_A_periph(AT91_PIN_PA17, 1);
+				if (data->slot[i].bus_width == 4) {
+					at91_set_A_periph(AT91_PIN_PA18, 1);
+					at91_set_A_periph(AT91_PIN_PA19, 1);
+					at91_set_A_periph(AT91_PIN_PA20, 1);
+				}
+				slot_count++;
+				break;
+			default:
+				printk(KERN_ERR
+				       "AT91: SD/MMC slot %d not available\n", i);
+				break;
+			}
+			if (slot_count) {
+				/* CLK */
+				at91_set_A_periph(AT91_PIN_PA12, 0);
+
+				mmc0_data = *data;
+				platform_device_register(&at91sam9263_mmc0_device);
+			}
+		} else if (mmc_id == 1) {			/* MCI1 */
+			switch (i) {
+			case 0:					/* slot A */
+				/* CMD */
+				at91_set_A_periph(AT91_PIN_PA7, 1);
+				/* DAT0, maybe DAT1..DAT3 */
+				at91_set_A_periph(AT91_PIN_PA8, 1);
+				if (data->slot[i].bus_width == 4) {
+					at91_set_A_periph(AT91_PIN_PA9, 1);
+					at91_set_A_periph(AT91_PIN_PA10, 1);
+					at91_set_A_periph(AT91_PIN_PA11, 1);
+				}
+				slot_count++;
+				break;
+			case 1:					/* slot B */
+				/* CMD */
+				at91_set_A_periph(AT91_PIN_PA21, 1);
+				/* DAT0, maybe DAT1..DAT3 */
+				at91_set_A_periph(AT91_PIN_PA22, 1);
+				if (data->slot[i].bus_width == 4) {
+					at91_set_A_periph(AT91_PIN_PA23, 1);
+					at91_set_A_periph(AT91_PIN_PA24, 1);
+					at91_set_A_periph(AT91_PIN_PA25, 1);
+				}
+				slot_count++;
+				break;
+			default:
+				printk(KERN_ERR
+				       "AT91: SD/MMC slot %d not available\n", i);
+				break;
+			}
+			if (slot_count) {
+				/* CLK */
+				at91_set_A_periph(AT91_PIN_PA6, 0);
+
+				mmc1_data = *data;
+				platform_device_register(&at91sam9263_mmc1_device);
+			}
+		}
+	}
+}
+#else
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
+#endif
+
+/* --------------------------------------------------------------------
  *  Compact Flash (PCMCIA or IDE)
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index fe4ae22..83c5845 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -228,6 +228,76 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
 
 
 /* --------------------------------------------------------------------
+ *  MMC / SD
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static u64 mmc_dmamask = DMA_BIT_MASK(32);
+static struct mci_platform_data mmc_data;
+
+static struct resource mmc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9RL_BASE_MCI,
+		.end	= AT91SAM9RL_BASE_MCI + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9RL_ID_MCI,
+		.end	= AT91SAM9RL_ID_MCI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91sam9rl_mmc_device = {
+	.name		= "atmel_mci",
+	.id		= -1,
+	.dev		= {
+				.dma_mask		= &mmc_dmamask,
+				.coherent_dma_mask	= DMA_BIT_MASK(32),
+				.platform_data		= &mmc_data,
+	},
+	.resource	= mmc_resources,
+	.num_resources	= ARRAY_SIZE(mmc_resources),
+};
+
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data)
+{
+	if (!data)
+		return;
+
+	if (data->slot[0].bus_width) {
+		/* input/irq */
+		if (gpio_is_valid(data->slot[0].detect_pin)) {
+			at91_set_gpio_input(data->slot[0].detect_pin, 1);
+			at91_set_deglitch(data->slot[0].detect_pin, 1);
+		}
+		if (gpio_is_valid(data->slot[0].wp_pin))
+			at91_set_gpio_input(data->slot[0].wp_pin, 1);
+
+		/* CLK */
+		at91_set_A_periph(AT91_PIN_PA2, 0);
+
+		/* CMD */
+		at91_set_A_periph(AT91_PIN_PA1, 1);
+
+		/* DAT0, maybe DAT1..DAT3 */
+		at91_set_A_periph(AT91_PIN_PA0, 1);
+		if (data->slot[0].bus_width == 4) {
+			at91_set_A_periph(AT91_PIN_PA3, 1);
+			at91_set_A_periph(AT91_PIN_PA4, 1);
+			at91_set_A_periph(AT91_PIN_PA5, 1);
+		}
+
+		mmc_data = *data;
+		platform_device_register(&at91sam9rl_mmc_device);
+	}
+}
+#else
+void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *data) {}
+#endif
+
+
+/* --------------------------------------------------------------------
  *  NAND / SmartMedia
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 161efba..1e294ba 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -148,6 +148,15 @@ static struct atmel_nand_data __initdata afeb9260_nand_data = {
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata afeb9260_mci0_data = {
+	.slot[1] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PC9,
+		.wp_pin		= AT91_PIN_PC4,
+	},
+};
+#else
 static struct at91_mmc_data __initdata afeb9260_mmc_data = {
 	.det_pin 	= AT91_PIN_PC9,
 	.wp_pin 	= AT91_PIN_PC4,
@@ -155,6 +164,7 @@ static struct at91_mmc_data __initdata afeb9260_mmc_data = {
 	.wire4		= 1,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 
 
@@ -202,7 +212,11 @@ static void __init afeb9260_board_init(void)
 	at91_set_B_periph(AT91_PIN_PA10, 0);	/* ETX2 */
 	at91_set_B_periph(AT91_PIN_PA11, 0);	/* ETX3 */
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &afeb9260_mci0_data);
+#else
 	at91_add_device_mmc(0, &afeb9260_mmc_data);
+#endif
 	/* I2C */
 	at91_add_device_i2c(afeb9260_i2c_devices,
 			ARRAY_SIZE(afeb9260_i2c_devices));
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 59d9cf9..050b9d5 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -81,6 +81,15 @@ static struct at91_udc_data __initdata carmeva_udc_data = {
 	// .vcc_pin	= -EINVAL,
 // };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata carmeva_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PB10,
+		.wp_pin		= AT91_PIN_PC14,
+	},
+};
+#else
 static struct at91_mmc_data __initdata carmeva_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
@@ -88,6 +97,7 @@ static struct at91_mmc_data __initdata carmeva_mmc_data = {
 	.wp_pin		= AT91_PIN_PC14,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static struct spi_board_info carmeva_spi_devices[] = {
 	{ /* DataFlash chip */
@@ -153,7 +163,11 @@ static void __init carmeva_board_init(void)
 	/* Compact Flash */
 //	at91_add_device_cf(&carmeva_cf_data);
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &carmeva_mci0_data);
+#else
 	at91_add_device_mmc(0, &carmeva_mmc_data);
+#endif
 	/* LEDs */
 	at91_gpio_leds(carmeva_leds, ARRAY_SIZE(carmeva_leds));
 }
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 5f3680e..9842297 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -339,6 +339,15 @@ static void __init cpu9krea_add_device_buttons(void)
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata cpu9krea_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PA29,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata cpu9krea_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
@@ -346,6 +355,7 @@ static struct at91_mmc_data __initdata cpu9krea_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static void __init cpu9krea_board_init(void)
 {
@@ -362,7 +372,11 @@ static void __init cpu9krea_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&cpu9krea_macb_data);
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &cpu9krea_mci0_data);
+#else
 	at91_add_device_mmc(0, &cpu9krea_mmc_data);
+#endif
 	/* I2C */
 	at91_add_device_i2c(cpu9krea_i2c_devices,
 		ARRAY_SIZE(cpu9krea_i2c_devices));
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index e094cc8..cb5dcbf 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -99,12 +99,22 @@ static struct at91_udc_data __initdata cpuat91_udc_data = {
 	.pullup_pin	= AT91_PIN_PC14,
 };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata cpuat91_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PC2,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata cpuat91_mmc_data = {
 	.det_pin	= AT91_PIN_PC2,
 	.wire4		= 1,
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static struct physmap_flash_data cpuat91_flash_data = {
 	.width		= 2,
@@ -171,7 +181,11 @@ static void __init cpuat91_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&cpuat91_udc_data);
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &cpuat91_mci0_data);
+#else
 	at91_add_device_mmc(0, &cpuat91_mmc_data);
+#endif
 	/* I2C */
 	at91_add_device_i2c(NULL, 0);
 	/* Platform devices */
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 1a1547b..36d65ef 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -95,6 +95,15 @@ static struct at91_cf_data __initdata csb337_cf_data = {
 	.rst_pin	= AT91_PIN_PD2,
 };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata csb337_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PD5,
+		.wp_pin		= AT91_PIN_PD6,
+	},
+};
+#else
 static struct at91_mmc_data __initdata csb337_mmc_data = {
 	.det_pin	= AT91_PIN_PD5,
 	.slot_b		= 0,
@@ -102,6 +111,7 @@ static struct at91_mmc_data __initdata csb337_mmc_data = {
 	.wp_pin		= AT91_PIN_PD6,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static struct spi_board_info csb337_spi_devices[] = {
 	{	/* CAN controller */
@@ -244,7 +254,11 @@ static void __init csb337_board_init(void)
 	/* SPI */
 	at91_add_device_spi(csb337_spi_devices, ARRAY_SIZE(csb337_spi_devices));
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &csb337_mci0_data);
+#else
 	at91_add_device_mmc(0, &csb337_mmc_data);
+#endif
 	/* NOR flash */
 	platform_device_register(&csb_flash);
 	/* LEDs */
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index d302ca3..f374ecc 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -83,6 +83,15 @@ static struct at91_cf_data __initdata eb9200_cf_data = {
 	.rst_pin	= AT91_PIN_PC5,
 };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata eb9200_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata eb9200_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
@@ -90,6 +99,7 @@ static struct at91_mmc_data __initdata eb9200_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static struct i2c_board_info __initdata eb9200_i2c_devices[] = {
 	{
@@ -116,7 +126,11 @@ static void __init eb9200_board_init(void)
 	at91_add_device_spi(NULL, 0);
 	/* MMC */
 	/* only supports 1 or 4 bit interface, not wired through to SPI */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &eb9200_mci0_data);
+#else
 	at91_add_device_mmc(0, &eb9200_mmc_data);
+#endif
 }
 
 MACHINE_START(ATEB9200, "Embest ATEB9200")
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 69966ce..0f39fb3 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -75,6 +75,15 @@ static struct at91_usbh_data __initdata ecb_at91usbh_data = {
 	.overcurrent_pin= {-EINVAL, -EINVAL},
 };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata ecbat91_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata ecb_at91mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
@@ -82,6 +91,7 @@ static struct at91_mmc_data __initdata ecb_at91mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 
 #if defined(CONFIG_MTD_DATAFLASH)
@@ -164,7 +174,11 @@ static void __init ecb_at91board_init(void)
 	at91_add_device_i2c(NULL, 0);
 
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &ecbat91_mci0_data);
+#else
 	at91_add_device_mmc(0, &ecb_at91mmc_data);
+#endif
 
 	/* SPI */
 	at91_add_device_spi(ecb_at91spi_devices, ARRAY_SIZE(ecb_at91spi_devices));
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index f23aabe..932bebd 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -64,6 +64,15 @@ static struct at91_udc_data __initdata eco920_udc_data = {
 	.pullup_pin	= AT91_PIN_PB13,
 };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata eco920_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 1,
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata eco920_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 0,
@@ -71,6 +80,7 @@ static struct at91_mmc_data __initdata eco920_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static struct physmap_flash_data eco920_flash_data = {
 	.width  = 2,
@@ -108,7 +118,11 @@ static void __init eco920_board_init(void)
 	at91_add_device_usbh(&eco920_usbh_data);
 	at91_add_device_udc(&eco920_udc_data);
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &eco920_mci0_data);
+#else
 	at91_add_device_mmc(0, &eco920_mmc_data);
+#endif
 	platform_device_register(&eco920_flash);
 
 	at91_ramc_write(0, AT91_SMC_CSR(7),	AT91_SMC_RWHOLD_(1)
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 1815152..6632a80 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -80,6 +80,15 @@ static struct spi_board_info flexibity_spi_devices[] = {
 };
 
 /* MCI (SD/MMC) */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata flexibity_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PC9,
+		.wp_pin		= AT91_PIN_PC4,
+	},
+};
+#else
 static struct at91_mmc_data __initdata flexibity_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
@@ -87,6 +96,7 @@ static struct at91_mmc_data __initdata flexibity_mmc_data = {
 	.wp_pin		= AT91_PIN_PC4,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 /* LEDs */
 static struct gpio_led flexibity_leds[] = {
@@ -155,7 +165,11 @@ static void __init flexibity_board_init(void)
 	at91_add_device_spi(flexibity_spi_devices,
 		ARRAY_SIZE(flexibity_spi_devices));
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &flexibity_mci0_data);
+#else
 	at91_add_device_mmc(0, &flexibity_mmc_data);
+#endif
 	/* LEDs */
 	at91_gpio_leds(flexibity_leds, ARRAY_SIZE(flexibity_leds));
 }
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index caf017f..6cda303 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -123,7 +123,7 @@ static struct at91_udc_data __initdata foxg20_udc_data = {
  * SPI devices.
  */
 static struct spi_board_info foxg20_spi_devices[] = {
-#if !defined(CONFIG_MMC_AT91)
+#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
 	{
 		.modalias	= "mtd_dataflash",
 		.chip_select	= 1,
@@ -146,6 +146,7 @@ static struct macb_platform_data __initdata foxg20_macb_data = {
  * MCI (SD/MMC)
  * det_pin, wp_pin and vcc_pin are not connected
  */
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 static struct at91_mmc_data __initdata foxg20_mmc_data = {
 	.slot_b		= 1,
 	.wire4		= 1,
@@ -153,6 +154,15 @@ static struct at91_mmc_data __initdata foxg20_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata foxg20_mci0_data = {
+	.slot[1] = {
+		.bus_width	= 4,
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
+	},
+};
+#endif
 
 
 /*
@@ -251,7 +261,11 @@ static void __init foxg20_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&foxg20_macb_data);
 	/* MMC */
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 	at91_add_device_mmc(0, &foxg20_mmc_data);
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &foxg20_mci0_data);
+#endif
 	/* I2C */
 	at91_add_device_i2c(foxg20_i2c_devices, ARRAY_SIZE(foxg20_i2c_devices));
 	/* LEDs */
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 59b92aa..e31ec8e 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -86,6 +86,15 @@ static struct at91_udc_data __initdata kb9202_udc_data = {
 	.pullup_pin	= AT91_PIN_PB22,
 };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata kb9202_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PB2,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata kb9202_mmc_data = {
 	.det_pin	= AT91_PIN_PB2,
 	.slot_b		= 0,
@@ -93,6 +102,7 @@ static struct at91_mmc_data __initdata kb9202_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static struct mtd_partition __initdata kb9202_nand_partition[] = {
 	{
@@ -124,7 +134,11 @@ static void __init kb9202_board_init(void)
 	/* USB Device */
 	at91_add_device_udc(&kb9202_udc_data);
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &kb9202_mci0_data);
+#else
 	at91_add_device_mmc(0, &kb9202_mmc_data);
+#endif
 	/* I2C */
 	at91_add_device_i2c(NULL, 0);
 	/* SPI */
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 57d5f6a..849b938 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -146,12 +146,22 @@ static struct spi_board_info neocore926_spi_devices[] = {
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata neocore926_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PE18,
+		.wp_pin		= AT91_PIN_PE19,
+	},
+};
+#else
 static struct at91_mmc_data __initdata neocore926_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PE18,
 	.wp_pin		= AT91_PIN_PE19,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 
 /*
@@ -357,7 +367,11 @@ static void __init neocore926_board_init(void)
 	neocore926_add_device_ts();
 
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &neocore926_mci0_data);
+#else
 	at91_add_device_mmc(1, &neocore926_mmc_data);
+#endif
 
 	/* Ethernet */
 	at91_add_device_eth(&neocore926_macb_data);
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 59e35dd..a8cb032 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -72,6 +72,15 @@ static struct at91_usbh_data __initdata picotux200_usbh_data = {
 	.overcurrent_pin= {-EINVAL, -EINVAL},
 };
 
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata picotux200_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PB27,
+		.wp_pin		= AT91_PIN_PA17,
+	},
+};
+#else
 static struct at91_mmc_data __initdata picotux200_mmc_data = {
 	.det_pin	= AT91_PIN_PB27,
 	.slot_b		= 0,
@@ -79,6 +88,7 @@ static struct at91_mmc_data __initdata picotux200_mmc_data = {
 	.wp_pin		= AT91_PIN_PA17,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 #define PICOTUX200_FLASH_BASE	AT91_CHIPSELECT_0
 #define PICOTUX200_FLASH_SIZE	SZ_4M
@@ -115,7 +125,11 @@ static void __init picotux200_board_init(void)
 	at91_add_device_i2c(NULL, 0);
 	/* MMC */
 	at91_set_gpio_output(AT91_PIN_PB22, 1);	/* this MMC card slot can optionally use SPI signaling (CS3). */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &picotux200_mci0_data);
+#else
 	at91_add_device_mmc(0, &picotux200_mmc_data);
+#endif
 	/* NOR Flash */
 	platform_device_register(&picotux200_flash);
 }
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index b6ed5ed..2a49993 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -173,6 +173,15 @@ static void __init ek_add_device_nand(void)
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata ek_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
@@ -180,6 +189,7 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 /*
  * GPIO Buttons
@@ -249,7 +259,11 @@ static void __init ek_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&ek_macb_data);
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &ek_mci0_data);
+#else
 	at91_add_device_mmc(0, &ek_mmc_data);
+#endif
 	/* Push Buttons */
 	ek_add_device_buttons();
 	/* LEDs */
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 01332aa..b6128fb 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -90,6 +90,15 @@ static struct at91_cf_data __initdata dk_cf_data = {
 };
 
 #ifndef CONFIG_MTD_AT91_DATAFLASH_CARD
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata dk_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata dk_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
@@ -98,6 +107,7 @@ static struct at91_mmc_data __initdata dk_mmc_data = {
 	.vcc_pin	= -EINVAL,
 };
 #endif
+#endif
 
 static struct spi_board_info dk_spi_devices[] = {
 	{	/* DataFlash chip */
@@ -211,8 +221,12 @@ static void __init dk_board_init(void)
 #else
 	/* MMC */
 	at91_set_gpio_output(AT91_PIN_PB7, 1);	/* this MMC card slot can optionally use SPI signaling (CS3). */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &dk_mci0_data);
+#else
 	at91_add_device_mmc(0, &dk_mmc_data);
 #endif
+#endif
 	/* NAND */
 	at91_add_device_nand(&dk_nand_data);
 	/* NOR Flash */
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index b2e4fe2..7177aac 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -83,6 +83,7 @@ static struct at91_udc_data __initdata ek_udc_data = {
 };
 
 #ifndef CONFIG_MTD_AT91_DATAFLASH_CARD
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.det_pin	= AT91_PIN_PB27,
 	.slot_b		= 0,
@@ -90,6 +91,15 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wp_pin		= AT91_PIN_PA17,
 	.vcc_pin	= -EINVAL,
 };
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata ek_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PB27,
+		.wp_pin		= AT91_PIN_PA17,
+	}
+};
+#endif
 #endif
 
 static struct spi_board_info ek_spi_devices[] = {
@@ -180,7 +190,11 @@ static void __init ek_board_init(void)
 #else
 	/* MMC */
 	at91_set_gpio_output(AT91_PIN_PB22, 1);	/* this MMC card slot can optionally use SPI signaling (CS3). */
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 	at91_add_device_mmc(0, &ek_mmc_data);
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &ek_mci0_data);
+#endif
 #endif
 	/* NOR Flash */
 	platform_device_register(&ek_flash);
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
index af0750f..373537a 100644
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -77,12 +77,22 @@ static struct at91_usbh_data rsi_ews_usbh_data __initdata = {
 /*
  * SD/MC
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata rsi_ews_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PB27,
+		.wp_pin		= AT91_PIN_PB29,
+	},
+};
+#else
 static struct at91_mmc_data rsi_ews_mmc_data __initdata = {
 	.slot_b		= 0,
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PB27,
 	.wp_pin		= AT91_PIN_PB29,
 };
+#endif
 
 /*
  * I2C
@@ -218,7 +228,11 @@ static void __init rsi_ews_board_init(void)
 	at91_add_device_spi(rsi_ews_spi_devices,
 			ARRAY_SIZE(rsi_ews_spi_devices));
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &rsi_ews_mci0_data);
+#else
 	at91_add_device_mmc(0, &rsi_ews_mmc_data);
+#endif
 	/* NOR Flash */
 	platform_device_register(&rsiews_nor_flash);
 	/* LEDs */
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index e8b116b..7562011 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -89,7 +89,7 @@ static struct at91_udc_data __initdata ek_udc_data = {
  * SPI devices.
  */
 static struct spi_board_info ek_spi_devices[] = {
-#if !defined(CONFIG_MMC_AT91)
+#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
 	{	/* DataFlash chip */
 		.modalias	= "mtd_dataflash",
 		.chip_select	= 1,
@@ -174,6 +174,15 @@ static void __init ek_add_device_nand(void)
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata ek_mci0_data = {
+	.slot[1] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PC8,
+		.wp_pin		= AT91_PIN_PC4,
+	},
+};
+#else
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.slot_b		= 1,
 	.wire4		= 1,
@@ -181,6 +190,7 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wp_pin		= AT91_PIN_PC4,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 static void __init ek_board_init(void)
 {
@@ -197,7 +207,11 @@ static void __init ek_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&ek_macb_data);
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &ek_mci0_data);
+#else
 	at91_add_device_mmc(0, &ek_mmc_data);
+#endif
 	/* I2C */
 	at91_add_device_i2c(NULL, 0);
 }
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index d5aec55..b39009e 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -121,7 +121,7 @@ static void __init at73c213_set_clk(struct at73c213_board_info *info) {}
  * SPI devices.
  */
 static struct spi_board_info ek_spi_devices[] = {
-#if !defined(CONFIG_MMC_AT91)
+#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
 	{	/* DataFlash chip */
 		.modalias	= "mtd_dataflash",
 		.chip_select	= 1,
@@ -224,6 +224,15 @@ static void __init ek_add_device_nand(void)
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata ek_mci0_data = {
+	.slot[1] = {
+		.bus_width	= 4,
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.slot_b		= 1,
 	.wire4		= 1,
@@ -231,6 +240,7 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 
 /*
@@ -332,7 +342,11 @@ static void __init ek_board_init(void)
 	/* Ethernet */
 	at91_add_device_eth(&ek_macb_data);
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &ek_mci0_data);
+#else
 	at91_add_device_mmc(0, &ek_mmc_data);
+#endif
 	/* I2C */
 	at91_add_device_i2c(ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
 	/* SSC (to AT73C213) */
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 065fed3..797dd7c 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -344,6 +344,7 @@ static struct spi_board_info ek_spi_devices[] = {
 #else /* CONFIG_SPI_ATMEL_* */
 /* spi0 and mmc/sd share the same PIO pins: cannot be used at the same time */
 
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 /*
  * MCI (SD/MMC)
  * det_pin, wp_pin and vcc_pin are not connected
@@ -354,6 +355,15 @@ static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata mci0_data = {
+	.slot[0] = {
+		.bus_width      = 4,
+		.detect_pin     = -EINVAL,
+		.wp_pin         = -EINVAL,
+	},
+};
+#endif
 
 #endif /* CONFIG_SPI_ATMEL_* */
 
@@ -601,7 +611,11 @@ static void __init ek_board_init(void)
 	at91_add_device_ssc(AT91SAM9261_ID_SSC1, ATMEL_SSC_TX);
 #else
 	/* MMC */
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 	at91_add_device_mmc(0, &ek_mmc_data);
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &mci0_data);
+#endif
 #endif
 	/* LCD Controller */
 	at91_add_device_lcdc(&ek_lcdc_data);
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 2ffe50f..419c57a 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -149,12 +149,22 @@ static struct spi_board_info ek_spi_devices[] = {
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata mci1_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PE18,
+		.wp_pin		= AT91_PIN_PE19,
+	},
+};
+#else
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PE18,
 	.wp_pin		= AT91_PIN_PE19,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 
 /*
@@ -423,7 +433,11 @@ static void __init ek_board_init(void)
 	/* Touchscreen */
 	ek_add_device_ts();
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(1, &mci1_data);
+#else
 	at91_add_device_mmc(1, &ek_mmc_data);
+#endif
 	/* Ethernet */
 	at91_add_device_eth(&ek_macb_data);
 	/* NAND */
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index b109ce2..bb06521 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -64,12 +64,22 @@ static struct usba_platform_data __initdata ek_usba_udc_data = {
 /*
  * MCI (SD/MMC)
  */
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wire4		= 1,
 	.det_pin	= AT91_PIN_PA15,
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PA15,
+		.wp_pin		= -EINVAL,
+	},
+};
+#endif
 
 
 /*
@@ -306,7 +316,11 @@ static void __init ek_board_init(void)
 	/* SPI */
 	at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
 	/* MMC */
+#if defined(CONFIG_MMC_AT91) || defined(CONFIG_MMC_AT91_MODULE)
 	at91_add_device_mmc(0, &ek_mmc_data);
+#elif defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &mci0_data);
+#endif
 	/* LCD Controller */
 	at91_add_device_lcdc(&ek_lcdc_data);
 	/* AC97 */
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index b7483a3..879e34e 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -114,7 +114,7 @@ static struct mmc_spi_platform_data at91_mmc_spi_pdata = {
  * SPI devices.
  */
 static struct spi_board_info usb_a9263_spi_devices[] = {
-#if !defined(CONFIG_MMC_AT91)
+#if !defined(CONFIG_MMC_AT91) && !defined(CONFIG_MMC_ATMELMCI)
 	{	/* DataFlash chip */
 		.modalias	= "mtd_dataflash",
 		.chip_select	= 0,
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 38dd279..3d3b8a6 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -138,12 +138,22 @@ static struct at91_udc_data __initdata yl9200_udc_data = {
 /*
  * MMC
  */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+static struct mci_platform_data __initdata yl9200_mci0_data = {
+	.slot[0] = {
+		.bus_width	= 4,
+		.detect_pin	= AT91_PIN_PB9,
+		.wp_pin		= -EINVAL,
+	},
+};
+#else
 static struct at91_mmc_data __initdata yl9200_mmc_data = {
 	.det_pin	= AT91_PIN_PB9,
 	.wire4		= 1,
 	.wp_pin		= -EINVAL,
 	.vcc_pin	= -EINVAL,
 };
+#endif
 
 /*
  * NAND Flash
@@ -571,7 +581,11 @@ static void __init yl9200_board_init(void)
 	/* I2C */
 	at91_add_device_i2c(yl9200_i2c_devices, ARRAY_SIZE(yl9200_i2c_devices));
 	/* MMC */
+#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
+	at91_add_device_mci(0, &yl9200_mci0_data);
+#else
 	at91_add_device_mmc(0, &yl9200_mmc_data);
+#endif
 	/* NAND */
 	at91_add_device_nand(&yl9200_nand_data);
 	/* NOR Flash */
-- 
1.7.5.4

