From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic
 names
Date: Wed, 05 Oct 2011 11:01:09 +0530
Message-ID: <1317792669-19925-4-git-send-email-rajeshwari.s@samsung.com>
References: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63979 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866Ab1JEFbB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 01:31:01 -0400
In-reply-to: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

Add support for lookup of sdhci-s3c controller clocks using generic names
for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |   99 ++++++++++++++---------
 arch/arm/mach-s3c2416/clock.c |   68 +++++++++-------
 arch/arm/mach-s3c64xx/clock.c |  138 +++++++++++++++++++++-----------
 arch/arm/mach-s5pc100/clock.c |  141 +++++++++++++++++++++------------
 arch/arm/mach-s5pv210/clock.c |  177 ++++++++++++++++++++++++++---------------
 5 files changed, 391 insertions(+), 232 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index d89b45e..3a7b206 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1197,42 +1197,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_MFC, .shift = 0, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "exynos4-sdhci.0",
-			.parent		= &clk_dout_mmc0.clk,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 0),
-		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "exynos4-sdhci.1",
-			.parent         = &clk_dout_mmc1.clk,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 4),
-		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "exynos4-sdhci.2",
-			.parent         = &clk_dout_mmc2.clk,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 8),
-		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "exynos4-sdhci.3",
-			.parent         = &clk_dout_mmc3.clk,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 12),
-		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
-	}, {
-		.clk		= {
 			.name		= "sclk_dwmmc",
 			.parent         = &clk_dout_mmc4.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
@@ -1242,6 +1206,57 @@ static struct clksrc_clk clksrcs[] = {
 	}
 };
 
+static struct clksrc_clk clk_sclk_mmc0 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "exynos4-sdhci.0",
+		.parent		= &clk_dout_mmc0.clk,
+		.enable		= exynos4_clksrc_mask_fsys_ctrl,
+		.ctrlbit	= (1 << 0),
+	},
+	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
+};
+
+static struct clksrc_clk clk_sclk_mmc1 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "exynos4-sdhci.1",
+		.parent         = &clk_dout_mmc1.clk,
+		.enable		= exynos4_clksrc_mask_fsys_ctrl,
+		.ctrlbit	= (1 << 4),
+	},
+	.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
+};
+
+static struct clksrc_clk clk_sclk_mmc2 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "exynos4-sdhci.2",
+		.parent         = &clk_dout_mmc2.clk,
+		.enable		= exynos4_clksrc_mask_fsys_ctrl,
+		.ctrlbit	= (1 << 8),
+	},
+	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
+};
+
+static struct clksrc_clk clk_sclk_mmc3 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "exynos4-sdhci.3",
+		.parent         = &clk_dout_mmc3.clk,
+		.enable		= exynos4_clksrc_mask_fsys_ctrl,
+		.ctrlbit	= (1 << 12),
+	},
+	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
+	&clk_sclk_mmc3,
+};
+
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1276,6 +1291,13 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_mout_mfc1,
 };
 
+static struct clk_lookup exynos4_clk_lookup[] = {
+	CLKDEV_INIT("exynos4-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
+};
+
 static int xtal_rate;
 
 static unsigned long exynos4_fout_apll_get_rate(struct clk *clk)
@@ -1484,13 +1506,16 @@ void __init exynos4_register_clocks(void)
 		s3c_register_clksrc(sclk_tv[ptr], 1);
 
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
 
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
 	register_syscore_ops(&exynos4_clock_syscore_ops);
 	s3c24xx_register_clock(&dummy_apb_pclk);
 
+	clkdev_add_table(exynos4_clk_lookup, ARRAY_SIZE(exynos4_clk_lookup));
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 72b7c62..cebaf3f 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -82,39 +82,38 @@ static struct clksrc_clk hsmmc_div[] = {
 	},
 };
 
