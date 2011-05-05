From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 18/22] mmc: omap_hsmmc: fix oops in omap_hsmmc_dma_cb
Date: Thu,  5 May 2011 14:51:18 +0300
Message-ID: <1304596282-4095-19-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:63452 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321Ab1EELwy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:54 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

In the case of an I/O error, the DMA will have been
cleaned up in the MMC interrupt and the request
structure pointer will be null.

In that case, it is essential to check if the DMA
DMA is over before dereferencing host->mrq->data.

Oops as follows:

<3>[ 2293.695281] wl1271: ERROR sdio read failed (-110)
<1>[ 2293.695739] Unable to handle kernel NULL pointer dereference at virtual
address 00000004
<1>[ 2293.703094] pgd = b0004000
<1>[ 2293.705780] [00000004] *pgd=00000000
<0>[ 2293.709381] Internal error: Oops: 17 [#1] PREEMPT
<0>[ 2293.714080] last sysfs file:
/sys/devices/platform/omapdss/manager0/cpr_enable
<4>[ 2293.721313] Modules linked in: ext2 dm_crypt xt_NFLOG xt_rateest
xt_RATEEST xt_condition iptable_filter ip_tables dm_mod xt_IDLETIMER
nfnetlink_log nfnetlink as3645a ad58xx smiapp smiapp_power omap3_isp iovmm
omap3_iommu iommu2 iommu wl12xx_spi bnep omaplfb bridgedriver g_file_storage
cmt_speech ssi_protocol phonet hsi_char wl12xx_sdio wl12xx pvrsrvkm omap_ssi
mailbox_mach vibra_spi radio_wl1273 mailbox bcm4751_gps lis3lv02d_i2c ak8975
lis3lv02d leds_lp5521 apds990x pn544 rtc_twl4030 twl4030_keypad
twl4030_pwrbutton cmt twl5031_aci hci_h4p
<4>[ 2293.769287] CPU: 0    Not tainted  (2.6.32.36-dfl61-20111603 #1)
<4>[ 2293.775329] PC is at omap_hsmmc_dma_cb+0x18/0x140
<4>[ 2293.780029] LR is at omap2_dma_irq_handler+0x244/0x28c
<4>[ 2293.785156] pc : [<b024e180>]    lr : [<b0049ed0>]    psr: a00001d3
<4>[ 2293.785186] sp : edfb3c48  ip : edfb3bf8  fp : edfb3d3c
<4>[ 2293.796661] r10: fa05632c  r9 : fa056000  r8 : ee4889c0
<4>[ 2293.801910] r7 : 00000020  r6 : 00000001  r5 : edfb2000  r4 : ee53e1c0
<4>[ 2293.808441] r3 : 00000000  r2 : edfb3c48  r1 : 00000020  r0 : 00000007
<4>[ 2293.814971] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
<4>[ 2293.822479] Control: 10c5387d  Table: bc9f4019  DAC: 00000017
<0>[ 2293.828247] Process phy0 (pid: 313, stack limit = 0xedfb22e8)
<0>[ 2293.833984] Stack: (0xedfb3c48 to 0xedfb4000)
...
<4>[ 2294.084320] [<b024e180>] (omap_hsmmc_dma_cb+0x18/0x140) from [<b0049ed0>]
(omap2_dma_irq_handler+0x244/0x28c)
<4>[ 2294.094268] [<b0049ed0>] (omap2_dma_irq_handler+0x244/0x28c) from
[<b0093d44>] (handle_IRQ_event+0x34/0xf0)
<4>[ 2294.104034] [<b0093d44>] (handle_IRQ_event+0x34/0xf0) from [<b0095bec>]
(handle_level_irq+0xcc/0x170)
<4>[ 2294.113250] [<b0095bec>] (handle_level_irq+0xcc/0x170) from [<b002c068>]
(asm_do_IRQ+0x68/0x84)
<4>[ 2294.121978] [<b002c068>] (asm_do_IRQ+0x68/0x84) from [<b002ca84>]
(__irq_svc+0x44/0xa8)
<4>[ 2294.129974] Exception stack(0xedfb3cc0 to 0xedfb3d08)
<4>[ 2294.135040] 3cc0: 0021d5cd 00000000 3d20cc2d 00000002 edf7dd40 edfb2000
edf7dee8 edf7ddd8
<4>[ 2294.143249] 3ce0: 00000001 00000000 ee516080 edfb3d3c b04880b8 edfb3d08
b0059e5c b0344184
<4>[ 2294.151428] 3d00: 00000053 ffffffff
<4>[ 2294.154968] [<b002ca84>] (__irq_svc+0x44/0xa8) from [<b0344184>]
(schedule+0x248/0x3a8)
<4>[ 2294.162963] [<b0344184>] (schedule+0x248/0x3a8) from [<b03448ac>]
(schedule_timeout+0x1c/0x224)
<4>[ 2294.171691] [<b03448ac>] (schedule_timeout+0x1c/0x224) from [<b0344738>]
(wait_for_common+0xe8/0x1a8)
<4>[ 2294.180938] [<b0344738>] (wait_for_common+0xe8/0x1a8) from [<b02459f8>]
(mmc_wait_for_req+0x110/0x120)
<4>[ 2294.190277] [<b02459f8>] (mmc_wait_for_req+0x110/0x120) from [<b0249bac>]
(mmc_io_rw_extended+0x178/0x1e0)
<4>[ 2294.199951] [<b0249bac>] (mmc_io_rw_extended+0x178/0x1e0) from
[<b024ab54>] (sdio_io_rw_ext_helper+0x164/0x190)
<4>[ 2294.210052] [<b024ab54>] (sdio_io_rw_ext_helper+0x164/0x190) from
[<b024aba0>] (sdio_writesb+0x20/0x24)
<4>[ 2294.219512] [<b024aba0>] (sdio_writesb+0x20/0x24) from [<af0d50e0>]
(wl1271_sdio_raw_write+0x64/0xa4 [wl12xx_sdio])
<4>[ 2294.230041] [<af0d50e0>] (wl1271_sdio_raw_write+0x64/0xa4 [wl12xx_sdio])
from [<af0bd4bc>] (wl1271_tx_work_locked+0x548/0x5fc [wl12xx])
<4>[ 2294.242218] [<af0bd4bc>] (wl1271_tx_work_locked+0x548/0x5fc [wl12xx])
from [<af0ba944>] (wl1271_irq_work+0x230/0x314 [wl12xx])
<4>[ 2294.253631] [<af0ba944>] (wl1271_irq_work+0x230/0x314 [wl12xx]) from
[<b00725ac>] (worker_thread+0x174/0x224)
<4>[ 2294.263519] [<b00725ac>] (worker_thread+0x174/0x224) from [<b0075bac>]
(kthread+0x7c/0x84)
<4>[ 2294.271820] [<b0075bac>] (kthread+0x7c/0x84) from [<b002d950>]
(kernel_thread_exit+0x0/0x8)
<0>[ 2294.280181] Code: e5923008 e1a0200d e3c25d7f e3c5503f (e5936004)
<4>[ 2294.286529] ---[ end trace e8fb05c679bd87ff ]---

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index de7f15c..2c8fa01 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1375,7 +1375,7 @@ static void omap_hsmmc_config_dma_params(struct omap_hsmmc_host *host,
 static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 {
 	struct omap_hsmmc_host *host = cb_data;
-	struct mmc_data *data = host->mrq->data;
+	struct mmc_data *data;
 	int dma_ch, req_in_progress;
 
 	if (!(ch_status & (OMAP_DMA_BLOCK_IRQ | OMAP2_DMA_SUPER_BLOCK_IRQ))) {
@@ -1390,6 +1390,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 		return;
 	}
 
+	data = host->mrq->data;
 	if (host->dma_in_use == DMA_TYPE_SDMA) {
 		host->dma_sg_idx++;
 		if (host->dma_sg_idx < host->dma_len) {
-- 
1.7.0.4

