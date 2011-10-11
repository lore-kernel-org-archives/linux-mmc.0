From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH V3 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using
 generic names
Date: Tue, 11 Oct 2011 13:45:07 +0530
Message-ID: <1318320907-8580-4-git-send-email-rajeshwari.s@samsung.com>
References: <1318320907-8580-1-git-send-email-rajeshwari.s@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1318320907-8580-1-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add support for lookup of sdhci-s3c controller clocks using generic names
for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |   88 +++++++++++++---------
 arch/arm/mach-s3c2416/clock.c |   85 +++++++++++++--------
 arch/arm/mach-s3c64xx/clock.c |  126 +++++++++++++++++++------------
 arch/arm/mach-s5pc100/clock.c |  130 +++++++++++++++++++-------------
 arch/arm/mach-s5pv210/clock.c |  167 +++++++++++++++++++++++++----------------
 5 files changed, 364 insertions(+), 232 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 9f50e33..c6383b9 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1157,42 +1157,6 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_MFC, .shift = 0, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.0",
-			.parent		= &clk_dout_mmc0.clk,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 0),
-		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.1",
-			.parent         = &clk_dout_mmc1.clk,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 4),
-		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.2",
-			.parent         = &clk_dout_mmc2.clk,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 8),
-		},
-		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
-	}, {
-		.clk		= {
-			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.3",
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
@@ -1250,6 +1214,50 @@ static struct clksrc_clk clk_sclk_uart3 = {
 	.reg_div = { .reg = S5P_CLKDIV_PERIL0, .shift = 12, .size = 4 },
 };
 
+static struct clksrc_clk clk_sclk_mmc0 = {
+	.clk		= {
+		.name		= "sclk_mmc",
+		.devname	= "s3c-sdhci.0",
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
+		.devname	= "s3c-sdhci.1",
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
+		.devname	= "s3c-sdhci.2",
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
+		.devname	= "s3c-sdhci.3",
+		.parent         = &clk_dout_mmc3.clk,
+		.enable		= exynos4_clksrc_mask_fsys_ctrl,
+		.ctrlbit	= (1 << 12),
+	},
+	.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
+};
+
 /* Clock initialization code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1289,6 +1297,10 @@ static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uart1,
 	&clk_sclk_uart2,
 	&clk_sclk_uart3,
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
+	&clk_sclk_mmc3,
 };
 
 static struct clk_lookup exynos4_clk_lookup[] = {
@@ -1296,6 +1308,10 @@ static struct clk_lookup exynos4_clk_lookup[] = {
 	CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_sclk_uart1.clk),
 	CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_sclk_uart2.clk),
 	CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_sclk_uart3.clk),
+	CLKDEV_INIT("exynos4-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
 };
 
 static int xtal_rate;
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 72b7c62..4d84b15 100644
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
@@ -125,6 +124,14 @@ static struct clk hsmmc0_clk = {
 	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
 };
 
+static struct clk hsmmc1_clk = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.1",
+	.parent		= &clk_h,
+	.enable		= s3c2443_clkcon_enable_h,
+	.ctrlbit	= S3C2443_HCLKCON_HSMMC,
+};
+
 static inline unsigned int s3c2416_fclk_div(unsigned long clkcon0)
 {
 	clkcon0 &= 7 << S3C2443_CLKDIV0_ARMDIV_SHIFT;
@@ -137,14 +144,25 @@ void __init_or_cpufreq s3c2416_setup_clocks(void)
 	s3c2443_common_setup_clocks(s3c2416_get_pll, s3c2416_fclk_div);
 }
 
-
 static struct clksrc_clk *clksrcs[] __initdata = {
 	&hsspi_eplldiv,
 	&hsspi_mux,
 	&hsmmc_div[0],
 	&hsmmc_div[1],
-	&hsmmc_mux[0],
-	&hsmmc_mux[1],
+	&hsmmc_mux0,
+	&hsmmc_mux1,
+};
+
+static struct clk *clk_cdev[] = {
+	&hsmmc0_clk,
+	&hsmmc1_clk,
+};
+
+static struct clk_lookup s3c2416_clk_lookup[] = {
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &hsmmc1_clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
 };
 
 void __init s3c2416_init_clocks(int xtal)
@@ -163,7 +181,8 @@ void __init s3c2416_init_clocks(int xtal)
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_register_clksrc(clksrcs[ptr], 1);
 
-	s3c24xx_register_clock(&hsmmc0_clk);
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416_clk_lookup));
 
 	s3c_pwmclk_init();
 
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 2addd98..415c540 100644
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
@@ -697,6 +672,42 @@ static struct clksrc_clk clk_sclk_uclk = {
 	.sources	= &clkset_uart,
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
 /* Clock initialisation code */
 
 static struct clksrc_clk *init_parents[] = {
@@ -707,11 +718,26 @@ static struct clksrc_clk *init_parents[] = {
 
 static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uclk,
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
+};
+
+static struct clk *clk_cdev[] = {
+	&clk_hsmmc0,
+	&clk_hsmmc1,
+	&clk_hsmmc2,
 };
 
 static struct clk_lookup s3c64xx_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
 	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uclk.clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &clk_hsmmc0),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &clk_hsmmc1),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.0", &clk_hsmmc2),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 };
 
 #define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
@@ -834,6 +860,10 @@ void __init s3c64xx_register_clocks(unsigned long xtal,
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (cnt = 0; cnt < ARRAY_SIZE(clk_cdev); cnt++)
+		s3c_disable_clocks(clk_cdev[cnt], 1);
+
 	s3c24xx_register_clocks(clks1, ARRAY_SIZE(clks1));
 	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
 	for (cnt = 0; cnt < ARRAY_SIZE(clksrc_cdev); cnt++)
diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 9d644ec..69829ba 100644
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
@@ -1014,39 +1020,6 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -1099,6 +1072,42 @@ static struct clksrc_clk clk_sclk_uart = {
 	.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
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
 /* Clock initialisation code */
 static struct clksrc_clk *sysclks[] = {
 	&clk_mout_apll,
@@ -1128,8 +1137,17 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_spdif,
 };
 
+static struct clk *clk_cdev[] = {
+	&clk_hsmmc0,
+	&clk_hsmmc1,
+	&clk_hsmmc2,
+};
+
 static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uart,
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
 };
 
 void __init_or_cpufreq s5pc100_setup_clocks(void)
@@ -1274,6 +1292,12 @@ static struct clk *clks[] __initdata = {
 static struct clk_lookup s5pc100_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
 	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_sclk_uart.clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &clk_hsmmc0),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &clk_hsmmc1),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.0", &clk_hsmmc2),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
 };
 
 void __init s5pc100_register_clocks(void)
