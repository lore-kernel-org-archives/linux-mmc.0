From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] arm64: dts: meson-g12a: add ddr-access-quirk property to SDIO controller
Date: Mon, 13 May 2019 11:15:48 +0200
Message-ID: <20190513091548.16674-4-narmstrong@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513091548.16674-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@baylibre.com
Cc: baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
mark this specific controller with the amlogic,ddr-access-quirk property.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

Kevin, the MMC node hasn't been sent yet, when the quirk bindings is
accepted, we will directly send the MMC modes with this property.

Nei

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 5cbfca00f5cf..d8b3441f0c45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1061,6 +1061,7 @@
 				 <&clkc CLKID_FCLK_DIV2>;
 			clock-names = "core", "clkin0", "clkin1";
 			resets = <&reset RESET_SD_EMMC_A>;
+			amlogic,ddr-access-quirk;
 		};
 
 		sd_emmc_b: sd@ffe05000 {
-- 
2.21.0
