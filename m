Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46E26A0F9
	for <linux-mmc@vger.kernel.org>; Wed,  7 May 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620759; cv=none; b=Hf1cgo/simAWdX3d00WIS1leJP506lqQLeg9Q7uc590iBNAeLxl3LkPHVU1HMFy0c1I3GfrSXfGUGHf5KF7KK0yy0HSH7rDkqOUyH1GTfEyDYSh9hcbX9wNLvvg9dVB4OErY3kixu4aU8V0j+1i2LBYHGaI2z6a9crhnz59BezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620759; c=relaxed/simple;
	bh=7jEdL9fAcKkFuShO6qXuY9Rl3vfWoCTALojrNx3ds0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQCYtT50569Ju8FjEt/eyXk8cxudDfBFDdZFjvPAaUtijefL5xHgQcRBd5WeAbbUSOMUd/t0jjRDJ3nEu87f9UTmL4t5DyJvccwqvhfzw/VPNrDt7bqcbXLoFs3MDYyDBgw0SkjQ9Dkpvgcpz7EhQqkKJTdjhA0pPSPGFi5iCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=IXLdJbNk; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IXLdJbNk"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-708ac7dfc19so54979617b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 07 May 2025 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1746620756; x=1747225556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jEdL9fAcKkFuShO6qXuY9Rl3vfWoCTALojrNx3ds0g=;
        b=IXLdJbNk2iTSSvNjbI66CPVbDs98pDN9wKZTGMPtOLPX2yKto1e6Mvaq0529wYYhJq
         g5OIT0MAHSajcm1EFeU1muYa9+dzCZSx1J19XjzJ30mcL5nHxSPzlmTPTRVeqnbEJSoR
         Hekg6f66zi4dDQtokAGpgf6b15VS+6hg6dREU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746620756; x=1747225556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jEdL9fAcKkFuShO6qXuY9Rl3vfWoCTALojrNx3ds0g=;
        b=J2wUQH+bGaR8VUMivzbz+MzRZHxGQ3W1IPj0KlQCS4EU43RGZFlyfswPaCxr1tObWg
         Tu7ZKf/VXEcb31bSbz16M++2EvgtrZXKrls8ctkhzy/n4Mw7hWK3pzVzEQFaodEMiKBg
         h9D1LjfO3NSCOiPaMQ/g7jnyU5DnAovLDI8PgJYXkGi564fav3GKuLXigtHYOtcU1qwX
         U266SGEPPvqJbRN+ucff/0ndifWmt55I09cYFlCj8xgpwYRuM8KqPHlsCx7YUL4p5Cnv
         igRvZAXKoS0zx7X+ALWmn8gxTG7F8id9UYgZaW3031oUfmHMaV+PuIWjaZN+23Adk9Y3
         2chQ==
X-Gm-Message-State: AOJu0YwejLJpJSpxrNv273+bXF17kM96AK5vi1O6StpSOLjCvuCvag0t
	FtgTGQ8FIRmRuIjGs3Cs7XvnhW65EsNw4vzAauhLkp5if7s+I0NZ59O4B4UvUPfxstkBg50VgEq
	0ldNis2ucXuQvUWvrFjE+sIKIP9tnVTd0hikT7A==
X-Gm-Gg: ASbGnctm7YdWbxqTxzTw5w7cgNrOtrF42uWbrY1imjEwlaX5dQGqyxrvRm2FJQwcOnl
	tVx5O0zlPuoopw9L/kIUmDtHO/hj6rmtvWAGYoQZxJh01CnF6fBaDUhSFWa/jX0Fn1EfK+2So5/
	rYAMN5IxInSIJvfZ9TvqM=
X-Google-Smtp-Source: AGHT+IE63STWSsGqXQcHIvvYgfQmaX2dEqQr/k7Fj7XCjPQf4js8bT4lzIOR8gqJ9mFT36GY+M7OIL7NsOG/7lAuE40=
X-Received: by 2002:a05:690c:905:b0:709:8839:b46f with SMTP id
 00721157ae682-70a1db0ff80mr43455257b3.38.1746620756367; Wed, 07 May 2025
 05:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
 <CAPDyKFqWRDTqXjkb84BG=Kid+MQO_R-cJNcYFB3scnEhhsX46g@mail.gmail.com>
 <CABGWkvr2TPKkqQKYZkx7u0rhf4xyg7WNg6H7+hdpETSqv6MF2w@mail.gmail.com>
 <PH7PR16MB61969260F3C367D70860F211E589A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFpZMq7J9Q8wwt0_mR2Kv_2=-=gd7g5edksuyyG=tROx-A@mail.gmail.com> <PH7PR16MB619636B39BB8ADE5D6ADC3C9E588A@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB619636B39BB8ADE5D6ADC3C9E588A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 7 May 2025 14:25:44 +0200
X-Gm-Features: ATxdqUFEomBHdR_OodDSkGQ-7-UnncHzt7So6euSMdadcb7CTnyyN_bqfecjit8
Message-ID: <CABGWkvreTbYj4dzqeXtOpr1tHNjxgR4F2HYAXuGh9sfKDM885w@mail.gmail.com>
Subject: Re: RFC: mmc-utils versioning
To: Avri Altman <Avri.Altman@sandisk.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:56=E2=80=AFPM Avri Altman <Avri.Altman@sandisk.com=
> wrote:
>
> > > > > > Would it be possible to tag future releases? That way,
> > > > > > Buildroot's autobuild service would automatically notify the
> > > > > > maintainers of the package of a new release, and in turn update
> > > > > > the package with the latest changes.
> > > > >
> > > > > It's certainly doable. Setting a tag is simple, but having a more
> > > > > formal release-cycle with release-notes, etc, is to me a bit too =
much.
> > > > >
> > > > > Would just a tag be okay with some kind of summary of the updates
> > > > > since the last tag?
> > > >
> > > > Yes, I think so
> > > Looks good to me as well.
> > >
> > > Thanks,
> > > Avri
> >
> > Okay. I guess making an initial release with version 1.0 is the next st=
ep, unless
> > you have some other suggestions. I will look into it soon.
> >
> > Not sure we need to decide on what frequency we should do releases, I g=
uess
> > we can decide on a case-by-case basis, depending on what we have applie=
d
> > lately.
> >
> > Any other comments?
Not for me either

Thanks and regards,
Dario

> Not from my side.
>
> Thanks,
> Avri
>
> >
> > Kind regards
> > Uffe



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
