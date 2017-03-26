From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [BUG] dmaengine: pxa_dma: + mmc: pxamci: race condition with DMA
 error on tx channel
Date: Sun, 26 Mar 2017 04:43:18 +0200
Message-ID: <ab2c9dcb-1718-46da-2f31-1f4721719b01@tul.cz>
References: <e749aff1-0ffc-c9ed-42b2-82397b4e8ba2@tul.cz>
 <877f3zwwgo.fsf@belgarion.home> <feb39d00-d40d-f935-751c-8119f40b4df4@tul.cz>
 <871stzh8bx.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5B2C8EAC715CDF6E78CD83F4"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:48116 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbdCZCnK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 25 Mar 2017 22:43:10 -0400
In-Reply-To: <871stzh8bx.fsf@belgarion.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: vinod.koul@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B2C8EAC715CDF6E78CD83F4
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit

Dne 14.3.2017 v 22:11 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
> Ok Petr, I've been trying for days to reproduce without any luck.

Hi,

I think I was able to finally find the problem with the PXA MCI and DMA. It seems to be a problem with a race condition with vchan_complete() tasklet.

The pxa_dma driver handles IRQ with pxad_chan_handler(), which calls vchan_cookie_complete(), which schedules the vchan_complete() tasklet. 

Starting the tasklet may take a long time. The race condition appeared during the heavy IRQ load. During that time, the pxamci driver can start another data write transmit. This another transmit with again schedule the tasklet. But as tasklet schedules are not cumulative, it will (probably) add item to a list. 

After some time the tasklet is finally scheduled and for every item in the list the callback pxamci_dma_irq() is called. And there is the main problem, the pxamci_dma_irq() is using __actual__ transmit variables (e.g. host->data). My debug printk shows the code tests a cookie of the actual transmit, which may be in a DMA_IN_PROGRESS state (every failure is during this state).

Solution:

I commented the error handling parts of the callback function and the driver works, but it is only for the testing purposes, there can be a partially filled FIFO (BUF_PART_FULL) which will not be handled. Problem is the driver won't wait on the completion before starting a new transmission. But this waiting on completion will probably slow down the MMC communication :-/.

The best thing would be to handle the partial buffer somewhere else and get rid of the callback completely. If it is possible, probably not as I assume the partially filled buffer will not create pxamci interrupt? In the other case then maybe in pxamci_data_done()?

Log:

	[ 2669.917946] dma dma0chan1: pxad_chan_handler(): checking txd c18c2f20[135f]: completed=1 dcsr=0x2000000c
		^^^ schedules the tasklet
	[ 2669.924255] dma dma0chan1: pxad_chan_handler(): checking txd c1a6b740[1360]: completed=1 dcsr=0x2000000c
		^^^ reschedule the tasklet
	[ 2669.934441] dma dma0chan1: pxad_chan_handler(): checking txd c1a6b880[1361]: completed=1 dcsr=0x2000000c
		^^^ reschedule the tasklet
	[ 2669.944893] dma dma0chan1: pxad_chan_handler(): checking txd c1a78ba0[1362]: completed=1 dcsr=0x2000000c
		^^^ reschedule the tasklet
	[ 2670.081114] ###pre
		^^^ tasklet has finally started
	[ 2670.081187] ###post
		^^^ first item of the list, callback
	[ 2670.081369] !!!cookie=1364 complete=1363 used=1364 ... status=1
		^^^ There it would fail with "DMA error on tx channel"
	[ 2670.081608] ###post
		^^^ The second item of the list
	[ 2670.081678] !!!cookie=1364 complete=1363 used=1364 ... status=1
		^^^ Again called with the same host->data, notice same cookie, status=1 == DMA_IN_PROGRESS (always)

The full log and used debug patch are attached. The machine is PXA272 @ 416MHz, during logging (over irda or usb ssh console) I created multiple interrupt sources by touching a touchscreen and pressing GPIO buttons. A higher bug occurrence was observed with sync-written files of unusual lengths:

	while : ; do
	dd if=/dev/urandom bs=7777 count=11 of=/tmp/file conv=fsync
	done

> 
> I had a look at your traces, and I'd like something else when it happens :
>  1) The patch I provided earlier applied

Yeah it is DMA_IN_PROGRESS in the "bug" case and a few DMA_COMPLETE in the "normal" case, but I don't know if it is a valid value due to the race condition "aliasing". Anyway the status value is written in the "!!!cookie=" printk.

>  2) This done (the 'cat' after the bug) :
> 	mount -t debugfs none /sys/kernel/debug/
> 	cat /sys/kernel/debug/pxa-dma.0/channels/4/[sd]*
> 

