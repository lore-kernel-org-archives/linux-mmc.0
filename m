From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 3/3] mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt
 support
Date: Tue, 19 Mar 2019 17:12:58 +0800
Message-ID: <1552986778-33904-4-git-send-email-shawn.lin@rock-chips.com>
References: <1552986778-33904-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1552986778-33904-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The new register for controlling hardware unbusy interrupt
is in 0x120. It looks like:

|------------------------------------------------------------|
|Bit    |  Attribute |  Reset Value  | Description           |
|------------------------------------------------------------|
|31:25  |    RO      |      0x0      |  reserved             |
|------------------------------------------------------------|
|24     |    RO      |      0x0      |  rdyint_cnt_finish    |
|       |            |               |When high, it indicates|
|	|            |               |that the rdyint counter|
|       |            |               |is finished.           |
|------------------------------------------------------------|
|23:16  |    RO      |      0x0      |  rdyint_cnt_status    |
|       |            |               |Couner status, reflect |
|       |            |               |internal counter value.|
|------------------------------------------------------------|
|15:9   |    RO      |      0x0      |  reserved             |
|------------------------------------------------------------|
|8      |    RW      |      0x0      |  rdyint_gen_working   |
|       |            |               |When set, IP starts to |
|       |            |               |count and generate one |
|       |            |               |rdyint trigger. After  |
|       |            |               |the rdyint trigger is  |
|       |            |               |generated, it will be  |
|       |            |               |cleaned automatically. |
|       |            |               |Software should set it |
|       |            |               |again next time.       |
|------------------------------------------------------------|
|7:0    |    RW      |      0xff     |   rdyint_gen_maxval   |
|       |            |               |Max counter value for  |
|       |            |               |the IP to count when   |
|       |            |               |rdyint_gen_working is  |
|       |            |               |set. This counter is   |
|       |            |               |based on biu_clk.      |
|------------------------------------------------------------|

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Tested-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc-rockchip.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 8c86a80..85b1e42 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -20,6 +20,9 @@
 #include "dw_mmc-pltfm.h"
 
 #define RK3288_CLKGEN_DIV       2
+#define RKMMC_RDYINT_GEN	0x120
+#define RKMMC_RDYINT_GEN_WORKING BIT(8)
+#define RKMMC_RDYINT_GEN_MAXVAL GENMASK(7, 0)
 
 struct dw_mci_rockchip_priv_data {
 	struct clk		*drv_clk;
@@ -28,6 +31,23 @@ struct dw_mci_rockchip_priv_data {
 	int			num_phases;
 };
 
+static int dw_mci_rockchip_prepare_hw_unbusy(struct dw_mci *host,
+					     bool enable)
+{
+	u32 reg = readl(host->regs + RKMMC_RDYINT_GEN);
+
+	if (enable)
+		/* Self-clean when generating unbusy int */
+		reg |= RKMMC_RDYINT_GEN_WORKING;
+	else
+		/* Otherwise do it manually to avoid racing condition */
+		reg &= ~RKMMC_RDYINT_GEN_WORKING;
+
+	writel(reg, host->regs + RKMMC_RDYINT_GEN);
+
+	return 0;
+}
+
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
@@ -301,6 +321,15 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 				    "rockchip,rk3288-dw-mshc"))
 		host->bus_hz /= RK3288_CLKGEN_DIV;
 
+	/* Some Rockchip SoCs use hw unbusy int */
+	if (of_device_is_compatible(host->dev->of_node,
+				    "rockchip,rk1808-dw-mshc")) {
+		host->hw_unbusy_int = 16;
+		writel(~(RKMMC_RDYINT_GEN_WORKING |
+			 RKMMC_RDYINT_GEN_MAXVAL),
+		       host->regs + RKMMC_RDYINT_GEN);
+	}
+
 	return 0;
 }
 
@@ -322,6 +351,7 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.execute_tuning		= dw_mci_rk3288_execute_tuning,
 	.parse_dt		= dw_mci_rk3288_parse_dt,
+	.prepare_hw_unbusy      = dw_mci_rockchip_prepare_hw_unbusy,
 	.init			= dw_mci_rockchip_init,
 };
 
-- 
1.9.1
