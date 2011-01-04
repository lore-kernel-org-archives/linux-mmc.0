From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: MMC_BLOCK_MINORS should depend on MMC_BLOCK.
Date: Tue, 4 Jan 2011 18:02:36 +0000
Message-ID: <20110104180236.GB17407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42336 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab1ADSCg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 13:02:36 -0500
Received: from chris by void.printf.net with local (Exim 4.69)
	(envelope-from <chris@void.printf.net>)
	id 1PaBDQ-0004ZS-4K
	for linux-mmc@vger.kernel.org; Tue, 04 Jan 2011 18:02:36 +0000
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/card/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 57e4416..2a876c4 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -16,6 +16,7 @@ config MMC_BLOCK
 
 config MMC_BLOCK_MINORS
 	int "Number of minors per block device"
+	depends on MMC_BLOCK
 	range 4 256
 	default 8
 	help
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