This wasn't possible as everything freezes on the vanilla kernel and with my debug patch the DMA transactions just continue.

Cheers,
Petr


--------------5B2C8EAC715CDF6E78CD83F4
Content-Type: text/x-patch;
 name="0001-DMA-MMC-debugs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-DMA-MMC-debugs.patch"

>From 070a9c01d94e5efbdf0afae9ad2ddab380a2513e Mon Sep 17 00:00:00 2001
From: Petr Cvek <petr.cvek@tul.cz>
Date: Thu, 23 Feb 2017 01:07:51 +0100
Subject: [PATCH] DMA/MMC debugs

---
 drivers/dma/virt-dma.c    |  6 +++++-
 drivers/mmc/host/pxamci.c | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index e47fc9b0944f..c7ea39ea97fb 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -101,15 +101,19 @@ static void vchan_complete(unsigned long arg)
 	}
 	spin_unlock_irq(&vc->lock);
 
+pr_info("###pre\n");
 	dmaengine_desc_callback_invoke(&cb, NULL);
 
 	while (!list_empty(&head)) {
 		vd = list_first_entry(&head, struct virt_dma_desc, node);
 		dmaengine_desc_get_callback(&vd->tx, &cb);
+pr_info("###post\n");
 
 		list_del(&vd->node);
-		if (dmaengine_desc_test_reuse(&vd->tx))
+		if (dmaengine_desc_test_reuse(&vd->tx)) {
+			pr_info("###reuse\n");
 			list_add(&vd->node, &vc->desc_allocated);
+		}
 		else
 			vc->desc_free(vd);
 
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b404510f..d7f04b11e9e6 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -191,6 +191,8 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 
 	host->data = data;
 
+pr_info("##pxamci_setup_data\n");
+
 	writel(nob, host->base + MMC_NOB);
 	writel(data->blksz, host->base + MMC_BLKLEN);
 
@@ -300,8 +302,10 @@ static int pxamci_cmd_done(struct pxamci_host *host, unsigned int stat)
 	int i;
 	u32 v;
 
-	if (!cmd)
+	if (!cmd) {
+pr_info("###pxamci_cmd_done NONE\n");
 		return 0;
+	}
 
 	host->cmd = NULL;
 
@@ -354,8 +358,10 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
 	struct mmc_data *data = host->data;
 	struct dma_chan *chan;
 
-	if (!data)
+	if (!data) {
+pr_info("###pxamci_data_done NONE\n");
 		return 0;
+	}
 
 	if (data->flags & MMC_DATA_READ)
 		chan = host->dma_chan_rx;
@@ -385,6 +391,7 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
 	host->data = NULL;
 	if (host->mrq->stop) {
 		pxamci_stop_clock(host);
+pr_info("##pxamci_start_cmd DD\n");
 		pxamci_start_cmd(host, host->mrq->stop, host->cmdat);
 	} else {
 		pxamci_finish_request(host, host->mrq);
@@ -441,6 +448,7 @@ static void pxamci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		if (mrq->data->flags & MMC_DATA_WRITE)
 			cmdat |= CMDAT_WRITE;
 	}
+pr_info("##pxamci_start_cmd RQ\n");
 
 	pxamci_start_cmd(host, mrq->cmd, cmdat);
 }
@@ -568,13 +576,19 @@ static void pxamci_dma_irq(void *param)
 
 	status = dmaengine_tx_status(chan, host->dma_cookie, &state);
 
+pr_info("!!!cookie=%x complete=%x used=%x ... status=%i\n",
+    host->dma_cookie,chan->completed_cookie,chan->cookie,
+    status);
+
 	if (likely(status == DMA_COMPLETE)) {
 		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
+/*
 	} else {
 		pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
 			host->data->flags & MMC_DATA_READ ? "rx" : "tx");
 		host->data->error = -EIO;
 		pxamci_data_done(host, 0);
+*/
 	}
 
 out_unlock:
-- 
2.11.0


--------------5B2C8EAC715CDF6E78CD83F4
Content-Type: text/x-log;
 name="dmesg_mmc4_final.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg_mmc4_final.log"

