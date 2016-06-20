From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3 03/15] phy: rockchip-emmc: configure default output tap
 delay
Date: Mon, 20 Jun 2016 10:56:42 -0700
Message-ID: <1466445414-11974-4-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466445414-11974-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

The output tap delay controls helps maintain the hold requirements for
eMMC. The exact value is dependent on the SoC and other factors, though
it isn't really an exact science. But the default of 0 is not very good,
as it doesn't give the eMMC much hold time, so let's bump up to 4
(approx 90 degree phase?). If we need to configure this any further
(e.g., based on board or speed factors), we may need to consider a
device tree representation.

Suggested-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Acked-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
Changes in v3:
- Add Brian's PHY patches into my series

Changes in v2: None

 drivers/phy/phy-rockchip-emmc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index f2f75cf69af1..a0b87cc6c818 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -69,6 +69,11 @@
 #define PHYCTRL_DR_66OHM	0x2
 #define PHYCTRL_DR_100OHM	0x3
 #define PHYCTRL_DR_40OHM	0x4
+#define PHYCTRL_OTAPDLYENA		0x1
+#define PHYCTRL_OTAPDLYENA_MASK		0x1
+#define PHYCTRL_OTAPDLYENA_SHIFT	0xb
+#define PHYCTRL_OTAPDLYSEL_MASK		0xf
+#define PHYCTRL_OTAPDLYSEL_SHIFT	0x7
 
 struct rockchip_emmc_phy {
 	unsigned int	reg_offset;
@@ -181,6 +186,20 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 				   PHYCTRL_DR_MASK,
 				   PHYCTRL_DR_SHIFT));
 
+	/* Output tap delay: enable */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
+		     HIWORD_UPDATE(PHYCTRL_OTAPDLYENA,
+				   PHYCTRL_OTAPDLYENA_MASK,
+				   PHYCTRL_OTAPDLYENA_SHIFT));
+
+	/* Output tap delay */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
+		     HIWORD_UPDATE(4,
+				   PHYCTRL_OTAPDLYSEL_MASK,
+				   PHYCTRL_OTAPDLYSEL_SHIFT));
+
 	/* Power up emmc phy analog blocks */
 	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
 	if (ret)
-- 
2.8.0.rc3.226.g39d4020
