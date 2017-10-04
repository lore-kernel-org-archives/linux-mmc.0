From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: describe new eMMC binding for fixed driver type
Date: Wed,  4 Oct 2017 19:39:18 +0200
Message-ID: <20171004173920.15232-2-wsa+renesas@sang-engineering.com>
References: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171004173920.15232-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>, Marek Vasut <marek.vasut@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-mmc@vger.kernel.org

Some boards may have to use a certain driver type (or drive strength) to
achieve stable eMMC communication. Describe a binding to set this up via
DT.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
Changes since RFC v1:
* rebased to mmc/next based on 4.14-rc3
* proper prefix for subject
* added Rob's ack

 Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index b32ade645ad97c..94a90b49a6925d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -53,6 +53,9 @@ Optional properties:
 - no-sdio: controller is limited to send sdio cmd during initialization
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
+- fixed-emmc-driver-type: for non-removable eMMC, enforce this driver type.
+  The value <n> is the driver type as specified in the eMMC specification
+  (table 206 in spec version 5.1).
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.11.0
