Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD29348C6C
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197683; cv=none; b=nehePWndrNrzTXa7jEcw7PCFknyZWy+3Csz9BQE9BD284m5LZ0hM6en7kfE+EWIAe5NmZadlwc44GLDVanlX+C/hnjQmF9Mb9qIVhiVnHzUtoR6zTdIUsv+fn+McC3dxuzkKW/lklFMYM+WW1HfaALPtiAsrlQ6Ds2gFSsdyIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197683; c=relaxed/simple;
	bh=9xmreuXX4OZRwbshJEWIm0npDYKfIXX0w6soI7Hy82M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srTb5RGOhNbeRHBOm6OA/szy0qh8s3uTKoYNHqxLwPbUeEJbnmDU360TWvDbCaMJ3OSADo+Gp/hVO3/nls+EGUQR7pJgQ9UcZzO/B8BeKGPedSdc4r+J/UsRc/KSyF+Jeq6Ea6+/Cn30pFPF3MFoQnaxo23Cj1b8kwZzpLTcTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-57533363201so978775e0c.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197679; x=1779802479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFTXmUfGllClZ3AjkTxvr6AJKDsibhiDcNnm6JqqsT0=;
        b=jQU+nq38K+7YY/Ntx1sYljJGKTIg1rG8o+XRFDfR/oxs4O426dLTBn2FNx+smzxF1h
         +oNA/ztISWdZpAMtWrUmf3fuoETxQKINJxK0PF/ubxmnHxW2jv3eeKvm+eyJVfTOFcyW
         rpxXMnKcj+F1LTFOeluBZXQN4JvAot23dnzcKTtCCgi8BTHaR/apkd4lnzTuOmZ/+eoJ
         YHJJ4OB1amLjJ75oM24ZE3V7UaRqPEqr1mpAE7jQKJ49S71PZFHSFbvYQGlC2RvWEFex
         E+ZmhggBpF0ftxv+TJ5cJWbu42Cz6FMSJ7pEhPd3V7i2ruh67K605e7avgroxqAfZQIR
         ci4A==
X-Forwarded-Encrypted: i=1; AFNElJ+J9Kxd/YnXoSU4wcltNSir5DJmFRotPMDKIKXfnDJPaMWEi8B2c4cvESK0R6LOdFu/P6EyVDuonhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuAvI3PXPKHLxS+iGRIyDMfjXUz2vRL7pAtpoxX6QB/IxyBC9
	kt9rnqtf5EkwAinhrNHLjmxhgtDUUaKcP6dPaZGSLSLttvtv9iyXIHmh+5yAFsK7
X-Gm-Gg: Acq92OGUKYWL5Bp9bYPgtjoKNEkbsxpI/ADB/CfkXg3U+7NBJHsasPMUjT0FUDd450D
	iE4yh/X4NMejObT0b2OQyZKvwkw7WvSlixCAWpe2i0erMU3V45ypq53cVSp5jIzDOi7lbdvftcF
	GaUrC6YYJtZYwA6W7PC86zO4VSVqNMO9FfN6Z0/0IwZ8G5B99MlsnxMb1A2qEddqvdI8CwjGjEV
	T39oPMxiNUumrzvQ+FqC3EuBCUr79obIji709Tw90AOYCsWqnYu6FaMbBBuom9h3O2Ph/5ZO9vW
	2zN5UjaBt5Qqp0+Q0jMEBIqVp3UHswaCKUht18+HzEK6azPE5JgYEg5ekrE4letNjjtDQHv9iF3
	IqJOSv7HRFiPopkNcNgTPFVwoEC30UWjiXCYT/7rbRhnublE2nSak0XJgpslVUg8ggQqC6meJxE
	IrQE875qtbXXF9JEKnK1Kumq8WOf2YB6gyUIC6fBaI0aJj4M9Lr589bVsabJsvBP5JsPr7AZ0=
X-Received: by 2002:a05:6122:d15:b0:575:24a9:78da with SMTP id 71dfb90a1353d-5760c013206mr10632547e0c.11.1779197678954;
        Tue, 19 May 2026 06:34:38 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760faa5645sm8198356e0c.14.2026.05.19.06.34.37
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:34:38 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-95d439bd3a5so699625241.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:34:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZlNRCV030EKak45Q0pHkxWKAg0T8o1P50GYAXeJ2qcfZRRiAvL4GEy3DfviLeEgkbcP3MsdVin38=@vger.kernel.org
X-Received: by 2002:a05:6122:338f:b0:56e:e68e:9fc2 with SMTP id
 71dfb90a1353d-5760c013b50mr11245780e0c.10.1779197677423; Tue, 19 May 2026
 06:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 15:34:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
X-Gm-Features: AVHnY4LojIxsw5qMq3Y5Vfna_ILMHrHCSLgg2NltrAvQXVuBSgCgEDdy5WadACI
Message-ID: <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel panic
> during error unwinding.
>
> The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on its
> flexible array member `arr`. While kzalloc_flex() initially sets the
> counter field (`cnt`) to `max_segs`, the allocation loop needs to track
> how many elements have actually been populated.
>
> Previously, leaving `mem->cnt` at `max_segs` meant that if the loop failed
> midway (e.g., "Failed to map sg list"), the error unwinding path in
> mmc_test_free_mem() would attempt to clean up uninitialized trailing
> array slots. This resulted in passing NULL pointers to __free_pages(),
> triggering a kernel panic:
>
>   [   66.172845] mmc0: Failed to map sg list
>   [   66.176722] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   ...
>   [   66.432747] Call trace:
>   [   66.435191]  ___free_pages+0x1c/0xc4 (P)
>   [   66.439119]  __free_pages+0x14/0x20
>   [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
>
> Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> allocation. Then, move the existing `mem->cnt` increment so that it occurs
> prior to populating each array slot, using `mem->cnt - 1` for the actual
> assignment index. This guarantees that the counter accurately tracks
> initialized entries for safe error cleanup, while dynamically expanding
> the `__counted_by` validation boundary ahead of each flexible array write.
>
> Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use a
> standard forward for-loop. This addresses the unsafe post-decrement logic
> in the original `while (mem->cnt--)` loop which evaluated and decremented
> the counter field before indexing the array, and avoids a potential integer
> underflow/wrap-around of the counter field if the cleanup path is invoked
> when `mem->cnt` is 0.
>
> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Started with cnt = 0 and incremented before assignment to ensure
>   accurate tracking of initialized entries in mmc_test_alloc_mem().
> - In mmc_test_free_mem(), replaced the while loop with a forward for-loop to
>   safely iterate over initialized entries without risking underflow.
> - Updated commit message to clarify the issue and the fix.

Thanks for your patch!

> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
>  {
>         if (!mem)
>                 return;
> -       while (mem->cnt--)
> -               __free_pages(mem->arr[mem->cnt].page,
> -                            mem->arr[mem->cnt].order);
> +       for (unsigned int i = 0; i < mem->cnt; i++)
> +               __free_pages(mem->arr[i].page, mem->arr[i].order);
>         kfree(mem);
>  }
>
> @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>         mem = kzalloc_flex(*mem, arr, max_segs);
>         if (!mem)
>                 return NULL;
> +       mem->cnt = 0;

This is not needed, as it is set to zero by kzalloc_flex().

>
>         while (max_page_cnt) {
>                 struct page *page;

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
