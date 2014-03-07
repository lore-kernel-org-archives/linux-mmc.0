From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v3 2/7] mmc: mmci: clarify DDR timing mode between SD-UHS and
 eMMC
Date: Fri, 07 Mar 2014 22:30:45 +0900
Message-ID: <002a01cf3a09$71cbebe0$5563c3a0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006101cf2a57$77859c00$6690d400$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47800 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbaCGNar (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Mar 2014 08:30:47 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N22007QOIV95M40@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Mar 2014 22:30:45 +0900 (KST)
In-reply-to: <006101cf2a57$77859c00$6690d400$%jun@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Russell King' <linux@arm.linux.org.uk>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Chris Ball' <chris@printf.net>, 'Rickard Andersson' <rickard.andersson@stericsson.com>

Added MMC_DDR52 as eMMC's DDR mode distinguished from SD-UHS.

CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 771c60a..7e85393 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -299,7 +299,8 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
 		clk |= MCI_ST_8BIT_BUS;
 
-	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
+	    host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
 		clk |= MCI_ST_UX500_NEG_EDGE;
 
 	mmci_write_clkreg(host, clk);
@@ -784,7 +785,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 			mmci_write_clkreg(host, clk);
 		}
 
-	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
+	    host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
 		datactrl |= MCI_ST_DPSM_DDRMODE;
 
 	/*
-- 
1.7.0.4


