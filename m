Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8133EB81B
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043819; cv=none; b=Z2EPzduWPi5Fj+Y5+8wa6UYR/KMGOsrEUeYWGbjCZS55zpfDMlaTdvXOtNhLVvxcZ2sotVUwW+gxuUsnRaiJwWyKPakNvXl8RTBiFYyFiZEKDg51mHXTFx1Mg5AHYT4Y3bEqVi0LGdKToKDCgcGvl1IP5YovX8s6jLy1or0M3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043819; c=relaxed/simple;
	bh=NmgtNIiaie5v1b+7v4Tfvjvl/nsrpJJcLEz6wbrdxZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCGUmj+/vEiVxVJYpLc4o9Wp1Lpl1F/o+bz3UZI4P7wYzeU10rwzqT6RT9U3rUckPAXYco6Czq7ATWRLektPHJh4RPochgmLJEMeHWlEZuQ7TgHmJBnSAGX0Twy2k6yP9p/GcVK8tuZZvftKJKuM76PRbgoqpQCv2NpDqoR9lxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-73a75f251a7so381255137.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 08:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043817; x=1784648617;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ada/q+dWqh09jb9bqASq9gF6EZOlFcR0dGagDul5ZU0=;
        b=BeFXBiNxAaIZLf4imfuDvsLuSxUne4EnI+wqJ6Hs+Y/AFAWUW9bUHOsJ0HmF4J3cmd
         25fp+OTo3+bQwFw3KWcNNAwgZBcNCL/ej5msgsbP8ExSkb9PrZRUfPL+WzNraijPf5HW
         SpiJeMavwPTxymYUo0YCfr0nFM893FPa7u/Ks+qNUcP/BED1d4pvaJAlXeuzbh3MVWYz
         nLZqDci1+YVp0gAOrgrvDnFq5y3QgZ+6P5gp1C0e5IlCsPTfLTqBPQs/RrHkSr9jdeCe
         rIumrWZPJKvA0qIUoY4f1Bm5LQwfYGL5pyurbZMRm5ebWmT9GlFAUfgFoNiqZ6kdrblC
         1rig==
X-Forwarded-Encrypted: i=1; AHgh+RrnShL9X0gvmzwGw7C8LgoGQzgWOA0M+ZHdOCOrdjeKUv82EsOX8jR/lPaft0NTZvdLvqwbxpCWMjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjDs4eRsPXgA9BHpXBis7OOHnMXu+7C5EgygvIQhI1aMa45vM
	0FAs89TokdFu4coI8+xeNamBnkOHm5oCYoc+NDitzznfoC92lUhYHql6+T/Ca69ZqDI=
X-Gm-Gg: AfdE7ckkA9Q4dBbiBwb5JhWC+BEUMHoihGrKWDe0CG11FdRuZcJBWrBnC0qFs3qmG6O
	Q/WuIHzsl3KmFof1LPGaYxz58ysa678VDrzIqOfsmZZeAvPizl20WPOs61UfnnKGf1yKCuELFPZ
	V/I4lqvD6faYl0QFxVNe98IOJF1qtCxVcx9sXZnI/XWm+Dax9+qkH4vWeokHLZj5I1ttiVMlsjm
	XmnHtrb5uFooJdiH6nc7lVivvtyE+mXTL8q8NiRwlNI7NET3IRYGKDuMwKGsTL2HMHZrY29VPE+
	gyLs4FeX90tpKS5xEaE+RqrjYBLlo+YywHZqYpyN2j3ehV24VyBLyIDahgtOVVqoCHjdfQ4LFU3
	+B1bNXMI8hOzrCOaF5WhHAkW94iKftnkJQNR7piuMiU1/hBhlJmEFIajKuEfHIu12/nPGwQOAiZ
	rQdlvoQqB8NlhPJmjMRLfKxGdsVS0oZV2bvXH0bf4jgIY4QKV2uvdJ2B/my+R0
X-Received: by 2002:a05:6102:5a89:b0:737:ba2e:8a29 with SMTP id ada2fe7eead31-74533e6fe9dmr7977296137.27.1784043816651;
        Tue, 14 Jul 2026 08:43:36 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6deb1aasm11032263137.7.2026.07.14.08.43.34
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:43:34 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-73a75f251a7so381241137.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 08:43:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqDnjiUTNrkEIZHCJMyGmCJCnhdUTHXbYYgnnVMkXejFI2pham4vci1gwiyxzmn9WDgWQacCa+NJEc=@vger.kernel.org
X-Received: by 2002:a05:6102:c4c:b0:726:e81f:f3f0 with SMTP id
 ada2fe7eead31-74533d660d8mr7704803137.15.1784043814149; Tue, 14 Jul 2026
 08:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com> <20260713175159.138334-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260713175159.138334-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2026 17:43:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQDWJGxuU04PEo2bJgHJF5F+0=HXqKzthKhKSR6dg0Tg@mail.gmail.com>
