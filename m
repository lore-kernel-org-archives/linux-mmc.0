Return-Path: <SRS0=uM1y=DN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE2C41604
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D27206D4
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ou+95XWk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8K5fVv+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJFPdh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:33:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37312 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgJFPdh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2020 11:33:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601998414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=TpFdJmNSEf9gqbMItbvQwoo6jjLXAwfCm9Ljik+iyOE=;
        b=ou+95XWkljm8BCzCGPg8lOH+8VW91gigOF2OHzRnUQq/vrxiOdV2OjFuBvlp3agjNy/4aT
        Dz1CUHVtg1ZAwhzeNHCN4XyfPoA6Gss07o0HIC6h+e7TCXDeMw5ZdZQ6hykU/jVP3dJgIU
        53MvCBQ36yW+0mEROqDOqOdXEdaDwBJBmDbLxGpI8T8ID7EuTNGamX24tSPy41oiWPGcXl
        rBR1aAbbbHy/SE0Ju3N96nNstphveMF5MALFPfkt4i4BB+iWYS4Cqj1xbnV/4UfrY/ZY/0
        5AJ70/oD8GHiToC9n0vV9Y0N/oKvJkAfG75mpxdPvo5OmowpfWaxT/NgXuqiYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601998414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=TpFdJmNSEf9gqbMItbvQwoo6jjLXAwfCm9Ljik+iyOE=;
        b=8K5fVv+YybyvUjx+EWuOYq3iiyuQziJN0K5nb2TvsSaJe9prqxu0hXjIHNUcUEPFypI4Y3
        CogLcssC0jn3VSBA==
To:     Brad Harper <bjharper@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-Reply-To: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com>
Date:   Tue, 06 Oct 2020 17:33:34 +0200
Message-ID: <87o8lf74j5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Brad,

On Wed, Oct 07 2020 at 00:45, Brad Harper wrote:
> I'm happy to test anything on a range of amlogic hardware with standard=20
> / rt and=C2=A0 multiple mmc devices.=C2=A0 Ill test Jerome's patch in nex=
t 24=20
> hours to report the results.

please do not top-post and trim your replies.

> On 6/10/2020 11:43 pm, Thomas Gleixner wrote:
>>       We rather should make interrupts which need to have their primary
>>       handler in hard interrupt context to set IRQF_NO_THREAD. That
>>       should at the same time confirm that the primary handler is RT
>>       safe.
>>
>>       Let me stare at the core code and the actual usage sites some more.

So there are a few nasties in there and I faintly remember that there
was an assumption that interrupts which are requested with both a
primary and a secondary handler should quiesce the device interrupt in
the primary handler if needed. OTOH, this also enforces that the primary
handler is RT safe, which is after a quick scan of all the usage sites
not a given and quite some of the users rely on IRQF_ONESHOT.

The below untested patch should cure the problem and keep the interrupt
line masked if requested with IRQF_ONESHOT.

Thanks,

        tglx
---
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -967,8 +967,7 @@ static int irq_wait_for_interrupt(struct
 static void irq_finalize_oneshot(struct irq_desc *desc,
 				 struct irqaction *action)
 {
-	if (!(desc->istate & IRQS_ONESHOT) ||
-	    action->handler =3D=3D irq_forced_secondary_handler)
+	if (!(action->flags & IRQF_ONESHOT))
 		return;
 again:
 	chip_bus_lock(desc);
@@ -1073,10 +1072,6 @@ irq_forced_thread_fn(struct irq_desc *de
=20
 	local_bh_disable();
 	ret =3D action->thread_fn(action->irq, action->dev_id);
-	if (ret =3D=3D IRQ_HANDLED)
-		atomic_inc(&desc->threads_handled);
-
-	irq_finalize_oneshot(desc, action);
 	local_bh_enable();
 	return ret;
 }
@@ -1089,14 +1084,7 @@ irq_forced_thread_fn(struct irq_desc *de
 static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 		struct irqaction *action)
 {
-	irqreturn_t ret;
-
-	ret =3D action->thread_fn(action->irq, action->dev_id);
-	if (ret =3D=3D IRQ_HANDLED)
-		atomic_inc(&desc->threads_handled);
-
-	irq_finalize_oneshot(desc, action);
-	return ret;
+	return action->thread_fn(action->irq, action->dev_id);
 }
=20
 static void wake_threads_waitq(struct irq_desc *desc)
@@ -1172,9 +1160,14 @@ static int irq_thread(void *data)
 		irq_thread_check_affinity(desc, action);
=20
 		action_ret =3D handler_fn(desc, action);
+		if (action_ret =3D=3D IRQ_HANDLED)
+			atomic_inc(&desc->threads_handled);
+
 		if (action_ret =3D=3D IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);
=20
+		irq_finalize_oneshot(desc, action);
+
 		wake_threads_waitq(desc);
 	}
=20
@@ -1219,7 +1212,7 @@ static int irq_setup_forced_threading(st
 {
 	if (!force_irqthreads)
 		return 0;
-	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
+	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU))
 		return 0;
=20
 	/*
@@ -1229,8 +1222,6 @@ static int irq_setup_forced_threading(st
 	if (new->handler =3D=3D irq_default_primary_handler)
 		return 0;
=20
-	new->flags |=3D IRQF_ONESHOT;
-
 	/*
 	 * Handle the case where we have a real primary handler and a
 	 * thread handler. We force thread them as well by creating a
@@ -1246,8 +1237,11 @@ static int irq_setup_forced_threading(st
 		new->secondary->dev_id =3D new->dev_id;
 		new->secondary->irq =3D new->irq;
 		new->secondary->name =3D new->name;
+		/* Preserve the requested IRQF_ONESHOT */
+		new->secondary->flags =3D new->flags & IRQF_ONESHOT;
 	}
 	/* Deal with the primary handler */