-static struct clksrc_clk hsmmc_mux[] = {
-	[0] = {
-		.clk	= {
-			.name	= "hsmmc-if",
-			.devname	= "s3c-sdhci.0",
-			.ctrlbit = (1 << 6),
-			.enable = s3c2443_clkcon_enable_s,
-		},
-		.sources = &(struct clksrc_sources) {
-			.nr_sources = 2,
-			.sources = (struct clk *[]) {
-				[0] = &hsmmc_div[0].clk,
-				[1] = NULL, /* to fix */
-			},
-		},
-		.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 16 },
+static struct clksrc_clk hsmmc_mux0 = {
+	.clk	= {
+		.name	= "hsmmc-if",
+		.devname	= "s3c-sdhci.0",
+		.ctrlbit = (1 << 6),
+		.enable = s3c2443_clkcon_enable_s,
 	},
-	[1] = {
-		.clk	= {
-			.name	= "hsmmc-if",
-			.devname	= "s3c-sdhci.1",
-			.ctrlbit = (1 << 12),
-			.enable = s3c2443_clkcon_enable_s,
+	.sources = &(struct clksrc_sources) {
+		.nr_sources = 2,
+		.sources = (struct clk * []) {
+			[0] = &hsmmc_div[0].clk,
+			[1] = NULL, /* to fix */
 		},
-		.sources = &(struct clksrc_sources) {
-			.nr_sources = 2,
-			.sources = (struct clk *[]) {
-				[0] = &hsmmc_div[1].clk,
-				[1] = NULL, /* to fix */
-			},
+	},
+	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 16 },
+};
+
+static struct clksrc_clk hsmmc_mux1 = {
+	.clk	= {
+		.name	= "hsmmc-if",
+		.devname	= "s3c-sdhci.1",
+		.ctrlbit = (1 << 12),
+		.enable = s3c2443_clkcon_enable_s,
+	},
+	.sources = &(struct clksrc_sources) {
+		.nr_sources = 2,
+		.sources = (struct clk * []) {
+			[0] = &hsmmc_div[1].clk,
+			[1] = NULL, /* to fix */
 		},
-		.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 17 },
 	},
+	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 17 },
 };
 
 static struct clk hsmmc0_clk = {
@@ -143,8 +142,14 @@ static struct clksrc_clk *clksrcs[] __initdata = {
 	&hsspi_mux,
 	&hsmmc_div[0],
 	&hsmmc_div[1],
-	&hsmmc_mux[0],
-	&hsmmc_mux[1],
+	&hsmmc_mux0,
+	&hsmmc_mux1,
+};
+
+static struct clk_lookup s3c2416_clk_lookup[] = {
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
 };
 
 void __init s3c2416_init_clocks(int xtal)
@@ -164,6 +169,7 @@ void __init s3c2416_init_clocks(int xtal)
 		s3c_register_clksrc(clksrcs[ptr], 1);
 
 	s3c24xx_register_clock(&hsmmc0_clk);
+	clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416_clk_lookup));
 
 	s3c_pwmclk_init();
 
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 39c238d..1fcaebf 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -243,24 +243,6 @@ static struct clk init_clocks[] = {
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_UHOST,
 	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.0",
-		.parent		= &clk_h,
-		.enable		= s3c64xx_hclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_HCLK_HSMMC0,
-	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.1",
-		.parent		= &clk_h,
-		.enable		= s3c64xx_hclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_HCLK_HSMMC1,
-	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.2",
-		.parent		= &clk_h,
-		.enable		= s3c64xx_hclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_HCLK_HSMMC2,
-	}, {
 		.name		= "otg",
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
@@ -310,6 +292,29 @@ static struct clk init_clocks[] = {
 	}
 };
 
