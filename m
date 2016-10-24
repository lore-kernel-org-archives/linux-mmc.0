From: Zach Brown <zach.brown@ni.com>
Subject: [RFC v3 1/2] mmc: sdhci: Add device tree property sdhci-cap-speed-modes-broken
Date: Mon, 24 Oct 2016 14:04:09 -0500
Message-ID: <1477335850-14945-2-git-send-email-zach.brown@ni.com>
References: <1477335850-14945-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477335850-14945-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

On some systems the sdhci capabilty registers are incorrect for one
reason or another.

The sdhci-cap-speed-modes-broken property will let the driver know that
the sdhci capability registers should not be relied on for speed modes.
Instead the driver should check the mmc generic DT bindings.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a37782..671d6c0 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -52,6 +52,9 @@ Optional properties:
 - no-sdio: controller is limited to send sdio cmd during initialization
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
+- sdhci-cap-speed-modes-broken: One or more of the bits in the sdhci
+  capabilities registers representing speed modes are incorrect. All the bits
+  representing speed modes should be ignored.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.7.4
