Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B561370AEC
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201516; cv=pass; b=Z7xxiFGcdgtaszf0G/4RqV6r/67G7Iy2QThRCgF5mr0oevLSLr3rW983dCGD3AIff7zDCtAfEHSKGjYTjuK2FZ0Y/186IOlklvhD7H4p2hXSIHcbXtG36hIp1XlsIbYHESvCz47SxJWiYk29LA+p/dJ2xTAUEQiQ3ncI1Xpi52c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201516; c=relaxed/simple;
	bh=cj8fMYGGV50JmuPH7dRsygkr0LOScVOWkGLEok5hm1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyObCdjTM6R9qlvBDZYbolnblNRlM1JwYXpLadhqA8F48mFShjRoaqthn9EloNPCrSKPgjKrYiBzkTF+CD5FVUtlX9uo2qvr6G2wVQHdj0+O3t7Fcv5YV7s7T66AKsYhonuC50IsCk5grAZJzO8mjtRuqkgMR1Q+l5Tc6p7KsoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCaHPohZ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCaHPohZ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so3136090f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 07:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779201513; cv=none;
        d=google.com; s=arc-20240605;
        b=i3qgLuNICRNHussHCkNSLitdk1kf4MS3c19pkuurcnq/ejvfy0+rgbsKm1uq4u6p+C
         DwQsRSxg+WHkzwg0J3yCv8lvtPfNj1RwtofMJaDCRW1SPek2I5ESiHJnu2HZPXY0M1Sb
         Qs/K+hzJ2RCilgWs0X36kW772124Y6JsIP6bt39Yg/btxNJ8BViofTTAM8QVC9V9hXRa
         J66wrfXYUzQAbJrf6+WNxkn3NXa5m7AmLPnndWMnmN8xriIBq2zlepRfvY2OlZxm4EWw
         V4Vy4dcvpSQ03srK9b1cg7uYl0Org3EGaFS0qNe0cvBHhDr3mpmzLQPrlmLLXgrm9yzb
         pLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8B0kUihN/kZA4O0Fnbmlk4Xoxc4WIG8UJmCytLrBe7g=;
        fh=bAETrl4rt17GBLq4Jo37gyAcJiFAaIpWsgNZwP7d8Eg=;
        b=OgJB/Ow7Ss4osMWgeunr+An13+ritxwMMljgAIZsK4+jpMgnH+Fyxm9dFkpjx54WLu
         7WXL8oC018WyCxUn5tya7+W7vBJWCh/Prc/UoNhMdupViJU9h1juZUpfx2RneOzesuC+
         S9KLJpJc/IpbgWDHRV8pDqhzGndiYKpqeXXbfcl81eG7kMQ9jvUgT5iK2TDqTgWeR2g+
         HTqNCLI13pwhQGWU+XiNNKnckXUPY50S8hh5sjNgU8PMoAoud5XperYqlA82yjhW0sMw
         el/TBzwiciTqI8Ampjf1GUqjNSI2tw256GHiRIzNpfwD68LAvRwQnZ9Cs1D/2LDUKnry
         cdfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779201513; x=1779806313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B0kUihN/kZA4O0Fnbmlk4Xoxc4WIG8UJmCytLrBe7g=;
        b=NCaHPohZtYO/I58mVjHwW7twI6RUFQE4eNDYKyYezif9e7RdL8dQZq7BaQmz7XS/pC
         fNbXv8qhD1fFrFbMQwKnEn5HSjcR2liwTnnDxbEJrA7ypSldP+qVQGekw3Zky38fb3K4
         tQtiRolB+milGEmLfhOKvDL37UPxm9vboI5OqLIbsuVY9+bZ8/h5iTHRRqxlPF1FuMvV
         cxksloucOHcb2NKODfRraRJRh/PT5iqLq+sTHe19j5mq7GMath1hFT2R10lx0CaZXuVM
         9aZ7An2HgnpKjaIIVo47bnIpSjWlH7T5KfDCGGsmiOu081YD7TNMaeedE+fmNlp2DBf+
         engg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201513; x=1779806313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8B0kUihN/kZA4O0Fnbmlk4Xoxc4WIG8UJmCytLrBe7g=;
        b=ZP0riITlJxKihZ43xkN/9MCOEh9Dto3yuL1BmnASH35Zl3kTfnX7oV4L87ERTp5SJw
         /B7Bt7HxiD7Fzi0r5NP6vPJEXCTy9/Hr6rrCGBa0Lb/0WYMWbYEe7k2RUgfieief1GyU
         C4pt8bee/UCC8IBeaVfGPFuz2AA05lBaZHeMhUatWkouO+LLr+EFJcq6H3v8nLrjFs2X
         T5F4uqndhGNnReADca56jm0gjw3S3mZqgmwkcDrTN04QM/GUQvMrovBuxfQ685fMyulR
         /mqEa2UMIGs/0u4oHqEsDgcBNVs69GahbHtYkmvdAklxN7JLGeBOxlQxqRzBIo87VlEf
         HWqw==
X-Forwarded-Encrypted: i=1; AFNElJ8qXv6VyfK9bQsU1Ea2AtJHq6C7ljKlb21T9zuBnNs0m1hoG3CG1i5Ym6GMF45eS3K1LoK6MM+8Sbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuP2hqflcjtrBSN9NNCnpH5rSIIeOVwNMzr5e2OECzeXoBReVN
	Gl+zXkrFlNG4ERwjROfh1tsHkVcZh2tYBZAVA9x6DSMZNRW3LVMamrRHoqGvp0uwvOvdZvQCpez
	Q2As2IR0Hoa5Gou3E+cnmJaLasrGJdVI=
