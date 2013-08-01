From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] mmc: dw_mmc-socfpga: Staticize dw_mci_socfpga_probe()
Date: Thu, 01 Aug 2013 15:30:09 +0900
Message-ID: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12795 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab3HAGaL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 02:30:11 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQU0094JA0W6H80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 Aug 2013 15:30:09 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dinh Nguyen <dinguyen@altera.com>, Jingoo Han <jg1.han@samsung.com>

dw_mci_socfpga_probe() is used only in this file.
Fix the following sparse warning:

drivers/mmc/host/dw_mmc-socfpga.c:116:5: warning: symbol 'dw_mci_socfpga_probe' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/dw_mmc-socfpga.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
index 14b5961..35aebb8 100644
--- a/drivers/mmc/host/dw_mmc-socfpga.c
+++ b/drivers/mmc/host/dw_mmc-socfpga.c
@@ -113,7 +113,7 @@ static const struct of_device_id dw_mci_socfpga_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_mci_socfpga_match);
 
-int dw_mci_socfpga_probe(struct platform_device *pdev)
+static int dw_mci_socfpga_probe(struct platform_device *pdev)
 {
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
-- 
1.7.10.4


