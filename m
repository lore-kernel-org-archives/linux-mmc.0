From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH v3 2/3] dt-bindings: mmc: Add binding for BlueField SoC
Date: Mon, 30 Apr 2018 10:51:07 -0400
Message-ID: <1525099868-45094-2-git-send-email-lsun@mellanox.com>
References: <1525099868-45094-1-git-send-email-lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525099868-45094-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This commit adds "mellanox,bluefield-dw-mshc" for dwmmc driver
extension on Mellanox BlueField SoC platform.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 .../devicetree/bindings/mmc/bluefield-dw-mshc.txt  | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
new file mode 100644
index 0000000..ee0dd61
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
@@ -0,0 +1,29 @@
+* Mellanox Bluefield SoC specific extensions to the Synopsys Designware
+  Mobile Storage Host Controller
+
+Read synopsys-dw-mshc.txt for more details
+
+The Synopsys designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the Mellanox Bluefield SoC
+specific extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be one of the following.
+  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefield SoC
+    specific extensions.
+
+Example:
+
+	/* Mellanox Bluefield SoC MMC */
+	dwmmc0@4,0 {
+		compatible = "mellanox,bluefield-dw-mshc";
+		reg = <4 0x8000 0x400>;
+		interrupts = <32>;
+		fifo-depth = <0x100>;
+		clock-frequency = <24000000>;
+		bus-width = <8>;
+		cap-mmc-highspeed;
+	};
-- 
1.8.3.1
