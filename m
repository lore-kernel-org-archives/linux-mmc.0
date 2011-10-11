From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH V3 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic names
Date: Tue, 11 Oct 2011 11:22:07 +0200
Message-ID: <201110111122.08241.heiko@sntech.de>
References: <1318320907-8580-1-git-send-email-rajeshwari.s@samsung.com> <1318320907-8580-4-git-send-email-rajeshwari.s@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1318320907-8580-4-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

somehow this did not apply against linux-next for me:

error: patch failed: arch/arm/mach-exynos4/clock.c:1250
error: arch/arm/mach-exynos4/clock.c: patch does not apply
error: patch failed: arch/arm/mach-s3c64xx/clock.c:697
error: arch/arm/mach-s3c64xx/clock.c: patch does not apply
error: patch failed: arch/arm/mach-s5pc100/clock.c:1099
error: arch/arm/mach-s5pc100/clock.c: patch does not apply
error: patch failed: arch/arm/mach-s5pv210/clock.c:1030
error: arch/arm/mach-s5pv210/clock.c: patch does not apply

and:

Am Dienstag, 11. Oktober 2011, 10:15:07 schrieb Rajeshwari Shinde:
> Add support for lookup of sdhci-s3c controller clocks using generic names
> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
[...]
> @@ -125,6 +124,14 @@ static struct clk hsmmc0_clk = {
>  	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
>  };
> 
> +static struct clk hsmmc1_clk = {
> +	.name		= "hsmmc",
> +	.devname	= "s3c-sdhci.1",
> +	.parent		= &clk_h,
> +	.enable		= s3c2443_clkcon_enable_h,
> +	.ctrlbit	= S3C2443_HCLKCON_HSMMC,
> +};
> +
this would lead to the hsmmc1 hclk being registered twice, as it is already
registered in plat-s3c24xx/clock-2443.c .

How about the following, which also adds the lookup for the s3c2443-specific
hsmmc-sclk.

Heiko

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 72b7c62..0b0b7c2 100644
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
@@ -137,14 +136,19 @@ void __init_or_cpufreq s3c2416_setup_clocks(void)
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
+static struct clk_lookup s3c2416_clk_lookup[] = {
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
+	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
+	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
 };
 
 void __init s3c2416_init_clocks(int xtal)
@@ -164,6 +168,7 @@ void __init s3c2416_init_clocks(int xtal)
 		s3c_register_clksrc(clksrcs[ptr], 1);
 
 	s3c24xx_register_clock(&hsmmc0_clk);
+	clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416_clk_lookup));
 
 	s3c_pwmclk_init();
 
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index cd51d04..38ca7df 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -275,6 +275,8 @@ void __init_or_cpufreq s3c2443_setup_clocks(void)
 	s3c2443_common_setup_clocks(s3c2443_get_mpll, s3c2443_fclk_div);
 }
 
+static struct clk_lookup hsmmc_lookup = CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_hsmmc);
+
 void __init s3c2443_init_clocks(int xtal)
 {
 	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
@@ -292,6 +294,8 @@ void __init s3c2443_init_clocks(int xtal)
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_register_clksrc(clksrcs[ptr], 1);
 
+	clkdev_add(&hsmmc_lookup);
+
 	/* register clocks from clock array */
 
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 07a4c81..6997819 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -307,11 +307,6 @@ static struct clk init_clocks[] = {
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_DMA5,
 	}, {
-		.name		= "hsmmc",
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_HSMMC,
-	}, {
 		.name		= "gpio",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
@@ -393,6 +388,14 @@ static struct clk init_clocks[] = {
 	}
 };
 
+static struct clk hsmmc1_clk = {
+	.name		= "hsmmc",
+	.devname	= "s3c-sdhci.1",
+	.parent		= &clk_h,
+	.enable		= s3c2443_clkcon_enable_h,
+	.ctrlbit	= S3C2443_HCLKCON_HSMMC,
+};
+
 static inline unsigned long s3c2443_get_hdiv(unsigned long clkcon0)
 {
 	clkcon0 &= S3C2443_CLKDIV0_HCLKDIV_MASK;
@@ -469,6 +472,8 @@ static struct clksrc_clk *clksrcs[] __initdata = {
 	&clk_msysclk,
 };
 
+static struct clk_lookup hsmmc_lookup = CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &hsmmc1_clk);
+
 void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 				       fdiv_fn get_fdiv)
 {
@@ -490,6 +495,9 @@ void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
 	s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clks));
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
 
+	s3c24xx_register_clock(&hsmmc1_clk);
+	clkdev_add(&hsmmc_lookup);
+
 	/* See s3c2443/etc notes on disabling clocks at init time */
 	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
 	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-- 
