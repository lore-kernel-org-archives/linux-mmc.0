From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 01/10] ARM: OMAP2+: add needs_vmmc to hsmmc_info
Date: Fri, 7 Jun 2013 00:44:10 +0530
Message-ID: <1370546059-24181-2-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1370546059-24181-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add needs_vmmc and needs_vmmc_aux to indicate whether regulator is
applicable so that omap_hsmmc can handle deferred probe error
properly for regulators.
Remove the assumption that vmmc_aux regulator to be available only if vmmc is
present. Platforms can have fixed-always-ON regulator for vmmc and/or vmmc_aux
in such cases regulator needed not be specified in board file.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    1 +
 arch/arm/mach-omap2/board-3430sdp.c          |    3 +++
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
 arch/arm/mach-omap2/board-overo.c            |    1 +
 arch/arm/mach-omap2/board-rm680.c            |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 +++
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++++
 arch/arm/mach-omap2/hsmmc.c                  |    2 ++
 arch/arm/mach-omap2/hsmmc.h                  |    2 ++
 include/linux/platform_data/mmc-omap.h       |    2 ++
 19 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 244d8a5..eba8593 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -211,6 +211,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.ext_clock	= 1,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 23b004a..9438c54 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -184,12 +184,15 @@ static struct omap2_hsmmc_info mmc[] = {
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
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ee6218c..207ea13 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -364,6 +364,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{
 		.mmc		= 2,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5764205..63fd8827 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -99,6 +99,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= 29,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index b54562d..a2a8a80 100644
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
index d0d17bc..62c1a2d 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -315,6 +315,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 04c1165..5063ac3 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -264,6 +264,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d0de..a9a7507 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -279,6 +279,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 63,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 #ifdef CONFIG_WILINK_PLATFORM_DATA
 	{
@@ -288,6 +290,7 @@ static struct omap2_hsmmc_info mmc[] = {
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
index 28133d5..c22cf74 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -283,6 +283,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_wp	= 126,
 		.ext_clock	= 0,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.mmc		= 2,
@@ -292,6 +293,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.ext_clock	= 1,
 		.transceiver	= true,
 		.deferred	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.mmc		= 3,
@@ -299,6 +301,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.init_card	= pandora_wl1251_init_card,
+		.needs_vmmc	= 1,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index d37e6b1..cc1b374 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -172,6 +172,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 23,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	 },
 	{}			/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 7da48bc..1087b71 100644
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
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4ca6b68..77d1ffc 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -255,6 +255,7 @@ static struct omap2_hsmmc_info mmc[] = {
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
index 18ca61e..4f4aad5 100644
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
index a90375d..b6a49c3 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -255,6 +255,8 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.power_saving	= true,
 		.deferred	= true,
+		.needs_vmmc	= 1,
+		.needs_vmmc_aux = 1,
 	},
 	{
 		.name		= "internal",
@@ -264,6 +266,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
+		.needs_vmmc	= 1,
 	},
 	{
 		.name		= "wl1271",
@@ -272,6 +275,7 @@ static struct omap2_hsmmc_info mmc[] = {
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

