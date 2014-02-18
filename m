From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 02/31] genirq: Provide irq_wake_thread()
Date: Tue, 18 Feb 2014 15:09:12 +0000
Message-ID: <E1WFmIK-0006le-OW@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40442 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755872AbaBRPJO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:14 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

In course of the sdhci/sdio discussion with Russell about killing the
sdio kthread hackery we discovered the need to be able to wake an
interrupt thread from software.

The rationale for this is, that sdio hardware can lack proper
interrupt support for certain features. So the driver needs to poll
the status registers, but at the same time it needs to be woken up by
an hardware interrupt.

To be able to get rid of the home brewn kthread construct of sdio we
need a way to wake an irq thread independent of an actual hardware
interrupt.

Provide an irq_wake_thread() function which wakes up the thread which
is associated to a given dev_id. This allows sdio to invoke the irq
thread from the hardware irq handler via the IRQ_WAKE_THREAD return
value and provides a possibility to wake it via a timer for the
polling scenarios. That allows to simplify the sdio logic
significantly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 include/linux/interrupt.h |  1 +
 kernel/irq/handle.c       |  4 ++--
 kernel/irq/internals.h    |  1 +
 kernel/irq/manage.c       | 27 +++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0053adde0ed9..83c52e8b5221 100644
=-DO NOT APPLY-= a/include/linux/interrupt.h
=+DO NOT APPLY+= b/include/linux/interrupt.h
@@ -183,6 +183,7 @@ extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
 extern void enable_percpu_irq(unsigned int irq, unsigned int type);
=+DO NOT APPLY+=extern void irq_wake_thread(unsigned int irq, void *dev_id);
 
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 131ca176b497..bfec453557b4 100644
=-DO NOT APPLY-= a/kernel/irq/handle.c
=+DO NOT APPLY+= b/kernel/irq/handle.c
@@ -51,7 +51,7 @@ static void warn_no_thread(unsigned int irq, struct irqaction *action)
 	       "but no thread function available.", irq, action->name);
 }
 
-static void irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
=+DO NOT APPLY+=void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 {
 	/*
 	 * In case the thread crashed and was killed we just pretend that
@@ -157,7 +157,7 @@ handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
 				break;
 			}
 
-			irq_wake_thread(desc, action);
=+DO NOT APPLY+=			__irq_wake_thread(desc, action);
 
 			/* Fall through to add to randomness */
 		case IRQ_HANDLED:
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 001fa5bab490..d61ac29e32d0 100644
=-DO NOT APPLY-= a/kernel/irq/internals.h
=+DO NOT APPLY+= b/kernel/irq/internals.h
@@ -82,6 +82,7 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
 /* Resending of interrupts :*/
 void check_irq_resend(struct irq_desc *desc, unsigned int irq);
 bool irq_wait_for_poll(struct irq_desc *desc);
=+DO NOT APPLY+=void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 
 #ifdef CONFIG_PROC_FS
 extern void register_irq_proc(unsigned int irq, struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 67ac52d59fd3..5ce280a56905 100644
=-DO NOT APPLY-= a/kernel/irq/manage.c
=+DO NOT APPLY+= b/kernel/irq/manage.c
@@ -908,6 +908,33 @@ static int irq_thread(void *data)
 	return 0;
 }
 
=+DO NOT APPLY+=/**
=+DO NOT APPLY+= *	irq_wake_thread - wake the irq thread for the action identified by dev_id
=+DO NOT APPLY+= *	@irq:		Interrupt line
=+DO NOT APPLY+= *	@dev_id:	Device identity for which the thread should be woken
=+DO NOT APPLY+= *
=+DO NOT APPLY+= */
=+DO NOT APPLY+=void irq_wake_thread(unsigned int irq, void *dev_id)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	struct irq_desc *desc = irq_to_desc(irq);
=+DO NOT APPLY+=	struct irqaction *action;
=+DO NOT APPLY+=	unsigned long flags;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
=+DO NOT APPLY+=		return;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	raw_spin_lock_irqsave(&desc->lock, flags);
=+DO NOT APPLY+=	for (action = desc->action; action; action = action->next) {
=+DO NOT APPLY+=		if (action->dev_id == dev_id) {
=+DO NOT APPLY+=			if (action->thread)
=+DO NOT APPLY+=				__irq_wake_thread(desc, action);
=+DO NOT APPLY+=			break;
=+DO NOT APPLY+=		}
=+DO NOT APPLY+=	}
=+DO NOT APPLY+=	raw_spin_unlock_irqrestore(&desc->lock, flags);
=+DO NOT APPLY+=}
=+DO NOT APPLY+=EXPORT_SYMBOL_GPL(irq_wake_thread);
=+DO NOT APPLY+=
 static void irq_setup_forced_threading(struct irqaction *new)
 {
 	if (!force_irqthreads)
-- 
1.8.3.1

