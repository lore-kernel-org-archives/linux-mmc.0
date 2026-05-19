Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852B348C51
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198924; cv=none; b=rEm/YIL7AY4gOIISMyR307TQ1Y5D7O/VAXDOK40uShmiRK08SOHoIHKNlUK3VohOiVFG2NG0oFnZHfu6IpTmg0JHvTYesTqHEavsm4D60sZes4xq+e/zyMuReCCg4Mhdeb8Qmw50qna5uIPtbxJHASxq3U8IuKq/wuwsmoIKmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198924; c=relaxed/simple;
	bh=ropJiXj/HBYvwp5Msa8W8dOE9wVAViMdDjVNcwFpVB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFwWkQxYo1kyztRWgsDziaUDIj5hrWXStp8DCa+304BVuvLgTLFP7/BpZSzGlHyyd5hptWP87MDvMJvT0CM3N7cGJRi5sM0+dzoAwAvZ06KKFWOkuMBR8ogebD1b2tz7U3O2g9WSE5jEVbxL06q90Ryspl3JSIvAfgjmJeV1nbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6312d29596cso2678605137.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198922; x=1779803722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hf4+Ek9YRT6fN0h/tFO9bOB6UgGg8JC36KgrKL0v3M=;
        b=JmKDdK6KcXZzsiPTy9BP1OjO6alncVtRqO93wYw/lP8uaAlPV3M3Uw1dxOajq54z1w
         FgWz62s5rEkoP6NondRU43Tgy5ZFA98RYFqIbeSmwM1kFoX0L56g3ovOXtwcY0fZ0iDK
         1OqnjetKhOV9TpzE1H9Pq9+3Y3Es3AmXwaOVsY638hDhU5st9iVqSt3F+iycxekv5Lyi
         k1lgKZHdRLG1lnSQo4gCSQkNxDdY4u38sTiloqZVv73U2OFjhrnybALLcbcr928DKv4r
         tS+6tnPLs2Ky50J13MCph7hn2reBMu4FNiUqGZ2c5PfaKxtVHQoY+dAu9XL5SycSn07w
         wsFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/71Jix/nymm8FVqvYOsa9jnGv4+ICv4OZYIPxLOao/xyvd/ulJ0h94XzO6BgNJysJcUpB+wrxedVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv1RcJ96L3BrU/VWD5nOWqGYorhiOjN70CNXx4kRUGB3Fs28uv
	PLyKrzRf8ON4bk4766sUeoGWbFAhXBc6HGE2SVWcRWl815/8vTs1DPnyYspwSh1i
X-Gm-Gg: Acq92OE4DihLq+PYaXbiDAD+SBLTgImjFR/blShqJxkhRjQ3pEZWKGHMNYKMaxN2hip
	Y3jLn+Ozx2FUVc/Z1YTgNMTmYyBR6QYqk22njws6zr8EnWL4LcRxPVEKFqVstlRja5Niel/oQ02
	pAwa3Dy9uXVdzIYOfpKw1bNYxzJYmBeHjjAmL117lBFx76zvnjruODsD9UoX7I5elnjKiRyXKhO
	rCcygVDaz4rNXyhgHgcQzIiQsTXIkpq26r8UZgd6i58Dpqw4YIE17RUS+ONhxF2oYMstiWTBLln
	hPDJBSy+QdByaWatpQO1D4Hz5dnOQNvERufqjq7T1fdZc/2yDeyv1ex+P37pae/EZmSe/YdsmTk
	UOiP0nFwKr0Ygk1em36Bb5OWTe/vt1r5pxHsdcyedPQN6LRAkvwXFzGDIinK99/qL3RG0mI1O5H
	EwFqcg22tXVSlPZhV7dmMs7BURBeWajT7NPSLaXSgNhMDHFZOA+bpITYkXMV5JKTdoEpGtfS00H
	qs=
X-Received: by 2002:a05:6102:304d:b0:5ff:e39d:9f93 with SMTP id ada2fe7eead31-63a3d42ebbamr10584148137.11.1779198921684;
        Tue, 19 May 2026 06:55:21 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2f8727bsm6208470241.10.2026.05.19.06.55.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:55:20 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5780c38ecb8so2058820e0c.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 06:55:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/I5uvFa0K7TDGE6lFNCeenXNs/WUZ3vLUQLvfmkCuXLPWvaPXahnNSnEteV3ASwLJrfJgPHHRC/wE=@vger.kernel.org
