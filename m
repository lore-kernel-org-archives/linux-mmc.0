Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D438F259
	for <linux-mmc@vger.kernel.org>; Tue, 26 May 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812700; cv=pass; b=Mpeu3F5dwjIJsvFL+9lqY0WzEOzxyE70mzm31RULenR+n/2Md7+iVRqa3lYOOXgpqkXsYLJlrL03If8okwm4YISys7ZKJxMVQxA6F7NNAbn2EZg4PR08lWGYbeNIVPt2c8LFG/Osi+QLCkxG00YlQXXn4yEk5Sa5cYePqCXdyjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812700; c=relaxed/simple;
	bh=wqD3bt6Kl6xYQ2OceSau18FGXwySTFWbI4PmzPjOUUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKYkIzGaSWfYCrwKNHaoEcEdOy0HoWDlvmOeSkVyKBJcmGTMx//a7qVim2K2MHuViVa/PWo67PXKR3moLHSrW8/TSXXfPv3/dJvLEJdOwwE9VhY4mO9RFKMYJsBJZ9pfuDEk730XyFyVLRLBKZHgFcNacSz40G/BD7AIJ05aNvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQR473VU; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQR473VU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45297094718so8357850f8f.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 May 2026 09:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779812697; cv=none;
        d=google.com; s=arc-20240605;
        b=ar4udGdBXopmsUoxpAEuS9WscKhm379SwoWgFdWzmXzpSKN/iWsgYfFCwtL6nlmyRZ
         UBpDOUTnbYewEIC6LghsD7nrfRZUGWkp4oOF7GeO4HOKvZr858SBm+WS/Rtkjv9YxZVO
         ljPv7Fs9tf1qgNM3IXI9UfuucM86fBgAtZo9/c6kQ7lEJoWYVjW1y6RG1GdhZf+f4oXs
         oktwkSpsVB44UZFgLI+Tdy21Gzzv8gXC8C6lgFldnCkUZe6X9AZe77aRQRe8GtuUN1gK
         YAEoK11ED//Rmik6t5EQLXAnjg4/nPNbwkaXc2QKCGyV3iqVdkJLo/4isafbn3rsYHs9
         Ig/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4oammD2Vn2GS7tgFaMZOeQPZHe3j9rfMWe0E1YbLoz8=;
        fh=zhlhsWwVmTbD7orvrkQwLXH9KwtP1J4/Xe/y5xyDuWc=;
        b=ChJ/W4Cwu6QKaVdDNcYKTlStXAONVcy3pN9eNGZkS7xfuqYL/dnQIxXc7psKQdWQFv
         TZOc1lLxYVSiJk1EM9nnBE0qcAhdJdTR+Vvc7DrftOGBA0e0FnOSj5gPA0Euhynn0fJA
         gxOadnoGCr6v7c7n4Vz7Wx/yfg70UErceMw3Ya+ReugrSkquM917tKsTJiyCs8ZUFxmm
         uhskx7dAjBEKj68XmabaXLrZNvKcOgfi+1XNn7O6ktcqiX/9Fg7Bb03hcYPMekm5/q8a
         JHiiNZBhKaA6fhla27IV0Sumy5NEVYNp3JPjeLyHOkHWhS4uJM4AUhXNQBlEAxS6FSw0
         50QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779812697; x=1780417497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oammD2Vn2GS7tgFaMZOeQPZHe3j9rfMWe0E1YbLoz8=;
        b=PQR473VU+k2XTlDUwROgrUZIB1W0/ryGF9IkahAIVNFOEnc7PjIe/krRmrHFyNc1O6
         mnMjEvuF04PmtjfdCImJMk8gT8iUYJAq/kq/W2B/SZkRgPHO0c1ABjfqSXuu5oL+Qb9F
         xHG6D59WEd+NQ+R6f3THzkKx+B5f1xMDyj4jlj250lr1fATmFAwnEoOl2TADiZjjD6Y3
         TF1EQITDgVHILbsMlSyfZBowjvIpODweDZfpOrpNzeKf/XX42zCYJ/J7MiMonlOny5lW
         rHon1tkVoazKkFuho1vh4H04njZfdp3WlfVm2wPOGAiPLCe5eWQOlRRdj3bpmtyYiqfR
         LcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779812697; x=1780417497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oammD2Vn2GS7tgFaMZOeQPZHe3j9rfMWe0E1YbLoz8=;
        b=MOBKL28QQrVvsU9pdMikl5RmuKAbANqYFwysbMuE5kMGLAPE6WESfDCGgpLXrvj84M
         xzZmxaJO9EyTDjXs9gKR0LKHzVQ7ohqj32XdDmVHfRr9todxgfXOYMX3lDQmr6Z78CTp
         jnXhvUEmUfVv+xHsipIhYUzjy+kjxUcLSMw/M+OiKtzcOVwqone5JURn5pwxpeE2DCBz
         /Hsh8zAPyjCE2Gy0ZqE7B8ly9QpH5qg8jjQVY4K6OBNCoP+HZaUnC4H8mjYGE+5mp5xX
         gH9d+mEiMqb839uXqNMcubKulK63tBxeXCbGnXZSnBSs5ezzGUFRQ6Nozy2mfWeniCDG
         3kTA==