+static struct clk clk_hsmmc0 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.0",
+	.parent		= &clk_h,
+	.enable		= s3c64xx_hclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_HCLK_HSMMC0,
+};
+
+static struct clk clk_hsmmc1 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.1",
+	.parent		= &clk_h,
+	.enable		= s3c64xx_hclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_HCLK_HSMMC1,
+};
+
+static struct clk clk_hsmmc2 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.2",
+	.parent		= &clk_h,
+	.enable		= s3c64xx_hclk_ctrl,
+	.ctrlbit	= S3C_CLKCON_HCLK_HSMMC2,
+};
 
 static struct clk clk_fout_apll = {
 	.name		= "fout_apll",
@@ -578,36 +583,6 @@ static struct clksrc_sources clkset_camif = {
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
-			.name		= "mmc_bus",
-			.devname	= "s3c-sdhci.0",
-			.ctrlbit        = S3C_CLKCON_SCLK_MMC0,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 18, .size = 2  },
-		.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 0, .size = 4  },
-		.sources	= &clkset_spi_mmc,
-	}, {
-		.clk	= {
-			.name		= "mmc_bus",
-			.devname	= "s3c-sdhci.1",
-			.ctrlbit        = S3C_CLKCON_SCLK_MMC1,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 20, .size = 2  },
-		.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 4, .size = 4  },
-		.sources	= &clkset_spi_mmc,
-	}, {
-		.clk	= {
-			.name		= "mmc_bus",
-			.devname	= "s3c-sdhci.2",
-			.ctrlbit        = S3C_CLKCON_SCLK_MMC2,
-			.enable		= s3c64xx_sclk_ctrl,
-		},
-		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 22, .size = 2  },
-		.reg_div 	= { .reg = S3C_CLK_DIV1, .shift = 8, .size = 4  },
-		.sources	= &clkset_spi_mmc,
-	}, {
-		.clk	= {
 			.name		= "usb-bus-host",
 			.ctrlbit        = S3C_CLKCON_SCLK_UHOST,
 			.enable		= s3c64xx_sclk_ctrl,
@@ -695,6 +670,63 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_mmc0 = {
+	.clk	= {
+		.name		= "mmc_bus",
+		.devname	= "s3c-sdhci.0",
+		.ctrlbit        = S3C_CLKCON_SCLK_MMC0,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 18, .size = 2  },
+	.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 0, .size = 4  },
+	.sources	= &clkset_spi_mmc,
+};
+
+static struct clksrc_clk clk_sclk_mmc1 = {
+	.clk	= {
+		.name		= "mmc_bus",
+		.devname	= "s3c-sdhci.1",
+		.ctrlbit        = S3C_CLKCON_SCLK_MMC1,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 20, .size = 2  },
+	.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 4, .size = 4  },
+	.sources	= &clkset_spi_mmc,
+};
+
+static struct clksrc_clk clk_sclk_mmc2 = {
+	.clk	= {
+		.name		= "mmc_bus",
+		.devname	= "s3c-sdhci.2",
+		.ctrlbit        = S3C_CLKCON_SCLK_MMC2,
+		.enable		= s3c64xx_sclk_ctrl,
+	},
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 22, .size = 2  },
+	.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 8, .size = 4  },
+	.sources	= &clkset_spi_mmc,
+};
+
+static struct clk *clk_cdev[] = {
+	&clk_hsmmc0,
+	&clk_hsmmc1,
+	&clk_hsmmc2,
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
+};
+
+static struct clk_lookup s3c64xx_clk_lookup[] = {
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &clk_hsmmc0),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &clk_hsmmc1),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.0", &clk_hsmmc2),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+};
+
 /* Clock initialisation code */
 
 static struct clksrc_clk *init_parents[] = {
@@ -811,17 +843,27 @@ static struct clk *clks[] __initdata = {
 void __init s3c64xx_register_clocks(unsigned long xtal, 
 				    unsigned armclk_divlimit)
 {
+	int ptr;
+
 	armclk_mask = armclk_divlimit;
 
 	s3c24xx_register_baseclocks(xtal);
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
 
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
 	s3c24xx_register_clocks(clks1, ARRAY_SIZE(clks1));
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+	clkdev_add_table(s3c64xx_clk_lookup, ARRAY_SIZE(s3c64xx_clk_lookup));
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 8d47709..1ac421b 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -426,24 +426,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5pc100_d0_2_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.2",
-		.parent		= &clk_div_d1_bus.clk,
-		.enable		= s5pc100_d1_0_ctrl,
-		.ctrlbit	= (1 << 7),
-	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.1",
-		.parent		= &clk_div_d1_bus.clk,
-		.enable		= s5pc100_d1_0_ctrl,
-		.ctrlbit	= (1 << 6),
-	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.0",
-		.parent		= &clk_div_d1_bus.clk,
-		.enable		= s5pc100_d1_0_ctrl,
-		.ctrlbit	= (1 << 5),
-	}, {
 		.name		= "modemif",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
@@ -711,6 +693,30 @@ static struct clk init_clocks_off[] = {
 	},
 };
 
+static struct clk clk_hsmmc2 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.2",
+	.parent		= &clk_div_d1_bus.clk,
+	.enable		= s5pc100_d1_0_ctrl,
+	.ctrlbit	= (1 << 7),
+};
+
+static struct clk clk_hsmmc1 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.1",
+	.parent		= &clk_div_d1_bus.clk,
+	.enable		= s5pc100_d1_0_ctrl,
+	.ctrlbit	= (1 << 6),
+};
+
+static struct clk clk_hsmmc0 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.0",
+	.parent		= &clk_div_d1_bus.clk,
+	.enable		= s5pc100_d1_0_ctrl,
+	.ctrlbit	= (1 << 5),
+};
+
 static struct clk clk_vclk54m = {
 	.name		= "vclk_54m",
 	.rate		= 54000000,
@@ -1024,39 +1030,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 24, .size = 4 },
 	}, {
 		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.0",
-			.ctrlbit	= (1 << 12),
-			.enable		= s5pc100_sclk1_ctrl,
-
-		},
-		.sources = &clk_src_mmc0,
-		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.1",
-			.ctrlbit	= (1 << 13),
-			.enable		= s5pc100_sclk1_ctrl,
-
-		},
-		.sources = &clk_src_mmc12,
-		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.2",
-			.ctrlbit	= (1 << 14),
-			.enable		= s5pc100_sclk1_ctrl,
-
-		},
-		.sources = &clk_src_mmc12,
-		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
-	}, {
-		.clk	= {
 			.name		= "sclk_irda",
 			.ctrlbit	= (1 << 10),
 			.enable		= s5pc100_sclk0_ctrl,
@@ -1098,6 +1071,63 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_mmc0 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.0",
+		.ctrlbit	= (1 << 12),
+		.enable		= s5pc100_sclk1_ctrl,
+	},
+	.sources = &clk_src_mmc0,
+	.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc1 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.1",
+		.ctrlbit	= (1 << 13),
+		.enable		= s5pc100_sclk1_ctrl,
+	},
+	.sources = &clk_src_mmc12,
+	.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc2 = {
+	.clk	= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.2",
+		.ctrlbit	= (1 << 14),
+		.enable		= s5pc100_sclk1_ctrl,
+	},
+	.sources = &clk_src_mmc12,
+	.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
+	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
+};
+
+static struct clk *clk_cdev[] = {
+	&clk_hsmmc0,
+	&clk_hsmmc1,
+	&clk_hsmmc2,
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
+};
+
+static struct clk_lookup s5pc100_clk_lookup[] = {
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &clk_hsmmc0),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &clk_hsmmc1),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.0", &clk_hsmmc2),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+};
+
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1276,12 +1306,19 @@ void __init s5pc100_register_clocks(void)
 		s3c_register_clksrc(sysclks[ptr], 1);
 
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
 
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
 	s3c24xx_register_clock(&dummy_apb_pclk);
 
