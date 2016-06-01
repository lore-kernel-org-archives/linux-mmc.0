From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 12/12] ARM: dts: exynos: Fix LAN and HUB after bootloader
 initialization on Odroid U3
Date: Wed, 01 Jun 2016 10:02:21 +0200
Message-ID: <1464768141-25420-13-git-send-email-k.kozlowski@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hzpeterchen@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Odroid U3 (Exynos4412-based) board if USB was initialized by
bootloader (in U-Boot "usb start" before tftpboot), the HUB (usb3503)
and LAN (smsc95xx) after after successful probing were not visible in the
system ("lsusb").

In such case the devices had to be fully reset before configuring.
Reset by GPIO (called RESET_N pin) and by RESET field in STCD register
in usb3503 HUB are not sufficient. Instead full reset has to be done by
disabling and enabling regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 31cdc036fda4..23e30e4609df 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -99,11 +99,15 @@
 	clock-names = "refclk";
 	clocks = <&pmu_system_controller 0>;
 	refclk-frequency = <24000000>;
+
+	power-sequence;
+	ext-supply = <&buck8_reg>;
 };
 
 &ehci {
 	port@1 {
 		status = "okay";
+		usb-pwrseq = <&usb3503>;
 	};
 	port@2 {
 		status = "okay";
-- 
1.9.1
