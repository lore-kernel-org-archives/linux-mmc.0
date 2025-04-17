Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81B2522B3;
	Thu, 17 Apr 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900649; cv=none; b=nqnb7YS5Y4zGM6tA5KdPH/T1iBc1OwGqF9XM1gvU3Jp2t/t7LqnZigPE3bwehyS+jCO4lJZD1oLL6RBICzP/UMy/f7B3EOcrYJkli+xR18OvixgIw3lCcigSwrAznw3dGfUdgEdYTZiTymloO022lCw43M5hEnleMSv2SseS4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900649; c=relaxed/simple;
	bh=LJZ4BzkmqO5FCxtr98CW90UDUw7hXcAKNizoRIIljs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL0Gvoyk0bzxX978r5sd95nhl295IWJxStje3UlnW18/ILNIlsk8+KI84/GMv64hnUwgpa5id/IFEaG4sr1MjaAv85BoCv8hpzB3BJ5ASvO1ruwfl6MpNPv2mH2llz8t3zt+zFdIDSJI5sIu0zzf3leDySDN6hMKeghwnMF44ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Yc1PQeia; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Yc1PQeia"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AA93A25C5C;
	Thu, 17 Apr 2025 16:37:25 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-f57SXnfEKw; Thu, 17 Apr 2025 16:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1744900645; bh=LJZ4BzkmqO5FCxtr98CW90UDUw7hXcAKNizoRIIljs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yc1PQeianGTLnTA/XuDF4RfgiZyumOAd8xznKe/THAas00Ef/SdxTtq5MvsphaEwV
	 +NQpyu8spmcVqNAWKB/mygzUYmoI+Y/Iig0NzUI9FZryJN9bwv2INGUYAhoSMBKDZd
	 JKjZX63mze9f04VuiHAcDv6wKvDDkwz/StyYF7y8Vr6NEpXaqhUCjZ2yy6Dp1zWdX0
	 fHqxrjRmmdkApQBZRRiLk2LCNPyQVzP4vUsOoHH/PoN2AvbuCqvjkn9DL9tJVDoUdC
	 NJNcCFmsV5LzDC5mbBRTCoosa5Cpz3QnQROweWeN7ekD4hDVI8cOFdJGSIhU9c4JfM
	 qkkFtZDA82g2Q==
From: Yao Zi <ziyao@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4 3/5] clk: rockchip: rk3528: Add SD/SDIO tuning clocks in GRF region
Date: Thu, 17 Apr 2025 14:36:45 +0000
Message-ID: <20250417143647.43860-4-ziyao@disroot.org>
In-Reply-To: <20250417143647.43860-1-ziyao@disroot.org>
References: <20250417143647.43860-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These clocks locate in VO and VPU GRF, serving for SD/SDIO controller
tuning purpose. Add their definitions and register them in driver if
corresponding GRF is available.

GRFs are looked up by compatible to simplify devicetree binding.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/rockchip/clk-rk3528.c | 61 ++++++++++++++++++++++++++++---
 drivers/clk/rockchip/clk.h        |  3 ++
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3528.c b/drivers/clk/rockchip/clk-rk3528.c
index b8b577b902a0..5c133a642ff9 100644
--- a/drivers/clk/rockchip/clk-rk3528.c
+++ b/drivers/clk/rockchip/clk-rk3528.c
@@ -10,6 +10,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/minmax.h>
 
 #include <dt-bindings/clock/rockchip,rk3528-cru.h>
 
@@ -1061,23 +1063,64 @@ static struct rockchip_clk_branch rk3528_clk_branches[] __initdata = {
 			0, 1, 1),
 };
 
