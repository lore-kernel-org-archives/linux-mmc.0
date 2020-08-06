Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A2FC433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3140E22CB3
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739025;
	bh=Oy7r9SHyawUIvZetEuefKaXnpk2XP1ss1vO4dyMGx5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bgu/68Obnw/53nXEm4yK4hg7Q+WURIYkyS7TNiOB66qskQkxeHxopCQ3KlF9uCJQO
	 K7cUnsLOOaLJ5wcSRhCVqQFxDTXyfJOLeIDjoRWdt+ZK9vWkm5HBs3VMOj5ow4xtM0
	 8c2BU1MYskTRoKFShHLf7SGqRof4xSlgB+FyGuW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgHFShD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgHFSf7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6C922DD6;
        Thu,  6 Aug 2020 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738231;
        bh=Oy7r9SHyawUIvZetEuefKaXnpk2XP1ss1vO4dyMGx5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKG9MdF37WfmDgSfif740tNptwyX3mCLsUQy+6qDKurjV+iNFlLYuzrKxfyXDb9hW
         vaLaT6/ak9iT4vTxgtfOJ59K53OrtVW6L8bu48dhy1L9gXIDBzA03hS6PJ29N763fH
         FwDdVeUrBnXBxhv9znjZohxH7bBOTi3BBp7G5bkY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ben Dooks <ben-linux@fluff.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 29/41] ARM: s3c24xx: move s3cmci pinctrl handling into board files
Date:   Thu,  6 Aug 2020 20:20:46 +0200
Message-Id: <20200806182059.2431-29-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Rather than call the internal s3c_gpio_cfgall_range() function
through a platform header, move the code into the set_power
callback that is already exported by the board, and add
a default implementation.

In DT mode, the code already does not set the pin config,
so nothing changes there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
[krzk: Rebase and correct set_power in mach-h1940.c]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Minor whitespace changes,
2. mach-h1940.c already had set_power.
---
 arch/arm/mach-s3c24xx/include/mach/pm-core.h |  1 +
 arch/arm/mach-s3c24xx/mach-amlm5900.c        | 15 +++++
 arch/arm/mach-s3c24xx/mach-at2440evb.c       | 10 ++-
 arch/arm/mach-s3c24xx/mach-gta02.c           | 15 +++++
 arch/arm/mach-s3c24xx/mach-h1940.c           |  9 +++
 arch/arm/mach-s3c24xx/mach-mini2440.c        |  9 ++-
 arch/arm/mach-s3c24xx/mach-n30.c             |  9 +++
 arch/arm/mach-s3c24xx/mach-qt2410.c          | 15 +++++
 arch/arm/mach-s3c24xx/mach-rx1950.c          |  9 +++
 arch/arm/mach-s3c24xx/mach-tct_hammer.c      | 15 +++++
 arch/arm/plat-samsung/devs.c                 | 29 ++++++++
 drivers/mmc/host/s3cmci.c                    | 71 +++++---------------
 include/linux/platform_data/mmc-s3cmci.h     |  2 +
 13 files changed, 153 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
index 8f87606c4cdc..a22b4a37ee57 100644
--- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
@@ -12,6 +12,7 @@
 
 #include "regs-clock.h"
 #include "regs-irq.h"
+#include <mach/irqs.h>
 
 static inline void s3c_pm_debug_init_uart(void)
 {
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index 6324e608dcda..1a2a9259b4b6 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/timer.h>
 #include <linux/init.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -121,6 +122,19 @@ static struct s3c2410_uartcfg amlm5900_uartcfgs[] = {
 	}
 };
 
