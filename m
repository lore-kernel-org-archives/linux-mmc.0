From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 15/22] mmc: sdhci-acpi: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 15:30:56 +0900
Message-ID: <005a01ce4a23$44350800$cc9f1800$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:11756 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3EFGbL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:31:11 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD003LY63LFZO0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:30:57 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Adrian Hunter' <adrian.hunter@intel.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-acpi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 7bcf74b..8e6c4da 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -211,7 +211,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	return 0;
 
 err_free:
-	platform_set_drvdata(pdev, NULL);
 	sdhci_free_host(c->host);
 	return err;
 }
@@ -230,7 +229,6 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
 
 	dead = (sdhci_readl(c->host, SDHCI_INT_STATUS) == ~0);
 	sdhci_remove_host(c->host, dead);
-	platform_set_drvdata(pdev, NULL);
 	sdhci_free_host(c->host);
 
 	return 0;
-- 
1.7.2.5