@@ -1294,6 +1318,10 @@ void __init s5pc100_register_clocks(void)
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	clkdev_add_table(s5pc100_clk_lookup, ARRAY_SIZE(s5pc100_clk_lookup));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
 	s3c24xx_register_clock(&dummy_apb_pclk);
 
 	s3c_pwmclk_init();
diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 43a045d..dc4586b 100644
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
@@ -866,46 +874,6 @@ static struct clksrc_clk clksrcs[] = {
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
@@ -1030,11 +998,70 @@ static struct clksrc_clk clk_sclk_uart3	= {
 	.reg_div = { .reg = S5P_CLK_DIV4, .shift = 28, .size = 4 },
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
 static struct clksrc_clk *clksrc_cdev[] = {
 	&clk_sclk_uart0,
 	&clk_sclk_uart1,
 	&clk_sclk_uart2,
 	&clk_sclk_uart3,
+	&clk_sclk_mmc0,
+	&clk_sclk_mmc1,
+	&clk_sclk_mmc2,
+	&clk_sclk_mmc3,
+};
+
+static struct clk *clk_cdev[] = {
+	&clk_hsmmc0,
+	&clk_hsmmc1,
+	&clk_hsmmc2,
+	&clk_hsmmc3,
 };
 
 /* Clock initialisation code */
@@ -1282,6 +1309,14 @@ static struct clk_lookup s5pv210_clk_lookup[] = {
 	CLKDEV_INIT("s5pv210-uart.1", "clk_uart_baud1", &clk_sclk_uart1.clk),
 	CLKDEV_INIT("s5pv210-uart.2", "clk_uart_baud1", &clk_sclk_uart2.clk),
 	CLKDEV_INIT("s5pv210-uart.3", "clk_uart_baud1", &clk_sclk_uart3.clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &clk_hsmmc0),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &clk_hsmmc1),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.0", &clk_hsmmc2),
+	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.0", &clk_hsmmc3),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
 };
 
 void __init s5pv210_register_clocks(void)
@@ -1306,6 +1341,10 @@ void __init s5pv210_register_clocks(void)
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	clkdev_add_table(s5pv210_clk_lookup, ARRAY_SIZE(s5pv210_clk_lookup));
 
+	s3c24xx_register_clocks(clk_cdev, ARRAY_SIZE(clk_cdev));
+	for (ptr = 0; ptr < ARRAY_SIZE(clk_cdev); ptr++)
+		s3c_disable_clocks(clk_cdev[ptr], 1);
+
 	s3c24xx_register_clock(&dummy_apb_pclk);
 	s3c_pwmclk_init();
 }
-- 
1.6.6.rc2
