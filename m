Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DF326B2D3;
	Tue,  6 May 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523394; cv=none; b=cU0PXc2zP8l0AbGFJ76WK8ssap5v3vW63KZ+9vvXWF5cr61QPYLbeTINQEYYN7GwtT/qpr8aDBitHMPwohDTZPldd6HEJx5MDRrTaCtp77poi+bl5c1e/6oGoTudlWOaE4LwKtxIJepu+yf9QUCbxRLOcIE1reRktQBxI9//Ki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523394; c=relaxed/simple;
	bh=KooZtKiKIS4kYyX45xKSekDnpaeKvpGX35KgXvdXVHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onObgsxwp5JrrUZkJtxG6QeNoZXwVxMg9C2cj0oXERje1nheJ/lpHTemNTVmhCNzfxeKZxZaQs9Ud1diGCSXVxUiFyfoqAYYzV8fqDQYnbk/aUWlk2vU0qk1a57SrR34/2RkRh+4/OCH9pnKmRUx9oM5+4Meg61/zPrVFPPETJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ed7ByAIg; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ed7ByAIg"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9AE7E20731;
	Tue,  6 May 2025 11:23:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k22TyXZw3tdZ; Tue,  6 May 2025 11:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1746523389; bh=KooZtKiKIS4kYyX45xKSekDnpaeKvpGX35KgXvdXVHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ed7ByAIgowDl7L0wG80IcxpsdGwUKPtgYkC0yox0lGF7IbJbHwXQskqS0yUH293Hr
	 PsCtNUxUGCEUrajTEArkxU8PveJb/P0b1hCZBWiQb5IMC/Tp8IcRqqyY20LqqgErK9
	 OCtxQ4rILSDLBgKjc9V5jvEJ9R6cQwJj5Dgor4jhaLcaV2TJi1+2KlwBrn1mVb9eB0
	 DLRVf1DlbGCFBgqJ/PayVoZvYXHsJlmb8F0HwBFg09Mn7+WUsHLKIc98bEwsHmjCN1
	 HNa+QjwNXoLl3VbHfw/Csh7OESXIS7mQQ0u/VelPLqs2rAdiz5sM8uRMmKo+GlEq9H
	 O0dgixJFL0dPw==
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
Subject: [PATCH v5 2/5] clk: rockchip: Support MMC clocks in GRF region
Date: Tue,  6 May 2025 09:22:03 +0000
Message-ID: <20250506092206.46143-3-ziyao@disroot.org>
In-Reply-To: <20250506092206.46143-1-ziyao@disroot.org>
References: <20250506092206.46143-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registers of MMC drive/sample clocks in Rockchip RV1106 and RK3528
locate in GRF regions. Adjust MMC clock code to support register
operations through regmap.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/rockchip/clk-mmc-phase.c | 24 ++++++++++++++++++++----
 drivers/clk/rockchip/clk.c           | 17 ++++++++++++++---
 drivers/clk/rockchip/clk.h           | 17 ++++++++++++++++-
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 91012078681b..b3ed8e7523e5 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -9,11 +9,14 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/regmap.h>
 #include "clk.h"
 
 struct rockchip_mmc_clock {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	struct regmap	*grf;
+	int		grf_reg;
 	int		shift;
 	int		cached_phase;
 	struct notifier_block clk_rate_change_nb;
@@ -54,7 +57,12 @@ static int rockchip_mmc_get_phase(struct clk_hw *hw)
 	if (!rate)
 		return 0;
 
-	raw_value = readl(mmc_clock->reg) >> (mmc_clock->shift);
+	if (mmc_clock->grf)
+		regmap_read(mmc_clock->grf, mmc_clock->grf_reg, &raw_value);
+	else
+		raw_value = readl(mmc_clock->reg);
+
+	raw_value >>= mmc_clock->shift;
 
 	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
 
@@ -134,8 +142,12 @@ static int rockchip_mmc_set_phase(struct clk_hw *hw, int degrees)
 	raw_value = delay_num ? ROCKCHIP_MMC_DELAY_SEL : 0;
 	raw_value |= delay_num << ROCKCHIP_MMC_DELAYNUM_OFFSET;
 	raw_value |= nineties;
-	writel(HIWORD_UPDATE(raw_value, 0x07ff, mmc_clock->shift),
-	       mmc_clock->reg);
+	raw_value = HIWORD_UPDATE(raw_value, 0x07ff, mmc_clock->shift);
+
+	if (mmc_clock->grf)
+		regmap_write(mmc_clock->grf, mmc_clock->grf_reg, raw_value);
+	else
+		writel(raw_value, mmc_clock->reg);
 
 	pr_debug("%s->set_phase(%d) delay_nums=%u reg[0x%p]=0x%03x actual_degrees=%d\n",
 		clk_hw_get_name(hw), degrees, delay_num,
@@ -189,7 +201,9 @@ static int rockchip_mmc_clk_rate_notify(struct notifier_block *nb,
 
 struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
-				void __iomem *reg, int shift)
+				void __iomem *reg,
+				struct regmap *grf, int grf_reg,
+				int shift)
 {
 	struct clk_init_data init;
 	struct rockchip_mmc_clock *mmc_clock;
@@ -208,6 +222,8 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 
 	mmc_clock->hw.init = &init;
 	mmc_clock->reg = reg;
+	mmc_clock->grf = grf;
+	mmc_clock->grf_reg = grf_reg;
 	mmc_clock->shift = shift;
 
 	clk = clk_register(NULL, &mmc_clock->hw);
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 34d96aa7cd51..0cba7e7e0c42 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -509,8 +509,10 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 		clk = NULL;
 
 		/* for GRF-dependent branches, choose the right grf first */
-		if ((list->branch_type == branch_muxgrf || list->branch_type == branch_grf_gate) &&
-				list->grf_type != grf_type_sys) {
+		if ((list->branch_type == branch_muxgrf		||
+		     list->branch_type == branch_grf_gate	||
+		     list->branch_type == branch_grf_mmc) &&
+		    list->grf_type != grf_type_sys) {
 			hash_for_each_possible(ctx->aux_grf_table, agrf, node, list->grf_type) {
 				if (agrf->type == list->grf_type) {
 					grf = agrf->grf;
@@ -612,6 +614,16 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 				list->name,
 				list->parent_names, list->num_parents,
 				ctx->reg_base + list->muxdiv_offset,
+				NULL, 0,
+				list->div_shift
+			);
+			break;
+		case branch_grf_mmc:
+			clk = rockchip_clk_register_mmc(
+				list->name,
+				list->parent_names, list->num_parents,
+				0,
+				grf, list->muxdiv_offset,
 				list->div_shift
 			);
 			break;
@@ -641,7 +653,6 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 			break;
 		case branch_linked_gate:
 			/* must be registered late, fall-through for error message */
-			break;
 		}
 
 		/* none of the cases above matched */
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index ebaed429a30d..d411de7a6f4a 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -619,7 +619,9 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 
 struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
-				void __iomem *reg, int shift);
+				void __iomem *reg,
+				struct regmap *grf, int grf_reg,
+				int shift);
 
 /*
  * DDRCLK flags, including method of setting the rate
@@ -664,6 +666,7 @@ enum rockchip_clk_branch_type {
 	branch_grf_gate,
 	branch_linked_gate,
 	branch_mmc,
+	branch_grf_mmc,
 	branch_inverter,
 	branch_factor,
 	branch_ddrclk,
@@ -1030,6 +1033,18 @@ struct rockchip_clk_branch {
 		.div_shift	= shift,			\
 	}
 
+#define MMC_GRF(_id, cname, pname, offset, shift, grftype)	\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_grf_mmc,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.muxdiv_offset	= offset,			\
+		.div_shift	= shift,			\
+		.grf_type	= grftype,			\
+	}
+
 #define INVERTER(_id, cname, pname, io, is, if)			\
 	{							\
 		.id		= _id,				\
-- 
2.49.0

