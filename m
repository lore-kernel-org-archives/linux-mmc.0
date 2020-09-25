Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EAAC4363D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902F820936
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jJuocI/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIYOOR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgIYOOQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2020 10:14:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D7C0613D3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2020 07:14:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so2638832edq.6
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2020 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=wM9M9SzefD5gqh6rUe+GGK3P8rbYWiC3a0TiUA4Suek=;
        b=jJuocI/bplwYAWFLuhGNb/1qgyrDnRkMLJAlZdkhGDJJsUt4ok2/cyUbysJMmCGDKA
         KXH9ftBquli+ARnXX4BDOeYilgqtVQ7ln8kOH1qXr48cU4hrWRFBhEuWYUrLzLgpp2PB
         gdPfZa3GoCJ0u2CVL/zGIo1yn3QawYh7274Sgw53RbqpDTyn45QUqUixesApHD9H7wY6
         BQaVd+GhKSE+N6ed7ZcaylKPV1wNGLOhJurEGTLlHszLFU1245uSjl0dJvrxnWiPPUXC
         sLzmP+bB360gkGoyR6jEcWZw2nlmWDuw+ZuNC1pfQxRBpzatPZkbcAmcIW5ixv9QfZmo
         wdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=wM9M9SzefD5gqh6rUe+GGK3P8rbYWiC3a0TiUA4Suek=;
        b=sLMcsulbqEmDFJmSwURhRY8oc6EslynGRcdKcCEm3TwW21cLXt4dPSTjH5TusfjoZD
         xXw3PbdJlZsvPwFlylMAdZEdDlTmJG6jy005Ng1zhW+oU/h+Osf4N8zrBF+KNHJ/2WiI
         vhCCU/AIo4Do20hZGTwxOZDfLxqSvW+dZWiccdY8PIv9VBqy+PJGYhU6WQu5Zy0Osaov
         gBP7ZKi1ITYknf+f79DRxbNOftQ/ZjKAVjGz79e4hBT9JiVXHXLzDJM6tdxD8eyZYveE
         YkYvCbZEuM4AVVnZnlwD8iHs1QkKHl2vSx4vvQBI/EjLUJl+iTaNUPwv8ZoflqCOx1qn
         cE1w==
X-Gm-Message-State: AOAM5324fC4pClBvuCqpihH6NwUJoVkrFnSplmQj8C4E/S4OIGootqOy
        78CNNPDSHfPrFpbNnrOFCUsZ9Q==
X-Google-Smtp-Source: ABdhPJzwIPCGQ+75gzlRe/ufSmeKulNDnlPMmGvgzb28BYKfC4imiU3i9M+FUIyU2tCF/soD6aW5iQ==
X-Received: by 2002:a50:bb62:: with SMTP id y89mr1551879ede.261.1601043252055;
        Fri, 25 Sep 2020 07:14:12 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k6sm1934617ejr.104.2020.09.25.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:14:11 -0700 (PDT)
References: <24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com> <7hk0wj9ki2.fsf@baylibre.com> <1jzh5e8bld.fsf@starbuckisacylon.baylibre.com> <20200925134445.rk366jip5ne4x7em@linutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Brad Harper <bjharper@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: meson-gx-mmc: fix possible deadlock condition for preempt_rt
In-reply-to: <20200925134445.rk366jip5ne4x7em@linutronix.de>
Date:   Fri, 25 Sep 2020 16:14:09 +0200
Message-ID: <1jh7rmj64u.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Fri 25 Sep 2020 at 15:44, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-09-25 11:11:42 [+0200], Jerome Brunet wrote:
>> I'm not sure about this.
>> As you have explained on IRC, I understand that IRQF_ONESHOT is causing
>> trouble with RT as the hard IRQ part of the thread will not be migrated
>> to a thread. That was certainly not the intent when putting this flag.
>
> That is my understanding as well.
>
>> This seems pretty unsafe to me. Maybe we could improve the driver so it
>> copes with this case gracefully. ATM, I don't think it would.
>
> Running the primary handler in hardirq context is bad, because it
> invokes meson_mmc_request_done() at the very end. And here:
> - mmc_complete_cmd() -> complete_all()
>   There is a lockdep_assert_RT_in_threaded_ctx() which should trigger.
>
> - led_trigger_event() -> led_trigger_event()
>   This should trigger a might_sleep() warning somewhere.
>
> So removing IRQF_ONESHOT is okay but it should additionally disable the
> IRQ source in meson_mmc_irq() and re-enable back in
> meson_mmc_irq_thread(). Otherwise the IRQ remains asserted and may fire
> multiple times before the thread has a chance to run.

Looks like we need to do manually what IRQF_ONESHOT was doing for us :(
This brings a few questions:

* The consideration you described is not mentioned near the description
  of IRQF_ONESHOT. Maybe it should so other drivers with same intent
  don't end up in the same pitfall ?

* Why doesn't RT move the IRQ with this flag ? Seems completly unrelated
  to RT (maybe it is the same documentation problem) 

* Can't we have flag doing the irq disable in the same way while still
  allowing to RT to do its magic ? seems better than open coding it in
  the driver ?

>
> Sebastian

