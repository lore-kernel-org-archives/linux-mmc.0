From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC 3/3] ARM: dts: Use frequency scaling for MSHC
Date: Mon, 12 Jan 2015 10:23:05 +0100
Message-ID: <1421054585-9032-4-git-send-email-k.kozlowski@samsung.com>
References: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Enable frequency scaling on MSHC to reduce energy consumption. In idle
this reduced energy consumption by 1.0% (from 27.16 mA to 26.89 mA).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index e53f62f216ba..aad09109fdbc 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -493,6 +493,7 @@
 	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
 	clock-freq-min-max = <400000 100000000>;
+	frequency-scaling;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-- 
1.9.1
