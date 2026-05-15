Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286CD3B2FF2
	for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861176; cv=pass; b=cYEcEan5h0+Q8VjjSFYDzolzitwzBDRtNyvC7BKJFRssT6JvJOibfh1tRo+l0RxnQr3VkM0XS81b38zkxYfurf9IjBIalTlYvWdY02jdWT7dgLVO1qUxjD3WN5DQLnvKhoN61m60ZAl8ZjAljDppUwDJ+lgWWoQblNGIVkxuoN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861176; c=relaxed/simple;
	bh=R3ZlJ690BspRazEOa85mYr8ASbFhLj44gIjJyH+WqE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvlBxL5O072DSoz+wD9h40I/BSoWxET/+zkiiuijeHu+466BOCdQZWbCjcYx2NNJQ5TBLk+F2OW+3VYMQD+AA5hCJNgy/vypyRTQ0s+/D9B6x2vthrlWRoHI+4BMCopqLVeGhkPP9wjQ17AsqB4xhCHst/jxq1qGBxXEi5m2Hxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLQvvphr; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLQvvphr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so741241a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2026 09:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778861174; cv=none;
        d=google.com; s=arc-20240605;
        b=H2j4OhzO3z0jKd1sjJd9Vl9SDwYHuCznhehMwGTwBzyvL4cDNeYjSpt1UMjzxLY+TR
         kzLlJXLNH0iCQ7zQj3pBgIDjfrpcds3e/fvzPJobsvRkQyhId0sPuRrKMjL+QJNloVKN
         t9yftyzoGCoiCbHlZsz0HDIMpFWX3vILE70+eprqI273hJNHA6G13Z8tzDJU8mMAgkie
         ZmunfbdGssHwbUGKV/IsrRiUtKrwa3NnXFZdPNhP1g35zlrrjsmJ/FRmfJMgDX7gKXpY
         +F66T0pvPGwH6iygxSVNUejJNe8nPj9fLWl/zpOEfIZytZ9Qb2sedRSeIaWbNOZYX7Ud
         l6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hg/ZBb07k+wSfTX6C7BkW1LcsYzI30mlFJ0aDI6bZOI=;
        fh=Xn5gGOD0wfvxR3QQnaA7YlzIeHMppEapma8laY3ceNU=;
        b=WS9paylzyZMS8j/ToqA5i3RfeQxr2/qUHAQh4oFbVR4BiKzhWa6fSIbBhjzx1ORemq
         8EMBIM0nxTil9B5x0K+48raGOWP0BTupqWPz9IISeZLWbkxhNsr+/zeup3t5ktfnwzka
         x4QIRkJCramItWjAwPXq2a2bWwcG3t/hhE4E/gJk4v4+rOYEw0ieyOc2CFD/1guEk/8t
         w0eYpWzjt0crSQUZC/pM7wyHbuBjUQvxasDaj8+oaLqncCqQiY/9t8H5cDSKSSqcekxZ
         DDkqyfRxpkGGfXMGcji4mRXRGgHIKP2J2HSvNwUQ/znLIwnbnGuR14lMORt/Tl2N9LoY
         bj2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861174; x=1779465974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hg/ZBb07k+wSfTX6C7BkW1LcsYzI30mlFJ0aDI6bZOI=;
        b=RLQvvphrrUtFyWITbc32GSMtovtQTRgZ+0NCcNnViirympL6r2hFg8kx4k7bCSyf/D
         Hp4+dQD3d7b0wmWpenSzRaZljwgu+HP0IegIUpaNIxVs0lsq/Fg26NkxtyT7jynzjF+i
         CPz0mcdTflN3AWHiRWkGY2sPOeG2jH/4ImbkkihgFgiknNDYdOsbMbTgN5ygf1FzYMLb
         r+cD4wI+sEqCu2bOBJVYk9JjFn2Zb52zcP/D7patVsjI5r8sQPLHn/KlyRMgEcA0sqvC
         SmYE+sInCIsTs9oAjqv3QSniQoO+MH9qtG3wnUlubJVmxxnReKXNuxA/mjIHl81UMZ5j
         uPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861174; x=1779465974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg/ZBb07k+wSfTX6C7BkW1LcsYzI30mlFJ0aDI6bZOI=;
        b=qlPVpUUP0ZjfBtfURpShjrlrUuPpz0kvJYgIfjRgVmMaLMA3OpmM134CAe593mHX81
         +qV9qM6AtcL8ogTmqiXkjEXMmHUpALvt/H2bbiGtCDCUWgeIBdMQQ59XUNfjGhw83XvG
         jTSWiMKSMbmUld5Vwv/I/CDKl9ITaLOurFGgHSAQ+wyH8DtjIFXpIzGcCzpnpQkGP46e
         fvlf/5HM3Nm9Gep95ohr1FYosjFNcLKPhLqVltz+t19nLIpmt+shpD47JgJGAWoirPsl
         wcmHgQh9ClJU96gkgclrIK7vUFBomB5FnG7V7r7687V/tW0uZEw6MGZ9x3XJ2ntAD/YV
         ZpPw==
