From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3 04/15] phy: rockchip-emmc: reindent the register definitions
Date: Mon, 20 Jun 2016 10:56:43 -0700
Message-ID: <1466445414-11974-5-git-send-email-dianders@chromium.org>
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

Some of the spacing was wrong (spaces instead of tabs), and due to
longer entries added later, the columns weren't aligned. Let's get
everything consistent.

Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Acked-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
Changes in v3:
- Add Brian's PHY patches into my series

Changes in v2: None

 drivers/phy/phy-rockchip-emmc.c | 76 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index a0b87cc6c818..a69f53630e67 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -31,44 +31,44 @@
 		((val) << (shift) | (mask) << ((shift) + 16))
 
 /* Register definition */
-#define GRF_EMMCPHY_CON0	0x0
-#define GRF_EMMCPHY_CON1	0x4
-#define GRF_EMMCPHY_CON2	0x8
-#define GRF_EMMCPHY_CON3	0xc
-#define GRF_EMMCPHY_CON4	0x10
-#define GRF_EMMCPHY_CON5	0x14
-#define GRF_EMMCPHY_CON6	0x18
-#define GRF_EMMCPHY_STATUS	0x20
-
-#define PHYCTRL_PDB_MASK	0x1
-#define PHYCTRL_PDB_SHIFT	0x0
-#define PHYCTRL_PDB_PWR_ON	0x1
-#define PHYCTRL_PDB_PWR_OFF	0x0
-#define PHYCTRL_ENDLL_MASK	0x1
-#define PHYCTRL_ENDLL_SHIFT     0x1
-#define PHYCTRL_ENDLL_ENABLE	0x1
-#define PHYCTRL_ENDLL_DISABLE	0x0
-#define PHYCTRL_CALDONE_MASK	0x1
-#define PHYCTRL_CALDONE_SHIFT   0x6
-#define PHYCTRL_CALDONE_DONE	0x1
-#define PHYCTRL_CALDONE_GOING	0x0
-#define PHYCTRL_DLLRDY_MASK	0x1
-#define PHYCTRL_DLLRDY_SHIFT	0x5
-#define PHYCTRL_DLLRDY_DONE	0x1
-#define PHYCTRL_DLLRDY_GOING	0x0
-#define PHYCTRL_FREQSEL_200M	0x0
-#define PHYCTRL_FREQSEL_50M	0x1
-#define PHYCTRL_FREQSEL_100M	0x2
-#define PHYCTRL_FREQSEL_150M	0x3
-#define PHYCTRL_FREQSEL_MASK	0x3
-#define PHYCTRL_FREQSEL_SHIFT	0xc
-#define PHYCTRL_DR_MASK		0x7
-#define PHYCTRL_DR_SHIFT	0x4
-#define PHYCTRL_DR_50OHM	0x0
-#define PHYCTRL_DR_33OHM	0x1
-#define PHYCTRL_DR_66OHM	0x2
-#define PHYCTRL_DR_100OHM	0x3
-#define PHYCTRL_DR_40OHM	0x4
+#define GRF_EMMCPHY_CON0		0x0
+#define GRF_EMMCPHY_CON1		0x4
+#define GRF_EMMCPHY_CON2		0x8
+#define GRF_EMMCPHY_CON3		0xc
+#define GRF_EMMCPHY_CON4		0x10
+#define GRF_EMMCPHY_CON5		0x14
+#define GRF_EMMCPHY_CON6		0x18
+#define GRF_EMMCPHY_STATUS		0x20
+
+#define PHYCTRL_PDB_MASK		0x1
+#define PHYCTRL_PDB_SHIFT		0x0
+#define PHYCTRL_PDB_PWR_ON		0x1
+#define PHYCTRL_PDB_PWR_OFF		0x0
+#define PHYCTRL_ENDLL_MASK		0x1
+#define PHYCTRL_ENDLL_SHIFT		0x1
+#define PHYCTRL_ENDLL_ENABLE		0x1
+#define PHYCTRL_ENDLL_DISABLE		0x0
+#define PHYCTRL_CALDONE_MASK		0x1
+#define PHYCTRL_CALDONE_SHIFT		0x6
+#define PHYCTRL_CALDONE_DONE		0x1
+#define PHYCTRL_CALDONE_GOING		0x0
+#define PHYCTRL_DLLRDY_MASK		0x1
+#define PHYCTRL_DLLRDY_SHIFT		0x5
+#define PHYCTRL_DLLRDY_DONE		0x1
+#define PHYCTRL_DLLRDY_GOING		0x0
+#define PHYCTRL_FREQSEL_200M		0x0
+#define PHYCTRL_FREQSEL_50M		0x1
+#define PHYCTRL_FREQSEL_100M		0x2
+#define PHYCTRL_FREQSEL_150M		0x3
+#define PHYCTRL_FREQSEL_MASK		0x3
+#define PHYCTRL_FREQSEL_SHIFT		0xc
+#define PHYCTRL_DR_MASK			0x7
+#define PHYCTRL_DR_SHIFT		0x4
+#define PHYCTRL_DR_50OHM		0x0
+#define PHYCTRL_DR_33OHM		0x1
+#define PHYCTRL_DR_66OHM		0x2
+#define PHYCTRL_DR_100OHM		0x3
+#define PHYCTRL_DR_40OHM		0x4
 #define PHYCTRL_OTAPDLYENA		0x1
 #define PHYCTRL_OTAPDLYENA_MASK		0x1
 #define PHYCTRL_OTAPDLYENA_SHIFT	0xb
-- 
2.8.0.rc3.226.g39d4020
