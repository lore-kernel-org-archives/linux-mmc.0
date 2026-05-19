Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E04DBD83
	for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194953; cv=pass; b=GPv7W0L1XlKRHoE6hHdK2ZrJI8ML45OUx0eYaDCfdyowuMAWShvQuf+lFAMeXeCUjuGEQP6PAQPRXgfsxChY9R0rDwPDn9TeOcQ42yB0AWrJB1ddPQuKvP8HyPzqoiNthyr3Yz6R7YTmP7MzUqDfxi45ndcNLJ7zVXlRJCRqRp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194953; c=relaxed/simple;
	bh=z5bbYmTfV3f1fUZkdMtjKau2veIkDy6z1gsrRWGyj8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mey5Xc0YmfLa0svMMoV+nbefFu9U6jBx8r42ey1/BAj7FmmwCPA25YJ2YVjdWHt1Dc+2xKCMdaJIUBtvNtl3DUcT5h7TfW6bdW1SRZSVLVx714wE7t9pmlQXQp968kx9JK8cuTl45KPIh8KVTIiUDJjOdQwjY2Mvnu8ox6jqSf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4OLNhkS; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4OLNhkS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so778115f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2026 05:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194950; cv=none;
        d=google.com; s=arc-20240605;
        b=KXv378/HZzlAaQ36b+i52QD/5XqYLLBlpMkn7R1KCSYmkC1hlIFlUh/l1x9zSXUnax
         T7Fer4pd7X7dRcpwNxZalOkt0/5rL7H25aWDofjYSTR2YcM+qFi2KRJ57aL2noaqinnr
         ykteEBnA8we1A8R8YYFTM9AgBeIKpbo1CJj8+eBnexZFhdZY5ffdxcLIb5W1JmBPGVYj
         Ody4A4P79F0SxNv4fmkLm1JGIzLQx4qAxFbOsSkL4DM3ynYo1JJ5+ouwKbIMkw5Vda9w
         NdEFl/QH+1o0g+joL7jhGeLIrL7hhKB6Et37Jkplsn5U+S3CuiuZXAiGDP3884DYsFii
         c5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gxnCZT3YkTibvlG6nqfkBDd0n82IagINu/+G6406bZ8=;
        fh=ddxXnoIvuKExGlAaG6Tbjal9uN5K1aU6HmglNQ5Nj6s=;
        b=BM0vW+6JhtmaBKfnzVUYRiN1G+wSHPwxa/XEGt1rZtADvM4cYgHljG4Js/HqI0tSv3
         PjQBHn+axDLIvo3SOVCzx5qv3hnuCl42JONDbuJ4FR7KSxbxLuKQCc/MpjaTJrAX4kLo
         pK5H8HwUTYvlxJ+T9i/8Qvz+L7E1uFqM7d7ox/xo2rWF1t6x6TZPc4ZJTkBfm1u3Hp4z
         qyi0pEfhWAj7ySsotqJddBtJnRFmNLKpu5gKHVQuGONWVWD54+FWNhbadXY4oQFUoz6N
         AIwL0n54DRWX8NCkL02kfBVVC3TF/s9BBQ7siUqNR6V0xYbRZdl2z4cxnIQlhmVxC9q4
         f/Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194950; x=1779799750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxnCZT3YkTibvlG6nqfkBDd0n82IagINu/+G6406bZ8=;
        b=g4OLNhkS8VablrP1HElVY7Q/0N0Y+TcJ74gDDNB7zG9gYb1ehYT9sIU+KZ7a5M9bX4
         wCoE3/1cJCBkYYGS0NtGXqM30ShwsML9Ot1uPlF6oWSJBvFIEkkvkbO4ypoxzK3k/V8i
         4QneTYESYwotGCD10AQ6Zt56S7RVAmscKXitKaPlFw3dkx/R2WWRaVi1RXLfcZ3itc5R
         DS6/J/mj7ojC3nQda0sSeH17LR9uUgVkR1gr0dcCMt4NG29dDwiag3MWuo19povkzUwZ
         pdPCbdF2OcoW0hMg8YjRNfISBGN8xAdXrteJesITVcpvw0hg0YFD17d3c85HnmBVezam
         UWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194950; x=1779799750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxnCZT3YkTibvlG6nqfkBDd0n82IagINu/+G6406bZ8=;
        b=jqwvV01COjPCdlTwX9kpuFCkhqah/f2UFAmTeP+NiUAM8rqWe/kEmJRR2KdOFfGuI8
         d1L4DZjr7nWfElif5Bvf9jv3B/HdNtF6bt6i13RjOuwvcYJon0obw3J45ahqPXT3lkj1
         ywtWb5Pmp7WlyRuTmTyCqP0lmg1mWrmUZ7UoySoU8MhW5bT8+6E12zjQuFy5gLXMXyBa
         jeqR86yvqSur0cIcXSdH9TFSokdowOg9wcA+c1CYtVzfNYdt3X5+cqstp9i/DntP/sy2
         EaaWTvZ2Xbmbr15o1U19kp8RYtp6krZlHJ74ZEgHezTaVqPb9Z9jaO2jh9dB4vQxPjSc
         vEBg==
