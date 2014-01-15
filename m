From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 5/7] mmc: rtsx: clarify DDR timing mode between SD-UHS and eMMC
Date: Wed, 15 Jan 2014 23:12:15 +0900
Message-ID: <002301cf11fb$cad390c0$607ab240$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57239 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbaAOOMx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 09:12:53 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZG009AJ4SF9W50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 23:12:15 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <chris@printf.net>, 'Wei WANG' <wei_wang@realsil.com.cn>, 'Samuel Ortiz' <sameo@linux.intel.com>
Cc: linux-mmc@vger.kernel.org

Added MMC_DDR52 as eMMC's DDR mode distinguished from SD-UHS.

CC: Wei WANG <wei_wang@realsil.com.cn>
CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index c46feda..752f003 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -864,6 +864,7 @@ static int sd_set_timing(struct realtek_pci_sdmmc *host, unsigned char timing)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CLK_CTL, CLK_LOW_FREQ, 0);
 		break;
 
+	case MMC_TIMING_MMC_DDR52:
 	case MMC_TIMING_UHS_DDR50:
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, SD_CFG1,
 				0x0C | SD_ASYNC_FIFO_NOT_RST,
@@ -944,6 +945,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->vpclk = true;
 		host->double_clk = false;
 		break;
+	case MMC_TIMING_MMC_DDR52:
 	case MMC_TIMING_UHS_DDR50:
 	case MMC_TIMING_UHS_SDR25:
 		host->ssc_depth = RTSX_SSC_DEPTH_1M;
-- 
1.7.0.4


