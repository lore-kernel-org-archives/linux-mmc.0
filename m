From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 1/2] sdhci: Add device tree property broken-highspeed
Date: Tue, 18 Oct 2016 10:37:05 -0500
Message-ID: <1476805026-677-2-git-send-email-zach.brown@ni.com>
References: <1476805026-677-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476805026-677-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

Certain board configurations can make highspeed malfuction due to timing
issues. In these cases a way is needed to force the controller and card
into standard speed even if they otherwise appear to be capable of
highspeed.

The broken-highspeed property will let the sdhci driver know that
highspeed will not work.

Signed-off-by: Zach Brown <zach.brown@ni.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 8a37782..a2b298c 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -52,6 +52,8 @@ Optional properties:
 - no-sdio: controller is limited to send sdio cmd during initialization
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
+- broken-highspeed: Highspeed is broken, even if the controller and card
+  themselves claim they support highspeed.
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.7.4
