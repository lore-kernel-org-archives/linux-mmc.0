From: Zach Brown <zach.brown@ni.com>
Subject: [RFC 1/2] sdhci: Add device tree property sd-broken-highspeed
Date: Fri, 23 Sep 2016 15:01:08 -0500
Message-ID: <1474660869-15532-2-git-send-email-zach.brown@ni.com>
References: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:44792 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030280AbcIWUXU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 23 Sep 2016 16:23:20 -0400
In-Reply-To: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

Certain board configurations can make highspeed malfunction due to
timing issues. In these cases a way is needed to force the controller
and card into standard speed even if they otherwise appear to be capable
of highspeed.

The sd-broken-highspeed property will let the sdhci driver know that
highspeed will not work.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a37782..59332ea 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -52,6 +52,8 @@ Optional properties:
 - no-sdio: controller is limited to send sdio cmd during initialization
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
+- sd-broken-highspeed: Highspeed is broken, even if the controller and card
+  themselves claim they support highspeed.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.7.4

