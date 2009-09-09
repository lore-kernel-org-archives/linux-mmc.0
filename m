From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/3] MMCI pass capabilities in platform data
Date: Wed,  9 Sep 2009 22:55:15 +0200
Message-ID: <1252529715-7698-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:56700 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753018AbZIIUzd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Sep 2009 16:55:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@stericsson.com>

This makes it possible to pass down the host controller
capabilities for the MMCI driver using the platform data. It
also provides the capabilties for the U300 implementation as an
example, and makes sure the 4bit wide mode is set if this is
requested by the ios() now that we can actually set that
capability for a platform.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/include/asm/mach/mmc.h |    1 +
 arch/arm/mach-u300/mmc.c        |    2 ++
 drivers/mmc/host/mmci.c         |    4 ++++
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/mmc.h b/arch/arm/include/asm/mach/mmc.h
index b490ecc..27bec55 100644
--- a/arch/arm/include/asm/mach/mmc.h
+++ b/arch/arm/include/asm/mach/mmc.h
@@ -12,6 +12,7 @@ struct mmc_platform_data {
 	unsigned int (*status)(struct device *);
 	int	gpio_wp;
 	int	gpio_cd;
+	unsigned long capabilities;
 };
 
 #endif
diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index e53409d..82af247 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -160,6 +160,8 @@ int __devinit mmc_init(struct amba_device *adev)
 	mmci_card->mmc0_plat_data.status = mmc_status;
 	mmci_card->mmc0_plat_data.gpio_wp = -1;
 	mmci_card->mmc0_plat_data.gpio_cd = -1;
+	mmci_card->mmc0_plat_data.capabilities = MMC_CAP_MMC_HIGHSPEED |
+		MMC_CAP_SD_HIGHSPEED | MMC_CAP_4_BIT_DATA;
 
 	mmcsd_device->platform_data = (void *) &mmci_card->mmc0_plat_data;
 
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 083f9b8..cee91e9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -62,6 +62,9 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 		/* clk |= MCI_CLK_PWRSAVE; */
 	}
 
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+		clk |= MCI_WIDE_BUS;
+
 	writel(clk, host->base + MMCICLOCK);
 }
 
@@ -601,6 +604,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	mmc->f_min = (host->mclk + 511) / 512;
 	mmc->f_max = min(host->mclk, fmax);
 	mmc->ocr_avail = plat->ocr_mask;
+	mmc->caps = plat->capabilities;
 
 	/*
 	 * We can do SGIO
-- 
1.6.2.1

