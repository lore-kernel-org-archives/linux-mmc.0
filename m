From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 06/11] Documentation: mmc: sdhci-of-arasan: Add ability to
 export card clock
Date: Mon, 13 Jun 2016 16:04:30 -0700
Message-ID: <1465859076-4868-7-git-send-email-dianders@chromium.org>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1465859076-4868-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
with arasan,sdhci-5.1) need to know the card clock frequency in order to
function properly.  Physically in a SoC this clock is exported from the
SDHCI IP block to the PHY IP block and the PHY needs to know the speed.
Let's export the SDHCI card clock using a standard device tree mechanism
so that the PHY can get access to it and query the card clock frequency.

Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
Changes in v2:
- Adjust commit message wording (Rob)
- Add Rob Herring's Ack.

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 476604e6ce2a..3404afa9b938 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -30,6 +30,12 @@ Optional Properties:
   - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
     used to access core corecfg registers.  Offsets of registers in this
     syscon are determined based on the main compatible string for the device.
+  - clock-output-names: If specified, this will be the name of the card clock
+    which will be exposed by this device.  Required if #clock-cells is
+    specified.
+  - #clock-cells: If specified this should be the value <0>.  With this property
+    in place we will export a clock representing the Card Clock.  This clock
+    is expected to be consumed by our PHY.  You must also specify
 
 Example:
 	sdhci@e0100000 {
@@ -61,7 +67,9 @@ Example:
 		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
+		clock-output-names = "emmc_cardclock";
 		phys = <&emmc_phy>;
 		phy-names = "phy_arasan";
+		#clock-cells = <0>;
 		status = "disabled";
 	};
-- 
2.8.0.rc3.226.g39d4020