+	clkdev_add_table(s5pc100_clk_lookup, ARRAY_SIZE(s5pc100_clk_lookup));
 	s3c_pwmclk_init();
 }
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 4c5ac7a..d785279 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -399,30 +399,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<25),
 	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.0",
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1<<16),
-	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.1",
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1<<17),
-	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.2",
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1<<18),
-	}, {
-		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.3",
-		.parent		= &clk_hclk_psys.clk,
-		.enable		= s5pv210_clk_ip2_ctrl,
-		.ctrlbit	= (1<<19),
-	}, {
 		.name		= "systimer",
 		.parent		= &clk_pclk_psys.clk,
 		.enable		= s5pv210_clk_ip3_ctrl,
@@ -559,6 +535,38 @@ static struct clk init_clocks[] = {
 	},
 };
 
+static struct clk clk_hsmmc0 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.0",
+	.parent		= &clk_hclk_psys.clk,
+	.enable		= s5pv210_clk_ip2_ctrl,
+	.ctrlbit	= (1<<16),
+};
+
+static struct clk clk_hsmmc1 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.1",
+	.parent		= &clk_hclk_psys.clk,
+	.enable		= s5pv210_clk_ip2_ctrl,
+	.ctrlbit	= (1<<17),
+};
+
+static struct clk clk_hsmmc2 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.2",
+	.parent		= &clk_hclk_psys.clk,
+	.enable		= s5pv210_clk_ip2_ctrl,
+	.ctrlbit	= (1<<18),
+};
+
+static struct clk clk_hsmmc3 = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.3",
+	.parent		= &clk_hclk_psys.clk,
+	.enable		= s5pv210_clk_ip2_ctrl,
+	.ctrlbit	= (1<<19),
+};
+
 static struct clk *clkset_uart_list[] = {
 	[6] = &clk_mout_mpll.clk,
 	[7] = &clk_mout_epll.clk,
@@ -906,46 +914,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 20, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.0",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 8),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.1",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 9),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.2",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 10),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 8, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 8, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.3",
-			.enable		= s5pv210_clk_mask0_ctrl,
-			.ctrlbit	= (1 << 11),
-		},
-		.sources = &clkset_group2,
-		.reg_src = { .reg = S5P_CLK_SRC4, .shift = 12, .size = 4 },
-		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
-	}, {
-		.clk		= {
 			.name		= "sclk_mfc",
 			.devname	= "s5p-mfc",
 			.enable		= s5pv210_clk_ip0_ctrl,
@@ -1022,6 +990,68 @@ static struct clksrc_clk clksrcs[] = {
 	},
 };
 
+static struct clksrc_clk clk_sclk_mmc0 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.0",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 8),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 0, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc1 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.1",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 9),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 4, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 4, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc2 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.2",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 10),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 8, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clk_sclk_mmc3 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.3",
+		.enable		= s5pv210_clk_mask0_ctrl,
+		.ctrlbit	= (1 << 11),
+	},
+	.sources = &clkset_group2,
+	.reg_src = { .reg = S5P_CLK_SRC4, .shift = 12, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
+};
+
+static struct clk *clk_cdev[] = {
+	&clk_hsmmc0,
+	&clk_hsmmc1,
+	&clk_hsmmc2,
+	&clk_hsmmc3,
+};
+
+static struct clksrc_clk *clksrc_cdev[] = {
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
+	&clk_sclk_mmc3,
+};
+
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1045,6 +1075,17 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_spdif,
 };
 
+static struct clk_lookup s5pv210_clk_lookup[] = {
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &clk_hsmmc0),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &clk_hsmmc1),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.0", &clk_hsmmc2),
+	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.0", &clk_hsmmc3),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
+};
+
 static u32 epll_div[][6] = {
 	{  48000000, 0, 48, 3, 3, 0 },
 	{  96000000, 0, 48, 3, 2, 0 },
@@ -1274,11 +1315,19 @@ void __init s5pv210_register_clocks(void)
 		s3c_register_clksrc(sclk_tv[ptr], 1);
 
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_cdev); ptr++)
+		s3c_register_clksrc(clksrc_cdev[ptr], 1);
+
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
+	clkdev_add_table(s5pv210_clk_lookup, ARRAY_SIZE(s5pv210_clk_lookup));
 	s3c24xx_register_clock(&dummy_apb_pclk);
 	s3c_pwmclk_init();
 }
-- 
1.6.6.rc2