X-Forwarded-Encrypted: i=1; AFNElJ9vgNfOPlyM6WmZEITitS8he47x9EXPiRzg23Vzd7+ZLW+tiFgcvssL9Dy8vGfy+KShp4zE2H3aBPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhldTI8nZaJZw9i4ndTbEoNE6SUFFP3enwC5KVj7EvhZvF8ph/
	KLNRto4bpfGKKIY59f+U1EDi+SAV1JE14uCnXzFO+8Uz+wFBBNC3rUVtJLA0Dri9HC2WjWKy7Ep
	e7CEVo8qtkj72qeki3t5oeEyFldhkkFE=
X-Gm-Gg: Acq92OE2JWBh8B+NTm5nqV1WbtSCKiFyrimoUIhim46ZfWjZNaBSASEBbClmxEJB0U8
	96G1O1tEo1gjHH0T/PAujvk/N7FbtAo1wLBypCw+YeCa8FZjm1z6DwY+GgO8xWvc31ALwpMhRPa
	k2qRSOYGC2lCTLZ8TmWgvqJmA/v+fvGgU3BcaZZ+0Y0dHHwFhoDVy64mlACONrIkt7SEdjRdZOJ
	wc8lN3+pX/jmsqEmPT+Gnub3y1rYdfotm1ucE5R1rOsarhpyOH7M47KgMcrpGZ6CwfIL8FiXUrn
	0Kc3cM19pYu75/q0VLeEKgMKtUaEW4eLSzeDTsOfcRC+2xZzdCZg/xAZLB+v3FdzVk4j
X-Received: by 2002:a5d:5d10:0:b0:44e:1984:5f3e with SMTP id
 ffacd0b85a97d-45e5c5951f9mr30114071f8f.31.1779194950039; Tue, 19 May 2026
 05:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV0BybWdKsPgB5TGg61U+E5u71Fu5KgXpj1sUuq-QcRQA@mail.gmail.com>
 <CA+V-a8t5NZP5QamrdH2-ViMcShcYh3czLsZ+0kkD_kjUodjTyw@mail.gmail.com> <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
