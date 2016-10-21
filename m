From: Zach Brown <zach.brown@ni.com>
Subject: [RFC v2 1/2] mmc: sdhci: Add device tree property sdhci-cap-speed-modes-broken
Date: Fri, 21 Oct 2016 16:35:14 -0500
Message-ID: <1477085715-30213-2-git-send-email-zach.brown@ni.com>
References: <1477085715-30213-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:37687 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933445AbcJUVfX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Oct 2016 17:35:23 -0400
In-Reply-To: <1477085715-30213-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

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

