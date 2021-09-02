Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50FEC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Sep 2021 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D167F610F7
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Sep 2021 21:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347580AbhIBVw0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Sep 2021 17:52:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46604 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347579AbhIBVwR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2021 17:52:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630619476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXynEmzNc/5dqTNv5HfEcE9bg8jjd3nUt9vOKJo805g=;
        b=gjfK/xwMuN9qpul1qSXhGslQ5t0nlyga/qktDHqC7NLiRuqSCV3dNDUrG31I3xhHvtTBYR
        eyOe46X1PIx8v8/FTSKnDLmxJGa2uTStHYYdpmKrUUqedP2C1g5aLPCGOsDyk/ijzp3W1b
        wQHju2K2Wk2WCixBAm6JMc9pNlBXn/34ZPnVzBzA5i00cYdiUfn2rBJrXA66NSxCodjPzy
        DX3c4hOtFKu2UJDZM3iiVwGZmeZmBvXvz0mcKVge96ATKWCAu7f9U87iRsep08m2Uioegk
        rYSwhawWZ7M2AwYrjAaBxQVdAoHOOjU4FsNyHtHGgw+NnlurxFvGVS5ePW94kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630619476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXynEmzNc/5dqTNv5HfEcE9bg8jjd3nUt9vOKJo805g=;
        b=16abJ3hXdJEEYi5ibns/xE8FQnkkGA7BJ0g5VzZdgAy+bR4tNJbN2ke+YAEj2uGjAouUnW
        AQP7Rf0g6s7ZwGAQ==
To:     paulmck@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        frederic@kernel.org
Subject: Re: NOHZ tick-stop error with ath10k SDIO
In-Reply-To: <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
 <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
 <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
Date:   Thu, 02 Sep 2021 23:51:15 +0200
Message-ID: <87czpqbq98.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Paul,

On Wed, Aug 18 2021 at 10:56, Paul E. McKenney wrote:
> On Wed, Aug 18, 2021 at 02:02:17PM -0300, Fabio Estevam wrote:
>> On Wed, Aug 18, 2021 at 1:29 PM Fabio Estevam <festevam@gmail.com> wrote:
>> > On Wed, Aug 18, 2021 at 12:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> >
>> > > I believe that you need this commit (and possibly some prerequsites):
>> > >
>> > > 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
>> > >
>> > > Adding Qais on CC for his thoughts.
>> >
>> > Thanks for the suggestion, but I am running 5.13.11, which already
>> > contains this commit.
>> >
>> > Any extra logs I should capture to help us understand the problem?
>> 
>> In case it helps, I followed your suggestion from:
>> https://lkml.org/lkml/2020/12/10/676
>> 
>> With the debug patch and suggested command line, I get the following log:
>> https://pastebin.com/raw/X96zKw7i
>
> And it turns out that I am also seeing it in v5.14-rc2, just a lot less
> frequently than earlier.  I have seen three instances of handler #02
> (NET_TX_SOFTIRQ?) over the past month or so while you are seeing handler
> #08 (BLOCK_SOFTIRQ?), in case that makes a difference.

Huch? #02 is TIMER_SOFTIRQ and #08 is NET_TX_SOFTIRQ.

And looking at that ftrace output in the pastebin there is nothing which
raises NET_TX_SOFTIRQ but then the warning claims it is pending.

This does not make any sense at all.

Thanks,

        tglx


