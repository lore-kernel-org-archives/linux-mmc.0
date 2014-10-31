From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: sdhci: Remove unused SDHCI_CTRL_HS_SDR200
Date: Fri, 31 Oct 2014 14:22:48 +0200
Message-ID: <1414758171-1244-2-git-send-email-adrian.hunter@intel.com>
References: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64398 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759422AbaJaMYh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Oct 2014 08:24:37 -0400
In-Reply-To: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

SDHCI_CTRL_HS_SDR200 is unused.  Remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c2ec7fc..79937cf 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -161,7 +161,6 @@
 #define   SDHCI_CTRL_UHS_SDR50		0x0002
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
-#define   SDHCI_CTRL_HS_SDR200		0x0005 /* reserved value in SDIO spec */
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
-- 
1.9.1