+	new->flags |=3D IRQF_ONESHOT;
 	set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
 	new->thread_fn =3D new->handler;
 	new->handler =3D irq_default_primary_handler;
@@ -1341,6 +1335,38 @@ setup_irq_thread(struct irqaction *new,
 	return 0;
 }
=20
+static unsigned long thread_mask_alloc(unsigned long thread_mask)
+{
+	/*
+	 * Unlikely to have 32 resp 64 irqs sharing one line,
+	 * but who knows.
+	 */
+	if (thread_mask =3D=3D ~0UL)
+		return 0;
+
+	/*
+	 * The thread_mask for the action is or'ed to
+	 * desc->thread_active to indicate that the
+	 * IRQF_ONESHOT thread handler has been woken, but not
+	 * yet finished. The bit is cleared when a thread
+	 * completes. When all threads of a shared interrupt
+	 * line have completed desc->threads_active becomes
+	 * zero and the interrupt line is unmasked. See
+	 * handle.c:irq_wake_thread() for further information.
+	 *
+	 * If no thread is woken by primary (hard irq context)
+	 * interrupt handlers, then desc->threads_active is
+	 * also checked for zero to unmask the irq line in the
+	 * affected hard irq flow handlers
+	 * (handle_[fasteoi|level]_irq).
+	 *
+	 * The new action gets the first zero bit of
+	 * thread_mask assigned. See the loop above which or's
+	 * all existing action->thread_mask bits.
+	 */
+	return 1UL << ffz(thread_mask);
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1525,35 +1551,18 @@ static int
 	 * conditional in irq_wake_thread().
 	 */
 	if (new->flags & IRQF_ONESHOT) {
-		/*
-		 * Unlikely to have 32 resp 64 irqs sharing one line,
-		 * but who knows.
-		 */
-		if (thread_mask =3D=3D ~0UL) {
-			ret =3D -EBUSY;
+		ret =3D -EBUSY;
+		new->thread_mask =3D thread_mask_alloc(thread_mask);
+		if (!new->thread_mask)
 			goto out_unlock;
+
+		if (new->secondary && (new->secondary->flags & IRQF_ONESHOT)) {
+			thread_mask |=3D new->thread_mask;
+			new->secondary->thread_mask =3D
+				thread_mask_alloc(thread_mask);
+			if (!new->secondary->thread_mask)
+				goto out_unlock;
 		}
-		/*
-		 * The thread_mask for the action is or'ed to
-		 * desc->thread_active to indicate that the
-		 * IRQF_ONESHOT thread handler has been woken, but not
-		 * yet finished. The bit is cleared when a thread
-		 * completes. When all threads of a shared interrupt
-		 * line have completed desc->threads_active becomes
-		 * zero and the interrupt line is unmasked. See
-		 * handle.c:irq_wake_thread() for further information.
-		 *
-		 * If no thread is woken by primary (hard irq context)
-		 * interrupt handlers, then desc->threads_active is
-		 * also checked for zero to unmask the irq line in the
-		 * affected hard irq flow handlers
-		 * (handle_[fasteoi|level]_irq).
-		 *
-		 * The new action gets the first zero bit of
-		 * thread_mask assigned. See the loop above which or's
-		 * all existing action->thread_mask bits.
-		 */
-		new->thread_mask =3D 1UL << ffz(thread_mask);
=20
 	} else if (new->handler =3D=3D irq_default_primary_handler &&
 		   !(desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)) {


