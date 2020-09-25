Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED295C4727D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA2420878
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cedLl12F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="28Dm8OwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgIYNot (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgIYNot (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2020 09:44:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B1C0613CE;
        Fri, 25 Sep 2020 06:44:48 -0700 (PDT)
Date:   Fri, 25 Sep 2020 15:44:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601041487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5yjXWUCliemUXkVS/rJm2/vf4VSrQMEbNG38722oq0=;
        b=cedLl12FGt/UdUx9yMki5S9aT3zj+WqF3v8VCUxOYH+HI+xQ2pD1CLhr8UrS/wpLa0LqXV
        GM3ZKOLg3TTYDjm/BQwVyGNMqDq33tlaNMfLHnYl6nTImvm9SkhFnbPzxERuGx6AUnV+A2
        bYU9ZbfC3txRmxpYKYrB6cWdz1M4/I02sw+y5nQIeJdGbN9DsR/eaGevAmch9u5wDXY3QN
        RSItRGAij22JsD38qXk3sAC1UpWirf8PSC5BZVS4SkKzaYVKh0gw9vc55elizR58vao9t+
        gwHO2AR2dS7nmmCaXifvhknpuUnp1cabsAKOjqeqKH7E/Fcre5eBh4H2MyR6eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601041487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5yjXWUCliemUXkVS/rJm2/vf4VSrQMEbNG38722oq0=;
        b=28Dm8OwXHBIvLvccBaiOwqv/3V9yPbmae8puYhHpd0y1kvgrkGpw5Ojgb/rpzqDSRX/KV8
        gkMv2Uv3eVK0gQCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition
 for preempt_rt
Message-ID: <20200925134445.rk366jip5ne4x7em@linutronix.de>
References: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com>
 <7hk0wj9ki2.fsf@baylibre.com>
 <1jzh5e8bld.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1jzh5e8bld.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2020-09-25 11:11:42 [+0200], Jerome Brunet wrote:
> I'm not sure about this.
> As you have explained on IRC, I understand that IRQF_ONESHOT is causing
> trouble with RT as the hard IRQ part of the thread will not be migrated
> to a thread. That was certainly not the intent when putting this flag.

That is my understanding as well.

> This seems pretty unsafe to me. Maybe we could improve the driver so it
> copes with this case gracefully. ATM, I don't think it would.

Running the primary handler in hardirq context is bad, because it
invokes meson_mmc_request_done() at the very end. And here:
- mmc_complete_cmd() -> complete_all()
  There is a lockdep_assert_RT_in_threaded_ctx() which should trigger.

- led_trigger_event() -> led_trigger_event()
  This should trigger a might_sleep() warning somewhere.

So removing IRQF_ONESHOT is okay but it should additionally disable the
IRQ source in meson_mmc_irq() and re-enable back in
meson_mmc_irq_thread(). Otherwise the IRQ remains asserted and may fire
multiple times before the thread has a chance to run.

Sebastian
