From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] MAINTAINERS: Mark vub300 mmc driver as orphan
Date: Mon,  4 Nov 2019 14:22:59 +0100
Message-ID: <20191104132259.32500-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Tony's email address from elandigitalsystems.com has bounced for a long
time. Let's update MAINTAINERS to mark the driver as orphan as to reflect
the situation.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fc3ff3cb23..be6a6539103b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17456,10 +17456,8 @@ S:	Maintained
 F:	drivers/hwmon/vt8231.c
 
 VUB300 USB to SDIO/SD/MMC bridge chip
-M:	Tony Olech <tony.olech@elandigitalsystems.com>
 L:	linux-mmc@vger.kernel.org
-L:	linux-usb@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	drivers/mmc/host/vub300.c
 
 W1 DALLAS'S 1-WIRE BUS
-- 
2.17.1
