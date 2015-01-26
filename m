From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] mmc: Enable Ricoh MMC quirk by default
Date: Mon, 26 Jan 2015 11:44:15 +0100
Message-ID: <20150126114415.00369e32@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47769 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359AbbAZKoS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Jan 2015 05:44:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Philipl Langdale <philipl@overt.org>

Config option MMC_RICOH_MMC's help text reads:

	  If unsure, say Y.

However the option defaults to N. Set the default to Y to match the
recommendation in the help text.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Philipl Langdale <philipl@overt.org>
---
 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-3.19-rc6.orig/drivers/mmc/host/Kconfig	2015-01-26 11:39:05.048048277 +0100
+++ linux-3.19-rc6/drivers/mmc/host/Kconfig	2015-01-26 11:39:27.121513084 +0100
@@ -83,6 +83,7 @@ config MMC_SDHCI_PCI
 config MMC_RICOH_MMC
 	bool "Ricoh MMC Controller Disabler"
 	depends on MMC_SDHCI_PCI
+	default y
 	help
 	  This adds a pci quirk to disable Ricoh MMC Controller. This
 	  proprietary controller is unnecessary because the SDHCI driver


-- 
Jean Delvare
SUSE L3 Support