In-Reply-To: <CAMuHMdUZkD0VTdSc4VChuaLvEAZ1j=5_69u8Ef0tO+dwMi6JDw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 May 2026 13:48:43 +0100
X-Gm-Features: AVHnY4I4917oez7RJMmKkLZjNlvjOWucXuN2H1DDq2uw9OwQGkIDoCLJP4CbJH0
Message-ID: <CA+V-a8uT+dkhKL7vAdFqAEX409keehC7RPOhKBTsL_dtEzMK_w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: Fix __counted_by handling after
 kzalloc_flex() conversion
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, May 19, 2026 at 11:09=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 19 May 2026 at 12:05, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Mon, May 18, 2026 at 12:08=E2=80=AFPM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 13 May 2026 at 22:13, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Fix logic issues introduced by the kzalloc_flex() conversion in
> > > > mmc_test_alloc_mem() due to interaction with the __counted_by
> > > > annotation on the flexible array.
> > > >
> > > > Bounds-checking sanitizers rely on the counter field reflecting the
> > > > allocated array size before any array access occurs. However, use
> > > > mem->cnt both as the allocation size and as the runtime insertion
> > > > index, causing incorrect indexing and potentially invalid bounds
> > > > tracking.
> > > >
> > > > Initialize mem->cnt to the maximum allocated number of segments
> > > > immediately after kzalloc_flex(), then use a separate local index
> > > > variable to track successfully allocated entries. Update mem->cnt t=
o
> > > > the actual number of initialized elements before returning or enter=
ing
> > > > the cleanup path.
> > > >
> > > > Also rewrite mmc_test_free_mem() to use a forward for-loop, improvi=
ng
> > > > readability and ensuring only initialized entries are freed.
> > > >
> > > > Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
>
> > > > --- a/drivers/mmc/core/mmc_test.c
> > > > +++ b/drivers/mmc/core/mmc_test.c
> > > > @@ -316,11 +316,13 @@ static int mmc_test_buffer_transfer(struct mm=
c_test_card *test,
> > > >
> > > >  static void mmc_test_free_mem(struct mmc_test_mem *mem)
> > > >  {
> > > > +       unsigned int idx;
> > > > +
> > > >         if (!mem)
> > > >                 return;
> > > > -       while (mem->cnt--)
> > > > -               __free_pages(mem->arr[mem->cnt].page,
> > > > -                            mem->arr[mem->cnt].order);
> > > > +       for (idx =3D 0; idx < mem->cnt; idx++)
> > >
> > > for (unsigned int i; ...)?
> > >
> > Ok.
> >
> > > > +               __free_pages(mem->arr[idx].page,
> > > > +                            mem->arr[idx].order);
> > > >         kfree(mem);
> > > >  }
> > > >
> > > > @@ -341,6 +343,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > > >         unsigned long page_cnt =3D 0;
> > > >         unsigned long limit =3D nr_free_buffer_pages() >> 4;
> > > >         struct mmc_test_mem *mem;
> > > > +       unsigned int idx =3D 0;
> > > >
> > > >         if (max_page_cnt > limit)
> > > >                 max_page_cnt =3D limit;
> > > > @@ -356,6 +359,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > > >         mem =3D kzalloc_flex(*mem, arr, max_segs);
> > > >         if (!mem)
> > > >                 return NULL;
> > > > +       mem->cnt =3D max_segs;
> > > >
> > > >         while (max_page_cnt) {
> > > >                 struct page *page;
> > > > @@ -375,23 +379,26 @@ static struct mmc_test_mem *mmc_test_alloc_me=
m(unsigned long min_sz,
> > > >                                 goto out_free;
> > > >                         break;
> > > >                 }
> > > > -               mem->arr[mem->cnt].page =3D page;
> > > > -               mem->arr[mem->cnt].order =3D order;
> > > > -               mem->cnt +=3D 1;
> > > > +               mem->arr[idx].page =3D page;
> > > > +               mem->arr[idx].order =3D order;
> > > > +               idx +=3D 1;
> > >
> > > While looking rather ugly, I think starting with mem->cnt at zero,
> > > and updating it in each step like
> > >
> > >     mem->cnt++;
> > >     mem->arr[mem->cnt - 1].page =3D page;
> > >     mem->arr[mem->cnt - 1].order =3D order;
> > >
> > > would still be better, as it makes the dependency between mem->cnt an=
d
> > > the size of mem->arr[] clearer (located closer to each other), and ..=
.
> > >
> > >
> > Ok, I will start with mem->cnt at zero; with this I can drop changes
> > in mmc_test_free_mem().
>
> I don't think you can drop these changes, as mmc_test_free_mem()
> does mem->cnt-- _before_ accessing mem->arr[mem->cnt].
>
Ack.

Cheers,
Prabhakar
