Return-Path: <SRS0=uM1y=DN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6968FC4363D
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC50F20782
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 12:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhmsWAgN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5M0EBf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgJFMnw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Oct 2020 08:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJFMnw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2020 08:43:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A3C061755;
        Tue,  6 Oct 2020 05:43:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601988230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAj9JE4eqj8FhfohvFYZxoqCcBarf5zqltsQxUiI1tk=;
        b=VhmsWAgNyVmBH7+ZdeqYiGj1kqUi6dTRhFBV7hC8xg7Yy6GtMZ9KpR8Hai1TOsSHr0erPg
        JPlWoQaGMAMRziJhFbs6FGfVBjJMgw7sea/7IJyc7jVAeq6efncgcJihLh73cc9vmYv5HZ
        WuCgaEO+Dt/bfw25tmlaJNyiqX4eT4E3mnsTSxPVDNhLWD4akM5i691HI444+dlvYSjSwn
        LmOQZogIdscqsg/gKxEadHv35+EsmcZuS8QhmvltqfwxMrdLYc66c8Lv+iD01P33KVU4IG
        lTTtzgolBf62iwt114zQV/3I0VO85vfFbFfhSl4Ny821OdLwD9QfWRxE104x/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601988230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAj9JE4eqj8FhfohvFYZxoqCcBarf5zqltsQxUiI1tk=;
        b=E5M0EBf6SmNEwcbN4HI+3LephINpMn63Ks6D1Mx6WzzMGDnIGpiZs3/dvGpMQRdqQynHwN
        Ri0QaKPbjpUmUoAQ==
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Brad Harper <bjharper@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-Reply-To: <87wo052grp.fsf@nanos.tec.linutronix.de>
References: <20201002164915.938217-1-jbrunet@baylibre.com> <CAPDyKFo6T_P+TQQZSzFgHwLeE08f146KxKBpAutv209MXq0mjA@mail.gmail.com> <87wo052grp.fsf@nanos.tec.linutronix.de>
Date:   Tue, 06 Oct 2020 14:43:49 +0200
Message-ID: <87v9fn7ce2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 05 2020 at 10:55, Thomas Gleixner wrote:
> On Mon, Oct 05 2020 at 10:22, Ulf Hansson wrote:
>> On Fri, 2 Oct 2020 at 18:49, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>
>>> IRQF_ONESHOT was added to this driver to make sure the irq was not enabled
>>> again until the thread part of the irq had finished doing its job.
>>>
>>> Doing so upsets RT because, under RT, the hardirq part of the irq handler
>>> is not migrated to a thread if the irq is claimed with IRQF_ONESHOT.
>>> In this case, it has been reported to eventually trigger a deadlock with
>>> the led subsystem.
>>>
>>> Preventing RT from doing this migration was certainly not the intent, the
>>> description of IRQF_ONESHOT does not really reflect this constraint:
>>>
>>>  > IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>>>  >              Used by threaded interrupts which need to keep the
>>>  >              irq line disabled until the threaded handler has been run.
>>>
>>> This is exactly what this driver was trying to acheive so I'm still a bit
>>> confused whether this is a driver or an RT issue.
>>>
>>> Anyway, this can be solved driver side by manually disabling the IRQs
>>> instead of the relying on the IRQF_ONESHOT. IRQF_ONESHOT may then be removed
>>> while still making sure the irq won't trigger until the threaded part of
>>> the handler is done.
>>
>> Thomas, may I have your opinion on this one.
>>
>> I have no problem to apply $subject patch, but as Jerome also
>> highlights above - this kind of makes me wonder if this is an RT
>> issue, that perhaps deserves to be solved in a generic way.
>>
>> What do you think?
>
> Let me stare at the core code. Something smells fishy.

The point is that for threaded interrupts (without a primary handler)
the core needs to be told that the interrupt line should be masked until
the threaded handler finished. That's what IRQF_ONESHOT is for.

For interrupts which have both a primary and a threaded handler that's a
different story. The primary handler decides whether the thread should
be woken and it decides whether to block further interrupt delivery in
the device or keep it enabled.

When forced interrupt threading is enabled (even independent of RT) then
we have the following cases:

  1) Regular device interrupt (primary handler only)

     The primary handler is replaced with the default 'wake up thread'
     handler and the original primary handler becomes the threaded
     handler. This enforces IRQF_ONESHOT so that the interupt line (for
     level interrupts) stays masked until the thread completed handling.

  2) Threaded interrupts

     Interrupts which have been requested as threaded handler (no
     primary handler) are not changed obvioulsy

  3) Interrupts which have both a primary and a thread handler

     Here IRQF_ONESHOT decides whether the primary handler will be
     forced threaded or not.

     That's a bit unfortunate and ill defined and was not intended to be
     used that way.

     We rather should make interrupts which need to have their primary
     handler in hard interrupt context to set IRQF_NO_THREAD. That
     should at the same time confirm that the primary handler is RT
     safe.

     Let me stare at the core code and the actual usage sites some more.

Thanks,

        tglx






