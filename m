From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 4/4] clk: rockchip: remove CLK_IGNORE_UNUSED flag for aclk_emmc_grf on rk3399
Date: Wed, 31 Aug 2016 09:37:28 +0800
Message-ID: <1472607448-4462-5-git-send-email-shawn.lin@rock-chips.com>
References: <1472607448-4462-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472607448-4462-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

aclk_emmc_grf is used for accessing corecfg_* of emmc stuff within
GRF block. We don't need to add CLK_IGNORE_UNUSED for it now as the
emmc driver will enable/disable it explicitly when needed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/clk/rockchip/clk-rk3399.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index ede6c47..908f684 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -934,7 +934,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(32), 8, GFLAGS),
 	GATE(ACLK_EMMC_NOC, "aclk_emmc_noc", "aclk_emmc", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(32), 9, GFLAGS),
-	GATE(ACLK_EMMC_GRF, "aclk_emmcgrf", "aclk_emmc", CLK_IGNORE_UNUSED,
+	GATE(ACLK_EMMC_GRF, "aclk_emmcgrf", "aclk_emmc", 0,
 			RK3399_CLKGATE_CON(32), 10, GFLAGS),
 
 	/* perilp0 */
-- 
2.3.7
