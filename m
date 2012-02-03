From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] usb: fix renesas_usbhs to not schedule in atomic context
Date: Fri, 3 Feb 2012 16:43:20 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202031623000.6211@axis700.grange>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
 <1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de> <4F22624E.2090201@renesas.com>
 <Pine.LNX.4.64.1201270946150.32661@axis700.grange> <4F27CA7D.601@renesas.com>
 <Pine.LNX.4.64.1202022317560.13860@axis700.grange> <4F2B9F34.60308@renesas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4F2B9F34.60308@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-usb@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The current renesas_usbhs driver triggers

BUG: scheduling while atomic: ksoftirqd/0/3/0x00000102

with enabled CONFIG_DEBUG_ATOMIC_SLEEP, by submitting DMA transfers from 
an atomic (tasklet) context, which is not supported by the shdma dmaengine 
driver. Fix it by switching to a work. Also simplify some list 
manipulations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Shimoda-san, this is the problem, that you were observing. However, it 
exists with the present version of shdma just as well as with the new one 
- on top of the simple DMA library. I marked it an RFC because (1) I only 
lightly tested it with the gadget device on mackerel with the mass storage 
gadget, and (2) I am somewhat concerned about races. Currently the work 
function runs with no locking and there are no usual cancel_work_sync() 
points in the patch. However, it has also been like this before with the 
tasklet implementation, which is not much better, and it looks like there 
are no asynchronous operations on the same packets like timeouts. Only 
asynchronous events, that I can think about are things like unloading the 
driver or unplugging the cable, but these have been there before too. It 
would become worse on SMP, I think. Comments welcome.

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 72339bd..4d739ec 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -75,8 +75,7 @@ void usbhs_pkt_push(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt,
 		pipe->handler = &usbhsf_null_handler;
 	}
 
-	list_del_init(&pkt->node);
-	list_add_tail(&pkt->node, &pipe->list);
+	list_move_tail(&pkt->node, &pipe->list);
 
 	/*
 	 * each pkt must hold own handler.
@@ -106,7 +105,7 @@ static struct usbhs_pkt *__usbhsf_pkt_get(struct usbhs_pipe *pipe)
 	if (list_empty(&pipe->list))
 		return NULL;
 
-	return list_entry(pipe->list.next, struct usbhs_pkt, node);
+	return list_first_entry(&pipe->list, struct usbhs_pkt, node);
 }
 
 struct usbhs_pkt *usbhs_pkt_pop(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt)
@@ -762,9 +761,9 @@ static int __usbhsf_dma_map_ctrl(struct usbhs_pkt *pkt, int map)
 }
 
 static void usbhsf_dma_complete(void *arg);
-static void usbhsf_dma_prepare_tasklet(unsigned long data)
+static void xfer_work(struct work_struct *work)
 {
-	struct usbhs_pkt *pkt = (struct usbhs_pkt *)data;
+	struct usbhs_pkt *pkt = container_of(work, struct usbhs_pkt, work);
 	struct usbhs_pipe *pipe = pkt->pipe;
 	struct usbhs_fifo *fifo = usbhs_pipe_to_fifo(pipe);
 	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
@@ -844,11 +843,8 @@ static int usbhsf_dma_prepare_push(struct usbhs_pkt *pkt, int *is_done)
 
 	pkt->trans = len;
 
-	tasklet_init(&fifo->tasklet,
-		     usbhsf_dma_prepare_tasklet,
-		     (unsigned long)pkt);
-
-	tasklet_schedule(&fifo->tasklet);
+	INIT_WORK(&pkt->work, xfer_work);
+	schedule_work(&pkt->work);
 
 	return 0;
 
@@ -938,11 +934,8 @@ static int usbhsf_dma_try_pop(struct usbhs_pkt *pkt, int *is_done)
 
 	pkt->trans = len;
 
-	tasklet_init(&fifo->tasklet,
-		     usbhsf_dma_prepare_tasklet,
-		     (unsigned long)pkt);
-
-	tasklet_schedule(&fifo->tasklet);
+	INIT_WORK(&pkt->work, xfer_work);
+	schedule_work(&pkt->work);
 
 	return 0;
 
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index f68609c..c31731a 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -19,6 +19,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/sh_dma.h>
+#include <linux/workqueue.h>
 #include <asm/dma.h>
 #include "pipe.h"
 
@@ -31,7 +32,6 @@ struct usbhs_fifo {
 	u32 ctr;	/* xFIFOCTR */
 
 	struct usbhs_pipe	*pipe;
-	struct tasklet_struct	tasklet;
 
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
@@ -53,6 +53,7 @@ struct usbhs_pkt {
 	struct usbhs_pkt_handle *handler;
 	void (*done)(struct usbhs_priv *priv,
 		     struct usbhs_pkt *pkt);
+	struct work_struct work;
 	dma_addr_t dma;
 	void *buf;
 	int length;
