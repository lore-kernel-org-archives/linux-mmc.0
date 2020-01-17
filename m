Return-Path: <SRS0=ySr4=3G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C6C33CB3
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032EB2176D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 15:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVGl54VE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAQP1H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:27:07 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39346 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgAQP1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2020 10:27:07 -0500
Received: by mail-vs1-f68.google.com with SMTP id y125so15047254vsb.6
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jan 2020 07:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Al120niEVsvG7P8tXNsKmXWmt+mTl+QFGeU5Kh7eR4U=;
        b=QVGl54VEk6IqoBZfxHiKRwJ7W7fHQLmoqA7dXl0/UxAvhejD4IBJmCNpLZ9lUkE1fC
         WgPZ5ADCtg7oiW3Xo/IBfYFnqNqb1mUA4FER2MRt2xQVaCc0yRvk0ERNFqG4aynigLaI
         bqARgMYrA0aFJvLm+sBqSqKMXMNbsxfuPReez/T+wvldBpqja7r9lrvERgANSm0gYQqm
         CcheN5lVCcNbuHklNrWljZGDAgEkDUz7RyqottS7GNrezHvRB9B70PN25AZUwQmVQYsV
         GpYuaB6BoZoI03VHenosOmUI5Z2wiDlqwjvF3GkimYTJEQWHBvlmwpMRq3YUwOS3D6rM
         bKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Al120niEVsvG7P8tXNsKmXWmt+mTl+QFGeU5Kh7eR4U=;
        b=d7ulz4GYtrn2b5ZblxWWpq2pXKb9XcPVRGYavftFIiZH4sI5yRShrmdGaoWxhuaE3K
         Ey7IZ7ZOqlALsRA7/0CXz/jp5SIxT8dXmt8I4pBwed29/5hbdUGjgQ1glcAGLdXnUUsT
         wkWYGmObKxovH6vz8iob/okdBqJks8Qz+bU3ypBEqyVX4epHByWe77DyoeUNwzl2VmBp
         YXfRGCkNujSiF7bts7U3VGDPWpYnQNQ0eKzl00SgaiPC/PxNp3fKOFN48DDKwoqqFYVC
         ZK+/HznJdVw4er97OpOKl07MialM27HS9fPdkhpW6r9UOgjxCTCvuviP0Cjvp/S1m3fi
         T8kg==
X-Gm-Message-State: APjAAAUYJzHCOR3JuL26Vp3ARUFLv4OPTGbPPY1R6PLA6rdbvq8O+QpD
        /nfm+3pzQ2goiIYmVYKbNX6Yq7IrG8hktUdS2VcnIA==
X-Google-Smtp-Source: APXvYqzTjDrVgGbgQ1r4ko50S2082/ytC9qF95Fb820LkGXbqN3IaRKe6bQ2iWNKbAR5+QtwsKhJolyI1SoWJlgiGR4=
X-Received: by 2002:a67:314e:: with SMTP id x75mr4981012vsx.35.1579274826364;
 Fri, 17 Jan 2020 07:27:06 -0800 (PST)
MIME-Version: 1.0
References: <f471bceaf237d582d746bd289c4c4f3639cb7b45.1577962382.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFpZWnkK7UmCZ8M4UnM05wR3MQsPrpEjOJuwkKcN2gePSg@mail.gmail.com> <20200117140511.GC26135@qmqm.qmqm.pl>
In-Reply-To: <20200117140511.GC26135@qmqm.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Jan 2020 16:26:30 +0100
Message-ID: <CAPDyKFpkhwnzi5PAr_0bAriYteeBUVM5Qr1byiXtJkgYd=dKfw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: limit probe clock frequency to configured f_max
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Jan 2020 at 15:05, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> On Thu, Jan 16, 2020 at 03:07:22PM +0100, Ulf Hansson wrote:
> > On Thu, 2 Jan 2020 at 11:54, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere=
.qmqm.pl> wrote:
> > >
> > > Currently MMC core disregards host->f_max during card initialization
> > > phase. Obey upper boundary for the clock frequency and skip faster
> > > speeds when they are above the limit.
> >
> > Is this a hypothetical problem or a real problem?
>
> This is a problem on noisy or broken boards or cards - so needed for
> debugging such a combination. I wouldn't expect this is required for
> normal devices.

Alright.

>
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > ---
> > >  drivers/mmc/core/core.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > index abf8f5eb0a1c..aa54d359dab7 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -2330,7 +2330,13 @@ void mmc_rescan(struct work_struct *work)
> > >         }
> > >
> > >         for (i =3D 0; i < ARRAY_SIZE(freqs); i++) {
> > > -               if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_=
min)))
> > > +               unsigned int freq =3D freqs[i];
> > > +               if (freq > host->f_max) {
> > > +                       if (i + 1 < ARRAY_SIZE(freqs))
> > > +                               continue;
> > > +                       freq =3D host->f_max;
> >
> > This looks wrong to me. For example, what if f_max =3D 250KHz and f_min=
 =3D 50 KHz.
> >
> > Then we should try with 250KHz, then 200KHz and then 100KHz. This
> > isn't what the above code does, I think.
> >
> > Instead it will try with 200KHz and then 100KHz, thus skip 250KHz.
> >
> > Maybe we should figure out what index of freqs[] to start the loop for
> > (before actually starting the loop), depending on the value of f_max -
> > rather than always start at 0.
>
> Yes, it will skip higher frequencies. I didn't view it a problem,
> because the new code guarantees at least one frequency will be tried.
> The eMMC standard specifies only max init frequency (400kHz), so all we
> should try is something less whatever works.
>
> SD spec specifies minimal frequency (100kHz), but I wouldn't expect
> this to be enforced nor required to be anywhere.

Well, my point isn't so much about the specs, rather about providing a
consistent behaviour.

We deal with f_min constraints like I described above, then I think we
should make f_max behave the similar way.

Kind regards
Uffe
