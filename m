From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 01/31] genirq: Provide synchronize_hardirq()
Date: Tue, 18 Feb 2014 15:09:07 +0000
Message-ID: <E1WFmIF-0006la-Ke@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40437 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756588AbaBRPJJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:09 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

synchronize_irq() waits for hard irq and threaded handlers to complete
before returning. For some special cases we only need to make sure
that the hard interrupt part of the irq line is not in progress when
we disabled the - possibly shared - interrupt at the device level.

A proper use case for this was provided by Russell. The sdhci driver
requires some irq triggered functions to be run in thread context. The
current implementation of the thread context is a sdio private kthread
construct, which has quite some shortcomings. These can be avoided
when the thread is directly associated to the device interrupt via the
generic threaded irq infrastructure.

Though there is a corner case related to run time power management
where one side disables the device interrupts at the device level and
needs to make sure, that an already running hard interrupt handler has
completed before proceeding further. Though that hard interrupt
handler might wake the associated thread, which in turn can request
the runtime PM to reenable the device. Using synchronize_irq() leads
to an immediate deadlock of the irq thread waiting for the PM lock and
the synchronize_irq() waiting for the irq thread to complete.

Due to the fact that it is sufficient for this case to ensure that no
hard irq handler is executing a new function which avoids the check
for the thread is required.

Add a function, which just monitors the hard irq parts and ignores the
threaded handlers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 include/linux/hardirq.h |  1 +
 kernel/irq/manage.c     | 67 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 12d5f972f23f..cba442ec3c66 100644
=-DO NOT APPLY-= a/include/linux/hardirq.h
=+DO NOT APPLY+= b/include/linux/hardirq.h
@@ -9,6 +9,7 @@
 
 
 extern void synchronize_irq(unsigned int irq);
=+DO NOT APPLY+=extern void synchronize_hardirq(unsigned int irq);
 
 #if defined(CONFIG_TINY_RCU)
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 481a13c43b17..67ac52d59fd3 100644
=-DO NOT APPLY-= a/kernel/irq/manage.c
=+DO NOT APPLY+= b/kernel/irq/manage.c
@@ -32,24 +32,10 @@ static int __init setup_forced_irqthreads(char *arg)
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
-/**
- *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
- *	@irq: interrupt number to wait for
- *
- *	This function waits for any pending IRQ handlers for this interrupt
- *	to complete before returning. If you use this function while
- *	holding a resource the IRQ handler may need you will deadlock.
- *
- *	This function may be called - with care - from IRQ context.
- */
-void synchronize_irq(unsigned int irq)
=+DO NOT APPLY+=static void __synchronize_hardirq(struct irq_desc *desc)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	bool inprogress;
 
-	if (!desc)
-		return;
-
 	do {
 		unsigned long flags;
 
@@ -67,12 +53,53 @@ void synchronize_irq(unsigned int irq)
 
 		/* Oops, that failed? */
 	} while (inprogress);
=+DO NOT APPLY+=}
 
-	/*
-	 * We made sure that no hardirq handler is running. Now verify
-	 * that no threaded handlers are active.
-	 */
-	wait_event(desc->wait_for_threads, !atomic_read(&desc->threads_active));
=+DO NOT APPLY+=/**
=+DO NOT APPLY+= *	synchronize_hardirq - wait for pending hard IRQ handlers (on other CPUs)
=+DO NOT APPLY+= *	@irq: interrupt number to wait for
=+DO NOT APPLY+= *
=+DO NOT APPLY+= *	This function waits for any pending hard IRQ handlers for this
=+DO NOT APPLY+= *	interrupt to complete before returning. If you use this
=+DO NOT APPLY+= *	function while holding a resource the IRQ handler may need you
=+DO NOT APPLY+= *	will deadlock. It does not take associated threaded handlers into
=+DO NOT APPLY+= *	account.
=+DO NOT APPLY+= *
=+DO NOT APPLY+= *	This function may be called - with care - from IRQ context.
=+DO NOT APPLY+= */
=+DO NOT APPLY+=void synchronize_hardirq(unsigned int irq)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	struct irq_desc *desc = irq_to_desc(irq);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	if (desc)
=+DO NOT APPLY+=		__synchronize_hardirq(desc);
=+DO NOT APPLY+=}
=+DO NOT APPLY+=EXPORT_SYMBOL(synchronize_hardirq);
=+DO NOT APPLY+=
=+DO NOT APPLY+=/**
=+DO NOT APPLY+= *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
=+DO NOT APPLY+= *	@irq: interrupt number to wait for
=+DO NOT APPLY+= *
=+DO NOT APPLY+= *	This function waits for any pending IRQ handlers for this interrupt
=+DO NOT APPLY+= *	to complete before returning. If you use this function while
=+DO NOT APPLY+= *	holding a resource the IRQ handler may need you will deadlock.
=+DO NOT APPLY+= *
=+DO NOT APPLY+= *	This function may be called - with care - from IRQ context.
=+DO NOT APPLY+= */
=+DO NOT APPLY+=void synchronize_irq(unsigned int irq)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	struct irq_desc *desc = irq_to_desc(irq);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	if (desc) {
=+DO NOT APPLY+=		__synchronize_hardirq(desc);
=+DO NOT APPLY+=		/*
=+DO NOT APPLY+=		 * We made sure that no hardirq handler is
=+DO NOT APPLY+=		 * running. Now verify that no threaded handlers are
=+DO NOT APPLY+=		 * active.
=+DO NOT APPLY+=		 */
=+DO NOT APPLY+=		wait_event(desc->wait_for_threads,
=+DO NOT APPLY+=			   !atomic_read(&desc->threads_active));
=+DO NOT APPLY+=	}
 }
 EXPORT_SYMBOL(synchronize_irq);
 
-- 
1.8.3.1

