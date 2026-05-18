Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F82FCC0E
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102519; cv=none; b=AkrzeFu/mGWr6c/S/Egy3CYYMVj1t2NWl0ySDCH1KmeRf6N1CCEDxopfy6S/yFkrJfVMne5P8diY2O0yGGHNTaYced6Q8sCVrM0SoWDigTY+rr/oBsiyUS6MMYaPuOWXgLzty5TM2v0Vgx1+YmN4i2CNLD3WhNt7bLo/fYQROvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102519; c=relaxed/simple;
	bh=PMRKc7cmQjcXH+EkLu8ARQjGDKAXvbHuRPNvuV2hbJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+qyDytzbI7FfkQWifrozSUXR8U4XvjdwN/8p7wMUW8nInxkUDxzJCgkHk8CDH1fi/t0wlX95nsmf1ob+Bxzk7RdjpYfmp+geQEbVjYf3+MQ1menDF/QDAzlyxi8mVSh46U7jVFN2T3x+slrnjLujoUEkI2DpcRjIq7lL2wPVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-57512b86273so1648119e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 04:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102514; x=1779707314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu+ZJS6PxzVr6PaR8SZzr/7K/mvYhij6WlM6YgqWCaY=;
        b=gUtMj0nIdicDcujqP2rznODJT4GvWQZ9+5PMNb8LUplAOs/GFsp/Fwi+nibpjRoRND
         NS/Cbze0OqTZpi8+bVHJbZhkBgQlb6qEIxIukH1BIH+YDihoRzWPR312XThVN53+agNO
         tk27O6Wz9F1AxuMlr4Tw2t/hRo16iWVxQU/+ipNlLP9nBkirUi+EJ02QgmAcqYqRvIQG
         FisHeekyIuiQs0S6LZHUKCQpCzdbF4ifEaxaunSFvqXrN50TE3igHAkYV23EnJ7VYLLa
         E4RaiXp/cmUq9QnPFE02aeGTFU/U2ggJ3k5XtqHmQP7LpQ7UVTBaFGzt0TvILiiKNqCP
         pgAQ==
X-Forwarded-Encrypted: i=1; AFNElJ96mOjpJNa5pHEPFfamTfe9+T0Tz1Y+DYLKXcj+uDk1JBPwlC6AtwgLi+mp3bNbrMpvYpUfL2OA4/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQObU0EpI2cQjVFzMXDBXd0j6TRJoDr0eG1d0DWhhpAL5/CeA
	5Z3MIEXvfuS07h3s1GgVr+s7xBE2PbYJlHmxzQ3J2QMCddV57Howsut8m0TUiWfu
X-Gm-Gg: Acq92OGnBJSLtemVR6O19tlARxt2PyIbD8fg9ggI8C7CXGM+OEig3FkOgfveyoJyVnf
	NdEsXkZD35Bf3+YM1wjZ2jPxOuRfRwqU2FzdJ7smtH4JwvHO94w8ojEetiH/xK6TJ/2xkXY6PNo
	O2vp/vR6oIiDa/UZkAczz9LWymGgjPE+W+LqtJDU3Q/B6vAAKar3FVW1D1lFPYNcv1pqC0XUCYC
	eHjnT4tQ1zixPbch0i3hdnTebO2bURHzeh/C2saQOXYF/MX1P6q5SYDgdMPStKcsOqdIYgQNp0G
	GYLi8FlDfEFAgpkbgtQkSbv+OYAbK4m+wQ8IOaMRkmgYFhgHAn5/4vDUILB5UvM3/qEF6BLKKDN
	bfOQjb6kiSebjOKSA9IVFCcHpPdq17NF3lHjeTEXQGltY8otM98C0xj5XYLr2yliXQLNVW0RcY9
	BaWsdcKmRAiJ/7rw0m/FzUMN82jXzBVdfPo1r/F2OR0og2sJT8GlxtVcZtzYI18yBp
