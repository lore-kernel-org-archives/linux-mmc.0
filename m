From: <rogerable@realtek.com>
Subject: [PATCH] mmc: rtsx: fix incorrect last byte in R2 response
Date: Mon, 11 Aug 2014 16:32:16 +0800
Message-ID: <1407745936-18513-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:58069 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaHKIcJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Aug 2014 04:32:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: rogerable@realtek.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, driverdev-devel@linuxdriverproject.org, wei_wang@realsil.com.cn, micky_ching@realsil.com.cn

From: Roger Tseng <rogerable@realtek.com>

Current code erroneously fill the last byte of R2 response with an undefined
value. In addition, it is impossible to obtain the real values since the
controller actually 'offloads' the last byte(CRC7, end bit) while receiving R2
response. This could cause mmc stack to obtain inconsistent CID from the same
card after resume and misidentify it as a different card.

Fix by assigning a dummy value 0x01 to the last byte of R2 response.

Signed-off-by: Roger Tseng <rogerable@realtek.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |    1 +
 drivers/mmc/host/rtsx_usb_sdmmc.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index dfde4a2..54849d8 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -412,6 +412,7 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 	}
 
 	if (rsp_type == SD_RSP_TYPE_R2) {
+		ptr[16] = 1;
 		for (i = 0; i < 4; i++) {
 			cmd->resp[i] = get_unaligned_be32(ptr + 1 + i * 4);
 			dev_dbg(sdmmc_dev(host), "cmd->resp[%d] = 0x%08x\n",
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 5d3766e..ca08df1 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -435,6 +435,7 @@ static void sd_send_cmd_get_rsp(struct rtsx_usb_sdmmc *host,
 	}
 
 	if (rsp_type == SD_RSP_TYPE_R2) {
+		ptr[16] = 1;
 		for (i = 0; i < 4; i++) {
 			cmd->resp[i] = get_unaligned_be32(ptr + 1 + i * 4);
 			dev_dbg(sdmmc_dev(host), "cmd->resp[%d] = 0x%08x\n",
-- 
1.7.10.4

