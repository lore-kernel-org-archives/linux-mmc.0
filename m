From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/3] mmc: describe new eMMC binding for fixed driver type
Date: Fri, 15 Sep 2017 20:02:59 +0200
Message-ID: <20170915180301.29175-2-wsa+renesas@sang-engineering.com>
References: <20170915180301.29175-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50131 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbdIOSDF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Sep 2017 14:03:05 -0400
In-Reply-To: <20170915180301.29175-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Some boards may have to use a certain driver type (or drive strength) to
achieve stable eMMC communication. Describe a binding to set this up via
DT.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index c7f4a0ec48eda7..e2fc5c864434c2 100644
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