X-Received: by 2002:a05:6122:6857:10b0:56f:bb91:4861 with SMTP id 71dfb90a1353d-5760bc5ab3emr5898918e0c.0.1779102514254;
        Mon, 18 May 2026 04:08:34 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2d324a6sm4485094241.7.2026.05.18.04.08.32
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 04:08:33 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-57512b86273so1648097e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 04:08:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ85lCRRCLU+0SgbWVjShgT0vOEGNLstkU5D38WpatgHKVzvWOhO2sEVTNV4l71XQx6XVX0CRl3B4qU=@vger.kernel.org
X-Received: by 2002:a05:6122:2a0e:b0:56c:fe16:f54b with SMTP id
 71dfb90a1353d-5760c0a6a8fmr7462476e0c.11.1779102512538; Mon, 18 May 2026
 04:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 13:08:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
X-Gm-Features: AVHnY4J3hgDaRNuD4ScVRVVTPiyGFnGF31deZAtpvTXzLCoed5gLPEQJi9qAKiU
Message-ID: <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
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

On Wed, 13 May 2026 at 22:13, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix logic issues introduced by the kzalloc_flex() conversion in
> mmc_test_alloc_mem() due to interaction with the __counted_by
> annotation on the flexible array.
>
> Bounds-checking sanitizers rely on the counter field reflecting the
> allocated array size before any array access occurs. However, use
> mem->cnt both as the allocation size and as the runtime insertion
> index, causing incorrect indexing and potentially invalid bounds
> tracking.
>
> Initialize mem->cnt to the maximum allocated number of segments
> immediately after kzalloc_flex(), then use a separate local index
> variable to track successfully allocated entries. Update mem->cnt to
> the actual number of initialized elements before returning or entering
> the cleanup path.
>
> Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
> readability and ensuring only initialized entries are freed.
>
> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
>
>  static void mmc_test_free_mem(struct mmc_test_mem *mem)
>  {
> +       unsigned int idx;
> +
>         if (!mem)
>                 return;
> -       while (mem->cnt--)
> -               __free_pages(mem->arr[mem->cnt].page,
> -                            mem->arr[mem->cnt].order);
> +       for (idx = 0; idx < mem->cnt; idx++)

for (unsigned int i; ...)?

> +               __free_pages(mem->arr[idx].page,
> +                            mem->arr[idx].order);
>         kfree(mem);
>  }
>
> @@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>         unsigned long page_cnt = 0;
>         unsigned long limit = nr_free_buffer_pages() >> 4;
>         struct mmc_test_mem *mem;
> +       unsigned int idx = 0;
>
>         if (max_page_cnt > limit)
>                 max_page_cnt = limit;
> @@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>         mem = kzalloc_flex(*mem, arr, max_segs);
>         if (!mem)
>                 return NULL;
> +       mem->cnt = max_segs;
>
>         while (max_page_cnt) {
>                 struct page *page;
> @@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>                                 goto out_free;
>                         break;
>                 }
> -               mem->arr[mem->cnt].page = page;
> -               mem->arr[mem->cnt].order = order;
> -               mem->cnt += 1;
> +               mem->arr[idx].page = page;
> +               mem->arr[idx].order = order;
> +               idx += 1;

While looking rather ugly, I think starting with mem->cnt at zero,
and updating it in each step like

    mem->cnt++;
    mem->arr[mem->cnt - 1].page = page;
    mem->arr[mem->cnt - 1].order = order;

would still be better, as it makes the dependency between mem->cnt and
the size of mem->arr[] clearer (located closer to each other), and ...


>                 if (max_page_cnt <= (1UL << order))
>                         break;
>                 max_page_cnt -= 1UL << order;
>                 page_cnt += 1UL << order;
> -               if (mem->cnt >= max_segs) {
> +               if (idx >= mem->cnt) {
>                         if (page_cnt < min_page_cnt)
>                                 goto out_free;
>                         break;
>                 }
>         }
>
> +       mem->cnt = idx;
> +
>         return mem;
>
>  out_free:
> +       mem->cnt = idx;

... as having to set mem->cnt twice looks rather fragile to me.

>         mmc_test_free_mem(mem);
>         return NULL;
>  }

Regardless, as the patch looks correct to me:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
