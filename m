Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E043C43467
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0386C215A4
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efoHu7dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgJHJJH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHJJG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2020 05:09:06 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC46C061755
        for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2020 02:09:04 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id f15so1645830uaq.9
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2020 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ys8YNvOHIAk8VrNZZJl76QEza47nB/FfFC5qHScGSYQ=;
        b=efoHu7drs789U4yzKMxSHSkvPlcbQTJJztg6jbUC2OJTpcDvlFhLVNXI0vsrU7gzDg
         KDVxR3SGi52hOLOdWqLl4/vp4nBcdg1pR5tPP2mtDqiZzQ19OlfaWvsBhzln23tOR6rR
         ylAzMsXHFjO9QrCgb2YzpvDtjkwpNGeaDbCK8tkNlWd7OPW2bMoLUiUW0ZhKGoR++v27
         7+ydyHi85t0pMx5SKQr3yS5I1MhJ0D4+LRJvQeM+V0NDDZoGbCibv4fgnulJIwG0ppB7
         0FzPXBJpgQ7ifoP/vdQYLsShBhs6kZ/ZV6XF4mOXN8rlL2DLQ11GGHv8/M9DeG/ROvm4
         dAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ys8YNvOHIAk8VrNZZJl76QEza47nB/FfFC5qHScGSYQ=;
        b=rYgSuyerT/topP8+CeAyqd1wx2a5/OEyiWcIWK1m73FuZpafqIhFjVrnn4tV+1UK4+
         QjU8RfB6svIDYaaq8E5bjTaOnQtYV0BfVFbtQ99/7AISmn9ikkAIXRY6EfPH0/Eau9iV
         78+NRJar4MNDt1BV5eOXkOdRqR6AOoa4kjKHNc8GT/7h+rvdGzwqxx1hPqH4KRFTiZdE
         LqAmpoejvyBAn8gghJGMT9aPipEGfsoJ7eZuLM7B80YSz+q03DdvRiEz0a0R04LVpWal
         kvVfIer7FKpY1vDH/w5uoFR6E8FMzliUq0bYbohvoogVevnE6uhv0k2U0tWeU7D2OydA
         n6Lw==
X-Gm-Message-State: AOAM532JOwW+fkFN/uPC0uwMh+f1GxFOhLPh+G7PzBpgW3vMrMMfnmM8
        gu5ia268DYAlc/7rC49aGdlULvpOkWpiBXOTSu6yow==
X-Google-Smtp-Source: ABdhPJzfkDaEWr1LMBcvQaebaaMeol2WcIbuZU5mEchl2MyTqCh+XzsTJc8hJB+agiGLkdCC9RTzYjm4sg3ir2YBpMc=
X-Received: by 2002:ab0:130a:: with SMTP id g10mr4149927uae.100.1602148143769;
 Thu, 08 Oct 2020 02:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com> <87o8lf74j5.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8lf74j5.fsf@nanos.tec.linutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Oct 2020 11:08:27 +0200
Message-ID: <CAPDyKFosR2wd=jqADBF_dNd3kCMbM4oDAHyxiYC-5RF=SZ_E5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Brad Harper <bjharper@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 6 Oct 2020 at 17:33, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Brad,
>
> On Wed, Oct 07 2020 at 00:45, Brad Harper wrote:
> > I'm happy to test anything on a range of amlogic hardware with standard
> > / rt and  multiple mmc devices.  Ill test Jerome's patch in next 24
> > hours to report the results.
>
> please do not top-post and trim your replies.
>
> > On 6/10/2020 11:43 pm, Thomas Gleixner wrote:
> >>       We rather should make interrupts which need to have their primary
> >>       handler in hard interrupt context to set IRQF_NO_THREAD. That
> >>       should at the same time confirm that the primary handler is RT
> >>       safe.
> >>
> >>       Let me stare at the core code and the actual usage sites some more.
>
> So there are a few nasties in there and I faintly remember that there
> was an assumption that interrupts which are requested with both a
> primary and a secondary handler should quiesce the device interrupt in
> the primary handler if needed. OTOH, this also enforces that the primary
> handler is RT safe, which is after a quick scan of all the usage sites
> not a given and quite some of the users rely on IRQF_ONESHOT.
>
> The below untested patch should cure the problem and keep the interrupt
> line masked if requested with IRQF_ONESHOT.
>
> Thanks,
>
>         tglx

Thomas, thanks a lot for helping out and looking at this!

It looks like the testing of the patch below went well. Are you
intending to queue up the patch via your tip tree?

If you need any help, just tell us!

Kind regards
Uffe