X-Gm-Features: AUfX_myvgANJp5og68PYkTHvIcIM4WKLf3Akk3PMIfJcnRn_2dsJDG0zHs09wp0
Message-ID: <CAMuHMdXQDWJGxuU04PEo2bJgHJF5F+0=HXqKzthKhKSR6dg0Tg@mail.gmail.com>
Subject: Re: [PATCH v20 08/12] mmc: renesas_sdhi: Add RZ/G3L SDHI support
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 13 Jul 2026 at 19:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RZ/G3L SoC (r9a08g046) has an SDHI controller with several
> differences from existing platforms, requiring dedicated handling.
>
> Utilise the TMIO_MMC_HWADJ flag to identify controllers that carry
> a second hardware adjustment register (SDm_SCC_HWADJ2 at offset 0x010).
> When both TMIO_MMC_TUNING_DELAY and TMIO_MMC_HWADJ are set,
> renesas_sdhi_set_hw_adjustment_delay() additionally programs HWADJ2
> with 0x3FFF at 3.3 V and 0xFF at 1.8 V. A new RZG3L_SDHI_SCC_HWADJ4
> register (offset 0x022) is also cleared at the start of tuning when
> TMIO_MMC_INTERNAL_DIVIDER is set.
>
> Add a new version constant SDHI_VER_RZ_G3L_SDMMC (0xce10) and extend
> renesas_sdhi_sdbuf_width() to handle it alongside the existing Gen3
> variants.
>
> Introduce of_data_rzg3l with RZ/G3L-specific parameters: a wider
> clk_mask of 0x200000200, a max_divider of 2048 (reflecting the 11-bit
> divider), a dedicated rzg3l_scc_taps table, and all relevant tmio_flags,
> including TMIO_MMC_INTERNAL_DIVIDER and TMIO_MMC_HWADJ. Wire it to a
> new of_rzg3l_compatible entry using sdhi_quirks_rzg3l (which sets
> fixed_addr_mode), and register the "renesas,sdhi-r9a08g046" compatible
> string in the OF match table.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

This causes a division by zero on Armadillo (R-Mobile A1):

    Division by zero in kernel.
    CPU: 0 UID: 0 PID: 22 Comm: kworker/0:2 Not tainted
7.2.0-rc3-armadillo-06338-gd1557670ab0c #976 VOLUNTARY
    Hardware name: Generic R8A7740 (Flattened Device Tree)
    Workqueue: events_freezable mmc_rescan
    Call trace:
     unwind_backtrace from show_stack+0x10/0x14
     show_stack from dump_stack_lvl+0x44/0x74
     dump_stack_lvl from Ldiv0+0x8/0x10
     Ldiv0 from tmio_mmc_set_ios+0x11c/0x1bc
     tmio_mmc_set_ios from mmc_sdio_init_card+0xa40/0xab8
     mmc_sdio_init_card from mmc_attach_sdio+0x90/0x32c
     mmc_attach_sdio from mmc_rescan+0x1d8/0x2a4
     mmc_rescan from process_scheduled_works+0x2bc/0x45c
     process_scheduled_works from worker_thread+0x170/0x214
     worker_thread from kthread+0x114/0x124
     kthread from ret_from_fork+0x14/0x28
    Exception stack(0xe0945fb0 to 0xe0945ff8)
    5fa0:                                     00000000 00000000
00000000 00000000
    5fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
    Division by zero in kernel.
    CPU: 0 UID: 0 PID: 22 Comm: kworker/0:2 Not tainted
7.2.0-rc3-armadillo-06338-gd1557670ab0c #976 VOLUNTARY
    Hardware name: Generic R8A7740 (Flattened Device Tree)
    Workqueue: events_freezable mmc_rescan
    Call trace:
     unwind_backtrace from show_stack+0x10/0x14
     show_stack from dump_stack_lvl+0x44/0x74
     dump_stack_lvl from Ldiv0+0x8/0x10
     Ldiv0 from tmio_mmc_set_ios+0x11c/0x1bc
     tmio_mmc_set_ios from sdio_enable_4bit_bus+0x120/0x138
     sdio_enable_4bit_bus from mmc_sdio_init_card+0xa48/0xab8
     mmc_sdio_init_card from mmc_attach_sdio+0x90/0x32c
     mmc_attach_sdio from mmc_rescan+0x1d8/0x2a4
     mmc_rescan from process_scheduled_works+0x2bc/0x45c

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -235,9 +238,18 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>
>         clock = clk & CLK_CTL_DIV_MASK;
>         if (clock != CLK_CTL_DIV_MASK)
> -               host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
> +               host->mmc->actual_clock /= (1 << (ffs(clk) + 1));

Is this change intentional?

    clock = 0, ffs(clock) = 0
    clk = 8388608, ffs(clk) = 24

Later:

    static void tmio_mmc_max_busy_timeout(struct tmio_mmc_host *host)
    {
            unsigned int clk_rate = host->mmc->actual_clock ?: host->mmc->f_max;

            host->mmc->max_busy_timeout = host->get_timeout_cycles(host) /
                                          (clk_rate / MSEC_PER_SEC);

clk_rate = 2, BOOM!

   }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