[ 2669.855800] PXAMCI: irq 00000001 stat 00003940
[ 2669.855835] ##pxamci_start_cmd DD
[ 2669.855869] PXAMCI: irq 00000004 stat 00002140
[ 2669.861016] ##pxamci_start_cmd RQ
[ 2669.861150] PXAMCI: irq 00000004 stat 00002140
[ 2669.861230] ##pxamci_setup_data
[ 2669.861473] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2669.861504] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2669.861598] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c14c7b80[0] flags=0x1
[ 2669.861644] dma dma0chan1: pxad_tx_submit(): txd c14c7b80[135e]: submitted (not linked)
[ 2669.861663] ##pxamci_start_cmd RQ
[ 2669.861726] PXAMCI: irq 00000004 stat 00002040
[ 2669.861765] dma dma0chan1: pxad_issue_pending(): txd c14c7b80[135e]
[ 2669.861791] dma dma0chan1: pxad_launch_chan(): desc=c14c7b80
[ 2669.861821] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2669.864501] PXAMCI: irq 00000001 stat 00003940
[ 2669.864566] ##pxamci_start_cmd DD
[ 2669.864618] PXAMCI: irq 00000004 stat 00002140
[ 2669.864776] dma dma0chan1: pxad_chan_handler(): checking txd c14c7b80[135e]: completed=1 dcsr=0x2000000c
[ 2669.864812] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2669.902634] ###pre
[ 2669.902707] ###post
[ 2669.902771] ###post
[ 2669.902789] ###post
[ 2669.902839] ###post
[ 2669.902862] ###post
[ 2669.902878] ###post
[ 2669.902919] ###post
[ 2669.902935] ###post
[ 2669.902956] ###post
[ 2669.904113] ##pxamci_start_cmd RQ
[ 2669.904231] PXAMCI: irq 00000004 stat 00002140
[ 2669.905030] ##pxamci_setup_data
[ 2669.905275] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2669.914749] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2669.914851] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c18c2f20[0] flags=0x1
[ 2669.914893] dma dma0chan1: pxad_tx_submit(): txd c18c2f20[135f]: submitted (not linked)
[ 2669.914912] ##pxamci_start_cmd RQ
[ 2669.914966] PXAMCI: irq 00000004 stat 00002040
[ 2669.915010] dma dma0chan1: pxad_issue_pending(): txd c18c2f20[135f]
[ 2669.915036] dma dma0chan1: pxad_launch_chan(): desc=c18c2f20
[ 2669.915067] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2669.917946] dma dma0chan1: pxad_chan_handler(): checking txd c18c2f20[135f]: completed=1 dcsr=0x2000000c
[ 2669.918015] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2669.918092] PXAMCI: irq 00000001 stat 00003940
[ 2669.918129] ##pxamci_start_cmd DD
[ 2669.918162] PXAMCI: irq 00000004 stat 00002140
[ 2669.921740] ##pxamci_start_cmd RQ
[ 2669.921857] PXAMCI: irq 00000004 stat 00002140
[ 2669.921930] ##pxamci_setup_data
[ 2669.922014] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2669.922044] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2669.922117] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1a6b740[0] flags=0x1
[ 2669.922156] dma dma0chan1: pxad_tx_submit(): txd c1a6b740[1360]: submitted (not linked)
[ 2669.922168] ##pxamci_start_cmd RQ
[ 2669.922212] PXAMCI: irq 00000004 stat 00002040
[ 2669.922250] dma dma0chan1: pxad_issue_pending(): txd c1a6b740[1360]
[ 2669.922275] dma dma0chan1: pxad_launch_chan(): desc=c1a6b740
[ 2669.922303] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2669.924255] dma dma0chan1: pxad_chan_handler(): checking txd c1a6b740[1360]: completed=1 dcsr=0x2000000c
[ 2669.924318] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2669.924386] PXAMCI: irq 00000001 stat 00003940
[ 2669.924417] ##pxamci_start_cmd DD
[ 2669.924451] PXAMCI: irq 00000004 stat 00002140
[ 2669.931088] ##pxamci_start_cmd RQ
[ 2669.931235] PXAMCI: irq 00000004 stat 00002140
[ 2669.931488] ##pxamci_setup_data
[ 2669.931572] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2669.931603] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2669.931693] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1a6b880[0] flags=0x1
[ 2669.931735] dma dma0chan1: pxad_tx_submit(): txd c1a6b880[1361]: submitted (not linked)
[ 2669.931753] ##pxamci_start_cmd RQ
[ 2669.931812] PXAMCI: irq 00000004 stat 00002040
[ 2669.931852] dma dma0chan1: pxad_issue_pending(): txd c1a6b880[1361]
[ 2669.931879] dma dma0chan1: pxad_launch_chan(): desc=c1a6b880
[ 2669.931908] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2669.934441] dma dma0chan1: pxad_chan_handler(): checking txd c1a6b880[1361]: completed=1 dcsr=0x2000000c
[ 2669.934506] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2669.934587] PXAMCI: irq 00000001 stat 00003940
[ 2669.934621] ##pxamci_start_cmd DD
[ 2669.934656] PXAMCI: irq 00000004 stat 00002140
[ 2669.935046] ##pxamci_start_cmd RQ
[ 2669.935128] PXAMCI: irq 00000004 stat 00002140
[ 2669.939669] ##pxamci_start_cmd RQ
[ 2669.939786] PXAMCI: irq 00000004 stat 00002140
[ 2669.941248] ##pxamci_setup_data
[ 2669.941657] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2669.941691] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2669.941771] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1a78ba0[0] flags=0x1
[ 2669.941813] dma dma0chan1: pxad_tx_submit(): txd c1a78ba0[1362]: submitted (not linked)
[ 2669.941827] ##pxamci_start_cmd RQ
[ 2669.941874] PXAMCI: irq 00000004 stat 00002040
[ 2669.941918] dma dma0chan1: pxad_issue_pending(): txd c1a78ba0[1362]
[ 2669.941948] dma dma0chan1: pxad_launch_chan(): desc=c1a78ba0
[ 2669.941976] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2669.944645] PXAMCI: irq 00000001 stat 00003940
[ 2669.944711] ##pxamci_start_cmd DD
[ 2669.944746] PXAMCI: irq 00000004 stat 00002140
[ 2669.944893] dma dma0chan1: pxad_chan_handler(): checking txd c1a78ba0[1362]: completed=1 dcsr=0x2000000c
[ 2669.944930] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2669.950787] ##pxamci_start_cmd RQ
[ 2669.950906] PXAMCI: irq 00000004 stat 00002140
[ 2669.989148] ##pxamci_setup_data
[ 2669.989314] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2669.989557] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2669.989636] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c15b98c0[0] flags=0x1
[ 2669.989675] dma dma0chan1: pxad_tx_submit(): txd c15b98c0[1363]: submitted (not linked)
[ 2669.989691] ##pxamci_start_cmd RQ
[ 2669.989730] PXAMCI: irq 00000004 stat 00002040
[ 2669.989774] dma dma0chan1: pxad_issue_pending(): txd c15b98c0[1363]
[ 2669.989805] dma dma0chan1: pxad_launch_chan(): desc=c15b98c0
[ 2669.989836] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2669.992247] dma dma0chan1: pxad_chan_handler(): checking txd c15b98c0[1363]: completed=1 dcsr=0x2000000c
[ 2669.992312] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2669.992391] PXAMCI: irq 00000001 stat 00002940
[ 2669.992427] ##pxamci_start_cmd DD
[ 2669.992462] PXAMCI: irq 00000004 stat 00002140
[ 2669.992855] ##pxamci_start_cmd RQ
[ 2669.992944] PXAMCI: irq 00000004 stat 00002140
[ 2669.993033] ##pxamci_start_cmd RQ
[ 2669.993132] PXAMCI: irq 00000004 stat 00002140
[ 2669.993704] ##pxamci_start_cmd RQ
[ 2669.993820] PXAMCI: irq 00000004 stat 00002140
[ 2669.993894] ##pxamci_start_cmd RQ
[ 2669.993967] PXAMCI: irq 00000004 stat 00002140
[ 2669.994266] ##pxamci_start_cmd RQ
[ 2669.994655] PXAMCI: irq 00000004 stat 00002140
[ 2669.994778] ##pxamci_setup_data
[ 2669.994870] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2669.994899] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2669.994990] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c15b9ac0[0] flags=0x1
[ 2669.995030] dma dma0chan1: pxad_tx_submit(): txd c15b9ac0[1364]: submitted (not linked)
[ 2669.995046] ##pxamci_start_cmd RQ
[ 2669.995090] PXAMCI: irq 00000004 stat 00002040
[ 2669.995129] dma dma0chan1: pxad_issue_pending(): txd c15b9ac0[1364]
[ 2669.995156] dma dma0chan1: pxad_launch_chan(): desc=c15b9ac0
[ 2669.995184] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.081114] ###pre
[ 2670.081187] ###post
[ 2670.081345] dma dma0chan1: pxad_residue(): txd c15b9ac0[1364] sw_desc=c15b9ac0: 3008
[ 2670.081369] !!!cookie=1364 complete=1363 used=1364 ... status=1
[ 2670.081608] ###post
[ 2670.081661] dma dma0chan1: pxad_residue(): txd c15b9ac0[1364] sw_desc=c15b9ac0: 3008
[ 2670.081678] !!!cookie=1364 complete=1363 used=1364 ... status=1
[ 2670.081715] ###post
[ 2670.081752] dma dma0chan1: pxad_residue(): txd c15b9ac0[1364] sw_desc=c15b9ac0: 3008
[ 2670.081768] !!!cookie=1364 complete=1363 used=1364 ... status=1
[ 2670.081801] ###post
[ 2670.081847] dma dma0chan1: pxad_residue(): txd c15b9ac0[1364] sw_desc=c15b9ac0: 3008
[ 2670.081863] !!!cookie=1364 complete=1363 used=1364 ... status=1
[ 2670.081896] ###post
[ 2670.081945] dma dma0chan1: pxad_residue(): txd c15b9ac0[1364] sw_desc=c15b9ac0: 3008
[ 2670.081961] !!!cookie=1364 complete=1363 used=1364 ... status=1
[ 2670.491058] dma dma0chan1: pxad_chan_handler(): checking txd c15b9da0[1367]: completed=1 dcsr=0x2000000c
[ 2670.491124] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.491221] PXAMCI: irq 00000001 stat 00003940
[ 2670.491257] ##pxamci_start_cmd DD
[ 2670.491317] PXAMCI: irq 00000004 stat 00002140
[ 2670.491648] ###pre
[ 2670.491658] ###post
[ 2670.492224] ##pxamci_start_cmd RQ
[ 2670.492571] PXAMCI: irq 00000004 stat 00002140
[ 2670.492666] ##pxamci_start_cmd RQ
[ 2670.492701] PXAMCI: irq 00000004 stat 00002140
[ 2670.494661] ##pxamci_start_cmd RQ
[ 2670.494784] PXAMCI: irq 00000004 stat 00002140
[ 2670.494907] ##pxamci_setup_data
[ 2670.494994] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.495024] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.495097] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1547020[0] flags=0x1
[ 2670.495135] dma dma0chan1: pxad_tx_submit(): txd c1547020[1368]: submitted (not linked)
[ 2670.495147] ##pxamci_start_cmd RQ
[ 2670.495190] PXAMCI: irq 00000004 stat 00002040
[ 2670.495226] dma dma0chan1: pxad_issue_pending(): txd c1547020[1368]
[ 2670.495251] dma dma0chan1: pxad_launch_chan(): desc=c1547020
[ 2670.495281] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.497774] dma dma0chan1: pxad_chan_handler(): checking txd c1547020[1368]: completed=1 dcsr=0x2000000c
[ 2670.497841] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.497904] PXAMCI: irq 00000001 stat 00003940
[ 2670.497939] ##pxamci_start_cmd DD
[ 2670.497981] PXAMCI: irq 00000004 stat 00002140
[ 2670.498027] ###pre
[ 2670.498037] ###post
[ 2670.501941] ##pxamci_start_cmd RQ
[ 2670.502077] PXAMCI: irq 00000004 stat 00002140
[ 2670.502161] ##pxamci_setup_data
[ 2670.502247] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.502475] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.502560] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1547020[0] flags=0x1
[ 2670.502612] dma dma0chan1: pxad_tx_submit(): txd c1547020[1369]: submitted (not linked)
[ 2670.502635] ##pxamci_start_cmd RQ
[ 2670.502701] PXAMCI: irq 00000004 stat 00002040
[ 2670.502743] dma dma0chan1: pxad_issue_pending(): txd c1547020[1369]
[ 2670.502769] dma dma0chan1: pxad_launch_chan(): desc=c1547020
[ 2670.502800] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.505457] dma dma0chan1: pxad_chan_handler(): checking txd c1547020[1369]: completed=1 dcsr=0x2000000c
[ 2670.505527] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.505603] PXAMCI: irq 00000001 stat 00003940
[ 2670.505639] ##pxamci_start_cmd DD
[ 2670.505678] PXAMCI: irq 00000004 stat 00002140
[ 2670.505956] ###pre
[ 2670.505965] ###post
[ 2670.506539] ##pxamci_start_cmd RQ
[ 2670.506647] PXAMCI: irq 00000004 stat 00002140
[ 2670.506724] ##pxamci_setup_data
[ 2670.506802] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.506830] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.506899] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1547020[0] flags=0x1
[ 2670.506938] dma dma0chan1: pxad_tx_submit(): txd c1547020[136a]: submitted (not linked)
[ 2670.506951] ##pxamci_start_cmd RQ
[ 2670.506988] PXAMCI: irq 00000004 stat 00002040
[ 2670.507023] dma dma0chan1: pxad_issue_pending(): txd c1547020[136a]
[ 2670.507049] dma dma0chan1: pxad_launch_chan(): desc=c1547020
[ 2670.507079] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.509895] dma dma0chan1: pxad_chan_handler(): checking txd c1547020[136a]: completed=1 dcsr=0x2000000c
[ 2670.509960] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.510032] PXAMCI: irq 00000001 stat 00003940
[ 2670.510070] ##pxamci_start_cmd DD
[ 2670.510114] PXAMCI: irq 00000004 stat 00002140
[ 2670.510218] ###pre
[ 2670.510229] ###post
[ 2670.513533] ##pxamci_start_cmd RQ
[ 2670.513643] PXAMCI: irq 00000004 stat 00002140
[ 2670.513714] ##pxamci_setup_data
[ 2670.513802] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.513831] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.513904] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1547020[0] flags=0x1
[ 2670.513942] dma dma0chan1: pxad_tx_submit(): txd c1547020[136b]: submitted (not linked)
[ 2670.513955] ##pxamci_start_cmd RQ
[ 2670.513995] PXAMCI: irq 00000004 stat 00002040
[ 2670.514031] dma dma0chan1: pxad_issue_pending(): txd c1547020[136b]
[ 2670.514057] dma dma0chan1: pxad_launch_chan(): desc=c1547020
[ 2670.514085] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.516018] dma dma0chan1: pxad_chan_handler(): checking txd c1547020[136b]: completed=1 dcsr=0x2000000c
[ 2670.516083] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.516169] PXAMCI: irq 00000001 stat 00003940
[ 2670.516204] ##pxamci_start_cmd DD
[ 2670.516246] PXAMCI: irq 00000004 stat 00002140
[ 2670.516427] ###pre
[ 2670.516437] ###post
[ 2670.523779] ##pxamci_start_cmd RQ
[ 2670.523909] PXAMCI: irq 00000004 stat 00002140
[ 2670.523981] ##pxamci_setup_data
[ 2670.524066] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.524096] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.524169] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c1547020[0] flags=0x1
[ 2670.524207] dma dma0chan1: pxad_tx_submit(): txd c1547020[136c]: submitted (not linked)
[ 2670.524220] ##pxamci_start_cmd RQ
[ 2670.524262] PXAMCI: irq 00000004 stat 00002040
[ 2670.524300] dma dma0chan1: pxad_issue_pending(): txd c1547020[136c]
[ 2670.524325] dma dma0chan1: pxad_launch_chan(): desc=c1547020
[ 2670.524354] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.526806] PXAMCI: irq 00000001 stat 00003940
[ 2670.526871] ##pxamci_start_cmd DD
[ 2670.526912] PXAMCI: irq 00000004 stat 00002140
[ 2670.527039] dma dma0chan1: pxad_chan_handler(): checking txd c1547020[136c]: completed=1 dcsr=0x2000000c
[ 2670.527077] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.527105] ###pre
[ 2670.527115] ###post
[ 2670.532609] ##pxamci_start_cmd RQ
[ 2670.532728] PXAMCI: irq 00000004 stat 00002140
[ 2670.532799] ##pxamci_setup_data
[ 2670.532884] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.532914] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.546064] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c29fb280[0] flags=0x1
[ 2670.546130] dma dma0chan1: pxad_tx_submit(): txd c29fb280[136d]: submitted (not linked)
[ 2670.546153] ##pxamci_start_cmd RQ
[ 2670.546234] PXAMCI: irq 00000004 stat 00002040
[ 2670.546277] dma dma0chan1: pxad_issue_pending(): txd c29fb280[136d]
[ 2670.546304] dma dma0chan1: pxad_launch_chan(): desc=c29fb280
[ 2670.546333] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.548955] dma dma0chan1: pxad_chan_handler(): checking txd c29fb280[136d]: completed=1 dcsr=0x2000000c
[ 2670.549021] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.549085] PXAMCI: irq 00000001 stat 00003940
[ 2670.549121] ##pxamci_start_cmd DD
[ 2670.549166] PXAMCI: irq 00000004 stat 00002140
[ 2670.549232] ###pre
[ 2670.549241] ###post
[ 2670.553563] ##pxamci_start_cmd RQ
[ 2670.553681] PXAMCI: irq 00000004 stat 00002140
[ 2670.553752] ##pxamci_setup_data
[ 2670.553838] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.553868] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.553938] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c222cac0[0] flags=0x1
[ 2670.553978] dma dma0chan1: pxad_tx_submit(): txd c222cac0[136e]: submitted (not linked)
[ 2670.553991] ##pxamci_start_cmd RQ
[ 2670.554033] PXAMCI: irq 00000004 stat 00002040
[ 2670.554070] dma dma0chan1: pxad_issue_pending(): txd c222cac0[136e]
[ 2670.554096] dma dma0chan1: pxad_launch_chan(): desc=c222cac0
[ 2670.554125] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.556962] PXAMCI: irq 00000001 stat 00003940
[ 2670.557025] ##pxamci_start_cmd DD
[ 2670.557085] PXAMCI: irq 00000004 stat 00002140
[ 2670.557192] dma dma0chan1: pxad_chan_handler(): checking txd c222cac0[136e]: completed=1 dcsr=0x2000000c
[ 2670.557232] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.557450] ###pre
[ 2670.557458] ###post
[ 2670.559813] ##pxamci_start_cmd RQ
[ 2670.559939] PXAMCI: irq 00000004 stat 00002140
[ 2670.560007] ##pxamci_setup_data
[ 2670.560091] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.560120] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.560207] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c222cac0[0] flags=0x1
[ 2670.560248] dma dma0chan1: pxad_tx_submit(): txd c222cac0[136f]: submitted (not linked)
[ 2670.560260] ##pxamci_start_cmd RQ
[ 2670.560545] PXAMCI: irq 00000004 stat 00002040
[ 2670.560607] dma dma0chan1: pxad_issue_pending(): txd c222cac0[136f]
[ 2670.560639] dma dma0chan1: pxad_launch_chan(): desc=c222cac0
[ 2670.560673] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.562653] PXAMCI: irq 00000001 stat 00003940
[ 2670.562717] ##pxamci_start_cmd DD
[ 2670.562755] PXAMCI: irq 00000004 stat 00002140
[ 2670.562903] dma dma0chan1: pxad_chan_handler(): checking txd c222cac0[136f]: completed=1 dcsr=0x2000000c
[ 2670.562939] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.562981] ###pre
[ 2670.562991] ###post
[ 2670.569784] ##pxamci_start_cmd RQ
[ 2670.569920] PXAMCI: irq 00000004 stat 00002140
[ 2670.569997] ##pxamci_setup_data
[ 2670.570082] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.570113] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.570189] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c222cac0[0] flags=0x1
[ 2670.570229] dma dma0chan1: pxad_tx_submit(): txd c222cac0[1370]: submitted (not linked)
[ 2670.570241] ##pxamci_start_cmd RQ
[ 2670.570279] PXAMCI: irq 00000004 stat 00002040
[ 2670.570316] dma dma0chan1: pxad_issue_pending(): txd c222cac0[1370]
[ 2670.570341] dma dma0chan1: pxad_launch_chan(): desc=c222cac0
[ 2670.570370] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.572835] dma dma0chan1: pxad_chan_handler(): checking txd c222cac0[1370]: completed=1 dcsr=0x2000000c
[ 2670.572900] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.572963] PXAMCI: irq 00000001 stat 00003940
[ 2670.572999] ##pxamci_start_cmd DD
[ 2670.573034] PXAMCI: irq 00000004 stat 00002140
[ 2670.573078] ###pre
[ 2670.573089] ###post
[ 2670.581915] ##pxamci_start_cmd RQ
[ 2670.582057] PXAMCI: irq 00000004 stat 00002140
[ 2670.582163] ##pxamci_setup_data
[ 2670.582250] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.582487] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.582580] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c222cac0[0] flags=0x1
[ 2670.582633] dma dma0chan1: pxad_tx_submit(): txd c222cac0[1371]: submitted (not linked)
[ 2670.582650] ##pxamci_start_cmd RQ
[ 2670.582720] PXAMCI: irq 00000004 stat 00002040
[ 2670.582767] dma dma0chan1: pxad_issue_pending(): txd c222cac0[1371]
[ 2670.582795] dma dma0chan1: pxad_launch_chan(): desc=c222cac0
[ 2670.582824] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.585516] PXAMCI: irq 00000001 stat 00003940
[ 2670.585579] ##pxamci_start_cmd DD
[ 2670.585622] PXAMCI: irq 00000004 stat 00002140
[ 2670.585770] dma dma0chan1: pxad_chan_handler(): checking txd c222cac0[1371]: completed=1 dcsr=0x2000000c
[ 2670.585808] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.585938] ###pre
[ 2670.585948] ###post
[ 2670.592212] ##pxamci_start_cmd RQ
[ 2670.592359] PXAMCI: irq 00000004 stat 00002140
[ 2670.598989] ##pxamci_setup_data
[ 2670.599155] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.599189] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.599271] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c2a72700[0] flags=0x1
[ 2670.609732] dma dma0chan1: pxad_tx_submit(): txd c2a72700[1372]: submitted (not linked)
[ 2670.609758] ##pxamci_start_cmd RQ
[ 2670.609814] PXAMCI: irq 00000004 stat 00002040
[ 2670.609859] dma dma0chan1: pxad_issue_pending(): txd c2a72700[1372]
[ 2670.609885] dma dma0chan1: pxad_launch_chan(): desc=c2a72700
[ 2670.609916] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.612797] dma dma0chan1: pxad_chan_handler(): checking txd c2a72700[1372]: completed=1 dcsr=0x2000000c
[ 2670.612867] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.612945] PXAMCI: irq 00000001 stat 00003940
[ 2670.612979] ##pxamci_start_cmd DD
[ 2670.613017] PXAMCI: irq 00000004 stat 00002140
[ 2670.613116] ###pre
[ 2670.613126] ###post
[ 2670.613508] ##pxamci_start_cmd RQ
[ 2670.613606] PXAMCI: irq 00000004 stat 00002140
[ 2670.618698] ##pxamci_start_cmd RQ
[ 2670.618897] PXAMCI: irq 00000004 stat 00002140
[ 2670.646290] ##pxamci_setup_data
[ 2670.646683] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.646716] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.646796] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c14c76c0[0] flags=0x1
[ 2670.646840] dma dma0chan1: pxad_tx_submit(): txd c14c76c0[1373]: submitted (not linked)
[ 2670.646854] ##pxamci_start_cmd RQ
[ 2670.646899] PXAMCI: irq 00000004 stat 00002040
[ 2670.646941] dma dma0chan1: pxad_issue_pending(): txd c14c76c0[1373]
[ 2670.646970] dma dma0chan1: pxad_launch_chan(): desc=c14c76c0
[ 2670.646999] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.649372] dma dma0chan1: pxad_chan_handler(): checking txd c14c76c0[1373]: completed=1 dcsr=0x2000000c
[ 2670.649439] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.649505] PXAMCI: irq 00000001 stat 00002940
[ 2670.649542] ##pxamci_start_cmd DD
[ 2670.649590] PXAMCI: irq 00000004 stat 00002140
[ 2670.649852] ###pre
[ 2670.649861] ###post
[ 2670.650111] ##pxamci_start_cmd RQ
[ 2670.650228] PXAMCI: irq 00000004 stat 00002140
[ 2670.650436] ##pxamci_start_cmd RQ
[ 2670.650540] PXAMCI: irq 00000004 stat 00002140
[ 2670.650875] ##pxamci_start_cmd RQ
[ 2670.651028] PXAMCI: irq 00000004 stat 00002140
[ 2670.651101] ##pxamci_start_cmd RQ
[ 2670.651133] PXAMCI: irq 00000004 stat 00002140
[ 2670.651187] ##pxamci_start_cmd RQ
[ 2670.651244] PXAMCI: irq 00000004 stat 00002140
[ 2670.652688] ##pxamci_start_cmd RQ
[ 2670.652834] PXAMCI: irq 00000004 stat 00002140
[ 2670.652943] ##pxamci_setup_data
[ 2670.653055] dma dma0chan1: pxad_get_config(): dev_addr=0x41100044 maxburst=32 width=1  dir=1
[ 2670.653122] dma dma0chan1: pxad_prep_slave_sg(): dir=1 flags=1
[ 2670.653226] dma dma0chan1: pxad_tx_prep(): vc=c39bfcb0 txd=c14c7780[0] flags=0x1
[ 2670.653538] dma dma0chan1: pxad_tx_submit(): txd c14c7780[1374]: submitted (not linked)
[ 2670.653570] ##pxamci_start_cmd RQ
[ 2670.653633] PXAMCI: irq 00000004 stat 00002040
[ 2670.653683] dma dma0chan1: pxad_issue_pending(): txd c14c7780[1374]
[ 2670.653713] dma dma0chan1: pxad_launch_chan(): desc=c14c7780
[ 2670.653744] dma dma0chan1: phy_enable(); phy=c393d0cc(13) misaligned=0
[ 2670.889030] dma dma0chan1: pxad_chan_handler(): checking txd c14c7780[1374]: completed=1 dcsr=0x2000000c
[ 2670.889098] dma dma0chan1: pxad_chan_handler(): channel stopped, submitted_empty=1 issued_empty=1
[ 2670.889165] PXAMCI: irq 00000001 stat 00003940
[ 2670.889201] ##pxamci_start_cmd DD
[ 2670.889241] PXAMCI: irq 00000004 stat 00002140

--------------5B2C8EAC715CDF6E78CD83F4--
