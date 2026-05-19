Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37648124E
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185152; cv=pass; b=VOZXjS2OeXbkYbqPKZgHUkYAfTP02A8VnlETpIF9PIbMHylD6QTfRjqSEt4VuSYQFb3u1lEV5lVXYW1vpZf39Omoxa8Qqq/2ipb5OnfsG8VmIn0t1shPHknK1ihb6prFuVka7FTQ16/bQdmoJrn5D5B3H6y2LLewM5t6Wy8QrhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185152; c=relaxed/simple;
	bh=czyUKy/5TRWEYZwJjc6/HYigu7VtwCQiu37oSpPfG88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE7ucmgcyjmAAgNmMj39Vfe1uMMhgt/z+SCsvEBOi9BAjJ63RRXfGHac2EFfDNrRqi2iMo3mv8KRnoDKyaoSA6cH8CU/mMRcbwu7fEfXLAELqbRMsqODmhf4h153tHuZhACsypmM9NqI+U8OoAOaYwQrDgeobQ1Si3/sPQYE4DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAMvRBcC; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAMvRBcC"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1797829f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 03:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779185148; cv=none;
        d=google.com; s=arc-20240605;
        b=U8/Oro+BhvpvzAWwBEUf+BHZ/G1I0kcYIMG+cVnWa3z6dGHbfrWd85MFmNExCbsAvK
         v5ZfHxSej1fRh33zilN1be/bOEiMrkGEQUaH+pb+VWsTrpVJTPHfC1Y0SRddIFgzwtUH
         zhgO5HNLjYq2fUKbyARoiT4USrLX6te2eg8vvAkWLTiqvQxoM0Um1cMQ1b7hm203wu9w
         iEgDtmS+6QQr/ZhvOWgg/692AA3G/fu4H63Suvn1QNnEW9XvMKcYSBdS8HmkYVGYoPlx
         I/IfFxSNMF/BbBE+Utd9mYUlE3gKuTD9dQRxuUTpkIpf1s8HZZyzORRkOXq9/0/TrAon
         8qZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiYL6/RjiqiIsp067U9+dXVTX/+7ETKrZ/JSTHkELaY=;
        fh=1C5E9XSTNHW17zkF4se/SzwMjgtV8fUPBiaJedqZWyI=;
        b=W3dRkz4yzwvjElrAMtavj2/tHmWSn1sPYaOjhK3pDMGDLpyDYIsoTxn+fVzHMZtRR/
         olOdqdT2gOCAT7QqrYbPXXBQgBlWxANP3CxRTHQVDPV6mIBY1bTbFZt0ApczV8srqirm
         JWlhJZENqDfLwDMG6eM70yYpAyHCbgGKJgfQnUZH5jplGhd4JwlvLMCbxoBvfznFu8Mi
         i+O3qW3fA9citGLgN6sSLz/32gkmkeB+dQ0sXzcOzs3sQOzwE2Woz7Pdguz19CsZv7V+
         7MahixlOC+XmLyAPbboGuYCRqCgfh35xzuqZnl3wLpeP00vAvxGzkfieqWfvDkvzF47C
         l9Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779185148; x=1779789948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiYL6/RjiqiIsp067U9+dXVTX/+7ETKrZ/JSTHkELaY=;
        b=IAMvRBcC7KgDVLtKWKI4ISN4eoS0ZjDPL79AexCe/c+r27PAdyN0x4u0I74uCq9seA
         DSSGiqsjKnspvetARzkTs2IErDsUBGILVDOOYv5XaJteVxLswnn4xC4pYhXNZZiOtrzk
         qEtSy7fw1V7AAmmrdMhZKUtf0HH1jRaDC2TUnLTJFaNSse1qc7j2UmSTPqpwCf/JRayX
         +d/EYPH8bZr7TOVnGUaprz0L+5hC017w9wapEVuKd47n/raWnUAXRhFtnh+h+/csOTg4
         tXvfn3qce/LnONJ/0fY2zKFoIcGtZJPuSEIoggNHq3hw0vRGVnKsKMj7yAn3x8uIZwRt
         hPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185148; x=1779789948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RiYL6/RjiqiIsp067U9+dXVTX/+7ETKrZ/JSTHkELaY=;
        b=sLk8+xn4CZYhYAXWDyUiOJ42Vp2KFlxZYzSP7/r9I1OzJBeb44CKPjJSRsiQ+YeMJy
         3M1v7pcJVjVurgPrJOmnRm0QalO238aQavu7D/xr3DH/QpQ8FndAfFdhVo+/k1eSvsuP
         gunOuVQdZnx7NmZAQeCqNXSrB5EoR+/YV37KLJVgrrr2jOcO/BqjNcTuwdgNqEQINz2f
         3PvlEFsvKq6+4FKWOpPM7bH98ZmxqJyA3HZPi/CspthHQJPoV4BgPUCwgN1qD9G80m3I
         wNSYjxgINhNXK+tYYdpu7bLOXsC17XDStKVJ/NeY2uKSNTZTyc5yYNz/Nqjjj7cy7tzQ
         Cibw==
X-Forwarded-Encrypted: i=1; AFNElJ+8hx8uBC4lHwgFkyc8C4wzEF+iiWrHi6mVRAaAWQj3irYCngGYksDSAVAFsUJQ7FjiO4b+TDUrLto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4848idcsKxXwEgVXaMqSlcnhp+LpCaYtEau/RZvohoriAm2f
	sOJfNLmZc6gYyB3y7LQf4kORtTrGyNe775E/aCLeJrMuvjoBcPe5XPwliLSK8fJZEzie/TARAUM
	w7Vw7ctKEf0Kohuw+A/XQnWajxJoO4Uc=
