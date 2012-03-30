From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: SDIO single irq optimization - Spurious interrupt notification
 to function driver
Date: Fri, 30 Mar 2012 15:05:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1203301437460.24151@xanadu.home>
References: <4F753D28.6020300@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57106 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760138Ab2C3TFa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 15:05:30 -0400
Received: by qcqw6 with SMTP id w6so556432qcq.19
        for <linux-mmc@vger.kernel.org>; Fri, 30 Mar 2012 12:05:29 -0700 (PDT)
In-Reply-To: <4F753D28.6020300@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, per.forlin@linaro.org

On Fri, 30 Mar 2012, Sujit Reddy Thumma wrote:

> Hi,
> 
> While I was debugging an issue where the sdio function driver panics upon
> receiving a spurious interrupt notification which is similar to the one found
> on libertas sdio http://permalink.gmane.org/gmane.linux.kernel.mmc/8338
> 
> I can confirm that my hardware not buggy and is not generating any interrupts
> during initialization and CCCR_INTx is all zero's.

Irrespective of whatever issue this optimization is uncovering, you 
should _never_ panic when receiving a spurious interrupt notification.  
This is just basic hardware driver programming practice to gracefully 
deal with unexpected hardware state.  In this case, you should simply 
notice that your function has no pending work and just return.  You 
probably know this already but this is still worth mentioning again.

> After some analysis, I found that there is a notification of interrupt to
> function handler by sdio_irq_thread() even though there is no interrupt. The
> sequence is as follows.
> 
> sdio_claim_host();
> 
> sdio_claim_irq():
> 	...
> 	sdio_card_irq_get() -> kthread_run(sdio_irq_thread) ->
> wake_up_sdio_irq_thread
> 	sdio_single_irq_set() -> card->sdio_single_irq = func = sdio_func[i];
> 	...
> 
> sdio_release_host();
> 
> Since we woke up sdio_irq_thread(), while this thread get a chance to run:
> ...
> __mmc_claim_host()
> process_sdio_pending_irqs() -> since sdio_single_irq is non NULL the
> func->handler is directly called without checking pending interrupt bit
> CCCR_INTx.
> mmc_release_host()
> ...
> 
> Irrespective of the function driver state, sdio driver should not call
> func->handler() if it is not real interrupt. I knew that function handler
> should be able to handle these interrupts gracefully. But it is just not the
> right thing for sdio driver to generate spurious interrupts.

I agree with you.  There is no point calling interrupt handlers 
spuriously if we can.  The patch below should fix that.  But that 
doesn't mean that your driver is not buggy as well.  In other words, the 
patch below is no excuse for you not to fix your code too!

----- >8
Subject: [PATCH] mmc: sdio: avoid spurious calls to interrupt handlers

Commit 06e8935feb "optimized SDIO IRQ handling for single irq" 
introduced some spurious calls to SDIO function interrupt handlers,
such as when the SDIO IRQ thread is started, or the safety check 
performed upon a system resume.  Let's add a flag to perform the
optimization only when a real interrupt is signaled by the host
driver and we know there is no point confirming it.

Reported-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@kernel.org

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index f573e7f9f7..3d8ceb4084 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -28,18 +28,20 @@
 
 #include "sdio_ops.h"
 
-static int process_sdio_pending_irqs(struct mmc_card *card)
+static int process_sdio_pending_irqs(struct mmc_host *host)
 {
+	struct mmc_card *card = host->card;
 	int i, ret, count;
 	unsigned char pending;
 	struct sdio_func *func;
 
 	/*
 	 * Optimization, if there is only 1 function interrupt registered
-	 * call irq handler directly
+	 * and we know an IRQ was signaled then call irq handler directly.
+	 * Otherwise do the full probe.
 	 */
 	func = card->sdio_single_irq;
-	if (func) {
+	if (func && host->sdio_irq_pending) {
 		func->irq_handler(func);
 		return 1;
 	}
@@ -116,7 +118,8 @@ static int sdio_irq_thread(void *_host)
 		ret = __mmc_claim_host(host, &host->sdio_irq_thread_abort);
 		if (ret)
 			break;
-		ret = process_sdio_pending_irqs(host->card);
+		ret = process_sdio_pending_irqs(host);
+		host->sdio_irq_pending = false;
 		mmc_release_host(host);
 
 		/*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ee2b0363c0..557aa4cd66 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -323,6 +323,7 @@ struct mmc_host {
 
 	unsigned int		sdio_irqs;
 	struct task_struct	*sdio_irq_thread;
+	bool			sdio_irq_pending;
 	atomic_t		sdio_irq_thread_abort;
 
 	mmc_pm_flag_t		pm_flags;	/* requested pm features */
@@ -378,6 +379,7 @@ extern int mmc_cache_ctrl(struct mmc_host *, u8);
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
 	host->ops->enable_sdio_irq(host, 0);
+	host->sdio_irq_pending = true;
 	wake_up_process(host->sdio_irq_thread);
 }
 
