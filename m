From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 3/3] ARM: dts: exynos: Lower SD card interface voltage to 2.8v
 on Odroid X/X2/U3
Date: Wed, 27 Apr 2016 14:19:13 +0200
Message-ID: <1461759553-10119-3-git-send-email-k.kozlowski@samsung.com>
References: <1461759553-10119-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1461759553-10119-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Anand Moon <linux.amoon@gmail.com>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Odroid X/X2/U3 schematics say that SD card vmmc regulator
(LDO21/TFLASH) operates on 2.8 V. Mainline U-Boot uses that value as
well. 2.8 V is common on Exynos-based boards. Additionally use some
descriptive name for this regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 55d766f28202..563681c39ec2 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -341,9 +341,9 @@
 			};
 
 			ldo21_reg: LDO21 {
-				regulator-name = "LDO21_3.3V";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-name = "TFLASH_2.8V";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
 				regulator-boot-on;
 			};
 
-- 
1.9.1
