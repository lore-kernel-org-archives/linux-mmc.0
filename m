Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854CEC4727D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 15:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1922422B2D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 15:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJOGbF86";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yeohw/JX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgIYPFX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:05:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYPFX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2020 11:05:23 -0400
Date:   Fri, 25 Sep 2020 17:05:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601046320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7es1yDj9/zjzMxs06+Vww2hrDHmTr8lqczgB9WnfFc=;
        b=MJOGbF86s4ulg2dwLhyiFpUwrUbKsXPpOgobXLou3xqdRJeQXF7Q5OF6REbbYec3Vqu7nG
        L4riyBPLz5XB1Ozl7X5ifiwO+7PCNFDaRPoXdXhrWEZIPM1QR2O7oB2AV93Dyv4rY8X8WC
        UoPw1uv74YznaDnkKwaMc2NdHO58KjnpX+VlC6Frp34l8Z1DYxMj36zhLz0624go36UEcc
        KXlNrxkFJhNhBAVAd9BaYatyUJakQdhnr8gObRGNN75Amz+I1EQ9tNZM+Uye1drKCANkgj
        LJ8/BpTX4Tod1gIMvXsCaPQku0HUM0YfkPYr8Ez5y/7n9Oo2xtQkuRvtGNcQeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601046320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7es1yDj9/zjzMxs06+Vww2hrDHmTr8lqczgB9WnfFc=;
        b=Yeohw/JXSR/26e4gGcNvnZlx7fiU8zt28HJO4pvel3a9b/BmscppNEfuRvko8R4VPwr27D
        GqUr3aC7ybFLnQBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition
 for preempt_rt
Message-ID: <20200925150519.sbzq57qphvzrdro3@linutronix.de>
References: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com>
 <7hk0wj9ki2.fsf@baylibre.com>
 <1jzh5e8bld.fsf@starbuckisacylon.baylibre.com>
 <20200925134445.rk366jip5ne4x7em@linutronix.de>
 <1jh7rmj64u.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1jh7rmj64u.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2020-09-25 16:14:09 [+0200], Jerome Brunet wrote:
> Looks like we need to do manually what IRQF_ONESHOT was doing for us :(

IRQF_ONESHOT disables the IRQ at the irqchip level. You must ensure that
the device keeps quite. Usually you mast the interrupt source at the
device lee.

> This brings a few questions:
> 
> * The consideration you described is not mentioned near the description
>   of IRQF_ONESHOT. Maybe it should so other drivers with same intent
>   don't end up in the same pitfall ?

From request_threaded_irq() ->
|  *      If you want to set up a threaded irq handler for your device
|  *      then you need to supply @handler and @thread_fn. @handler is
|  *      still called in hard interrupt context and has to check
|  *      whether the interrupt originates from the device. If yes it
|  *      needs to disable the interrupt on the device and return
|  *      IRQ_WAKE_THREAD which will wake up the handler thread and run
|  *      @thread_fn. This split handler design is necessary to support
|  *      shared interrupts.

Just the line that saying what needs to be done before returning
IRQ_WAKE_THREAD.

> * Why doesn't RT move the IRQ with this flag ? Seems completly unrelated
>   to RT (maybe it is the same documentation problem) 

It is unrelated to RT. Mostly. You end up with the same problem booting
with `threadirqs'. RT has the additional restrictions that you may not
acquire any sleeping locks in hardirq context. This you can see with
addinional lockdep magic.

> * Can't we have flag doing the irq disable in the same way while still
>   allowing to RT to do its magic ? seems better than open coding it in
>   the driver ?

Puh. That should be forwarded the IRQ department.
So we have IRQF_NO_THREAD to avoid force threading. This is documented
as such. Then we have IRQF_TIMER and IRQF_PERCPU which are also not
force threaded and it is not documented as such. However it is used for
the timer-IRQ, IPI, perf and such - things you obviously don't want to
thread and need to run in hard-IRQ context.

What you have ist a primary and secondary and IRQF_ONESHOT and don't
want the primary handler to be force-threaded. I can't answer why we
don't.
However, drivers usually disable the source themself if they providing
both handler.

Sebastian
