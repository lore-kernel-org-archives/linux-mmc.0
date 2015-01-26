From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] mmc: Fix menuconfig alignment of MMC_SDHCI_* options
Date: Mon, 26 Jan 2015 11:35:44 +0100
Message-ID: <20150126113544.3f44e4a1@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47493 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbbAZKfs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Jan 2015 05:35:48 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Albert Herranz <albert_herranz@yahoo.es>

Let MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER depend on MMC_SDHCI. Not
only this is more correct, but this also avoids breaking the alignment
of all other MMC_SDHCI_* options in menuconfig.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-3.19-rc6.orig/drivers/mmc/host/Kconfig	2015-01-26 11:18:57.715667965 +0100
+++ linux-3.19-rc6/drivers/mmc/host/Kconfig	2015-01-26 11:26:31.986215716 +0100
@@ -57,6 +57,7 @@ config MMC_SDHCI_IO_ACCESSORS
 
 config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	bool
+	depends on MMC_SDHCI
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This option is selected by drivers running on big endian hosts


-- 
Jean Delvare
SUSE L3 Support
