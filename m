From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 01/22] mmc: dw_mmc: don't queue up a card detect at slot startup
Date: Sat, 31 Aug 2013 00:11:06 +0900
Message-ID: <000401cea593$2642f160$72c8d420$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20117 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023Ab3H3PLH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:11:07 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00KWZNIGWJQ0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:11:06 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Doug Anderson <dianders@chromium.org>

The MMC subsystem handles looking for a card at probe time. Queuing up our
own can race with the rest of the MMC subsystem and cause problems if we get
unlucky with timing. Just remove driver own detection triggering.
While progressing the request from 'mmc_rescan', if 'dw_mci_work_routine_card'
routine is activated, it will cancel the current request. The problem case is
that 'mmc_rescan' is prior to 'dw_mci_work_routine_card' from host own.
Specifically, the following message shows the detection problem in driver's
probing. It would get an err -123 (-ENOMEDIUM) during probe.

[    4.216595] dwmmc_exynos 12210000.dwmmc1: Using internal DMA controller.
[    4.395935] dwmmc_exynos 12210000.dwmmc1: Version ID is 250a
[    4.401948] dwmmc_exynos 12210000.dwmmc1: DW MMC controller at irq 108, 64 bit host data width, 64 deep fifo
[    4.424430] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
[    4.453975] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
[    4.459592] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 400000Hz, actual 400000HZ div = 125)
[    4.484258] dwmmc_exynos 12210000.dwmmc1: 1 slots initialized
[    4.485406] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
[    4.487606] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
[    4.489794] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
[    4.509757] mmc1: error -123 whilst initialising SDIO card

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index beafb4c..dc81034 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2008,12 +2008,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	/* Card initially undetected */
 	slot->last_detect_state = 0;
 
-	/*
-	 * Card may have been plugged in prior to boot so we
-	 * need to run the detect tasklet
-	 */
-	queue_work(host->card_workqueue, &host->card_work);
-
 	return 0;
 
 err_setup_bus:
-- 
1.7.0.4


