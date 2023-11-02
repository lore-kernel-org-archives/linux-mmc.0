Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC8C4167B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Nov 2023 11:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjKBLqa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Nov 2023 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjKBLq2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Nov 2023 07:46:28 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3B18A
        for <linux-mmc@vger.kernel.org>; Thu,  2 Nov 2023 04:45:53 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5ae143e08b1so10268587b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Nov 2023 04:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698925552; x=1699530352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxMaDUxJOLHUqHthPkAJMb7NpcXb6mnaXJmmD9rEAAQ=;
        b=jX0g2ppxQd45p8BzFb0qQP+W4f6kCBvt/nIRW5y+ryEZXqoQENhuoZ4ETAaHmW2Or4
         1nntqUMM9PhjA9MM5saHVVmplrwKpVXhZSsn3F4CZIkWHF1PDQD2b1hWECY8FEH5OTrR
         iaWxcTuoE4NrmA+ikNrH0FvMKM8sDrxHf9lk4rSUlcek9ZP6eG67YloD0uzkNIlkryXf
         qE0uaNdG3eKDHx19+YRfraKS8m3GnywJA1Qp5Kgy5rxuD39wkqW81KKoMZ1jyl2/U/p9
         Dg7eJB/TUFRcW8KBzMyfPPCvsLKhO+GhXnrEnqRV9AsgZOPIhwGmmreRMAU1zt2QE6pW
         acYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698925552; x=1699530352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxMaDUxJOLHUqHthPkAJMb7NpcXb6mnaXJmmD9rEAAQ=;
        b=ODrcPFBzxm4hMfXPQuOWk9dtJgyIU0CTGUzABGbkfuF9uc8pHcfaMFbziUYIJwcCi9
         L98iHOmL+wo9zaqujWkvPxc7bAy3DExHRrlI3Fsx3D/bnPBMZQelHxy9P5nHP+gJlibl
         rZVL6CVMRaqxTwqeNGmYuXr4gvFXOB0B8+vEmG5BbmTetMc/qJgobI4WeBHzhGIITiyY
         NbHR8zfTJu0Mba7vSFsLTqI28nUHUVr2kcSJkLbxi0teq2HNG7lE1WV/gCIIRe/4ctjr
         CBNMl0ddWOUpgOdGDghM3wov4uPqA0Y6f/9fiSb6ZR7cVQwG6SsC2fXUkpKf5Deq+xlA
         qIzA==
X-Gm-Message-State: AOJu0YwueCix8oiRhjI7NW1kOwLL5UhWgCgs0MFSjQNPaBBnwgm1TUlR
        hqHJh5jCaM85DpbR3mdnwKOOfOFMa7QSXXdcQwKDRg==
X-Google-Smtp-Source: AGHT+IGqs+tyNIwSzdSc1B62YX1/6AgiBa7C0Z+ii/Da0bAbeH1D3GlidLDkEsDalrNqoD0y0ytg2uJUfdXzWTQdELc=
X-Received: by 2002:a25:414a:0:b0:da0:c746:3866 with SMTP id
 o71-20020a25414a000000b00da0c7463866mr17680176yba.41.1698925552411; Thu, 02
 Nov 2023 04:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <b669f8e2aebcfe7a0937175058364daa5862d862.1698766265.git.geert+renesas@glider.be>
