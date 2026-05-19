Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5410481ABE
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185345; cv=none; b=CnTsyErZDFf50FVg3MZWFjdGwnO8qXaNjYAGUDecv0fGFZ10FolfCTP/RP4u8jGZ1meejZlolCxyIpYzsDTbTZSd1Dv9z2KDknQJuSUVXP/W9rs6JCcg05XBn818XlylZdLsEGxctS2smAcJq8yoAHwV+WVWe46N2Lr3fKySD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185345; c=relaxed/simple;
	bh=d5wqftF63M6yklv3zeLt4GQqpDKoy4cN11UgWv71+J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMq0UsubI+Zc+luHCeVnlfTJGDc6Zci+md6yaP4QhXUkqDgi31U4nxcDDrOTvBMN6PTm2HgZ+jjdHUtY92rLl1uUhiNRpD9uwVxH60f9uSsm3QboIKOFduisYXLhfFxczI+kFpyLUqumBeC9lwPX0sSTttH9XGTuWDUIpUX+aBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56f70865797so2103398e0c.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 03:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185343; x=1779790143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxuVldO4eyfcDOsGEwUBhaeFLVJjGaNmFshsGT684kc=;
        b=CQ9CW7Tcfa+FeP3ThPmfX6MGDuAHyf3uqncJKx5FxKafGENFn1Ur2NDATHzi0lxiG/
         H/Tli2F4o/qs66em+oNXQo0HpQAEpKjM2KR33rJ53M4DAgHvetsdMIo7QFeNJINaew5u
         iv8oRO57iHd9v4PMTf3G6woYJ09NnYrnsqyKpWd7qFLjh1qwbgMPg5XpqVsNK+4foKZG
         svAF4KmbvuIw+s4sbktibInss+YA/pdhf82S+eqXn80bLpWvHwJFye7DLf354wYfzoZd
         JxwKsefnjY8tAh4CUTLFePB8/q4zMAH2Gp333k1W02zSs+yPLSfTX+c4k74UInO+Pi73
         GcWA==
X-Forwarded-Encrypted: i=1; AFNElJ+NxsYYGrI5mvL258y3WP7DoI2fXE7uLZBxKeLmd0QRvq+10p34hJo3Y3FBNacMf3aV4QcWLssH3FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwsyK2QlgvpjfZea4L/Qd7vtDqqu+RYSVQHgQUKXKfFdP9MEe
	5mh5eoW44ac8xPiQXJAF1+ghgg7zuY6ogeQyyXTJF2CJAwRXeRvH2ptuFvZFRhKn
X-Gm-Gg: Acq92OE50igXQIldyhsgWnRbZxi7eOEmbYLtu+fT1PN2WrjCqYvSwr30R+gxngVhlQj
	st9VOwlD5hNoDl9Lm36YKYU6KUI5RDkbC8nYmnFdTP1YOSWLbqxcSC8wHJZW0NgIa8QNOhEO+sO
	1ULkFajOuHK5va02cWnvfMBEUg/IcSkOqOs+9OONEXZ0MMkcYMZ1M1Ug4Ld8Rdg+KkktGdDJAr3
	FOWtgexNsdquqhI2PpYBPRWvGNt20xXBFIt3pBITS6/ligyjkYskHgzG5fQVE97lLy9yI/Alire
	NA7v4MoxJTd+bRW/6iivAbbe6Qz5Gidci2MIMG0HNaM6ABH0gRYCuQk3jBp7mMhfNnaUDJLc9cR
	S7RzXL681N81/uHZ6AqGNsCHMXdcQMQj0WD0F4cvKwyKUU63I+pqgWMdivOoTsQX6CnVLDfbz+E
	mOYjJn09tp27kCXcYHk7m02+EiTs2kXPzZ+O8HUI6gBBcR+BA1Puiiet/hDEywhYlcBAOUHAk=
