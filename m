Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66834239E91
	for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831537; cv=none; b=YeeHIbWASMTpG0CJGnc/FU9VIxUw2dDMdMY2fgtDmNNouRo387mzobJ8+11fdDokLYB0fxX8XxIG837X++H+EKrrMOxa15xUivnNYRY1+nP0G3H8uatSXuhiHO+ODin4ZmtLtGbFyxyRCyfMlknx5DEwEAf2HTZDxjVbQk7KLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831537; c=relaxed/simple;
	bh=n6rPJCx9/rJo0cLsi6xMccKyA/Zz3SsJyR7Z4cGd+a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1GXXxe7rZHU69N9vfaXRMd2eBk4Jep5sr5snKBZKLL56RTAIHx8Ar8J7gpqVC+VjVFrWcGlHyiT929ErIbNZdiPM4RIUSUYgjwUJKOwaEHKoHTF5Bj2p0KFABSE1z/y8L0SLs9ZTz9NS5DBEtaATLIowTlLKw4DhE5fr7xultY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZx/UHjF; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZx/UHjF"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7b962a1518so3207371276.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 May 2025 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747831534; x=1748436334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTGEEcDJ4Rf44o/m0iYLH1IvvxWp6S4La78m9u7l9Dk=;
        b=YZx/UHjFwVO5rOU9UXwOJSAPsreG8JzSLus3yRDPteIOIFiy+W67QaC3Vasdh08t7V
         FkO/62TkvqBiXXAY5koYLZEPTCA0H4gVVlm86mXGUxzhnhhR/cyY6FZnYHYHrJwYipGO
         sYHbP8MRteQ/WHmQFHS4oHY2U0Noc1CWBF9usMTocSZs/k/OhwC8DBN49unrQc2NkJVB
         LskJCu9Yov9M6NTmOWj9DymiAPzIPT2vJEc94/MqzcnjLnTifsXCtpLb5kp3FiW66GMv
         WsW/QORveau1b+jV4qKZb8YEmTFwES7gwBLuUKmD+Gr37E3Ky+bXV8M7veZVW1mqZUvN
         j1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747831534; x=1748436334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTGEEcDJ4Rf44o/m0iYLH1IvvxWp6S4La78m9u7l9Dk=;
        b=Tpgubg9Ag1E++595PDhvilpfeF/vbZybk7qhyzrxP2i4a2t76mssPGXuMLGLi8DfHk
         QzGRT51FKcvXDrGZxkA5z1v9t5KaGtX9HFXT0auPeSo+/OKSIlMqh64QZafRtSQQIlr9
         juKdoZsAxRRmwDVJvMxBTzPfPrS9Q0f6Vsqq/NQb7s1d+mtc3+T5qs1OrxCLKSC79VyN
         xdcYPddEyFd8bWEr+GhZw9Nox6YA96dUqrLwYNhnu5YvJG+/NNvkQGlOuDlwu84nIOEo
         4aQ3gQgz62NbdW6p3AyumU6QCxCCVdLrSznPaM7g+WVajqwm73Navp6gtdiUJIYf6Qe3
         x60Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlQNyHO43EECKbCSbZe+jIyu32taW/hvsYmWTQx1o0Lwb3ySS5LSukIhc91u8xSjPWCquTpaQrJoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6fZW+7KxNJlhx6xgr8n30gIMf4jksG44QoyWpioCLf51Kmci
	pmbQuFWXiH0aFYGEZ+UsoMVeMfXcTA+Mq81Kk1KCe0cJA6V7M1/1+nh2opCQQxzH6/Aq/UZqKkz
	oHhy8CIJ26GH4eanC+JiyyjiW4BGwG0pYgP2t/vdjEg==
X-Gm-Gg: ASbGncs0yx88uxKSZRoxifKPN7sJjSkzcgZD+n6DJI79ShkaFirkUFiWSrqEJe24I/j
	s3L6AdYT+QFsh0O4DZb4XKbyczEuhUUW/yejK1qRpV72Za79gxlgYpn8WLZVNrHrPfWBb3ONlbL
	aIN5Dbw2yGZpjcv5E/ffOnBh1NAVX3iU01+w==
X-Google-Smtp-Source: AGHT+IFdZAN7WRv6VPS5cGJ3gLPs22mEKo408MqP93yw+t5BEIMPcUMP1HhYDPUHVSuVMpda74VHpQZ4hE6QblI0FRQ=
X-Received: by 2002:a05:6902:120c:b0:e7d:6717:b4f with SMTP id
 3f1490d57ef6-e7d67171335mr718291276.20.1747831534201; Wed, 21 May 2025
 05:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516092716.3918-1-victorshihgli@gmail.com>
 <20250516092716.3918-3-victorshihgli@gmail.com> <CAPDyKFqCo2-9fYYAoNpmJf7XOiTvLM07hQks1io-S0MvmbAjCQ@mail.gmail.com>
 <CAK00qKAEN9+aA_7_YEGjjgovNG78du7+wmMyB4D0jZjzzcFNbA@mail.gmail.com>
In-Reply-To: <CAK00qKAEN9+aA_7_YEGjjgovNG78du7+wmMyB4D0jZjzzcFNbA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 May 2025 14:44:58 +0200
X-Gm-Features: AX0GCFvdjxqAmgbrTOzHHBpAjrwEOM3dIarU_X-Ow71DNc9AeVmuEv_ZWGrofdM
Message-ID: <CAPDyKFqsKqw2Oy2_JCK9ts1DytkMo86snWw9-OdxYwJfNWbnqw@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] mmc: sdhci-uhs2: Adjust some error messages and
 register dump for SD UHS-II card
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 21 May 2025 at 12:45, Victor Shih <victorshihgli@gmail.com> wrote:
>
> On Mon, May 19, 2025 at 8:25=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Fri, 16 May 2025 at 11:27, Victor Shih <victorshihgli@gmail.com> wro=
te:
> > >
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Adjust some error messages to debug mode and register dump to dynamic
> > > debug mode to avoid causing misunderstanding it is an error.
> >
> > Dumping the register may be useful for the debug level, I am not sure.
> > Maybe Adrian has an opinion?
> >
> > >
> > > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > ---
> > >  drivers/mmc/host/sdhci-uhs2.c | 18 +++++++++---------
> > >  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
> > >  2 files changed, 25 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-u=
hs2.c
> > > index c53b64d50c0d..9ff867aee985 100644
> > > --- a/drivers/mmc/host/sdhci-uhs2.c
> > > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > > @@ -99,8 +99,8 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 =
mask)
> > >         /* hw clears the bit when it's done */
> > >         if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask),=
 10,
> > >                                      UHS2_RESET_TIMEOUT_100MS, true, =
host, SDHCI_UHS2_SW_RESET)) {
> > > -               pr_warn("%s: %s: Reset 0x%x never completed. %s: clea=
n reset bit.\n", __func__,
> > > -                       mmc_hostname(host->mmc), (int)mask, mmc_hostn=
ame(host->mmc));
> > > +               DBG("%s: %s: Reset 0x%x never completed. %s: clean re=
set bit.\n", __func__,
> > > +                   mmc_hostname(host->mmc), (int)mask, mmc_hostname(=
host->mmc));
> >
> > As I said on patch1, please use pr_debug() and drop the macro.
> >
>
> Hi, Ulf
>
> This macro has been defined in previous patches not the first time it
> has appeared here,
> are we still going to drop this macro?

Yes, please.

We don't have macros for other log-prints, so let's not use a macro
for debug prints either.

[...]

Kind regards
Uffe
