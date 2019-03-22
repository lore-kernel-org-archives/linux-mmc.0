From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] MAINTAINERS: Collect TI FLASH MEDIA drivers into one section
Date: Fri, 22 Mar 2019 12:43:34 +0100
Message-ID: <20190322114334.26482-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>, Alex Dubov <alex.dubov@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The current SONY MEMORYSTICK CARD SUPPORT section is pointing to the TI
flash media memorystick driver, which is a bit confusing. Let's make this
more clear by moving this part into TI FLASH MEDIA INTERFACE DRIVER
section, but rename the section to TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS,
as to make it more clear.

Finally, add Alex Dubov to the SONY MEMORYSTICK STANDARD SUPPORT, as I
believe that has been the intention.

Cc: Alex Dubov <oakad@yahoo.com>
Cc: Alex Dubov <alex.dubov@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..61bdbade3daf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14463,14 +14463,9 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/i2c/imx355.c
 
-SONY MEMORYSTICK CARD SUPPORT
-M:	Alex Dubov <oakad@yahoo.com>
-W:	http://tifmxx.berlios.de/
-S:	Maintained
-F:	drivers/memstick/host/tifm_ms.c
-
 SONY MEMORYSTICK STANDARD SUPPORT
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
+M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
 F:	drivers/memstick/core/ms_block.*
 
@@ -15497,9 +15492,11 @@ S:	Maintained
 F:	drivers/net/ethernet/ti/cpsw*
 F:	drivers/net/ethernet/ti/davinci*
 
-TI FLASH MEDIA INTERFACE DRIVER
+TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
+W:	http://tifmxx.berlios.de/
+F:	drivers/memstick/host/tifm_ms.c
 F:	drivers/misc/tifm*
 F:	drivers/mmc/host/tifm_sd.c
 F:	include/linux/tifm.h
-- 
2.17.1
