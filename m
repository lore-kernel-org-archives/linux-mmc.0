From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa board
Date: Thu, 02 Oct 2014 18:10:06 +0200
Message-ID: <2750153.I3nVqzmXTP@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
Cc: Doug Anderson <dianders@google.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "cpgs ." <cpgs@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Regulators for MMC2 (SD card) are PVDD_TFLASH_2V8 (LDO19) for vmmc
and PVDD_APIO_MMCOFF_2V8 (LDO13) for vqmmc.  Currently the device
tree entry for MMC2 uses PVDD_PRE_1V8 (LDO10) for vmmc and vqmmc is
not specified.  Fix it.

Without this patch:
- "mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators"
  patch causes a SD card detection to fail
- "mmc: dw_mmc: Support voltage changes" patch causes a boot hang

This patch fixes both above problems.

Suggested-by: Doug Anderson <dianders@google.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
===================================================================
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts	2014-10-02 15:44:53.014826886 +0200
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts	2014-10-02 17:35:24.110600398 +0200
@@ -74,7 +74,8 @@
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-		vmmc-supply = <&ldo10_reg>;
+		vmmc-supply = <&ldo19_reg>;
+		vqmmc-supply = <&ldo13_reg>;
 
 		slot@0 {
 			reg = <0>;
