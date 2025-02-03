Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DB204C04
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738603766; cv=none; b=t+Qmn19GSiiGfrMZuMEruQIOAEJIGbntZQ3yzdEkDxVfPk4SkN90Nn5TRTSk2x4h1w/nevwV2kfiwslX07RCCfLOM0ZeiSZQcrCcZijdqy9WTVp8DH1OBghhJW/Kl5FvAlxi9kLIm6Tj4hpu2jvnV5z3KdhD35ONFjaG1rt2vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738603766; c=relaxed/simple;
	bh=UM4Lz9JV1FVAJnxuQyREovpM1rr/5Bb7V2ZlYLAmWq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEMIgbMZefj0aCic+/J/9Ebouwr/ugr2rcou7+sVVaHX/l6Y2JdekbOLwXHw6k6foSzYfspMdIMR8t/QJ3LbUorwKuOGmvNM+RMpiSwPX+nANImtb1a5GTxB5fIUppIoYXCCt+CdMD/OpMycxiMjI+L2Y77jDorD9e+G6h4bYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZXWdPCjd; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZXWdPCjd"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5189a440a65so2933920e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2025 09:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738603763; x=1739208563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnMh2QP+bdFEyDQpBRWlEwi3p1HXoXAwVV7u9PagzdY=;
        b=ZXWdPCjdqn422OZwM2x2G/WVA+OirhPyXkdWX9HHrAeQkMGQlE7w1XqrGc1+ccU3fe
         KMoo96I6Wr29Y7guaIvbQT1ZTTLxEZifuYGCD6conguUvUn3a3k00LEg9qNXBUoLCj/7
         OHA0g0CFsCmg8Fclmk4XoLn8KhJPeK1ALwS0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738603763; x=1739208563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnMh2QP+bdFEyDQpBRWlEwi3p1HXoXAwVV7u9PagzdY=;
        b=tzkCyRajOhmCOTr07VjGPHcISVJCkkm+fuEK9OzCPco70diLbrmlXNEHyzQWdD1SA6
         1/yDGPsmsQ2iRdUzlOCO0VFfe2aLc4fgfH1GeohdA1LwWsTcaM6HJmYawuCqBu7vlowJ
         LHQXpXrihX2LJyFlSk5QQwDCuLecXYDhTwRTif2aSOF41zurxVQCIneb6djey1dMAYgb
         4fgGnO6emlhUI09yScNbM14UTVHa+MYBeJNaySGVaOujgweyGSnPkCv42NeOm7QhkTcZ
         ajWZvivPjUnBDQp3SnX38NCVsO7Jdtn6qVkuvVvnM8OQJVLGedzuu2gA4279u15kvhQi
         aX4g==
X-Forwarded-Encrypted: i=1; AJvYcCXB2txhWL2mbsTYSvRXDkFCUtErxNZFMbQ7bm5reT695K+ZJ5JbW2/5iWcc0oBwUy9qkzDjXjuAZkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSlw+BjWUUhqyiB4GV80DXmLRs15Sh6BLUh9eIFKWvkRs+CTt
	caIv9yfWCHGcJUibV8aask+61heamH01Jo/vXshmIvQ7JAn/8UH1wz4kJUhXfKKO45IdUHSGEB8
	5zPM5d6nUkIhiFZdJfC3++FrnEjRV1pTnm6Pm
X-Gm-Gg: ASbGncvjG0sVREjGnwUGPluSo0BVT0f8nTXrmsfXgEoOz74dtFPok8RKhIVIuZcf8w2
	OIe09hc/uCaiuYj1+qGrxX/qVBoBdEZ9b7qQrul6qCa9r35aNTsMECTE4dhe5aLQG0iUcoe6RMW
	X8+E32ImqhEmO/rnPyd0ESMzA=
X-Google-Smtp-Source: AGHT+IFRO4e2o2Pe2BRl4PJlPJhHcgTD88bPajDotOisHDQg4eTqR3mU/TfyKI76LSUx2I8V+xT1ACURIwjfJEGv4jM=
X-Received: by 2002:a05:6122:3541:b0:516:2d4e:448a with SMTP id
 71dfb90a1353d-51e9e33abdcmr18611912e0c.3.1738603763535; Mon, 03 Feb 2025
 09:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201012936.2816101-1-gwendal@chromium.org> <DM6PR04MB6575976DFADFE5B05727EB87FCEB2@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575976DFADFE5B05727EB87FCEB2@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 3 Feb 2025 09:29:12 -0800
X-Gm-Features: AWEUYZnScKN2Af2I-eUbrDIdvIEPXz0yRFZNaQt84uQw0iQNIFLmFM0fgbfy5RM
Message-ID: <CAPUE2usFvmx3c91YdoTfFtKuO37CU5LK3zK9rJMiu5qp+1fZzA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix conditional around sparse
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 11:07=E2=80=AFPM Avri Altman <Avri.Altman@wdc.com> =
wrote:
>
> Hi,
> >
> > sparse would always be invoked, since `ifdef C` is always true afet `C =
?=3D xx`.
> > Instead, use ifeq to check if C is 0 or 1.
> >
> > Fixes f884bfe684f ("mmc-utils: Make functions static for local scope
> > enforcement")
> The commit log of the above say:
> " Run Sparse and fix its warnings.  Apparently, running make C=3D1 is rar=
ely
>     done, so make running sparse default."
>
> So this was intentional.
> You need to provide further reasoning why you want to revert it.
This patch is not a revert. It ensures that when `make C=3D0` is
invoked, sparse is not called.

> You also forgot to sign your commit.
Added in v2.
>
> Thanks,
> Avri
>
> >
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 06ae0f7..c0284bb 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -27,14 +27,14 @@ progs =3D mmc
> >
> >  # make C=3D1 to enable sparse - default
> >  C ?=3D 1
> > -ifdef C
> > +ifeq "$(C)" "1"
> >         check =3D sparse $(CHECKFLAGS) $(AM_CFLAGS)  endif
> >
> >  all: $(progs)
> >
> >  .c.o:
> > -ifdef C
> > +ifeq "$(C)" "1"
> >         $(check) $<
> >  endif
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $< -o $@
> > --
> > 2.48.1.362.g079036d154-goog
>
