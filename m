From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 1/3] dt-bindings: mmc: describe new eMMC binding for fixed driver type
Date: Sun, 15 Oct 2017 14:46:13 +0200
Message-ID: <20171015124615.31391-2-wsa+renesas@sang-engineering.com>
References: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46246 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdJOMq1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Oct 2017 08:46:27 -0400
In-Reply-To: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh@kernel.org>

Some boards may have to use a certain driver type (or drive strength) to
achieve stable eMMC communication. Describe a binding to set this up via
DT.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
---

no changes since v2

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

