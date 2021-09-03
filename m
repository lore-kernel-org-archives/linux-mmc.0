Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E26C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Sep 2021 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C3D60F91
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Sep 2021 08:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348082AbhICIIk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Sep 2021 04:08:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhICIIk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Sep 2021 04:08:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630656459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sz3NEorzSRhQ/KiRak0L67VRUrrFzRTUrbz18Kw9pyw=;
        b=s0CaIoH6qRe4B4DYl7Y5Ppw0fgkDPkL2B3W2KxJwau5wcw27PIHwZIzKc+iGwpuUE4FViw
        je4kuTaytAbf4nXp819MYipFgKFwq7BMHLbRpStetfEkjNnL9j6z3gAMDu+pkQuBflR0VV
        5YJ0ml/wBjwFycbvY5twLI3pvLwRM8V0B+zfaxHvapKQ8LXERP7hao4wbv1CobPVV65F7r
        DOhjQcoKyVsLZ80nreaJWwp/vovzNI5HjjTDD2Qf4ZSyPtQAwBm7Vf0Nad5rd6bjJWVsRb
        CIt+CaNGsmJ7oOnQc/qUeKU08r8WhjoXlY8M/CD0hjHNyyD/S7FHiu59l2jlYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630656459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sz3NEorzSRhQ/KiRak0L67VRUrrFzRTUrbz18Kw9pyw=;
        b=CQJZyC1q8j4JW+dNvGC4I/kGtEltDL+IbN0NZ/4YzClkBD4RZ30qcUmLc8lwfTu3Hr4T6m
        sk3A/yM1esCzE7Dw==
To:     paulmck@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        frederic@kernel.org
Subject: Re: NOHZ tick-stop error with ath10k SDIO
In-Reply-To: <87czpqbq98.ffs@tglx>
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
 <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
 <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
 <87czpqbq98.ffs@tglx>
Date:   Fri, 03 Sep 2021 10:07:38 +0200
Message-ID: <877dfyaxpx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fabio,

On Thu, Sep 02 2021 at 23:51, Thomas Gleixner wrote:
> On Wed, Aug 18 2021 at 10:56, Paul E. McKenney wrote:
>> On Wed, Aug 18, 2021 at 02:02:17PM -0300, Fabio Estevam wrote:
>>> On Wed, Aug 18, 2021 at 1:29 PM Fabio Estevam <festevam@gmail.com> wrote:
>>>
>>> With the debug patch and suggested command line, I get the following log:
>>> https://pastebin.com/raw/X96zKw7i
>
> And looking at that ftrace output in the pastebin there is nothing which
> raises NET_TX_SOFTIRQ but then the warning claims it is pending.
>
> This does not make any sense at all.

Looked once more at the trace output. It seems to be incomplete. The
last recording of softirq raise was at 379568us ~= 0.38s post boot, but
the splat comes about 20 seconds post boot. Did your kernel trigger a
WARN_ON before that splat? If so, that might have disabled tracing.

As you are triggering this manually by invoking hostapd and the machine
should be still functional afterwards, can you please replace Paul's
debug patch with the one below? Please remove the command line option
and do the following:

# echo 1 >/sys/kernel/debug/tracing/events/irq/softirq_raise/enable
# echo 1 >/sys/kernel/debug/tracing/events/irq/softirq_entry/enable
# echo 1 > /proc/sys/kernel/stack_tracer_enabled
# hostapd ...

Once the warning triggered do:

# cat /sys/kernel/debug/tracing/trace >trace.txt

That should give us the full trace data and hopefully a better
understanding of the problem.

Thanks,

        tglx
---
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6bffe5af8cb1..269f804090ef 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1015,6 +1015,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 
 		if (ratelimit < 10 && !local_bh_blocked() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
+			tracing_off();
 			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());
 			ratelimit++;