X-Gm-Gg: Acq92OHAD7LH8ULh0+sAstMKoiwMWGBa7ZwPMiv+OD8hXF67Fv4hVCC+1uOM82RKxe4
	SfDRsOJ56IC1BrnLE66cTSwgubFKJQ75Kyn2sqaWqAebwTIpeebV/p9gn6hQ+TSyO8Ih2P9oJEx
	I9ESt5lJw4SzXO0A+T0aW7SLJsMBaqhvNNdbg+e2dQ0fDMDCsGJKg3m7jBVsnYKRzUH/yF6mpWz
	L85ZBwt1kyIS/Yg7q0n4gXses08WMun8CQXqmumHvW4YsxcEnQmqZ7DwJ5bL4FnKpv8uUgChBro
	yhel22osuqbKC7h61/YnT0Qo12CX9wrWAKGAX79UpCiY7HeAeFwOB/R//R8/YgB1QKUO3eiU97T
	HqmY=
X-Received: by 2002:a05:6000:1787:b0:45b:d5d7:1f59 with SMTP id
 ffacd0b85a97d-45e5c5e3282mr30988684f8f.24.1779185148172; Tue, 19 May 2026
 03:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
In-Reply-To: <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 11:05:22 +0100
X-Gm-Features: AVHnY4JoB4T1br5m3mLltNKq-ucASMJuVjuTIoj0NffHxkPFdgR_H0jzHgpPrWU
Message-ID: <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, May 18, 2026 at 12:08=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, 13 May 2026 at 22:13, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Fix logic issues introduced by the kzalloc_flex() conversion in
> > mmc_test_alloc_mem() due to interaction with the __counted_by
> > annotation on the flexible array.
> >
> > Bounds-checking sanitizers rely on the counter field reflecting the
> > allocated array size before any array access occurs. However, use
> > mem->cnt both as the allocation size and as the runtime insertion
> > index, causing incorrect indexing and potentially invalid bounds
> > tracking.
> >
> > Initialize mem->cnt to the maximum allocated number of segments
> > immediately after kzalloc_flex(), then use a separate local index
> > variable to track successfully allocated entries. Update mem->cnt to
> > the actual number of initialized elements before returning or entering
> > the cleanup path.
> >
> > Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
> > readability and ensuring only initialized entries are freed.
> >
> > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/mmc/core/mmc_test.c
> > +++ b/drivers/mmc/core/mmc_test.c
> > @@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mmc_te=
st_card *test,
> >
> >  static void mmc_test_free_mem(struct mmc_test_mem *mem)
> >  {
> > +       unsigned int idx;
> > +
> >         if (!mem)
> >                 return;
> > -       while (mem->cnt--)
> > -               __free_pages(mem->arr[mem->cnt].page,
> > -                            mem->arr[mem->cnt].order);
> > +       for (idx =3D 0; idx < mem->cnt; idx++)
>
> for (unsigned int i; ...)?
>
Ok.

> > +               __free_pages(mem->arr[idx].page,
> > +                            mem->arr[idx].order);
> >         kfree(mem);
> >  }
> >
> > @@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsi=
gned long min_sz,
> >         unsigned long page_cnt =3D 0;
> >         unsigned long limit =3D nr_free_buffer_pages() >> 4;
> >         struct mmc_test_mem *mem;
> > +       unsigned int idx =3D 0;
> >
> >         if (max_page_cnt > limit)
> >                 max_page_cnt =3D limit;
> > @@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsi=
gned long min_sz,
> >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> >         if (!mem)
> >                 return NULL;
> > +       mem->cnt =3D max_segs;
> >
> >         while (max_page_cnt) {
> >                 struct page *page;
> > @@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> >                                 goto out_free;
> >                         break;
> >                 }
> > -               mem->arr[mem->cnt].page =3D page;
> > -               mem->arr[mem->cnt].order =3D order;
> > -               mem->cnt +=3D 1;
> > +               mem->arr[idx].page =3D page;
> > +               mem->arr[idx].order =3D order;
> > +               idx +=3D 1;
>
> While looking rather ugly, I think starting with mem->cnt at zero,
> and updating it in each step like
>
>     mem->cnt++;
>     mem->arr[mem->cnt - 1].page =3D page;
>     mem->arr[mem->cnt - 1].order =3D order;
>
> would still be better, as it makes the dependency between mem->cnt and
> the size of mem->arr[] clearer (located closer to each other), and ...
>
>
Ok, I will start with mem->cnt at zero; with this I can drop changes
in mmc_test_free_mem().

Cheers,
Prabhakar

> >                 if (max_page_cnt <=3D (1UL << order))
> >                         break;
> >                 max_page_cnt -=3D 1UL << order;
> >                 page_cnt +=3D 1UL << order;
> > -               if (mem->cnt >=3D max_segs) {
> > +               if (idx >=3D mem->cnt) {
> >                         if (page_cnt < min_page_cnt)
> >                                 goto out_free;
> >                         break;
> >                 }
> >         }
> >
> > +       mem->cnt =3D idx;
> > +
> >         return mem;
> >
> >  out_free:
> > +       mem->cnt =3D idx;
>
> ... as having to set mem->cnt twice looks rather fragile to me.
>
> >         mmc_test_free_mem(mem);
> >         return NULL;
> >  }
>
> Regardless, as the patch looks correct to me:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