X-Forwarded-Encrypted: i=1; AFNElJ+kKiXZMY+TueAtrmtU2v1bVe2utw42nQ3UnftOj31Oz8kGar9LsxpjYg7mnMnwDAMTQaEHwGIYfds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cNbXzTgezhpUAr7Cmc/2weMQfj/GSkb7YRoGsn3havDJplyL
	4KsRlLD2RF9MixpHCtn8onPdaJLDFZyofYvsJBP4/lG8neuR3WMxXZLShrfhFReodTRaHiRq/1m
	1AVSkbfCfzgd9OZwkQfrCve0UIj2/IeQ=
X-Gm-Gg: Acq92OH88n7QpakZ2Z37vSBcckC4tP5juGmNjcl9eCIEzRdx2S25vUB/SlJIVzioegt
	bYBEVIne/mCntvBWKVCEajujuBo4eXDaK95Dq06DvaOljvGXCpNsJAHM9FCr0ClHYRiGl9TqQZd
	7MuzAYyZ7KLULqHoHPI1GzMXB39xrS/iu1s92ahlQGTTMPgSGfI95aG6oYV5VcrPgDivtRNR6/O
	j9Mc7Vct2n+9PY4uayhKg+tQACRZUHpmOL4YtGf4cHm4k3IaxN1M41djLcljVE11zBkCHC9P5Wp
	++fFbx3w879a/2ZmXAC2xIq2U6Sv1D60LsWxP9Hi/wb1BbiQ/cw483UwuO2nRLtlaEg=
X-Received: by 2002:a5d:64e4:0:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-45eb38c19b5mr33050060f8f.30.1779812696769; Tue, 26 May 2026
 09:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVKOdzThVMOcQ1K9crUkyDutvuZsP2-5v5++SVFHkgtOA@mail.gmail.com>
 <CA+V-a8sFNjp9euEEfBf3BoscjU8W3isRT_pnzd7J4QsuiN6qfg@mail.gmail.com>
 <18c41409-e1d1-4877-87a6-1c3156f943aa@embeddedor.com> <CAMuHMdVznvSLr+ap3QwawZdu8fc4dZjpkWi7wgUA815KRfCgEQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVznvSLr+ap3QwawZdu8fc4dZjpkWi7wgUA815KRfCgEQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 26 May 2026 17:24:30 +0100
X-Gm-Features: AVHnY4K6-krW10j45FFrHmg7LOI21ztwu2LQ8TKbK1nF96GjbpuuFdl7Xhmc4k4
Message-ID: <CA+V-a8szZoKSb1SszB_0pGW+jU+8mUVJrL-uiTZ844DQ=ZB9qg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Wed, May 20, 2026 at 8:41=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Gustavo,
>
> On Tue, 19 May 2026 at 20:44, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > On 5/19/26 07:44, Lad, Prabhakar wrote:
> > > On Tue, May 19, 2026 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > >> On Tue, 19 May 2026 at 15:30, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>>
> > >>> Fix an counter tracking in mmc_test_alloc_mem() that causes a kerne=
l panic
> > >>> during error unwinding.
> > >>>
> > >>> The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation o=
n its
> > >>> flexible array member `arr`. While kzalloc_flex() initially sets th=
e
> > >>> counter field (`cnt`) to `max_segs`, the allocation loop needs to t=
rack
> > >>> how many elements have actually been populated.
> > >>>
> > >>> Previously, leaving `mem->cnt` at `max_segs` meant that if the loop=
 failed
