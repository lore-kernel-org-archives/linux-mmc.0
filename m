Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B72C4363A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A412078D
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 08:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bVjaYXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nn+A19Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJEIz5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIz4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2020 04:55:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1320C0613CE;
        Mon,  5 Oct 2020 01:55:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601888154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tIhP0FuIGl8w6hVtstWYo1miB0t+IY3lSNHO1NwBAUg=;
        b=1bVjaYXPTOWxPjjCZXbGOhko1pl72m1MMxVgnEKe/Z72kbb9a8fAxnZ7B+EGasuIXh3BW6
        0Uxci4nPv8Drste3gRfkwbq4oOe3hhNIiUcCtKXEeLfyTrKIEWUYX2ZI6ZTqYzu6JHz7bj
        wk0Qt1WFy96m4OPF87gOw0oa/DYY3cnKi21RacudiD4S/POjFaBFaZXXmZ69QQdYb+FniR
        gGNjxcGOZ8fZZcm7ficHllUgV2lccAwnU7FCb5drk4Rs9XgTPEngyLbOzQbZd+OJos+ekc
        VQPZ4jDBfT2JwbnPVjI55zcZORLi2YTWEtueqYvD6+lJGRYH6Tze8AItfGMdNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601888154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tIhP0FuIGl8w6hVtstWYo1miB0t+IY3lSNHO1NwBAUg=;
        b=Nn+A19Q+Lozpu8w7R4t0zbn+T9kc7/1vuZQhI5Wg6N3F0nR0r8evtwNibaf602A4ecMxS9
        m5hTCF8F9bbSbtAg==
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
In-Reply-To: <CAPDyKFo6T_P+TQQZSzFgHwLeE08f146KxKBpAutv209MXq0mjA@mail.gmail.com>
References: <20201002164915.938217-1-jbrunet@baylibre.com> <CAPDyKFo6T_P+TQQZSzFgHwLeE08f146KxKBpAutv209MXq0mjA@mail.gmail.com>
Date:   Mon, 05 Oct 2020 10:55:54 +0200
Message-ID: <87wo052grp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 05 2020 at 10:22, Ulf Hansson wrote:
> On Fri, 2 Oct 2020 at 18:49, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> IRQF_ONESHOT was added to this driver to make sure the irq was not enabled
>> again until the thread part of the irq had finished doing its job.
>>
>> Doing so upsets RT because, under RT, the hardirq part of the irq handler
>> is not migrated to a thread if the irq is claimed with IRQF_ONESHOT.
>> In this case, it has been reported to eventually trigger a deadlock with
>> the led subsystem.
>>
>> Preventing RT from doing this migration was certainly not the intent, the
>> description of IRQF_ONESHOT does not really reflect this constraint:
>>
>>  > IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>>  >              Used by threaded interrupts which need to keep the
>>  >              irq line disabled until the threaded handler has been run.
>>
>> This is exactly what this driver was trying to acheive so I'm still a bit
>> confused whether this is a driver or an RT issue.
>>
>> Anyway, this can be solved driver side by manually disabling the IRQs
>> instead of the relying on the IRQF_ONESHOT. IRQF_ONESHOT may then be removed
>> while still making sure the irq won't trigger until the threaded part of
>> the handler is done.
>
> Thomas, may I have your opinion on this one.
>
> I have no problem to apply $subject patch, but as Jerome also
> highlights above - this kind of makes me wonder if this is an RT
> issue, that perhaps deserves to be solved in a generic way.
>
> What do you think?

Let me stare at the core code. Something smells fishy.
