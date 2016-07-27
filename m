From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: rtsx_pci: Use the provided busy timeout from the mmc core
Date: Wed, 27 Jul 2016 14:25:37 +0200
Message-ID: <1469622338-11158-2-git-send-email-ulf.hansson@linaro.org>
References: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35711 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbcG0MZz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 08:25:55 -0400
Received: by mail-lf0-f54.google.com with SMTP id f93so26122932lfi.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 05:25:54 -0700 (PDT)
In-Reply-To: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, Roger Tseng <rogerable@realtek.com>, Mauro Santos <registo.mailling@gmail.com>, Baolin Wang <baolin.wang@linaro.org>

The rtsx_pci driver is using a fixed 3s timeout for R1B responses, which
in some cases isn't suffient. For example, erase/discard requests may
require longer timeouts.

Instead of always using a fixed timeout, let's use the per request
calculated busy timeout from the mmc core.

Cc: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 9313748..6158b96 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -244,7 +244,7 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 	stat_idx = sd_status_index(rsp_type);
 
 	if (rsp_type == SD_RSP_TYPE_R1b)
-		timeout = 3000;
+		timeout = cmd->busy_timeout ? cmd->busy_timeout : 3000;
 
 	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
 		err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
-- 
1.9.1

