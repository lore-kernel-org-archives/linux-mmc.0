From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3 12/15] Documentation: phy: Let the rockchip eMMC PHY get an
 exported card clock
Date: Mon, 20 Jun 2016 10:56:51 -0700
Message-ID: <1466445414-11974-13-git-send-email-dianders@chromium.org>
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
Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

As of an earlier change in this series ("Documentation: mmc:
sdhci-of-arasan: Add ability to export card clock") the SDHCI driver
used on Rockchip SoCs can now expose its clock.  Let's now specify that
the PHY can use it.

Letting the PHY get access to this clock means it can adjust
phyctrl_frqsel field appropriately.  Although the Rockchip PHY appears
slightly different than the reference Arasan one, you can see that the
Arasan datasheet [1] had it defined as:
  Select the frequency range of DLL operation:
  3b'000 => 200MHz to 170 MHz
  3b'001 => 170MHz to 140 MHz
  3b'010 => 140MHz to 110 MHz
  3b'011 => 110MHz to 80MHz
  3b'100 => 80MHz to 50 MHz
  3b'101 => 275Mhz to 250MHz
  3b'110 => 250MHz to 225MHz
  3b'111 => 225MHz to 200MHz

On the Rockchip version of the PHY we have less granularity but the idea
is the same.

[1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf

Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Acked-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
Changes in v3:
- Add collected tags

Changes in v2:
- List out clocks and clock names (Rob)

 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
index 555cb0f40690..e3ea55763b0a 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
@@ -7,6 +7,13 @@ Required properties:
  - reg: PHY register address offset and length in "general
    register files"
 
+Optional clocks using the clock bindings (see ../clock/clock-bindings.txt),
+specified by name:
+ - clock-names: Should contain "emmcclk".  Although this is listed as optional
+		(because most boards can get basic functionality without having
+		access to it), it is strongly suggested.
+ - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
+
 Example:
 
 
@@ -20,6 +27,8 @@ grf: syscon@ff770000 {
 	emmcphy: phy@f780 {
 		compatible = "rockchip,rk3399-emmc-phy";
 		reg = <0xf780 0x20>;
+		clocks = <&sdhci>;
+		clock-names = "emmcclk";
 		#phy-cells = <0>;
 	};
 };
-- 
2.8.0.rc3.226.g39d4020