+static struct rockchip_clk_branch rk3528_vo_clk_branches[] __initdata = {
+	MMC_GRF(SCLK_SDMMC_DRV, "sdmmc_drv", "cclk_src_sdmmc0",
+			RK3528_SDMMC_CON(0), 1),
+	MMC_GRF(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "cclk_src_sdmmc0",
+			RK3528_SDMMC_CON(1), 1),
+};
+
+static struct rockchip_clk_branch rk3528_vpu_clk_branches[] __initdata = {
+	MMC_GRF(SCLK_SDIO0_DRV, "sdio0_drv", "cclk_src_sdio0",
+			RK3528_SDIO0_CON(0), 1),
+	MMC_GRF(SCLK_SDIO0_SAMPLE, "sdio0_sample", "cclk_src_sdio0",
+			RK3528_SDIO0_CON(1), 1),
+	MMC_GRF(SCLK_SDIO1_DRV, "sdio1_drv", "cclk_src_sdio1",
+			RK3528_SDIO1_CON(0), 1),
+	MMC_GRF(SCLK_SDIO1_SAMPLE, "sdio1_sample", "cclk_src_sdio1",
+			RK3528_SDIO1_CON(1), 1),
+};
+
 static int __init clk_rk3528_probe(struct platform_device *pdev)
 {
-	struct rockchip_clk_provider *ctx;
+	unsigned long nr_vpu_branches = ARRAY_SIZE(rk3528_vpu_clk_branches);
+	unsigned long nr_vo_branches = ARRAY_SIZE(rk3528_vo_clk_branches);
+	unsigned long nr_branches = ARRAY_SIZE(rk3528_clk_branches);
+	unsigned long nr_clks, nr_vo_clks, nr_vpu_clks;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	unsigned long nr_branches = ARRAY_SIZE(rk3528_clk_branches);
-	unsigned long nr_clks;
+	struct rockchip_clk_provider *ctx;
+	struct regmap *vo_grf, *vpu_grf;
 	void __iomem *reg_base;
 
-	nr_clks = rockchip_clk_find_max_clk_id(rk3528_clk_branches,
-					       nr_branches) + 1;
-
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return dev_err_probe(dev, PTR_ERR(reg_base),
 				     "could not map cru region");
 
+	nr_clks = rockchip_clk_find_max_clk_id(rk3528_clk_branches,
+					       nr_branches) + 1;
+
+	vo_grf = syscon_regmap_lookup_by_compatible("rockchip,rk3528-vo-grf");
+	if (!IS_ERR(vo_grf)) {
+		nr_vo_clks = rockchip_clk_find_max_clk_id(rk3528_vo_clk_branches,
+							  nr_vo_branches) + 1;
+		nr_clks = max(nr_clks, nr_vo_clks);
+	} else if (PTR_ERR(vo_grf) != -ENODEV) {
+		return dev_err_probe(dev, PTR_ERR(vo_grf),
+				     "failed to look up VO GRF\n");
+	}
+
+	vpu_grf = syscon_regmap_lookup_by_compatible("rockchip,rk3528-vpu-grf");
+	if (!IS_ERR(vpu_grf)) {
+		nr_vpu_clks = rockchip_clk_find_max_clk_id(rk3528_vpu_clk_branches,
+							   nr_vpu_branches) + 1;
+		nr_clks = max(nr_clks, nr_vpu_clks);
+	} else if (PTR_ERR(vpu_grf) != -ENODEV) {
+		return dev_err_probe(dev, PTR_ERR(vpu_grf),
+				     "failed to look up VPU GRF\n");
+	}
+
 	ctx = rockchip_clk_init(np, reg_base, nr_clks);
 	if (IS_ERR(ctx))
 		return dev_err_probe(dev, PTR_ERR(ctx),
@@ -1091,6 +1134,12 @@ static int __init clk_rk3528_probe(struct platform_device *pdev)
 				     &rk3528_cpuclk_data, rk3528_cpuclk_rates,
 				     ARRAY_SIZE(rk3528_cpuclk_rates));
 	rockchip_clk_register_branches(ctx, rk3528_clk_branches, nr_branches);
+	if (!IS_ERR(vo_grf))
+		rockchip_clk_register_grf_branches(ctx, rk3528_vo_clk_branches,
+						   vo_grf, nr_vo_branches);
+	if (!IS_ERR(vpu_grf))
+		rockchip_clk_register_grf_branches(ctx, rk3528_vpu_clk_branches,
+						   vpu_grf, nr_vpu_branches);
 
 	rk3528_rst_init(np, reg_base);
 
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index ec86ba1dd38c..f07cd1bb8952 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -217,6 +217,9 @@ struct clk;
 #define RK3528_CLKSEL_CON(x)		((x) * 0x4 + 0x300)
 #define RK3528_CLKGATE_CON(x)		((x) * 0x4 + 0x800)
 #define RK3528_SOFTRST_CON(x)		((x) * 0x4 + 0xa00)
+#define RK3528_SDMMC_CON(x)		((x) * 0x4 + 0x24)
+#define RK3528_SDIO0_CON(x)		((x) * 0x4 + 0x4)
+#define RK3528_SDIO1_CON(x)		((x) * 0x4 + 0xc)
 #define RK3528_PMU_CLKSEL_CON(x)	((x) * 0x4 + 0x300 + RK3528_PMU_CRU_BASE)
 #define RK3528_PMU_CLKGATE_CON(x)	((x) * 0x4 + 0x800 + RK3528_PMU_CRU_BASE)
 #define RK3528_PCIE_CLKSEL_CON(x)	((x) * 0x4 + 0x300 + RK3528_PCIE_CRU_BASE)
-- 
2.49.0

