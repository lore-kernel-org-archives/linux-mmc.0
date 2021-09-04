Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23534C433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  4 Sep 2021 21:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30F160E74
	for <linux-mmc@archiver.kernel.org>; Sat,  4 Sep 2021 21:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhIDVMA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 4 Sep 2021 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhIDVMA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Sep 2021 17:12:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC7C061575
        for <linux-mmc@vger.kernel.org>; Sat,  4 Sep 2021 14:10:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l18so4372336lji.12
        for <linux-mmc@vger.kernel.org>; Sat, 04 Sep 2021 14:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8IOvNTUOq6JzLAydqjspWW5KTRCUhLqlTrLjSJZ2/M=;
        b=NXVRGKYStBYuta2B+4aG9yj8aPd8QlkIR6ZaCupIrIOw2OxkHhQadEyIc27BqUmr2z
         Bb5gM+2vHp2IjhgiUrSvN0ybqLjIvdzwuvqSGbZaghyuv7IWFSV/IFBlZbWO2rU4RW8K
         Jg6wdWqm31+oKpmfJ3M4ssn8nLMTN1xhZFpLySrz8qIJubmjC98bBpdamFrra93/d1qp
         Xx3Fxa0lsBaJt4FPSdDUBKnhAZhvd2pKeeSWucRtnuxA0NEB/cTYMEfn7CdyrCBYmk4y
         qwLrkbaLvmJYzY/PnwtvBvK+Fk/Ra7bh1XBQOeqwD/KzKHNUbaQZcZEDqbhv4ewdHPib
         6FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8IOvNTUOq6JzLAydqjspWW5KTRCUhLqlTrLjSJZ2/M=;
        b=ASvMd+kBudCts1exJjzl318xmblfuWyR4N138WlUPg14MGF3Kx94mmtCtmCeNkxeZA
         VjFhtc7IYQyVeiz+7aaiBVg5hkzGcZAHW2enrOo5wsoLuF4pUp+ajAOf1koUfWsdcq4M
         i4j9gkhu+vim9kyc+7vr7F+4qI1J5+sZCKagoDo3a41kUjEmwjfkGm5uOPotNlA7Q25Z
         1aUr9Z2wjFyVUnrSDGt17iSX3zB+qBVqr3VZsad0FMjgLiSpY0VdZq32Ilhjg09w+Tdl
         Bg8zo4oeA+hxPO6Hg5iQaRsPuHZsMVWvTUyck6xrXala8/NkQ/L+Y9qG6sLt/Hr1l1Uj
         1n2g==
X-Gm-Message-State: AOAM532ueYQLjH/D+8A4fImxmEVpBMJUIGTiOiwqj8xd9AopNo2/Sic4
        5zkvZqnLQTg5X/wu8o0KM9zGYpJJaL9+VOomZP7gobVMfNY=
X-Google-Smtp-Source: ABdhPJwnLXHVYXDKaxeoM5eWOigZm8O3zI+oNOKkU4Zx+cLmL2hc1PUGONsvs68VxuawQi4Pun+N2xfXq1WsaewcFeY=
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr4184883ljp.203.1630789856137;
 Sat, 04 Sep 2021 14:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1> <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
 <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1> <87czpqbq98.ffs@tglx> <877dfyaxpx.ffs@tglx>
In-Reply-To: <877dfyaxpx.ffs@tglx>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 4 Sep 2021 18:10:45 -0300
Message-ID: <CAOMZO5BnPEnF-HNM7vCzeUrRW7BsQ-hhm4fcVmO_QieKf6oJsw@mail.gmail.com>
Subject: Re: NOHZ tick-stop error with ath10k SDIO
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Thomas,

Thanks for your response.

On Fri, Sep 3, 2021 at 5:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> Looked once more at the trace output. It seems to be incomplete. The
> last recording of softirq raise was at 379568us ~= 0.38s post boot, but
> the splat comes about 20 seconds post boot. Did your kernel trigger a
> WARN_ON before that splat? If so, that might have disabled tracing.

You are right. The WARN_ON only happens after hostapd runs, which is at a
much later stage.

> As you are triggering this manually by invoking hostapd and the machine
> should be still functional afterwards, can you please replace Paul's
> debug patch with the one below? Please remove the command line option
> and do the following:
>
> # echo 1 >/sys/kernel/debug/tracing/events/irq/softirq_raise/enable
> # echo 1 >/sys/kernel/debug/tracing/events/irq/softirq_entry/enable
> # echo 1 > /proc/sys/kernel/stack_tracer_enabled
> # hostapd ...
>
> Once the warning triggered do:
>
> # cat /sys/kernel/debug/tracing/trace >trace.txt
>
> That should give us the full trace data and hopefully a better
> understanding of the problem.

I did as suggested and here is trace.txt:
https://pastebin.com/VUfLRJ8a

Also, while investigating this problem I saw a commit that fixed a
similar issue:
e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schdule()").

I then tried the same approach on the ath10k sdio driver:

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c
b/drivers/net/wireless/ath/ath10k/sdio.c
index b746052737e0..eb705214f3f0 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1363,8 +1363,11 @@ static void
ath10k_rx_indication_async_work(struct work_struct *work)
         ep->ep_ops.ep_rx_complete(ar, skb);
     }

-    if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags))
+    if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags)) {
+        local_bh_disable();
         napi_schedule(&ar->napi);
+        local_bh_enable();
+    }
 }

and no longer get the "NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!" error messages after launching hostapd.

Is this a proper fix?

Thanks,

Fabio Estevam
