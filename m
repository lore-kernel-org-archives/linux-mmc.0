From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 07/23] mmc: sdhci: check SDHCI_QUIRK2_NO_1_8_V when do voltage switch
Date: Sat, 16 Apr 2016 01:29:31 +0800
Message-ID: <1460741387-23815-8-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0091.outbound.protection.outlook.com ([157.56.111.91]:47616
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750820AbcDORwY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 13:52:24 -0400
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, haibo.chen@nxp.com, dongas86@gmail.com

Currently when card type supports EXT_CSD_CARD_TYPE_DDR_1_8V
which means it can work on DDR mode with either 3.3v IO or 1.8v
IO voltage. MMC core will first try 1.8v then 3.3v if host claims
MMC_CAP_1_8V_DDR support.
However the host driver voltage switch code does not check NO_1_8_V
quirk which may set a wrong 1.8v and causes the card fixed to 3.3v
VIO un-work.

Checking 1.8V quirk before setting it to avoid such issue.

CC: stable <stable@vger.kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2338aab..96ccb15 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1683,6 +1683,8 @@ static int sdhci_do_signal_voltage_switch(struct sdhci_host *host,
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_180:
+		if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
+			return -EINVAL;
 		/*
 		 * Enable 1.8V Signal Enable in the Host Control2
 		 * register
-- 
1.9.1

