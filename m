From: John Keeping <john@metanate.com>
Subject: [PATCH] dt-bindings: rockchip-dw-mshc: use consistent clock names
Date: Thu,  1 Mar 2018 10:34:47 +0000
Message-ID: <20180301103447.7059-1-john@metanate.com>
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
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, John Keeping <john@metanate.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The names of these clocks are "ciu-drive" and "ciu-sample" as described
for the clock-names property.  Avoid confusion by spelling these
correctly everywhere they are referenced.

Signed-off-by: John Keeping <john@metanate.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index c6558785e61b..8ce49b255974 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -21,7 +21,7 @@ Required Properties:
 	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
 
 Optional Properties:
-* clocks: from common clock binding: if ciu_drive and ciu_sample are
+* clocks: from common clock binding: if ciu-drive and ciu-sample are
   specified in clock-names, should contain handles to these clocks.
 
 * clock-names: Apart from the clock-names described in synopsys-dw-mshc.txt
@@ -29,7 +29,7 @@ Optional Properties:
   to control the clock phases, "ciu-sample" is required for tuning high-
   speed modes.
 
-* rockchip,default-sample-phase: The default phase to set ciu_sample at
+* rockchip,default-sample-phase: The default phase to set ciu-sample at
   probing, low speeds or in case where all phases work at tuning time.
   If not specified 0 deg will be used.
 
-- 
2.16.2
