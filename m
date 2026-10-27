Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102724;
	b=VLw87JOPZSInkY3Dzbqz0kGrDMv++L5W/L3IrnCheSpei6b0Fd9HsoEeDqen8LbKpJc1
	 y7etaH2IIwLArIgmyy3jJLbQ0lYUEfh2NfCENw9rNhbn5eTSRBhhFpqlqFXTQQdAZv9yW
	 FxgAuOM9+rx2AZnGUYVfq0fybqbiPpazfARGOrtFr5G5ECozqM7l5yjSx6B+DFhflYdKO
	 yNEhWJHOI6+hcD9JnvwxpZAQDlJjMu99sn9LMkgF3L4zIwE3JehfpC1zxurwPufvEhGMz
	 Y4yI1P5My5Dp3lSkxNIRJnV5n4SmyNXyD12065vC0EN0WNgmdKUuzew1dlQhzPJJp8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102724;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NqEHCLFHg/YZTrdCvxEaQojESD0wlarw6wA9b0nhmXo=;
	b=IYftRPq5Fcxt/8s4no8p3opJJG1nh7e21ZFQvnwIEo4IGiKQiwtd8cuKI0gOVWPXHoNv
	 3i0qlRFN+zumssBxmseJvcWxDDT/NJKoq3HOgEOF2tVGVdyzzgHlYMLzYQ2LW1p4iMIPc
	 i3lKmgrOVd6Oc/9XLWMiNvlvSGNDokGoZa2sOKe+CFcCz2MCu8xlidODjUtVZdJQvDy8x
	 G6+G+bBEknGiAoLpRLhLXDzv7S59l5Q3F/Na2hZ3hAUJL/4pP6M+/6/Xn4cbqQyrbkwJu
	 Mi9bArol909y1s98GoGJ5CtRzoMCSulOo87QlsSGj2fa2DdPtOjgYNdBKLUrAW3QJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=k2qznDTg;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E531606C955
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 12:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E531606C955
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=k2qznDTg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793102721; bh=NqEHCLFHg/YZTrdCvxEaQojESD0wlarw6wA9b0nhmXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k2qznDTgR+igebwJ3O+83zIrI5mskGhXIkn2iXvsScqJHDpiEHA7ojCrHAGNpfISa
	 2oS0cU76c2tESFYzNoi513gFlITWhkoAGqCPeliWyH9wS6i8rA7QbMpGTabTwhPujO
	 j3ccE/ivDtZG8kSC/gQoZcebx947RmSxVCvJogo68VAICXCI2BJT32TuS9WxnhV1xV
	 ahpdTGh2add4qUgVsCLUdLjAF9Ac7Zewcj87YAGBINj3L7/KElplV20yAVgcK8swcK
	 G5igrYDqvuVVYExDzKT+0bFR+oqT+dxxA5gnmhdv/B2e0rduTXysy4VTuQ/PDCZXYr
	 ZnTn1NnYNo+VA==
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 0138D1271C3
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 12:05:20 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6de1ca1b05aso2546686eaf.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 05:05:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwc55dpFhHuq9fKW94crJd0pW8B6VjQBCIh9T7vABvb5olcLPL8iNq/kenzvo/5dEi5q2owu0Zv4W4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz5p/Nn9sgn4VCppvLdK9tZsNvjMLxRPRUZUr/+BOZMFk5AKz0
	uQyR+cWg5RcZ86BsZgxX0QvLPRVrxp99Fn7bJvbesWMf198iPj81y7KIYjnlKEHwUoaJ5PdNj5p
	5A999Y/Xh/O0PkrK63PIQpfUvwZe8ZA==
X-Received: by 2002:a05:6820:610:b0:703:c2a2:cc9a with SMTP id
 006d021491bc7-70ba0b5adf0mr5430261eaf.9.1793102719530; Tue, 27 Oct 2026
 05:05:19 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023232813.2983368-1-rojer@rojer.me> <20261023232813.2983368-3-rojer@rojer.me>
 <4e8bbb32-e062-40fe-8ee4-363e83a68f2b@rock-chips.com> <46a26683-9d8e-451b-bc98-505b1c13b09f@rock-chips.com>
 <202610261435018282601@rock-chips.com> <CABFmFwr0JozEeaDd4KErDzh+DWjkjkVRo6z61OxHG6BE=L_hKg@mail.gmail.com>
 <6e59ac7e-0186-477d-8166-083dd2987aa4@linux.dev>
In-Reply-To: <6e59ac7e-0186-477d-8166-083dd2987aa4@linux.dev>
From: "Deomid \"rojer\" Ryabkov" <rojer@rojer.me>
Date: Tue, 27 Oct 2026 14:05:07 +0200
X-Gmail-Original-Message-ID: <CABFmFwr9uGBNF1YkqWYp1L95wM+vjn7NXVahc7rjEmWeqNEX0g@mail.gmail.com>
X-Gm-Features: AclHuK-ZfGNpknDt8OEgvtqYY6LHLRznlRDEFz1uyBQ7dOxZ50hJpqapR4Kv1uM
Message-ID: <CABFmFwr9uGBNF1YkqWYp1L95wM+vjn7NXVahc7rjEmWeqNEX0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: sdio: skip CMD11 if signalling is already 1.8V
To: Shawn Lin <shawn.lin@linux.dev>
Cc: "llj@rock-chips.com" <llj@rock-chips.com>, =?UTF-8?B?5p6X5rab77yI57O757uf77yJ?= <shawn.lin@rock-chips.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jensen Huang <jensenhuang@friendlyarm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

agreed, will send a v2 with all the updates



On Tue, 27 Oct 2026 at 13:53, Shawn Lin <shawn.lin@linux.dev> wrote:
>
> Hi Deomid
>
> =E5=9C=A8 2026/10/27 =E6=98=9F=E6=9C=9F=E4=BA=8C 19:00, Deomid "rojer" Ry=
abkov =E5=86=99=E9=81=93:
> > On Mon, 26 Oct 2026 at 08:35, llj@rock-chips.com <llj@rock-chips.com> w=
rote:
> >> With this patch, swt6621s can skip CMD11 and successfully
> >> enable UHS mode.
> >>
> >> Tested-by: Longjian Lin <llj@rock-chips.com>
> >
> > thanks for testing, Longjian! so in your case it's even worse: without
> > the patch doesn't come up at all. good to know that now it does.
> > note that your reply didn't reach the list (vger drops HTML-only
> > mail). i'm quoting it here for but if you can, please re-send it in
> > plain text again, with full context.
> >
> > Shawn, thanks for the reviews! you're right about the soft-reset vs
> > power cycle: card is soft-reset, not power-cycled.
>
> Just to mention that vqmmc is optional, so if not vqmmc-supply in DT,
> the voltage is hardwired to 1.8V, then this patch doesn't help.
>
> I'm inclined to add vqmmc dependency to the commit msg of this patch as
> well. What's your opinion?
>
>
> >
> > Ulf, if there are no other comments, please s/power-cycle the
> > card/reset the card/ in 1/2 when applying. sounds like we're
> > converging on 2a, so the alt patch can be dropped. or, if you prefer a
> > single cleaned up patch set, please let me know.
> >
>


--
Deomid "rojer" Ryabkov
rojer@rojer.me