> > >>> midway (e.g., "Failed to map sg list"), the error unwinding path in
> > >>> mmc_test_free_mem() would attempt to clean up uninitialized trailin=
g
> > >>> array slots. This resulted in passing NULL pointers to __free_pages=
(),
> > >>> triggering a kernel panic:
> > >>>
> > >>>    [   66.172845] mmc0: Failed to map sg list
> > >>>    [   66.176722] Unable to handle kernel NULL pointer dereference =
at virtual address 0000000000000000
> > >>>    ...
> > >>>    [   66.432747] Call trace:
> > >>>    [   66.435191]  ___free_pages+0x1c/0xc4 (P)
> > >>>    [   66.439119]  __free_pages+0x14/0x20
> > >>>    [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]
> > >>>
> > >>> Fix this by explicitly resetting `mem->cnt` to 0 immediately after
> > >>> allocation. Then, move the existing `mem->cnt` increment so that it=
 occurs
> > >>> prior to populating each array slot, using `mem->cnt - 1` for the a=
ctual
> > >>> assignment index. This guarantees that the counter accurately track=
s
> > >>> initialized entries for safe error cleanup, while dynamically expan=
ding
> > >>> the `__counted_by` validation boundary ahead of each flexible array=
 write.
> > >>>
> > >>> Additionally, rewrite the cleanup loop in mmc_test_free_mem() to us=
e a
> > >>> standard forward for-loop. This addresses the unsafe post-decrement=
 logic
> > >>> in the original `while (mem->cnt--)` loop which evaluated and decre=
mented
> > >>> the counter field before indexing the array, and avoids a potential=
 integer
> > >>> underflow/wrap-around of the counter field if the cleanup path is i=
nvoked
> > >>> when `mem->cnt` is 0.
> > >>>
> > >>> Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
> > >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > >>> ---
> > >>> v1->v2:
> > >>> - Started with cnt =3D 0 and incremented before assignment to ensur=
e
> > >>>    accurate tracking of initialized entries in mmc_test_alloc_mem()=
.
> > >>> - In mmc_test_free_mem(), replaced the while loop with a forward fo=
r-loop to
> > >>>    safely iterate over initialized entries without risking underflo=
w.
> > >>> - Updated commit message to clarify the issue and the fix.
> > >>
> > >> Thanks for your patch!
> > >>
> > >>> --- a/drivers/mmc/core/mmc_test.c
> > >>> +++ b/drivers/mmc/core/mmc_test.c
> > >>> @@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_m=
em *mem)
> > >>>   {
> > >>>          if (!mem)
> > >>>                  return;
> > >>> -       while (mem->cnt--)
> > >>> -               __free_pages(mem->arr[mem->cnt].page,
> > >>> -                            mem->arr[mem->cnt].order);
> > >>> +       for (unsigned int i =3D 0; i < mem->cnt; i++)
> > >>> +               __free_pages(mem->arr[i].page, mem->arr[i].order);
> > >>>          kfree(mem);
> > >>>   }
> > >>>
> > >>> @@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(=
unsigned long min_sz,
> > >>>          mem =3D kzalloc_flex(*mem, arr, max_segs);
> > >>>          if (!mem)
> > >>>                  return NULL;
> > >>> +       mem->cnt =3D 0;
> > >>
> > >> This is not needed, as it is set to zero by kzalloc_flex().
> > >>
> > > Actually, kzalloc_flex() automatically sets mem->cnt to max_segs
> > > because cnt is annotated with __counted_by. Because of that implicit
> > > initialization, we need this explicit reset to get it back to zero.
> >
> > An auxiliary variable could be used to avoid having to update the
> > counter too early[1][2].
>
> Thank you!
> In light of this, Prabhakar's v1[3] is the better solution.
> But perhaps that the addition of "mem->cnt =3D max_segs;" after the
> kzalloc_flex() should be dropped, as it is done automatically by
> compilers that support __counted_by, but is irrelevant for compilers
> that do not support it (the correct value is set at the end anyway).
>
> Gustavo, what do you think?
>
Do you want me to send a v3 based on v1 [0] dropping  "mem->cnt =3D max_seg=
s;"?

[0] https://lore.kernel.org/all/20260513201315.3186621-1-prabhakar.mahadev-=
lad.rj@bp.renesas.com/


Cheers,
Prabhakar
