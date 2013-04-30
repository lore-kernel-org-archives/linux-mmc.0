From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 01/13] ARM: OMAP2+: add needs_vmmc to hsmmc_info
Date: Tue, 30 Apr 2013 19:33:41 +0530
Message-ID: <1367330633-5941-2-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58081 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760687Ab3D3OEG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Apr 2013 10:04:06 -0400
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>

Add needs_vmmc and needs_vmmc_aux to indicate whether regulator is
applicable so that omap_hsmmc can handle regulator deferred probe error
properly.
Remove the assumption that vmmc_aux regulator to be available only if vmmc is
present. Platforms can have fixed-always-ON regulator for vmmc and/or vmmc_aux
in such cases regulator needed not be specified in board file.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    1 +
 arch/arm/mach-omap2/board-3430sdp.c          |    3 +++
 arch/arm/mach-omap2/board-4430sdp.c          |    3 +++
 arch/arm/mach-omap2/board-cm-t35.c           |    2 ++
 arch/arm/mach-omap2/board-devkit8000.c       |    1 +
 arch/arm/mach-omap2/board-igep0020.c         |    3 +++
 arch/arm/mach-omap2/board-ldp.c              |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 ++
 arch/arm/mach-omap2/board-omap3evm.c         |    3 +++
 arch/arm/mach-omap2/board-omap3logic.c       |    1 +
 arch/arm/mach-omap2/board-omap3pandora.c     |    3 +++
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 ++
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 ++
 arch/arm/mach-omap2/board-omap4panda.c       |    2 ++
 arch/arm/mach-omap2/board-overo.c            |    1 +
 arch/arm/mach-omap2/board-rm680.c            |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++++
 arch/arm/mach-omap2/hsmmc.c                  |    2 ++
 arch/arm/mach-omap2/hsmmc.h                  |    2 ++
 include/linux/platform_data/mmc-omap.h       |    2 ++
 21 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a3e0aaa..538dd55 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -242,6 +242,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.ext_clock	= 1,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ce812de..6432227 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -201,12 +201,15 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 4,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{
 		.mmc		= 2,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 7,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 35f3ad0..c28ce4e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -461,12 +461,14 @@ static struct omap2_hsmmc_info mmc[] = {
 		.nonremovable   = true,
 		.ocr_mask	= MMC_VDD_29_30,
 		.no_off_init	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.needs_vmmc	= 1,
 	},
 	{
 		.mmc		= 5,
@@ -476,6 +478,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.ocr_mask	= MMC_VDD_165_195,
 		.nonremovable	= true,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index af2bb21..f616961 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -407,6 +407,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{
 		.mmc		= 2,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 53056c3..fc02ab1 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -100,6 +100,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index bf92678..0c71f90 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -284,6 +284,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
 	{
@@ -291,6 +292,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 #endif
 	{}      /* Terminator */
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index b12fe96..770f5bc 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -358,6 +358,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index c3558f9..a81087c 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -263,6 +263,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 48789e0..6eb29c2 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -309,6 +309,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 63,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 #ifdef CONFIG_WILINK_PLATFORM_DATA
 	{
@@ -318,6 +320,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
 		.nonremovable	= true,
+		.needs_vmmc	= 1,
 	},
 #endif
 	{}	/* Terminator */
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index bab51e6..ff00c81 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -104,6 +104,7 @@ static struct omap2_hsmmc_info __initdata board_mmc_info[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.needs_vmmc	= 1,
 	},
 	{}      /* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 2bba362..4c1d646 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -278,6 +278,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_wp	= 126,
 		.ext_clock	= 0,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.mmc		= 2,
@@ -287,6 +288,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.ext_clock	= 1,
 		.transceiver	= true,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.mmc		= 3,
@@ -294,6 +296,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.init_card	= pandora_wl1251_init_card,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 95c10b3..b445a1a 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -184,6 +184,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 23,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	 },
 	{}			/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index bcd44fb..d8a1ca3 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -103,6 +103,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b02c2f0..f9eaa7b 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -199,6 +199,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
+		.needs_vmmc	= 1,
 	},
 	{
 		.name		= "wl1271",
@@ -208,6 +209,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.ocr_mask	= MMC_VDD_165_195,
 		.nonremovable	= true,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 86bab51..b5874e9 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -285,6 +285,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.needs_vmmc	= 1,
 	},
 	{
 		.mmc		= 2,
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 345e8c4..9d4bcc1 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -106,6 +106,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.needs_vmmc	= 1,
 	},
 	{ /* Terminator */ }
 };
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3a077df..ef36a5e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -496,6 +496,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_cd	= 160,
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.name		= "internal",
@@ -507,6 +508,8 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.nonremovable	= true,
 		.power_saving	= true,
 		.remux		= rx51_mmc2_remux,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index cdc0c10..deab49c 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -205,6 +205,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{
 		.name		= "internal",
@@ -214,6 +216,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.name		= "wl1271",
@@ -222,6 +225,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
 		.nonremovable	= true,
+		.needs_vmmc	= 1,
 	},
 	{}      /* Terminator */
 };
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 2ef1f87..9e8b02c 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -313,6 +313,8 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 								c->mmc, 1);
 	mmc->slots[0].name = hc_name;
 	mmc->nr_slots = 1;
+	mmc->needs_vmmc = c->needs_vmmc;
+	mmc->needs_vmmc_aux = c->needs_vmmc_aux;
 	mmc->slots[0].caps = c->caps;
 	mmc->slots[0].pm_caps = c->pm_caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 7f2e790..9bc71ee 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -33,6 +33,8 @@ struct omap2_hsmmc_info {
 	void (*remux)(struct device *dev, int slot, int power_on);
 	/* init some special card */
 	void (*init_card)(struct mmc_card *card);
+	unsigned needs_vmmc:1;
+	unsigned needs_vmmc_aux:1;
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 2bf1b30..11583a6 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -66,6 +66,8 @@ struct omap_mmc_platform_data {
 
 	/* Register offset deviation */
 	u16 reg_offset;
+	unsigned needs_vmmc:1;
+	unsigned needs_vmmc_aux:1;
 
 	struct omap_mmc_slot_data {
 
-- 
1.7.5.4

