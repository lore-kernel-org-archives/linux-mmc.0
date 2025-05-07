Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F976410
	for <linux-mmc@vger.kernel.org>; Wed,  7 May 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612441; cv=none; b=kbPSZ0yg/zVjU3lXb73qkPwPHv2vWuiDqzf9uSNTQiJwMRcBvKmFyQ7R00qvRvcRXxZy4FbEwdDL24pfjv8Tm9WOy3eOWBpgN1+0C4dYE8QCypsXKvpM9Tt18LTEt/yoXOZ+7/dkLVL1kNSz8S6/FBUh6qpcIg/Uq85vIVTkW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612441; c=relaxed/simple;
	bh=BE46vYq34BY6Z5CfSBscVv/F+21bvYjevWf8j2itf6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a73z6JEwDhE/63FhaFD8qiPUm4E3y6EpuU4WOC37EJMKRcw3RwWM5MyQVd1HR7sruwz4Ju0ylmaoaYm9m5uwfq9Cp+X4DLjTDsheSn71ogDw3bxhAcXg3hG/jc9FoMsu6JCyKNNmews7Qvu6nYxgZ5Qrwrk2vqjX5r9Qzfx9aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rY1xlu84; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rY1xlu84"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70907505121so31193007b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 07 May 2025 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746612438; x=1747217238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE46vYq34BY6Z5CfSBscVv/F+21bvYjevWf8j2itf6Y=;
        b=rY1xlu84X4yKuLQgCitZVi3SL7Qyoav5xc/8mCq15uclBbmugfeYviwvf9cIUwZzI8
         uwxYMgd1U16fXU2lU7Wi5Re46yJ1JPZNAHLhJSCor+N14ZvO75r0MqGFxxE3by/oFtk9
         Mxv2C9GlVetrbVp31zKdvIWMLV+Cfr+ixDf2HQ4EqaCgKeYr3LvvkY8FDQVnRWpINwqo
         BlzXCHFExCJmjTBbv0j6rQwrUfnG++osn/7frK+LCH719NawraIt6m/IVSmD1ifjchKY
         ibnl8pz5niWCCno6S6xm4n26s0/C6ota5sfdx/z5jElE577ruHVbJwr8zjOQBDVXwoK3
         gnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746612438; x=1747217238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE46vYq34BY6Z5CfSBscVv/F+21bvYjevWf8j2itf6Y=;
        b=fi33SpLCGQztQ7dcwejqfv4GB9TUQWSWylb6AvUe+xS7kWVYd7HECg/sZAK237mr3q
         WQWRcfe7q6y1ezSo/eEaRprHE1dP3dWqyn8oOSdSwRexbGOPs8WTnSH9KBJ29vbMFeAY
         3W+EI7DqxMIKt7czsIJMSStxVapOM0KBxDkjRWpWOEcq0HRcrL4DLU/pfgHRhL23K4gH
         31fEq64d+aA7CI+GqqAqTAW1P5AymR7rAqOYRSKLBmnMtf5reqmq1VXBbekn1REElJ67
         SfK0bCcU13DX9AeyUSAZZgPpdYgqDkNSIWwPRjlwgdyJPuBmrCkGcC9ynTuJgFtuiSKB
         Lc8A==
X-Forwarded-Encrypted: i=1; AJvYcCV4J9UYqBv6gOb1Wu/z4rsu1zGUjsdn/hnCw6JBC2Wn9DKTuvkLJobYJWLDuHxQlVdRCJ3GZLd4gg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8SiWjU5Qxt1OaJWAjSLVyp2LiWZzI/Ii40YE7vGlQ3n7/I71
	KIlG4OBzIlPvhk4ZFz8CD2BxEL5hbjNBCJYS0XJfgQwcGzoZBYFpw6LI8qBKMr0wYuAbpqIsaEV
	bS8eWlokIBMOfWeKWqMC+J3ZJ5Mi8V+6olZSevw==
X-Gm-Gg: ASbGncsi/ZoL70eprqZYfGfntLqK/k6SCmaqDZewMqlXY82dDE6dWwc38c5JomxY9eh
	nlTfmyY2L8+oiiylN2Ne7oDCRl7xcG0/4U6nYzpD15ai+/zQqwq7EpifO5dCyU1uOGCS4t2uCgF
	YL7o8Cqi+S8cCtYPcvtQFTatY=
X-Google-Smtp-Source: AGHT+IEV79egu8e4UvpIUvdJCfcIcPMJxfxr5jDTf97vlyq+0HGlgOhowy+MGUt6cKShlqc8T6OgIEGPHpx5CQcQYS8=
X-Received: by 2002:a05:690c:6f0a:b0:706:b2f9:1a7d with SMTP id
 00721157ae682-70a1dad9a4emr35012877b3.33.1746612438579; Wed, 07 May 2025
 03:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABGWkvp-peEfhc57-+g+_w4DWWqdWVgw6CFF0tS7yjGsTtTufQ@mail.gmail.com>
 <CAPDyKFqWRDTqXjkb84BG=Kid+MQO_R-cJNcYFB3scnEhhsX46g@mail.gmail.com>
 <CABGWkvr2TPKkqQKYZkx7u0rhf4xyg7WNg6H7+hdpETSqv6MF2w@mail.gmail.com> <PH7PR16MB61969260F3C367D70860F211E589A@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB61969260F3C367D70860F211E589A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 7 May 2025 12:06:42 +0200
X-Gm-Features: ATxdqUFNAvk52cxYXhlAI9jPHfn3Zc5FqsXHxSB8WOK4wlbpUPmLRNJgXxYR4yo
Message-ID: <CAPDyKFpZMq7J9Q8wwt0_mR2Kv_2=-=gd7g5edksuyyG=tROx-A@mail.gmail.com>
Subject: Re: RFC: mmc-utils versioning
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 May 2025 at 21:42, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
> > Hello Ulf,
> >
> > On Mon, May 5, 2025 at 3:20=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org>
> > wrote:
> > >
> > > On Wed, 30 Apr 2025 at 19:05, Dario Binacchi
> > > <dario.binacchi@amarulasolutions.com> wrote:
> > > >
> > > > Hello Ulf and Avri,
> > > >
> > > > Would it be possible to tag future releases? That way, Buildroot's
> > > > autobuild service would automatically notify the maintainers of the
> > > > package of a new release, and in turn update the package with the
> > > > latest changes.
> > >
> > > It's certainly doable. Setting a tag is simple, but having a more
> > > formal release-cycle with release-notes, etc, is to me a bit too much=
.
> > >
> > > Would just a tag be okay with some kind of summary of the updates
> > > since the last tag?
> >
> > Yes, I think so
> Looks good to me as well.
>
> Thanks,
> Avri

Okay. I guess making an initial release with version 1.0 is the next
step, unless you have some other suggestions. I will look into it
soon.

Not sure we need to decide on what frequency we should do releases, I
guess we can decide on a case-by-case basis, depending on what we have
applied lately.

Any other comments?

Kind regards
Uffe
