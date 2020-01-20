Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD60EC2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9A120882
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkZOpbNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATL0M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:26:12 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34294 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATL0M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 06:26:12 -0500
Received: by mail-vk1-f194.google.com with SMTP id w67so8454177vkf.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/6h44apr/MBSH4phU83NTZvL9KJrwpMdL+9j2IrAWsY=;
        b=kkZOpbNcTWORy2JfVELYofOW2Ah224v7M22T8SKH9T2lgF/Z1WoikTNktM+8c+QZ/A
         HYsXAguAT8AodT0l3BObL8TLKAK9EfixNNwhb6tVdQMcCKGQWfb8iZw1rCZkKhc+kqz2
         WRg+XE9V0hR0fSQ1pQLD51INKWNvveLYXukdQlp0RUd0cpaP9GG+dFWD/nVrt0Qs4FTi
         M4wcty/2vh+DLzJMrX0feBXVNkft1LZ/zfUQpA3xrlsqm3O580b/Z2i/a5AaEpDBvRm/
         +3tx/roNgqOPUIo+dbqDMRT4GKfnxLy4gWfp0n2xmRDpTjV0VBXDsBFJ10c6wpCfr1BY
         kBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/6h44apr/MBSH4phU83NTZvL9KJrwpMdL+9j2IrAWsY=;
        b=HZ8akkk3wXb7CLphkH3enUQh2GKV6Gunq/3fZUnPPYmn60/fT/j7UyaeSRxwkhFrwF
         Tq2WWMhBH4oX+a+O3JisDNDEoGtkka2ntBQ9nWq7CrfF9+pfT+Kd9B35lq8oc4iHFf+A
         SBub8eFX82l0V69vjGUaUKCcAKHkLOBcaqnG2Tzxsa50cffTUpy4QcBGVgDPPtiNT4PC
         ng03+GlDnQBCKph0bvDCp68TS/+vTTziTOaiTDICuN5Y4E/V/N+z8midNTEI6fFbSARc
         pIEhvU21UCWWqhHdKVspWC5QKNRCF6suAhm5Y5xT6WfihLh/CenwiCR1XPMmbsji2/rK
         8APg==
X-Gm-Message-State: APjAAAXqBTIJr7HCsW66/LmljgN9/CYchVZwbymwTlev7/iq4/K9NB8D
        z5v4oKYRuMpnHJjOPjihCKKp893xVFZq7w+F5eeUL2nE
X-Google-Smtp-Source: APXvYqxI1iMU6cU9a4kyNfcT/7FhHDagumdwB9XVb3vIpFfPpgyU01bKZfDvZ/cqXO7oNV0JlnfKNItv19qv5BnlyOQ=
X-Received: by 2002:ac5:cde3:: with SMTP id v3mr605857vkn.43.1579519570907;
 Mon, 20 Jan 2020 03:26:10 -0800 (PST)
MIME-Version: 1.0
References: <f471bceaf237d582d746bd289c4c4f3639cb7b45.1577962382.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFpZWnkK7UmCZ8M4UnM05wR3MQsPrpEjOJuwkKcN2gePSg@mail.gmail.com>
 <20200117140511.GC26135@qmqm.qmqm.pl> <CAPDyKFpkhwnzi5PAr_0bAriYteeBUVM5Qr1byiXtJkgYd=dKfw@mail.gmail.com>
 <20200117161422.GA11081@qmqm.qmqm.pl>
In-Reply-To: <20200117161422.GA11081@qmqm.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:25:35 +0100
Message-ID: <CAPDyKFqdq_eizwgaKf=ZdohBY01K2RhVNZG2dyrLbQgVT+Miwg@mail.gmail.com>
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

On Fri, 17 Jan 2020 at 17:14, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> On Fri, Jan 17, 2020 at 04:26:30PM +0100, Ulf Hansson wrote:
> > On Fri, 17 Jan 2020 at 15:05, Micha=C5=82 Miros=C5=82aw <mirq-linux@rer=
e.qmqm.pl> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 03:07:22PM +0100, Ulf Hansson wrote:
> > > > On Thu, 2 Jan 2020 at 11:54, Micha=C5=82 Miros=C5=82aw <mirq-linux@=
rere.qmqm.pl> wrote:
> > > > >
> > > > > Currently MMC core disregards host->f_max during card initializat=
ion
> > > > > phase. Obey upper boundary for the clock frequency and skip faste=
r
> > > > > speeds when they are above the limit.
> > > >
> > > > Is this a hypothetical problem or a real problem?
> > >
> > > This is a problem on noisy or broken boards or cards - so needed for
> > > debugging such a combination. I wouldn't expect this is required for
> > > normal devices.
> >
> > Alright.
> >
> > >
> > > > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl=
>
> > > > > ---
> > > > >  drivers/mmc/core/core.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > > index abf8f5eb0a1c..aa54d359dab7 100644
> > > > > --- a/drivers/mmc/core/core.c
> > > > > +++ b/drivers/mmc/core/core.c
> > > > > @@ -2330,7 +2330,13 @@ void mmc_rescan(struct work_struct *work)
> > > > >         }
> > > > >
> > > > >         for (i =3D 0; i < ARRAY_SIZE(freqs); i++) {
> > > > > -               if (!mmc_rescan_try_freq(host, max(freqs[i], host=
->f_min)))
> > > > > +               unsigned int freq =3D freqs[i];
> > > > > +               if (freq > host->f_max) {
> > > > > +                       if (i + 1 < ARRAY_SIZE(freqs))
> > > > > +                               continue;
> > > > > +                       freq =3D host->f_max;
> > > >
> > > > This looks wrong to me. For example, what if f_max =3D 250KHz and f=
_min =3D 50 KHz.
> > > >
> > > > Then we should try with 250KHz, then 200KHz and then 100KHz. This
> > > > isn't what the above code does, I think.
> > > >
> > > > Instead it will try with 200KHz and then 100KHz, thus skip 250KHz.
> > > >
> > > > Maybe we should figure out what index of freqs[] to start the loop =
for
> > > > (before actually starting the loop), depending on the value of f_ma=
x -
> > > > rather than always start at 0.
> > >
> > > Yes, it will skip higher frequencies. I didn't view it a problem,
> > > because the new code guarantees at least one frequency will be tried.
> > > The eMMC standard specifies only max init frequency (400kHz), so all =
we
> > > should try is something less whatever works.
> > >
> > > SD spec specifies minimal frequency (100kHz), but I wouldn't expect
> > > this to be enforced nor required to be anywhere.
> >
> > Well, my point isn't so much about the specs, rather about providing a
> > consistent behaviour.
> >
> > We deal with f_min constraints like I described above, then I think we
> > should make f_max behave the similar way.
>
> Okay, this would be a second fix as trying the same freq multiple times
> is not what this code is supposed to do.

Well, I think we want to allow to run a couple retries on failures,
but I admit that it's kind of questionable to try the same freq
multiple times. Anyway, that's what the code around f_min does.

In any case, I have queued this is up for next, thanks!

Kind regards
Uffe
