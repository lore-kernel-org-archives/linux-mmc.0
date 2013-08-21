From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 09/14] mmc: dw_mmc: fix error handling on response error
Date: Wed, 21 Aug 2013 22:50:56 +0900
Message-ID: <002e01ce9e75$762a29c0$627e7d40$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12620 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3HUNu6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 09:50:58 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV009LWVSWTOC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 22:50:57 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

Even if response error is detected in case data command,
data transfer is continued. It means that data can live
in FIFO. Current handling just breaks out the request
when seeing the command error. This causes kernel panic
in dw_mci_read_data_pio [host->data = NULL]. And also,
FIFO should be guaranteed to be empty.

Unable to handle kernel NULL pointer dereference at virtual address 00000018
<...>
[<c02af814>] (dw_mci_read_data_pio+0x68/0x198) from [<c02b04b4>] (dw_mci_interrupt+0x374/0x3a0)
[<c02b04b4>] (dw_mci_interrupt+0x374/0x3a0) from [<c006b094>] (handle_irq_event_percpu+0x50/0x194)
[<c006b094>] (handle_irq_event_percpu+0x50/0x194) from [<c006b214>] (handle_irq_event+0x3c/0x5c)
[<c006b214>] (handle_irq_event+0x3c/0x5c) from [<c006de1c>] (handle_fasteoi_irq+0xa4/0x148)
[<c006de1c>] (handle_fasteoi_irq+0xa4/0x148) from [<c006aa88>] (generic_handle_irq+0x20/0x30)
[<c006aa88>] (generic_handle_irq+0x20/0x30) from [<c000f154>] (handle_IRQ+0x38/0x90)
[<c000f154>] (handle_IRQ+0x38/0x90) from [<c00085bc>] (gic_handle_irq+0x34/0x68)
[<c00085bc>] (gic_handle_irq+0x34/0x68) from [<c0011f40>] (__irq_svc+0x40/0x70)
Exception stack(0xef0b1c00 to 0xef0b1c48)
1c00: 000eb0cf ffffffff 00001300 c01a7738 ef295e10 0000000a c04df298 ef0b1dc0
1c20: ef295ec0 00000000 00000000 00000006 00000000 ef0b1c48 c02b1274 c01a7764
1c40: 20000113 ffffffff
[<c0011f40>] (__irq_svc+0x40/0x70) from 	[<c01a7764>] (__loop_delay+0x0/0xc)
Code: e1a00005 e0891006 e0662004 e12fff33 (e59a3018)
---[ end trace a7043b9ba9aed1db ]---
Kernel panic - not syncing: Fatal exception in interrupt

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 486024c..9c3205e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1140,11 +1140,6 @@ static void dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd
 		/* newer ip versions need a delay between retries */
 		if (host->quirks & DW_MCI_QUIRK_RETRY_DELAY)
 			mdelay(20);
-
-		if (cmd->data) {
-			dw_mci_stop_dma(host);
-			host->data = NULL;
-		}
 	}
 }
 
@@ -1185,6 +1180,17 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				goto unlock;
 			}
 
+			if (cmd->data && cmd->error) {
+				dw_mci_stop_dma(host);
+				if (data->stop) {
+					send_stop_cmd(host, data);
+					state = STATE_SENDING_STOP;
+					break;
+				} else {
+					host->data = NULL;
+				}
+			}
+
 			if (!host->mrq->data || cmd->error) {
 				dw_mci_request_end(host, host->mrq);
 				goto unlock;
@@ -1279,7 +1285,17 @@ static void dw_mci_tasklet_func(unsigned long priv)
 						&host->pending_events))
 				break;
 
+			/* CMD error in data command */
+			if (host->mrq->cmd->error && host->mrq->data) {
+				sg_miter_stop(&host->sg_miter);
+				host->sg = NULL;
+				ctrl = mci_readl(host, CTRL);
+				ctrl |= SDMMC_CTRL_FIFO_RESET;
+				mci_writel(host, CTRL, ctrl);
+			}
+
 			host->cmd = NULL;
+			host->data = NULL;
 			dw_mci_command_complete(host, host->mrq->stop);
 			dw_mci_request_end(host, host->mrq);
 			goto unlock;
-- 
1.7.4.1


