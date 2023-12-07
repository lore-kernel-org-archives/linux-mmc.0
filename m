Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPl/N/Fh"
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059210F7
	for <linux-mmc@vger.kernel.org>; Thu,  7 Dec 2023 06:17:13 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d3d5b10197so7119467b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 Dec 2023 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958632; x=1702563432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIqBeZRl8y1XOtBXYU9T4wX38+aoN3n1Nv3+KCL0QkQ=;
        b=gPl/N/FhNHdiGN4IQOE6mwS1nimV9MmU7a13XTLeIcGKqQdQIl/lhuTHll+ue5pLcM
         lpYTAWml+ZPdCq4xOjdVaF0ezmLJi2i3COSPXO4Cvus38F3GqXGSZwmOV1Yw0ZL0iO9n
         LvGNMzhK3vlEZqovtSadgK/4rVp9Ci9XfeegH6YHuf2cCM3KwdlOGPRBTEwBPvChS0/H
         mZO+JQugpDSvkLAjCNKE8jYcTM0Jo+0BJxit9IUDleUZYP8GYuGbiaTXlAQ24wasyGvW
         z7IKwVb7h2AB5CK5WPojzEmM25OAjnEnPzvjdyilssu2esrAfsmxnz76w/J0Szc/7wex
         Y1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958632; x=1702563432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIqBeZRl8y1XOtBXYU9T4wX38+aoN3n1Nv3+KCL0QkQ=;
        b=oCKxZcJ0VNVKtlxNAzRP+6gUuJb0SSEWPT6eJo2/zr40ThvGwmpMXwIJXbXPehRMI7
         XHCEHquGbx89TMb0Rpo1FT/JZm7dUoxuHCeJ6iFk4i1Ss1CLvdVBMpEYLM2+N4G2MYaE
         1ayj9S/LayEUQ3r450cqcv7L7wt6r+YHKzemQkCDs3/CwrkoPACnGknCmTGlgMVWxjdv
         HO94OaDsxv0QVDmqkSbXxNfaPM5rC9sEkB/rrHoW0doYNlrNfzeN9f+M99HwJXUjfglS
         h0ZQAFQjBvLj1oSQW9p9AEIa/jY7te11mzLnYEvqxc/yeplc92xMtl0tYoLjbQoddEdI
         gE+A==
X-Gm-Message-State: AOJu0YxP+Q99Z2Qk+3PhxhvYuuHqfckH0j5o0ZvorgfjyrnRBHv49Z88
	1fp0EiLSDnDwgQ2BdbcLU9Lafuy/0Vmm+X1bBT3Ulg==
X-Google-Smtp-Source: AGHT+IEu7VXq5ZT/2mJX0V5VPdEWT29iVTokSzStSwQ9aCi8OknKE2Q1X+GPcGt4/5HXuZV9QPu4giDYzZyGl+tNPLk=
X-Received: by 2002:a81:4310:0:b0:5d7:1941:aa4 with SMTP id
 q16-20020a814310000000b005d719410aa4mr2439204ywa.63.1701958632406; Thu, 07
 Dec 2023 06:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <205dc4c91b47e31b64392fe2498c7a449e717b4b.1701689330.git.geert+renesas@glider.be>
In-Reply-To: <205dc4c91b47e31b64392fe2498c7a449e717b4b.1701689330.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 15:16:36 +0100
Message-ID: <CAPDyKFrw24WfQA2yh-PmoRcJR=+KP2Efo5DyWhBwpx2NC3k7Og@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Cancel delayed work before releasing host
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Dec 2023 at 12:30, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> On RZ/Five SMARC EVK, where probing of SDHI is deferred due to probe
> deferral of the vqmmc-supply regulator:
>
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1738 __run_timers.part.0+0x1d0/0x1e8
>     Modules linked in:
>     CPU: 0 PID: 0 Comm: swapper Not tainted 6.7.0-rc4 #101
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __run_timers.part.0+0x1d0/0x1e8
>      ra : __run_timers.part.0+0x134/0x1e8
>     epc : ffffffff800771a4 ra : ffffffff80077108 sp : ffffffc800003e60
>      gp : ffffffff814f5028 tp : ffffffff8140c5c0 t0 : ffffffc800000000
>      t1 : 0000000000000001 t2 : ffffffff81201300 s0 : ffffffc800003f20
>      s1 : ffffffd8023bc4a0 a0 : 00000000fffee6b0 a1 : 0004010000400000
>      a2 : ffffffffc0000016 a3 : ffffffff81488640 a4 : ffffffc800003e60
>      a5 : 0000000000000000 a6 : 0000000004000000 a7 : ffffffc800003e68
>      s2 : 0000000000000122 s3 : 0000000000200000 s4 : 0000000000000000
>      s5 : ffffffffffffffff s6 : ffffffff81488678 s7 : ffffffff814886c0
>      s8 : ffffffff814f49c0 s9 : ffffffff81488640 s10: 0000000000000000
>      s11: ffffffc800003e60 t3 : 0000000000000240 t4 : 0000000000000a52
>      t5 : ffffffd8024ae018 t6 : ffffffd8024ae038
>     status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
>     [<ffffffff800771a4>] __run_timers.part.0+0x1d0/0x1e8
>     [<ffffffff800771e0>] run_timer_softirq+0x24/0x4a
>     [<ffffffff80809092>] __do_softirq+0xc6/0x1fa
>     [<ffffffff80028e4c>] irq_exit_rcu+0x66/0x84
>     [<ffffffff80800f7a>] handle_riscv_irq+0x40/0x4e
>     [<ffffffff80808f48>] call_on_irq_stack+0x1c/0x28
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
>                 -EPROBE_DEFER
>
>         tmio_mmc_host_free()
>             mmc_free_host()
>     }
>
> When expire_timers() runs later, it warns because the MMC host structure
> containing the delayed work was freed, and now contains an invalid work
> function pointer.
>
> Fix this by cancelling any pending delayed work before releasing the
> MMC host structure.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
> This is v2 of "[RFC] mmc: tmio: Cancel delayed work before freeing
> host".
>
> v2:
>   - Move cancel_delayed_work_sync() call from tmio_mmc_host_free() to
>     mmc_free_host(),
>   - Correct explanation from missing pin control to vqmmc-supply probe
>     deferral,
>   - Update backtrace.
> ---
>  drivers/mmc/core/host.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be006353..2f51db4df1a8571b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -692,6 +692,7 @@ EXPORT_SYMBOL(mmc_remove_host);
>   */
>  void mmc_free_host(struct mmc_host *host)
>  {
> +       cancel_delayed_work_sync(&host->detect);
>         mmc_pwrseq_free(host);
>         put_device(&host->class_dev);
>  }
> --
> 2.34.1
>