> ---
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -967,8 +967,7 @@ static int irq_wait_for_interrupt(struct
>  static void irq_finalize_oneshot(struct irq_desc *desc,
>                                  struct irqaction *action)
>  {
> -       if (!(desc->istate & IRQS_ONESHOT) ||
> -           action->handler == irq_forced_secondary_handler)
> +       if (!(action->flags & IRQF_ONESHOT))
>                 return;
>  again:
>         chip_bus_lock(desc);
> @@ -1073,10 +1072,6 @@ irq_forced_thread_fn(struct irq_desc *de
>
>         local_bh_disable();
>         ret = action->thread_fn(action->irq, action->dev_id);
> -       if (ret == IRQ_HANDLED)
> -               atomic_inc(&desc->threads_handled);
> -
> -       irq_finalize_oneshot(desc, action);
>         local_bh_enable();
>         return ret;
>  }
> @@ -1089,14 +1084,7 @@ irq_forced_thread_fn(struct irq_desc *de
>  static irqreturn_t irq_thread_fn(struct irq_desc *desc,
>                 struct irqaction *action)
>  {
> -       irqreturn_t ret;
> -
> -       ret = action->thread_fn(action->irq, action->dev_id);
> -       if (ret == IRQ_HANDLED)
> -               atomic_inc(&desc->threads_handled);
> -
> -       irq_finalize_oneshot(desc, action);
> -       return ret;
> +       return action->thread_fn(action->irq, action->dev_id);
>  }
>
>  static void wake_threads_waitq(struct irq_desc *desc)
> @@ -1172,9 +1160,14 @@ static int irq_thread(void *data)
>                 irq_thread_check_affinity(desc, action);
>
>                 action_ret = handler_fn(desc, action);
> +               if (action_ret == IRQ_HANDLED)
> +                       atomic_inc(&desc->threads_handled);
> +
>                 if (action_ret == IRQ_WAKE_THREAD)
>                         irq_wake_secondary(desc, action);
>
> +               irq_finalize_oneshot(desc, action);
> +
>                 wake_threads_waitq(desc);
>         }
>
> @@ -1219,7 +1212,7 @@ static int irq_setup_forced_threading(st
>  {
>         if (!force_irqthreads)
>                 return 0;
> -       if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
> +       if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU))
>                 return 0;
>
>         /*
> @@ -1229,8 +1222,6 @@ static int irq_setup_forced_threading(st
>         if (new->handler == irq_default_primary_handler)
>                 return 0;
>
> -       new->flags |= IRQF_ONESHOT;
> -
>         /*
>          * Handle the case where we have a real primary handler and a
>          * thread handler. We force thread them as well by creating a
> @@ -1246,8 +1237,11 @@ static int irq_setup_forced_threading(st
>                 new->secondary->dev_id = new->dev_id;
>                 new->secondary->irq = new->irq;
>                 new->secondary->name = new->name;
> +               /* Preserve the requested IRQF_ONESHOT */
> +               new->secondary->flags = new->flags & IRQF_ONESHOT;
>         }
>         /* Deal with the primary handler */
> +       new->flags |= IRQF_ONESHOT;
>         set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
>         new->thread_fn = new->handler;
>         new->handler = irq_default_primary_handler;
> @@ -1341,6 +1335,38 @@ setup_irq_thread(struct irqaction *new,
>         return 0;
>  }
>
> +static unsigned long thread_mask_alloc(unsigned long thread_mask)
> +{
> +       /*
> +        * Unlikely to have 32 resp 64 irqs sharing one line,
> +        * but who knows.
> +        */
> +       if (thread_mask == ~0UL)
> +               return 0;
> +
> +       /*
> +        * The thread_mask for the action is or'ed to
> +        * desc->thread_active to indicate that the
> +        * IRQF_ONESHOT thread handler has been woken, but not
> +        * yet finished. The bit is cleared when a thread
> +        * completes. When all threads of a shared interrupt
> +        * line have completed desc->threads_active becomes
> +        * zero and the interrupt line is unmasked. See
> +        * handle.c:irq_wake_thread() for further information.
> +        *
> +        * If no thread is woken by primary (hard irq context)
> +        * interrupt handlers, then desc->threads_active is
> +        * also checked for zero to unmask the irq line in the
> +        * affected hard irq flow handlers
> +        * (handle_[fasteoi|level]_irq).
> +        *
> +        * The new action gets the first zero bit of
> +        * thread_mask assigned. See the loop above which or's
> +        * all existing action->thread_mask bits.
> +        */
> +       return 1UL << ffz(thread_mask);
> +}
> +
>  /*
>   * Internal function to register an irqaction - typically used to
>   * allocate special interrupts that are part of the architecture.
> @@ -1525,35 +1551,18 @@ static int
>          * conditional in irq_wake_thread().
>          */
>         if (new->flags & IRQF_ONESHOT) {
> -               /*
> -                * Unlikely to have 32 resp 64 irqs sharing one line,
> -                * but who knows.
> -                */
> -               if (thread_mask == ~0UL) {
> -                       ret = -EBUSY;
> +               ret = -EBUSY;
> +               new->thread_mask = thread_mask_alloc(thread_mask);
> +               if (!new->thread_mask)
>                         goto out_unlock;
> +
> +               if (new->secondary && (new->secondary->flags & IRQF_ONESHOT)) {
> +                       thread_mask |= new->thread_mask;
> +                       new->secondary->thread_mask =
> +                               thread_mask_alloc(thread_mask);
> +                       if (!new->secondary->thread_mask)
> +                               goto out_unlock;
>                 }
> -               /*
> -                * The thread_mask for the action is or'ed to
> -                * desc->thread_active to indicate that the
> -                * IRQF_ONESHOT thread handler has been woken, but not
> -                * yet finished. The bit is cleared when a thread
> -                * completes. When all threads of a shared interrupt
> -                * line have completed desc->threads_active becomes
> -                * zero and the interrupt line is unmasked. See
> -                * handle.c:irq_wake_thread() for further information.
> -                *
> -                * If no thread is woken by primary (hard irq context)
> -                * interrupt handlers, then desc->threads_active is
> -                * also checked for zero to unmask the irq line in the
> -                * affected hard irq flow handlers
> -                * (handle_[fasteoi|level]_irq).
> -                *
> -                * The new action gets the first zero bit of
> -                * thread_mask assigned. See the loop above which or's
> -                * all existing action->thread_mask bits.
> -                */
> -               new->thread_mask = 1UL << ffz(thread_mask);
>
>         } else if (new->handler == irq_default_primary_handler &&
>                    !(desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)) {
>
>