X-Received: by 2002:a05:6122:4b8c:b0:56c:ca03:b668 with SMTP id
 71dfb90a1353d-5760bfb8ca9mr10883102e0c.3.1779198919511; Tue, 19 May 2026
 06:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com> <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
In-Reply-To: <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 15:55:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
X-Gm-Features: AVHnY4If75BE1VFsoTcZFsczakSSYimGh11UdyDyK4f5gTnPlxJ8oEAkRkMK1OM
Message-ID: <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Tue, 19 May 2026 at 15:44, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel =
panic
> > > during error unwinding.
> > >
> > > The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on =
its
> > > flexible array member `arr`. While kzalloc_flex() initially sets the
> > > counter field (`cnt`) to `max_segs`, the allocation loop needs to tra=
ck
> > > how many elements have actually been populated.
> > >
> > > Previously, leaving `mem->cnt` at `max_segs` meant that if the loop f=
ailed
> > > midway (e.g., "Failed to map sg list"), the error unwinding path in
> > > mmc_test_free_mem() would attempt to clean up uninitialized trailing
> > > array slots. This resulted in passing NULL pointers to __free_pages()=
,
> > > triggering a kernel panic:
> > >
> > >   [   66.172845] mmc0: Failed to map sg list
> > >   [   66.176722] Unable to handle kernel NULL pointer dereference at =
virtual address 0000000000000000
> > >   ...
> > >   [   66.432747] Call trace:
> > >   [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> > >   [   66.439119]  __free_pages+0x14/0x20
> > >   [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> > >
> > > Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> > > allocation. Then, move the existing `mem->cnt` increment so that it o=
ccurs
> > > prior to populating each array slot, using `mem->cnt - 1` for the act=
ual
> > > assignment index. This guarantees that the counter accurately tracks
> > > initialized entries for safe error cleanup, while dynamically expandi=
ng
> > > the `__counted_by` validation boundary ahead of each flexible array w=
rite.
> > >
> > > Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use =
a
> > > standard forward for-loop. This addresses the unsafe post-decrement l=
ogic
> > > in the original `while (mem->cnt--)` loop which evaluated and decreme=
nted
> > > the counter field before indexing the array, and avoids a potential i=
nteger
> > > underflow/wrap-around of the counter field if the cleanup path is inv=
oked
> > > when `mem->cnt` is 0.
> > >
> > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v1->v2:
> > > - Started with cnt =3D 0 and incremented before assignment to ensure
> > >   accurate tracking of initialized entries in mmc_test_alloc_mem().
> > > - In mmc_test_free_mem(), replaced the while loop with a forward for-=
loop to
> > >   safely iterate over initialized entries without risking underflow.
> > > - Updated commit message to clarify the issue and the fix.
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/mmc/core/mmc_test.c
> > > +++ b/drivers/mmc/core/mmc_test.c
> > > @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem=
 *mem)
> > >  {
> > >         if (!mem)
> > >                 return;
> > > -       while (mem->cnt--)
> > > -               __free_pages(mem->arr[mem->cnt].page,
> > > -                            mem->arr[mem->cnt].order);
> > > +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> > > +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> > >         kfree(mem);
> > >  }
> > >
> > > @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(un=
signed long min_sz,
> > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > >         if (!mem)
> > >                 return NULL;
> > > +       mem->cnt =3D 0;
> >
> > This is not needed, as it is set to zero by kzalloc_flex().
> >
> Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> because cnt is annotated with __counted_by. Because of that implicit
> initialization, we need this explicit reset to get it back to zero.

Only when your compiler supports it[1].

OMG...

When I commented on the LWN.net article[2], I considered only the case
where the compiler is too old, and the counter stays at zero when the
user forgets to initialize it explicitly.  Now we have the opposite
case, where we need the counter to stay at zero :-(

[1] https://elixir.bootlin.com/linux/v7.0.9/source/include/linux/compiler_t=
ypes.h#L549
[2] https://lwn.net/Articles/1063295/

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
