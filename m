Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2A0C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6101161278
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhFHNS7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhFHNS6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:18:58 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D3CC061789
        for <linux-mmc@vger.kernel.org>; Tue,  8 Jun 2021 06:16:55 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id p1so11536696uam.13
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZQ/ATmiafM2AOuVLREKT0J3takvQ3ch2OmYWGk2+jHo=;
        b=rGvXACqlDsC8zcp5ai7euTTTNJA+QN7dKd8x9tlHprGxkmgNacK8kCIoqb2qabYwYJ
         3eNihUXqkYtjlPhtB6oVdxSt++iN66IxefGBkVRlLRPfVMr0nQnstrBLv/VG5Nn7SBON
         kEfuKcnJOXE4sQ0Hbykpt2gazPtuhuyTxvF57iCQmdbNi1hAnbXSkgeSWsjneva1ztoP
         ow9bf6x618QyK6nH7vu7xsAGNrrwlkBzwV9Th1suYgGiEttJALyVIz8C4uLjEyYquPlQ
         dl2cMltWFOBqQ3HJqU/KN6m91hHFhbwJXAST4bO8868VbK6GgEyY8PwbyxVzXQp79zWM
         RB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQ/ATmiafM2AOuVLREKT0J3takvQ3ch2OmYWGk2+jHo=;
        b=afLGzVUdhKQQ4rp5KZPyqwWqzkWP1Qfps6k5a9zHpSOYe7ppofItfUW+VmyI3DIC9r
         ynRkuXc45awWPy0ILqkBC83NwfYv9nck8g38z4DIuWOtabF+d2mMnYfbChGDH0ThHvp8
         dvbw5XL2klQE4Fn4fPRbnmLG49mtxqXd9gykQljX+SS8GiCqwPZ5iycRZz466nM713kU
         k8uo747UH7LGKPnIOGnCN1gGWHm+CsVhNOnX0P/2ntYO87zTATlOJitNUAFF1UNaPOFL
         dClEe1DqNqy4hOvLG7YEp3fculQvP07UfYsdW9z1ONTtndK4DQPT/YYLRH/aZ6EmmJZE
         uR3w==
X-Gm-Message-State: AOAM530N2/v6YVsLN57h6DjiQi1Qf1qdCofvgD11BUPe6OnqjgOrO6Fk
        kJowI3iqZDpsKHH3Y1f8bldd32KePHFtr/lLmn9EXg==
X-Google-Smtp-Source: ABdhPJxZkRLrb5Tb4NykxE3MziqTfgEwtLXnEqR+UpWSaxxPVMxMdU7auKZ2p8ChK5vUhHaGrnpp1hqOwogBBu0ah9I=
X-Received: by 2002:a9f:35b3:: with SMTP id t48mr12290837uad.129.1623158214455;
 Tue, 08 Jun 2021 06:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <1622727200-15808-1-git-send-email-zheyuma97@gmail.com>