+static struct gpiod_lookup_table amlm5900_mmc_gpio_table = {
+	.dev_id = "s3c2410-sdi",
+	.table = {
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
 
 static struct platform_device *amlm5900_devices[] __initdata = {
 #ifdef CONFIG_FB_S3C2410
@@ -216,6 +230,7 @@ static void __init amlm5900_init(void)
 	s3c24xx_fb_set_platdata(&amlm5900_fb_info);
 #endif
 	s3c_i2c0_set_platdata(NULL);
+	gpiod_add_lookup_table(&amlm5900_mmc_gpio_table);
 	platform_add_devices(amlm5900_devices, ARRAY_SIZE(amlm5900_devices));
 }
 
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index fe8f9f1bdc0a..a2693246b3ca 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -134,7 +134,7 @@ static struct platform_device at2440evb_device_eth = {
 };
 
 static struct s3c24xx_mci_pdata at2440evb_mci_pdata __initdata = {
-	/* Intentionally left blank */
+	.set_power	= s3c24xx_mci_def_set_power,
 };
 
 static struct gpiod_lookup_table at2440evb_mci_gpio_table = {
@@ -142,10 +142,18 @@ static struct gpiod_lookup_table at2440evb_mci_gpio_table = {
 	.table = {
 		/* Card detect S3C2410_GPG(10) */
 		GPIO_LOOKUP("GPIOG", 10, "cd", GPIO_ACTIVE_LOW),
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
 
+
 /* 7" LCD panel */
 
 static struct s3c2410fb_display at2440evb_lcd_cfg __initdata = {
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 3c7f2a3d00a5..c023e261a240 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -487,6 +487,20 @@ static struct platform_device gta02_audio = {
 	.id = -1,
 };
 
+static struct gpiod_lookup_table gta02_mmc_gpio_table = {
+	.dev_id = "s3c2410-sdi",
+	.table = {
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void __init gta02_map_io(void)
 {
 	s3c24xx_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
@@ -543,6 +557,7 @@ static void __init gta02_machine_init(void)
 			      S3C_GPIO_PULL_NONE);
 
 	gpiod_add_lookup_table(&gta02_audio_gpio_table);
+	gpiod_add_lookup_table(&gta02_mmc_gpio_table);
 	platform_add_devices(gta02_devices, ARRAY_SIZE(gta02_devices));
 	pm_power_off = gta02_poweroff;
 
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 1f18ac4e84b2..e9b3b048a96d 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -445,6 +445,8 @@ static struct platform_device h1940_device_bluetooth = {
 
 static void h1940_set_mmc_power(unsigned char power_mode, unsigned short vdd)
 {
+	s3c24xx_mci_def_set_power(power_mode, vdd);
+
 	switch (power_mode) {
 	case MMC_POWER_OFF:
 		gpio_set_value(H1940_LATCH_SD_POWER, 0);
@@ -470,6 +472,13 @@ static struct gpiod_lookup_table h1940_mmc_gpio_table = {
 		GPIO_LOOKUP("GPIOF", 5, "cd", GPIO_ACTIVE_LOW),
 		/* Write protect S3C2410_GPH(8) */
 		GPIO_LOOKUP("GPIOH", 8, "wp", GPIO_ACTIVE_LOW),
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 0bd2746f19a6..d3cc0141f58c 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -234,7 +234,7 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 
 static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
 	.wprotect_invert	= 1,
-	.set_power		= NULL,
+	.set_power		= s3c24xx_mci_def_set_power,
 	.ocr_avail		= MMC_VDD_32_33|MMC_VDD_33_34,
 };
 
@@ -245,6 +245,13 @@ static struct gpiod_lookup_table mini2440_mmc_gpio_table = {
 		GPIO_LOOKUP("GPIOG", 8, "cd", GPIO_ACTIVE_LOW),
 		/* Write protect S3C2410_GPH(8) */
 		GPIO_LOOKUP("GPIOH", 8, "wp", GPIO_ACTIVE_HIGH),
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 9410fcb82340..24e97646b068 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -368,6 +368,8 @@ static struct s3c2410fb_mach_info n30_fb_info __initdata = {
 
 static void n30_sdi_set_power(unsigned char power_mode, unsigned short vdd)
 {
+	s3c24xx_mci_def_set_power(power_mode, vdd);
+
 	switch (power_mode) {
 	case MMC_POWER_ON:
 	case MMC_POWER_UP:
@@ -393,6 +395,13 @@ static struct gpiod_lookup_table n30_mci_gpio_table = {
 		/* Write protect S3C2410_GPG(10) */
 		GPIO_LOOKUP("GPIOG", 10, "wp", GPIO_ACTIVE_LOW),
 		{ },
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
 	},
 };
 
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 5e33f3da629e..b21f7fbcadf9 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -223,6 +223,20 @@ static struct gpiod_lookup_table qt2410_spi_gpiod_table = {
 	},
 };
 
+static struct gpiod_lookup_table qt2410_mmc_gpiod_table = {
+	.dev_id = "s3c2410-sdi",
+	.table = {
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /* Board devices */
 
 static struct platform_device *qt2410_devices[] __initdata = {
@@ -347,6 +361,7 @@ static void __init qt2410_machine_init(void)
 	gpiod_add_lookup_table(&qt2410_spi_gpiod_table);
 	s3c_gpio_setpull(S3C2410_GPB(0), S3C_GPIO_PULL_NONE);
 	gpiod_add_lookup_table(&qt2410_led_gpio_table);
+	gpiod_add_lookup_table(&qt2410_mmc_gpiod_table);
 	platform_add_devices(qt2410_devices, ARRAY_SIZE(qt2410_devices));
 	s3c_pm_init();
 }
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 86d348f33972..aa91785a95b5 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -548,6 +548,8 @@ static struct platform_device rx1950_backlight = {
 
 static void rx1950_set_mmc_power(unsigned char power_mode, unsigned short vdd)
 {
+	s3c24xx_mci_def_set_power(power_mode, vdd);
+
 	switch (power_mode) {
 	case MMC_POWER_OFF:
 		gpio_direction_output(S3C2410_GPJ(1), 0);
@@ -573,6 +575,13 @@ static struct gpiod_lookup_table rx1950_mmc_gpio_table = {
 		GPIO_LOOKUP("GPIOF", 5, "cd", GPIO_ACTIVE_LOW),
 		/* Write protect S3C2410_GPH(8) */
 		GPIO_LOOKUP("GPIOH", 8, "wp", GPIO_ACTIVE_LOW),
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index fd51a098e443..8092be7b47db 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -7,6 +7,7 @@
 // derived from linux/arch/arm/mach-s3c2410/mach-bast.c, written by
 // Ben Dooks <ben@simtec.co.uk>
 
+#include <linux/gpio/machine.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -101,6 +102,19 @@ static struct s3c2410_uartcfg tct_hammer_uartcfgs[] = {
 	}
 };
 
+static struct gpiod_lookup_table tct_hammer_mmc_gpio_table = {
+	.dev_id = "s3c2410-sdi",
+	.table = {
+		/* bus pins */
+		GPIO_LOOKUP_IDX("GPIOE",  5, "bus", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  6, "bus", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  7, "bus", 2, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  8, "bus", 3, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE",  9, "bus", 4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIOE", 10, "bus", 5, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
 
 static struct platform_device *tct_hammer_devices[] __initdata = {
 	&s3c_device_adc,
@@ -129,6 +143,7 @@ static void __init tct_hammer_init_time(void)
 static void __init tct_hammer_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
+	gpiod_add_lookup_table(&tct_hammer_mmc_gpio_table);
 	platform_add_devices(tct_hammer_devices, ARRAY_SIZE(tct_hammer_devices));
 }
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index c42e4a272cc7..b16be04c0169 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -5,6 +5,7 @@
 //
 // Base Samsung platform device definitions
 
+#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
@@ -39,6 +40,7 @@
 
 #include <mach/irqs.h>
 #include <mach/map.h>
+#include <mach/gpio-samsung.h>
 
 #ifdef CONFIG_PLAT_S3C24XX
 #include <mach/regs-s3c2443-clock.h>
@@ -46,6 +48,7 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/gpio-cfg.h>
 #include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <plat/fb.h>
@@ -835,16 +838,42 @@ struct platform_device s3c_device_rtc = {
 /* SDI */
 
 #ifdef CONFIG_PLAT_S3C24XX
+void s3c24xx_mci_def_set_power(unsigned char power_mode, unsigned short vdd)
+{
+	switch (power_mode) {
+	case MMC_POWER_ON:
+	case MMC_POWER_UP:
+		/* Configure GPE5...GPE10 pins in SD mode */
+		s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
+				      S3C_GPIO_PULL_NONE);
+		break;
+
+	case MMC_POWER_OFF:
+	default:
+		gpio_direction_output(S3C2410_GPE(5), 0);
+		break;
+	}
+}
+
 static struct resource s3c_sdi_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C24XX_PA_SDI, S3C24XX_SZ_SDI),
 	[1] = DEFINE_RES_IRQ(IRQ_SDI),
 };
 
+static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
+	/* This is currently here to avoid a number of if (host->pdata)
+	 * checks. Any zero fields to ensure reasonable defaults are picked. */
+	.no_wprotect = 1,
+	.no_detect = 1,
+	.set_power = s3c24xx_mci_def_set_power,
+};
+
 struct platform_device s3c_device_sdi = {
 	.name		= "s3c2410-sdi",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s3c_sdi_resource),
 	.resource	= s3c_sdi_resource,
+	.dev.platform_data = &s3cmci_def_pdata,
 };
 
 void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 60fc3fc30fb4..dcd458649338 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -24,10 +24,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/mmc/slot-gpio.h>
-
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
-
 #include <linux/platform_data/mmc-s3cmci.h>
 
 #include "s3cmci.h"
@@ -306,7 +302,8 @@ static inline void clear_imask(struct s3cmci_host *host)
 static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 {
 	if (host->sdio_irqen) {
-		if (gpio_get_value(S3C2410_GPE(8)) == 0) {
+		if (host->pdata->bus[3] &&
+		    gpiod_get_value(host->pdata->bus[3]) == 0) {
 			pr_debug("%s: signalling irq\n", __func__);
 			mmc_signal_sdio_irq(host->mmc);
 		}
@@ -1202,33 +1199,20 @@ static void s3cmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_ON:
 	case MMC_POWER_UP:
-		/* Configure GPE5...GPE10 pins in SD mode */
-		if (!host->pdev->dev.of_node)
-			s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
-					      S3C_GPIO_PULL_NONE);
-
-		if (host->pdata->set_power)
-			host->pdata->set_power(ios->power_mode, ios->vdd);
-
 		if (!host->is2440)
 			mci_con |= S3C2410_SDICON_FIFORESET;
-
 		break;
 
 	case MMC_POWER_OFF:
 	default:
-		if (!host->pdev->dev.of_node)
-			gpio_direction_output(S3C2410_GPE(5), 0);
-
 		if (host->is2440)
 			mci_con |= S3C2440_SDICON_SDRESET;
-
-		if (host->pdata->set_power)
-			host->pdata->set_power(ios->power_mode, ios->vdd);
-
 		break;
 	}
 
+	if (host->pdata->set_power)
+		host->pdata->set_power(ios->power_mode, ios->vdd);
+
 	s3cmci_set_clk(host, ios);
 
 	/* Set CLOCK_ENABLE */
@@ -1306,13 +1290,6 @@ static const struct mmc_host_ops s3cmci_ops = {
 	.enable_sdio_irq = s3cmci_enable_sdio_irq,
 };
 
-static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
-	/* This is currently here to avoid a number of if (host->pdata)
-	 * checks. Any zero fields to ensure reasonable defaults are picked. */
-	 .no_wprotect = 1,
-	 .no_detect = 1,
-};
-
 #ifdef CONFIG_ARM_S3C24XX_CPUFREQ
 
 static int s3cmci_cpufreq_transition(struct notifier_block *nb,
@@ -1466,24 +1443,21 @@ static int s3cmci_probe_pdata(struct s3cmci_host *host)
 	int i, ret;
 
 	host->is2440 = platform_get_device_id(pdev)->driver_data;
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "need platform data");
+		return -ENXIO;
+	}
 
-	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++) {
-		ret = gpio_request(i, dev_name(&pdev->dev));
-		if (ret) {
+	for (i = 0; i < 6; i++) {
+		pdata->bus[i] = devm_gpiod_get_index(&pdev->dev, "bus", i,
+						     GPIOD_OUT_LOW);
+		if (IS_ERR(pdata->bus[i])) {
 			dev_err(&pdev->dev, "failed to get gpio %d\n", i);
-
-			for (i--; i >= S3C2410_GPE(5); i--)
-				gpio_free(i);
-
-			return ret;
+			return PTR_ERR(pdata->bus[i]);
 		}
 	}
 
-	if (!pdev->dev.platform_data)
-		pdev->dev.platform_data = &s3cmci_def_pdata;
-
-	pdata = pdev->dev.platform_data;
-
 	if (pdata->no_wprotect)
 		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 
@@ -1538,7 +1512,6 @@ static int s3cmci_probe(struct platform_device *pdev)
 	struct s3cmci_host *host;
 	struct mmc_host	*mmc;
 	int ret;
-	int i;
 
 	mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
 	if (!mmc) {
@@ -1582,7 +1555,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 			"failed to get io memory region resource.\n");
 
 		ret = -ENOENT;
-		goto probe_free_gpio;
+		goto probe_free_host;
 	}
 
 	host->mem = request_mem_region(host->mem->start,
@@ -1591,7 +1564,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 	if (!host->mem) {
 		dev_err(&pdev->dev, "failed to request io memory region.\n");
 		ret = -ENOENT;
-		goto probe_free_gpio;
+		goto probe_free_host;
 	}
 
 	host->base = ioremap(host->mem->start, resource_size(host->mem));
@@ -1715,11 +1688,6 @@ static int s3cmci_probe(struct platform_device *pdev)
  probe_free_mem_region:
 	release_mem_region(host->mem->start, resource_size(host->mem));
 
- probe_free_gpio:
-	if (!pdev->dev.of_node)
-		for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
-			gpio_free(i);
-
  probe_free_host:
 	mmc_free_host(mmc);
 
@@ -1745,7 +1713,6 @@ static int s3cmci_remove(struct platform_device *pdev)
 {
 	struct mmc_host		*mmc  = platform_get_drvdata(pdev);
 	struct s3cmci_host	*host = mmc_priv(mmc);
-	int i;
 
 	s3cmci_shutdown(pdev);
 
@@ -1758,10 +1725,6 @@ static int s3cmci_remove(struct platform_device *pdev)
 
 	free_irq(host->irq, host);
 
-	if (!pdev->dev.of_node)
-		for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
-			gpio_free(i);
-
 	iounmap(host->base);
 	release_mem_region(host->mem->start, resource_size(host->mem));
 
diff --git a/include/linux/platform_data/mmc-s3cmci.h b/include/linux/platform_data/mmc-s3cmci.h
index 33310b11cbdd..bacb86db3112 100644
--- a/include/linux/platform_data/mmc-s3cmci.h
+++ b/include/linux/platform_data/mmc-s3cmci.h
@@ -35,6 +35,7 @@ struct s3c24xx_mci_pdata {
 	unsigned long	ocr_avail;
 	void		(*set_power)(unsigned char power_mode,
 				     unsigned short vdd);
+	struct gpio_desc *bus[6];
 };
 
 /**
@@ -44,6 +45,7 @@ struct s3c24xx_mci_pdata {
  * Copy the platform data supplied by @pdata so that this can be marked
  * __initdata.
  */
+extern void s3c24xx_mci_def_set_power(unsigned char power_mode, unsigned short vdd);
 extern void s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata);
 
 #endif /* _ARCH_NCI_H */
-- 
2.17.1

