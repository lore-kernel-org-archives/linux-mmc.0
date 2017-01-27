From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v5 4/13] mmc: sunxi: Enable the new timings for the A64 MMC
 controllers
Date: Fri, 27 Jan 2017 22:38:36 +0100
Message-ID: <4a2be38120cebd8bed2358b19addb0985fe28a61.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
References: <cover.6f3d82744628848e2182720c35f13e87e8b62258.1485553113.git-series.maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The A64 MMC controllers need to set a "new timings" bit when a new rate is
set.

The actual meaning of that bit is not clear yet, but not setting it leads
to some corner-case issues, like the CMD53 failing, which is used to
implement SDIO packet aggregation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/mmc/host/sunxi-mmc.c | 6 ++++++
 1 file changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b9c8a62bc212..51d6388a194e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -253,6 +253,8 @@ struct sunxi_mmc_cfg {
 
 	/* does the IP block support autocalibration? */
 	bool can_calibrate;
+
+	bool needs_new_timings;
 };
 
 struct sunxi_mmc_host {
@@ -779,6 +781,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	}
 	mmc_writel(host, REG_CLKCR, rval);
 
+	if (host->cfg->needs_new_timings)
+		mmc_writel(host, REG_SD_NTSR, SDXC_2X_TIMING_MODE);
+
 	ret = sunxi_mmc_clk_set_phase(host, ios, rate);
 	if (ret)
 		return ret;
@@ -1076,6 +1081,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
 	.idma_des_size_bits = 16,
 	.clk_delays = NULL,
 	.can_calibrate = true,
+	.needs_new_timings = true,
 };
 
 static const struct of_device_id sunxi_mmc_of_match[] = {
-- 
git-series 0.8.11
