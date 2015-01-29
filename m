From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 6/6] ARM: dts: exynos5250-snow: Add cap-sdio-irq to wifi mmc node
Date: Thu, 29 Jan 2015 16:00:08 +0100
Message-ID: <1422543608-24704-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Arend van Spriel <arend@broadcom.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Enabling SDIO IRQ signalling for the wifi MMC/SDIO slot
doubles the transmission transfer rate.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v2: None.

Changes since v1: None, new patch.
---
 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index b78712058903..909edc3448d3 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -539,6 +539,7 @@
 	status = "okay";
 	num-slots = <1>;
 	broken-cd;
+	cap-sdio-irq;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
-- 
2.1.3