X-Gm-Gg: Acq92OEKs4EJ/a0rIeaALK9VntA2HPhfANQ7Qo07ph0OQfYv5/ra6OcCZh8lSxnWsnG
	TwQRS/6wnx+bXyHW3+3+xFs6OBpPHan2yDEjPbaXbna1lGJazicSZNlsWyg7twk1G4Fjwhm3RwS
	y3G6DYCI6S0HzERRoVHpt+tzyEiI5H7nXmbrRsJH9NnM704h/NkLJnmgZaf477aNuL4q2ZHrKWc
	HDYYuE5seAVBqwrCavXoGlBDWmk7+isE7ASMWc0WZRH3xKT5OmCrMzzZdql0aZiNvxXgrrPC0zW
	TRzI629PR8FWTvDxA9fWu8I6IqH+7DBDZ90WIkL2XEkgpy+lZfusZVNbE10lyqsvrQuH
X-Received: by 2002:a5d:64c6:0:b0:43d:210:2b2d with SMTP id
 ffacd0b85a97d-45d958e057cmr39062509f8f.31.1779201513379; Tue, 19 May 2026
 07:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
 <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com> <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
In-Reply-To: <CAMuHMdWZGv6BwjGwRhU+x8iE2pXtOSz21RG64bsNoPQQCjTVjg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 15:38:06 +0100
X-Gm-Features: AVHnY4KUmVmbQaA9sHRIcWj7rBu76G43r-b8iP8pGkSNUit944VTI5cgfQcFjvU
Message-ID: <CA+V-a8ujJ5AL8S6DABmZjmJbXMQ=umPDCZZfXsgyuj-9mTt3GA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
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

On Tue, May 19, 2026 at 2:55=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 19 May 2026 at 15:44, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Fix an counter tracking in mmc_test_alloc_mem() that causes a kerne=
l panic
> > > > during error unwinding.
> > > >
> > > > The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation o=
n its
> > > > flexible array member `arr`. While kzalloc_flex() initially sets th=
e
> > > > counter field (`cnt`) to `max_segs`, the allocation loop needs to t=
rack
> > > > how many elements have actually been populated.
> > > >
> > > > Previously, leaving `mem->cnt` at `max_segs` meant that if the loop=
 failed
> > > > midway (e.g., "Failed to map sg list"), the error unwinding path in
> > > > mmc_test_free_mem() would attempt to clean up uninitialized trailin=
g
> > > > array slots. This resulted in passing NULL pointers to __free_pages=
(),
> > > > triggering a kernel panic:
> > > >
> > > >   [   66.172845] mmc0: Failed to map sg list
> > > >   [   66.176722] Unable to handle kernel NULL pointer dereference a=
t virtual address 0000000000000000
> > > >   ...
> > > >   [   66.432747] Call trace:
> > > >   [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> > > >   [   66.439119]  __free_pages+0x14/0x20
> > > >   [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> > > >
> > > > Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> > > > allocation. Then, move the existing `mem->cnt` increment so that it=
 occurs
> > > > prior to populating each array slot, using `mem->cnt - 1` for the a=
ctual
> > > > assignment index. This guarantees that the counter accurately track=
s
> > > > initialized entries for safe error cleanup, while dynamically expan=
ding
> > > > the `__counted_by` validation boundary ahead of each flexible array=
 write.
> > > >
> > > > Additionally, rewrite the cleanup loop in mmc_test_free_mem() to us=
e a
> > > > standard forward for-loop. This addresses the unsafe post-decrement=
 logic
> > > > in the original `while (mem->cnt--)` loop which evaluated and decre=
mented
> > > > the counter field before indexing the array, and avoids a potential=
 integer
> > > > underflow/wrap-around of the counter field if the cleanup path is i=
nvoked
> > > > when `mem->cnt` is 0.
> > > >
> > > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > v1->v2:
> > > > - Started with cnt =3D 0 and incremented before assignment to ensur=
e
> > > >   accurate tracking of initialized entries in mmc_test_alloc_mem().
> > > > - In mmc_test_free_mem(), replaced the while loop with a forward fo=
r-loop to
> > > >   safely iterate over initialized entries without risking underflow=
.
> > > > - Updated commit message to clarify the issue and the fix.
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/mmc/core/mmc_test.c
> > > > +++ b/drivers/mmc/core/mmc_test.c
> > > > @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_m=
em *mem)
> > > >  {
> > > >         if (!mem)
> > > >                 return;
> > > > -       while (mem->cnt--)
> > > > -               __free_pages(mem->arr[mem->cnt].page,
> > > > -                            mem->arr[mem->cnt].order);
> > > > +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> > > > +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> > > >         kfree(mem);
> > > >  }
> > > >
> > > > @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > > >         if (!mem)
> > > >                 return NULL;
> > > > +       mem->cnt =3D 0;
> > >
> > > This is not needed, as it is set to zero by kzalloc_flex().
> > >
> > Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> > because cnt is annotated with __counted_by. Because of that implicit
> > initialization, we need this explicit reset to get it back to zero.
>
> Only when your compiler supports it[1].
>
> OMG...
>
> When I commented on the LWN.net article[2], I considered only the case
> where the compiler is too old, and the counter stays at zero when the
> user forgets to initialize it explicitly.  Now we have the opposite
> case, where we need the counter to stay at zero :-(
>
Yeah, it definitely introduces some tricky, asymmetrical behavior
depending on the toolchain.

Cheers,
Prabhakar

> [1] https://elixir.bootlin.com/linux/v7.0.9/source/include/linux/compiler=
_types.h#L549
> [2] https://lwn.net/Articles/1063295/
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
