Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83DEC4708E
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 12:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLGMix (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiLGMi2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 07:38:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83556C56
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 04:38:16 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d7so608670pll.9
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 04:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq47N/ZOOwJfcqXzgmggK3bk8KWVsQXVwMJxyc39x0w=;
        b=xuBqyfYrIxMPliMMxj9qLT1fhkr0UNssZ2JAkE4gPRsJ1c4rGN7HxWSvW986Atd/sJ
         V++hfviQym9GCbEkuz1lIYdDku4HB2BagxiLYSLJNK1M9P0vCilOQddqR2Kq/JH3iUs6
         UsQIJgRf0bIRR4a6QsIBBVPPR81LKJiisgSpSCAOzcBXkw04YgoZAQcFGK5zpO6/sM29
         tBhPFOWS1gJNRb9O2MX8SDZ69/ShdugXBRmiE1JZJeAXPQ7Pc/2Lsr3l21GNDqaAlp/y
         +H2ltfbtGp9YRMIB612MAcqAdqay5VXUps3fBF+MIMccG4cGqFz0TqxssUffutrDSgid
         cdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq47N/ZOOwJfcqXzgmggK3bk8KWVsQXVwMJxyc39x0w=;
        b=phRv3GiZ7mnVV87c2Ie/jPnJuittHR6MHIyjHpC6/CC8PVOMWsfH0QxCRddWQbMQug
         4ET0guU6l8vl38m7CReMxmYUZvqFStD0gMTk+3QMe6QKxAIYcZnrWEezTXwPR2ibAqV2
         60Fo5EnT6K3NjRBX2HcaMZ3go3GiYyhh0nJ4IF0hCsBkVoWB08mfFfLkcmtbj38Dwr+G
         SaV2k4FepMOQkDnpG9b3fOTo9B+NLpIGv29mPFk5MCb2sS7H6JetG325LB6rwmXjxUjR
         ScrrVk7Qp/WBNCdKMb2kBhXQqkzbNECd4Z78qGU2H0BQVjnEPfteQ/NVysamvWVRIwX8
         8WzA==
X-Gm-Message-State: ANoB5pnXRBZNgsJozXyJV+8+hxaNqdrSu53mbj59CUeuDcxyiRWRxTO8
        +OJpflcl1ewAGnGrxl6+w98ruMEs9qX3xXwtr7Lu9w==
X-Google-Smtp-Source: AA0mqf44UgY9jAl2a1r9HulFGS5OcYUHT0t6QPKBXloif6qmrZJgXEqWD8xyYbXw61aM0/2wMAArsQBA+kpWZCDbRJQ=
X-Received: by 2002:a17:902:ee01:b0:189:e089:5d51 with SMTP id
 z1-20020a170902ee0100b00189e0895d51mr10894703plb.165.1670416696083; Wed, 07
 Dec 2022 04:38:16 -0800 (PST)
MIME-Version: 1.0
References: <87dc45b122d26d63c80532976813c9365d7160b3.1670140888.git.deren.wu@mediatek.com>
In-Reply-To: <87dc45b122d26d63c80532976813c9365d7160b3.1670140888.git.deren.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:40 +0100
Message-ID: <CAPDyKFo-cU1RD1kBR+EsuAdFyJ8HmhdqZukMWJVjrHF_91qZwA@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix warning - do not call blocking ops when !TASK_RUNNING
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 4 Dec 2022 at 09:27, Deren Wu <deren.wu@mediatek.com> wrote:
>
> vub300_enable_sdio_irq() works with mutex and need TASK_RUNNING here.
> Ensure that we mark current as TASK_RUNNING for sleepable context.
>
> [   77.554641] do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff92a72c1d>] sdio_irq_thread+0x17d/0x5b0
> [   77.554652] WARNING: CPU: 2 PID: 1983 at kernel/sched/core.c:9813 __might_sleep+0x116/0x160
> [   77.554905] CPU: 2 PID: 1983 Comm: ksdioirqd/mmc1 Tainted: G           OE      6.1.0-rc5 #1
> [   77.554910] Hardware name: Intel(R) Client Systems NUC8i7BEH/NUC8BEB, BIOS BECFL357.86A.0081.2020.0504.1834 05/04/2020
> [   77.554912] RIP: 0010:__might_sleep+0x116/0x160
> [   77.554920] RSP: 0018:ffff888107b7fdb8 EFLAGS: 00010282
> [   77.554923] RAX: 0000000000000000 RBX: ffff888118c1b740 RCX: 0000000000000000
> [   77.554926] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffed1020f6ffa9
> [   77.554928] RBP: ffff888107b7fde0 R08: 0000000000000001 R09: ffffed1043ea60ba
> [   77.554930] R10: ffff88821f5305cb R11: ffffed1043ea60b9 R12: ffffffff93aa3a60
> [   77.554932] R13: 000000000000011b R14: 7fffffffffffffff R15: ffffffffc0558660
> [   77.554934] FS:  0000000000000000(0000) GS:ffff88821f500000(0000) knlGS:0000000000000000
> [   77.554937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   77.554939] CR2: 00007f8a44010d68 CR3: 000000024421a003 CR4: 00000000003706e0
> [   77.554942] Call Trace:
> [   77.554944]  <TASK>
> [   77.554952]  mutex_lock+0x78/0xf0
> [   77.554973]  vub300_enable_sdio_irq+0x103/0x3c0 [vub300]
> [   77.554981]  sdio_irq_thread+0x25c/0x5b0
> [   77.555006]  kthread+0x2b8/0x370
> [   77.555017]  ret_from_fork+0x1f/0x30
> [   77.555023]  </TASK>
> [   77.555025] ---[ end trace 0000000000000000 ]---
>
> Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Ideally this driver should be converted to use the sdio_signal_irq()
interface and thus move away from the legacy mmc_signal_sdio_irq()
interface. However, as a fix for stable kernels, this looks good to
me!

So, applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/vub300.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 97beece62fec..b58a1a869ed8 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2049,6 +2049,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
>                 return;
>         kref_get(&vub300->kref);
>         if (enable) {
> +               set_current_state(TASK_RUNNING);
>                 mutex_lock(&vub300->irq_mutex);
>                 if (vub300->irqs_queued) {
>                         vub300->irqs_queued -= 1;
> @@ -2064,6 +2065,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
>                         vub300_queue_poll_work(vub300, 0);
>                 }
>                 mutex_unlock(&vub300->irq_mutex);
> +               set_current_state(TASK_INTERRUPTIBLE);
>         } else {
>                 vub300->irq_enabled = 0;
>         }
> --
> 2.18.0
>
