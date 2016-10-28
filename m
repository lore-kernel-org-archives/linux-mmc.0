From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 1/2] mmc: sdhci: dt: Add device tree properties sdhci-caps and sdhci-caps-mask
Date: Fri, 28 Oct 2016 10:56:10 -0500
Message-ID: <1477670171-30015-2-git-send-email-zach.brown@ni.com>
References: <1477670171-30015-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477670171-30015-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

On some systems the sdhci capabilty register is incorrect for one
reason or another.

The sdhci-caps-mask property specifies which bits in the register
are incorrect and should be turned off before using sdhci-caps to turn
on bits.

The sdhci-caps property specifies which bits should be turned on.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 Documentation/devicetree/bindings/mmc/sdhci.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Documentation/devicetree/bindings/mmc/sdhci.txt
new file mode 100644
index 0000000..0f4f1bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci.txt
@@ -0,0 +1,14 @@
+The properties specific for SD host controllers. For properties shared by MMC
+host controllers refer to the mmc[1] bindings.
+
+  [1] Documentation/devicetree/bindings/mmc/mmc.txt
+
+Optional properties:
+- sdhci-caps-mask: The sdhci capabilities register is incorrect. This 64bit
+  property corresponds to the bits in the sdhci capabilty register. If the bit
+  is on in the mask then the bit is incorrect in the register and should be
+  turned off, before applying sdhci-caps.
+- sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
+  property corresponds to the bits in the sdhci capability register. If the
+  bit is on in the property then the bit should be turned on.
+
-- 
2.7.4