In-Reply-To: <1622727200-15808-1-git-send-email-zheyuma97@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:17 +0200
Message-ID: <CAPDyKFrpJUmyFWwqy=t3FsMRPwodj+m-91sFZ1BmMgjvg=ne9w@mail.gmail.com>
Subject: Re: [PATCH] mmc: via-sdmmc: add a check against NULL pointer dereference
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Jun 2021 at 15:33, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> Before referencing 'host->data', the driver needs to check whether it is
> null pointer, otherwise it will cause a null pointer reference.
>
> This log reveals it:
>
> [   29.355199] BUG: kernel NULL pointer dereference, address:
> 0000000000000014
> [   29.357323] #PF: supervisor write access in kernel mode
> [   29.357706] #PF: error_code(0x0002) - not-present page
> [   29.358088] PGD 0 P4D 0
> [   29.358280] Oops: 0002 [#1] PREEMPT SMP PTI
> [   29.358595] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.12.4-
> g70e7f0549188-dirty #102
> [   29.359164] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   29.359978] RIP: 0010:via_sdc_isr+0x21f/0x410
> [   29.360314] Code: ff ff e8 84 aa d0 fd 66 45 89 7e 28 66 41 f7 c4 00
> 10 75 56 e8 72 aa d0 fd 66 41 f7 c4 00 c0 74 10 e8 65 aa d0 fd 48 8b 43
> 18 <c7> 40 14 ac ff ff ff e8 55 aa d0 fd 48 89 df e8 ad fb ff ff e9 77
> [   29.361661] RSP: 0018:ffffc90000118e98 EFLAGS: 00010046
> [   29.362042] RAX: 0000000000000000 RBX: ffff888107d77880
> RCX: 0000000000000000
> [   29.362564] RDX: 0000000000000000 RSI: ffffffff835d20bb
> RDI: 00000000ffffffff
> [   29.363085] RBP: ffffc90000118ed8 R08: 0000000000000001
> R09: 0000000000000001
> [   29.363604] R10: 0000000000000000 R11: 0000000000000001
> R12: 0000000000008600
> [   29.364128] R13: ffff888107d779c8 R14: ffffc90009c00200
> R15: 0000000000008000
> [   29.364651] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000)
> knlGS:0000000000000000
> [   29.365235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.365655] CR2: 0000000000000014 CR3: 0000000005a2e000
> CR4: 00000000000006e0
> [   29.366170] DR0: 0000000000000000 DR1: 0000000000000000
> DR2: 0000000000000000
> [   29.366683] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> DR7: 0000000000000400
> [   29.367197] Call Trace:
> [   29.367381]  <IRQ>
> [   29.367537]  __handle_irq_event_percpu+0x53/0x3e0
> [   29.367916]  handle_irq_event_percpu+0x35/0x90
> [   29.368247]  handle_irq_event+0x39/0x60
> [   29.368632]  handle_fasteoi_irq+0xc2/0x1d0
> [   29.368950]  __common_interrupt+0x7f/0x150
> [   29.369254]  common_interrupt+0xb4/0xd0
> [   29.369547]  </IRQ>
> [   29.369708]  asm_common_interrupt+0x1e/0x40
> [   29.370016] RIP: 0010:native_safe_halt+0x17/0x20
> [   29.370360] Code: 07 0f 00 2d db 80 43 00 f4 5d c3 0f 1f 84 00 00 00
> 00 00 8b 05 c2 37 e5 01 55 48 89 e5 85 c0 7e 07 0f 00 2d bb 80 43 00 fb
> f4 <5d> c3 cc cc cc cc cc cc cc 55 48 89 e5 e8 67 53 ff ff 8b 0d f9 91
> [   29.371696] RSP: 0018:ffffc9000008fe90 EFLAGS: 00000246
> [   29.372079] RAX: 0000000000000000 RBX: 0000000000000002
> RCX: 0000000000000000
> [   29.372595] RDX: 0000000000000000 RSI: ffffffff854f67a4
> RDI: ffffffff85403406
> [   29.373122] RBP: ffffc9000008fe90 R08: 0000000000000001
> R09: 0000000000000001
> [   29.373646] R10: 0000000000000000 R11: 0000000000000001
> R12: ffffffff86009188
> [   29.374160] R13: 0000000000000000 R14: 0000000000000000
> R15: ffff888100258000
> [   29.374690]  default_idle+0x9/0x10
> [   29.374944]  arch_cpu_idle+0xa/0x10
> [   29.375198]  default_idle_call+0x6e/0x250
> [   29.375491]  do_idle+0x1f0/0x2d0
> [   29.375740]  cpu_startup_entry+0x18/0x20
> [   29.376034]  start_secondary+0x11f/0x160
> [   29.376328]  secondary_startup_64_no_verify+0xb0/0xbb
> [   29.376705] Modules linked in:
> [   29.376939] Dumping ftrace buffer:
> [   29.377187]    (ftrace buffer empty)
> [   29.377460] CR2: 0000000000000014
> [   29.377712] ---[ end trace 51a473dffb618c47 ]---
> [   29.378056] RIP: 0010:via_sdc_isr+0x21f/0x410
> [   29.378380] Code: ff ff e8 84 aa d0 fd 66 45 89 7e 28 66 41 f7 c4 00
> 10 75 56 e8 72 aa d0 fd 66 41 f7 c4 00 c0 74 10 e8 65 aa d0 fd 48 8b 43
> 18 <c7> 40 14 ac ff ff ff e8 55 aa d0 fd 48 89 df e8 ad fb ff ff e9 77
> [   29.379714] RSP: 0018:ffffc90000118e98 EFLAGS: 00010046
> [   29.380098] RAX: 0000000000000000 RBX: ffff888107d77880
> RCX: 0000000000000000
> [   29.380614] RDX: 0000000000000000 RSI: ffffffff835d20bb
> RDI: 00000000ffffffff
> [   29.381134] RBP: ffffc90000118ed8 R08: 0000000000000001
> R09: 0000000000000001
> [   29.381653] R10: 0000000000000000 R11: 0000000000000001
> R12: 0000000000008600
> [   29.382176] R13: ffff888107d779c8 R14: ffffc90009c00200
> R15: 0000000000008000
> [   29.382697] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000)
> knlGS:0000000000000000
> [   29.383277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.383697] CR2: 0000000000000014 CR3: 0000000005a2e000
> CR4: 00000000000006e0
> [   29.384223] DR0: 0000000000000000 DR1: 0000000000000000
> DR2: 0000000000000000
> [   29.384736] DR3: 0000000000000000 DR6: 00000000fffe0ff0
> DR7: 0000000000000400
> [   29.385260] Kernel panic - not syncing: Fatal exception in interrupt
> [   29.385882] Dumping ftrace buffer:
> [   29.386135]    (ftrace buffer empty)
> [   29.386401] Kernel Offset: disabled
> [   29.386656] Rebooting in 1 seconds..
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index a1d098560099..c32df5530b94 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -857,6 +857,9 @@ static void via_sdc_data_isr(struct via_crdr_mmc_host *host, u16 intmask)
>  {
>         BUG_ON(intmask == 0);
>
> +       if (!host->data)
> +               return;
> +
>         if (intmask & VIA_CRDR_SDSTS_DT)
>                 host->data->error = -ETIMEDOUT;
>         else if (intmask & (VIA_CRDR_SDSTS_RC | VIA_CRDR_SDSTS_WC))
> --
> 2.17.6
>