In-Reply-To: <b669f8e2aebcfe7a0937175058364daa5862d862.1698766265.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Nov 2023 12:45:16 +0100
Message-ID: <CAPDyKFp40gZqYTXm8ARuSY0DX4ps82KhEsT+FOWwT4+uub43bA@mail.gmail.com>
Subject: Re: [PATCH/RFC] mmc: tmio: Cancel delayed work before freeing host
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Oct 2023 at 16:48, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> On RZ/Five SMARC EVK, where probing of SDHI fails due to missing pin
> control:
>
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1739 __run_timers.part.0+0x1e8/0x22a
>     Modules linked in:
>     CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-10953-ga37a67d260e6-dirty #86
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __run_timers.part.0+0x1e8/0x22a
>      ra : __run_timers.part.0+0x130/0x22a
>     epc : ffffffff8007540c ra : ffffffff80075354 sp : ffffffc800003e60
>      gp : ffffffff814f5f08 tp : ffffffff8140d5c0 t0 : 0000000000046600
>      t1 : 0000000000000001 t2 : ffffffff81200c10 s0 : ffffffc800003f20
>      s1 : ffffffd8023bc4a0 a0 : 00000000fffee790 a1 : 0000000000000200
>      a2 : 0000000000000200 a3 : ffffffff81489640 a4 : ffffffc800003e60
>      a5 : 0000000000000000 a6 : 0000000000000000 a7 : ffffffc800003e68
>      s2 : 0000000000200000 s3 : 0000000000000122 s4 : 0000000000000000
>      s5 : ffffffffffffffff s6 : ffffffff814896c0 s7 : ffffffff814f58a0
>      s8 : ffffffff80f8bec8 s9 : 0000000000000000 s10: ffffffc800003e60
>      s11: ffffffff81489640 t3 : ffffffff81489678 t4 : 0000000000000240
>      t5 : ffffffd8024ac018 t6 : ffffffd8024ac038
>     status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
>     [<ffffffff8007540c>] __run_timers.part.0+0x1e8/0x22a
>     [<ffffffff80075472>] run_timer_softirq+0x24/0x4a
>     [<ffffffff80804ec6>] __do_softirq+0xc6/0x212
>     [<ffffffff80027434>] irq_exit_rcu+0x7c/0x9a
>     [<ffffffff807fcd8a>] handle_riscv_irq+0x40/0x4e
>     [<ffffffff807fd7f8>] do_irq+0x40/0x68
>     ---[ end trace 0000000000000000 ]---
>
> What happens?
>
>     renesas_sdhi_probe()
>     {
>         tmio_mmc_host_alloc()
>             mmc_alloc_host()
>                 INIT_DELAYED_WORK(&host->detect, mmc_rescan);
>
>         devm_request_irq(tmio_mmc_irq);
>
>         /*
>          * After this, the interrupt handler may be invoked at any time
>          *
>          *  tmio_mmc_irq()
>          *  {
>          *      __tmio_mmc_card_detect_irq()
>          *          mmc_detect_change()
>          *              _mmc_detect_change()
>          *                  mmc_schedule_delayed_work(&host->detect, delay);
>          *  }
>          */
>
>         tmio_mmc_host_probe()
>             tmio_mmc_init_ocr()
>                     -EPROBE_DEFER
>
>         tmio_mmc_host_free()
>             mmc_free_host()
>     }
>
> When expire_timers() runs later, it warns because the scheduled work was
> freed, and now contains a NULL handler function pointer.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Calling __mmc_stop_host() instead works too, but __mmc_stop_host() is an
> internal core function, and is not exported to modules yet.
>
> Perhaps this should be handled by mmc_free_host() instead?

That sounds reasonable to me. Or actually not "instead of"
__mmc_stop_host(), but rather from mmc_free_host() too.

mmc_stop_host() also needs to make sure that mmc_rescan() isn't
currently being executed, so that when setting the
"host->rescan_disable = 1;" it really takes effect.

Do you want to send a patch?

> ---
>  drivers/mmc/host/tmio_mmc_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index be7f18fd4836ab29..1e56e78a020d94b9 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1132,6 +1132,7 @@ EXPORT_SYMBOL_GPL(tmio_mmc_host_alloc);
>
>  void tmio_mmc_host_free(struct tmio_mmc_host *host)
>  {
> +       cancel_delayed_work_sync(&host->mmc->detect);
>         mmc_free_host(host->mmc);
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_free);

Kind regards
Uffe
