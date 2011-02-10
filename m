From: Will Newton <will.newton@gmail.com>
Subject: [PATCH] mmc: Improve MMC_TEST config text.
Date: Thu, 10 Feb 2011 10:41:02 +0000
Message-ID: <AANLkTinps7xSofxw8opY4A5X=14jT+EE4P2bo=-F16q_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52996 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129Ab1BJKlD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 05:41:03 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so1947000bwz.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Feb 2011 02:41:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

The test file is created under debugfs, not sysfs. Also remove
the unnecessary default n.

Signed-off-by: Will Newton <will.newton@imgtec.com>
---
 drivers/mmc/card/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 2a876c4..3b1f783 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -58,12 +58,11 @@ config SDIO_UART

 config MMC_TEST
 	tristate "MMC host test driver"
-	default n
 	help
 	  Development driver that performs a series of reads and writes
 	  to a memory card in order to expose certain well known bugs
 	  in host controllers. The tests are executed by writing to the
-	  "test" file in sysfs under each card. Note that whatever is
+	  "test" file in debugfs under each card. Note that whatever is
 	  on your card will be overwritten by these tests.

 	  This driver is only of interest to those developing or
-- 
1.7.3.4
