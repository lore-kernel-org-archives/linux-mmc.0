From: John Keeping <john@metanate.com>
Subject: [PATCH] mmc: dw_mmc-rockchip: correct property names in debug
Date: Thu,  1 Mar 2018 10:36:25 +0000
Message-ID: <20180301103625.7285-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, linux-rockchip@lists.infradead.org, John Keeping <john@metanate.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Following up the device tree fixed in commits e78c637127ee ("ARM: dts:
rockchip: Fix DWMMC clocks") and ca9eee95a2de ("arm64: dts: rockchip:
Fix DWMMC clocks", 2018-02-15), avoid confusion by using the correct
property name in the debug output if clocks are not found.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 339295212935..40d7de2eea12 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -282,11 +282,11 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 
 	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
 	if (IS_ERR(priv->drv_clk))
-		dev_dbg(host->dev, "ciu_drv not available\n");
+		dev_dbg(host->dev, "ciu-drive not available\n");
 
 	priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
 	if (IS_ERR(priv->sample_clk))
-		dev_dbg(host->dev, "ciu_sample not available\n");
+		dev_dbg(host->dev, "ciu-sample not available\n");
 
 	host->priv = priv;
 
-- 
2.16.2