X-Received: by 2002:a05:6122:8482:b0:577:48e1:8aff with SMTP id 71dfb90a1353d-57748e1c34dmr4207491e0c.11.1779185342568;
        Tue, 19 May 2026 03:09:02 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f5e5759sm7659034e0c.7.2026.05.19.03.08.59
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:08:59 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9568159ee07so2338772241.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 03:08:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Co1vrY0Ed9XNsza5on3Yv+/2lW5XZLn2JUNl35z8AU2lk15Z/xYaONkGeKiksCn6+jE2ha24Awrk=@vger.kernel.org
X-Received: by 2002:a05:6102:854d:10b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-65094c2070fmr3495426137.4.1779185339284; Tue, 19 May 2026
 03:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com> <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com>
In-Reply-To: <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 12:08:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
X-Gm-Features: AVHnY4KXSTDQjh_29RoOYl4VnSgomB8DY9x_PMa5sxwN-vFAI033A9vKOGLVEQ8
Message-ID: <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Tue, 19 May 2026 at 12:05, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Mon, May 18, 2026 at 12:08=E2=80=AFPM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, 13 May 2026 at 22:13, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Fix logic issues introduced by the kzalloc_flex() conversion in
> > > mmc_test_alloc_mem() due to interaction with the __counted_by
> > > annotation on the flexible array.
> > >
> > > Bounds-checking sanitizers rely on the counter field reflecting the
> > > allocated array size before any array access occurs. However, use
> > > mem->cnt both as the allocation size and as the runtime insertion
> > > index, causing incorrect indexing and potentially invalid bounds
> > > tracking.
> > >
> > > Initialize mem->cnt to the maximum allocated number of segments
> > > immediately after kzalloc_flex(), then use a separate local index
> > > variable to track successfully allocated entries. Update mem->cnt to
> > > the actual number of initialized elements before returning or enterin=
g
> > > the cleanup path.
> > >
> > > Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
> > > readability and ensuring only initialized entries are freed.
> > >
> > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>

> > > --- a/drivers/mmc/core/mmc_test.c
> > > +++ b/drivers/mmc/core/mmc_test.c
> > > @@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mmc_=
test_card *test,
> > >
> > >  static void mmc_test_free_mem(struct mmc_test_mem *mem)
> > >  {
> > > +       unsigned int idx;
> > > +
> > >         if (!mem)
> > >                 return;
> > > -       while (mem->cnt--)
> > > -               __free_pages(mem->arr[mem->cnt].page,
> > > -                            mem->arr[mem->cnt].order);
> > > +       for (idx =3D 0; idx < mem->cnt; idx++)
> >
> > for (unsigned int i; ...)?
> >
> Ok.
>
> > > +               __free_pages(mem->arr[idx].page,
> > > +                            mem->arr[idx].order);
> > >         kfree(mem);
> > >  }
> > >
> > > @@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> > >         unsigned long page_cnt =3D 0;
> > >         unsigned long limit =3D nr_free_buffer_pages() >> 4;
> > >         struct mmc_test_mem *mem;
> > > +       unsigned int idx =3D 0;
> > >
> > >         if (max_page_cnt > limit)
> > >                 max_page_cnt =3D limit;
> > > @@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > >         if (!mem)
> > >                 return NULL;
> > > +       mem->cnt =3D max_segs;
> > >
> > >         while (max_page_cnt) {
> > >                 struct page *page;
> > > @@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > >                                 goto out_free;
> > >                         break;
> > >                 }
> > > -               mem->arr[mem->cnt].page =3D page;
> > > -               mem->arr[mem->cnt].order =3D order;
> > > -               mem->cnt +=3D 1;
> > > +               mem->arr[idx].page =3D page;
> > > +               mem->arr[idx].order =3D order;
> > > +               idx +=3D 1;
> >
> > While looking rather ugly, I think starting with mem->cnt at zero,
> > and updating it in each step like
> >
> >     mem->cnt++;
> >     mem->arr[mem->cnt - 1].page =3D page;
> >     mem->arr[mem->cnt - 1].order =3D order;
> >
> > would still be better, as it makes the dependency between mem->cnt and
> > the size of mem->arr[] clearer (located closer to each other), and ...
> >
> >
> Ok, I will start with mem->cnt at zero; with this I can drop changes
> in mmc_test_free_mem().

I don't think you can drop these changes, as mmc_test_free_mem()
does mem->cnt-- _before_ accessing mem->arr[mem->cnt].

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
