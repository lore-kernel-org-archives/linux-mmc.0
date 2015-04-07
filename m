From: <micky_ching@realsil.com.cn>
Subject: [PATCH] sdhci: rtsx: fix 64 BIT DMA quirks
Date: Tue, 7 Apr 2015 11:32:01 +0800
Message-ID: <1428377521-16619-1-git-send-email-micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:39955 "EHLO
	rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbbDGDcd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2015 23:32:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, dan.carpenter@oracle.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn, Micky Ching <micky_ching@realsil.com.cn>

From: Micky Ching <micky_ching@realsil.com.cn>

rts5250 chip failed handle 64 bit ADMA for address below 4G.
Add 64 BIT quirks to disable this feature.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
---
 drivers/mmc/host/sdhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 0342775..ae8e450 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -650,6 +650,7 @@ static int rtsx_probe_slot(struct sdhci_pci_slot *slot)
 
 static const struct sdhci_pci_fixes sdhci_rtsx = {
 	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
 			SDHCI_QUIRK2_BROKEN_DDR50,
 	.probe_slot	= rtsx_probe_slot,
 };
-- 
1.9.1