X-Gm-Message-State: AOJu0YziLnVgYBOQaV1vMQtl2w+PEr6F4nGLLPVggIE1NuaEm/MK72aQ
	B7ojyvueGB5ri64oHGEyDTahdlA3sp1Ma2kGjbUSoiKP9Ggfh7xQSEBvIihheIwPJiDEmJaYrrQ
	ajh2zXJk6mG/3Okd6hAMjJyOCujevgTIb7wYJ738=
X-Gm-Gg: Acq92OGBBI8mUykYzORcVBtf8mb8MZKbF6CVNRLvIIaVXW/UeUd9aDL2IuSP+fE5NxZ
	llOan0KS0iiXw0/aYpUIVu6MUI6/MRfytYB7lyWYT25WJ123nebPBN6mgSJ2npCuF1wqthNypE0
	fn0fy6FNUuSM4b5GEWKqHhMky+uVTo8Gn1/ZzFgxUm3TSjLF0CAZVFWW7gpFTg8uUsQHEvaCSP8
	cPufo6vnIrZ8zTeHuQk4F730mAqq3tNm3CIXaZQj8RigZbLqOiC7XqLeZ3g3MLvK319ZJV/NvpD
	AQDHMwMjjxSuteP1tefcvWbUBcBhPYQlJQHIrA==
X-Received: by 2002:a17:90b:5245:b0:364:6f27:43ea with SMTP id
 98e67ed59e1d1-36951c953c6mr4702896a91.21.1778861174278; Fri, 15 May 2026
 09:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515083457.3690804-1-torsteine+linux@gmail.com> <DS1PR16MB675343BEA9DE94B268CDE927E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB675343BEA9DE94B268CDE927E5042@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Torstein Eide <torsteine@gmail.com>
Date: Fri, 15 May 2026 18:06:01 +0200
X-Gm-Features: AVHnY4IbE_nfYs08gMpB4fAI4Oq_m6HeqmdzuclsW_o3RW73uYoFJeSPxzMms6g
Message-ID: <CAL5DHTFvJfV1DVNjBLsdCQ8FP7TmNq0SK=EpA-2wWzdo4+FsRQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc-utils: improve lsmmc usability
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide <torsteine+linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

fre. 15. mai 2026 kl. 16:29 skrev Avri Altman <Avri.Altman@sandisk.com>:
>
> > Resend the lsmmc usability updates as an ordered series after the previous
> > submission could not be applied cleanly from patchwork or b4.
> >
> Thanks.  Still having some troubles applying it cleanly.
> Please make sure you are rebasing it on recent master.
> Will review your series anyway.
>
> Thanks,
> Avri
>

The first patch serie i modified after  `git format-patch master` and
did also fail locally,

in the new export  i only changed the subject and description in
cover letter, I let notice it was not happy when i try to apply the
cover letter, but locally to a new branch the all apply without issue.
I am unsure what i did wrong.

> > This adds external manufacturer ID files, accepts /dev and /sys/block paths for
> > register reads, adds an mmc list command, and installs bash completion for mmc-
> > utils.
> >
> > Torstein Eide (4):
> >   mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
> >   mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
> >   mmc-utils: lsmmc: Add mmc list command
> >   mmc-utils: Add bash completion
> >
> >  Makefile           |  11 +-
> >  completion/mmc     |  62 +++++++
> >  docs/HOWTO.rst     |  77 +++++++-
> >  lsmmc.c            | 434 ++++++++++++++++++++++++++++-----------------
> >  mmc.c              |   6 +-
> >  mmc_cmds.h         |   1 +
> >  multimediacard.ids |  16 ++
> >  sdcard.ids         |  23 +++
> >  8 files changed, 452 insertions(+), 178 deletions(-)  create mode 100644
> > completion/mmc  create mode 100644 multimediacard.ids  create mode 100644
> > sdcard.ids
> >
> > --
> > 2.53.0
>
