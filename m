From: Zach Brown <zach.brown@ni.com>
Subject: [RFC 1/2] mmc: sdhci: dt: Add device tree properties sdhci-caps and sdhci-caps-mask
Date: Tue, 25 Oct 2016 14:58:57 -0500
Message-ID: <1477425538-3315-2-git-send-email-zach.brown@ni.com>
References: <1477425538-3315-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477425538-3315-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

On some systems the sdhci capabilty registers are incorrect for one
reason or another.

The sdhci-caps-mask property specifies which bits in the registers
are incorrect and should be turned off before using sdhci-caps to turn
on bits.

The sdhci-caps property specifies which bits should be turned on.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a37782..1415aa0 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -52,6 +52,13 @@ Optional properties:
 - no-sdio: controller is limited to send sdio cmd during initialization
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
+- sdhci-caps-mask: The sdhci capabilities registers are incorrect. This 64bit
+  property corresponds to the bits in the sdhci capabilty registers. If the bit
+  is on in the mask then the bit is incorrect in the registers and should be
+  turned off.
+- sdhci-caps: The sdhci capabilities registers are incorrect. This 64bit
+  property corresponds to the bits in the sdhci capability registers. If the
+  bit is on in the property then the bit should be on in the reigsters.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.7.4
