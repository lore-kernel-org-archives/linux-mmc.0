From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 1/3] mmc: dt-bindings: update bindings doc to support Meson-AXG SoC
Date: Tue, 3 Apr 2018 18:06:49 +0800
Message-ID: <20180403100652.41056-2-yixun.lan@amlogic.com>
References: <20180403100652.41056-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403100652.41056-1-yixun.lan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nan Li <nan.li@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Nan Li <nan.li@amlogic.com>

Update the documentation to list support for Meson-AXG SoC explicitly.
The new binding string is necessary since this SoC introduce a few
IP difference comparing to previous old generation.

Signed-off-by: Nan Li <nan.li@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index 50bf611a4d2c..5add8d7d855f 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -12,6 +12,7 @@ Required properties:
   - "amlogic,meson-gxbb-mmc"
   - "amlogic,meson-gxl-mmc"
   - "amlogic,meson-gxm-mmc"
+  - "amlogic,meson-axg-mmc"
 - clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
 - clock-names: Should contain the following:
 	"core" - Main peripheral bus clock
-- 
2.16.2
