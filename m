From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: meson-gx: add dram-access-quirk property
Date: Mon, 27 May 2019 14:43:05 +0200
Message-ID: <20190527124307.32075-2-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527124307.32075-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@baylibre.com, devicetree@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
makes any DRAM access from the MMC controller fail.

Add the amlogic,dram-access-quirk property so signal this particular
controller has this bug and needs a quirk to work properly.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index 13e70409e8ac..ccc5358db131 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -22,6 +22,10 @@ Required properties:
   clock rate requested by the MMC core.
 - resets     : phandle of the internal reset line
 
+Optional properties:
+- amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
+  DRAM memory, like on the G12A dedicated SDIO controller.
+
 Example:
 
 	sd_emmc_a: mmc@70000 {
-- 
2.21.0
