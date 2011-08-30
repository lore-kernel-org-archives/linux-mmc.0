From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 1/3] arm/dt: Tegra: Update SDHCI nodes to match bindings
Date: Tue, 30 Aug 2011 13:17:15 -0600
Message-ID: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
This is a repost of http://www.spinics.net/lists/linux-tegra/msg02117.html
I'm including it here since it's not in linux-next yet, and patch 3 depends
on it.

 arch/arm/boot/dts/tegra-harmony.dts  |   12 ++++++------
 arch/arm/boot/dts/tegra-seaboard.dts |    6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 4c05334..e581866 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -57,14 +57,14 @@
 	};
 
 	sdhci@c8000200 {
-		gpios = <&gpio 69 0>, /* cd, gpio PI5 */
-			<&gpio 57 0>, /* wp, gpio PH1 */
-			<&gpio 155 0>; /* power, gpio PT3 */
+		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
+		power-gpios = <&gpio 155 0>; /* gpio PT3 */
 	};
 
 	sdhci@c8000600 {
-		gpios = <&gpio 58 0>, /* cd, gpio PH2 */
-			<&gpio 59 0>, /* wp, gpio PH3 */
-			<&gpio 70 0>; /* power, gpio PI6 */
+		cd-gpios = <&gpio 58 0>; /* gpio PH2 */
+		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
+		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 	};
 };
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 1940cae..64cedca 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -21,8 +21,8 @@
 	};
 
 	sdhci@c8000400 {
-		gpios = <&gpio 69 0>, /* cd, gpio PI5 */
-			<&gpio 57 0>, /* wp, gpio PH1 */
-			<&gpio 70 0>; /* power, gpio PI6 */
+		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
+		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
+		power-gpios = <&gpio 70 0>; /* gpio PI6 */
 	};
 };
-- 
1.7.0.4
