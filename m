Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC121345
	for <linux-mmc@vger.kernel.org>; Tue, 13 Aug 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551176; cv=none; b=JGSmmYOdyLL8FLVOSENCS5kPZhJVsZBSf4ByEZ/aohPYwjU4746UrxgIwTdQ+wIxj1JFKxg3MM2QppAxxK0VA4crF61OsfYE7a40VLi+bC6yEwTag7W7uqsf/Ddo042Gx0R0wRWH3Dv2asFFplP5xhUQWD6VeRO7xe55/vKwkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551176; c=relaxed/simple;
	bh=Z6aB3+VbuXftYE7kX7d+IQFgJMheZZjMJeOE/72VaSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqdV5tqaaMPpp8nfYE7fouDD2sUUgwMChH/DTIkhG08wRlvRu0HnfYdlVG1qAsK6Cl0spImcDpxCLwNeZju2OXo3hCX3TSrtvmB7Kye8kAIY6dAPxqa3Bcv1PxwlO/KzpmRpxxSnDEha/00C1Fl/TAAcezjTEUvqQcHIm7FizYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljoDSjyP; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljoDSjyP"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2681941eae0so3285325fac.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Aug 2024 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723551174; x=1724155974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EUeHYBgIOyxw1cJ/tffLH8sMTL20Mo78lidlSUpQmE=;
        b=ljoDSjyPKHbrF+vIr7RIPcRDjJ4pqDDoFSl0MBBbJ4bnPP0SiNPXqRcrglHTMQhcgi
         Lnad6rwCMqFs30EuhxGmhBXDSL6OB9gmGdKZcj3MkvkruC37EsAqNl8sBvXrgDlK10RY
         HyIC2/bxhcuQWvSnUJAldiLF2bJ/koKeWWc7tYhHZoySmHV9X4nrwlsuMdWlLf+NrBv7
         sWCcoM8ADIWDjf6tNRs/zhs9b2y4MkBdSAudJTiDK0azvtUGpQ7s4MTBpe8TAhYNdxbF
         r4CoQBLkD1AIa34KAg4IqKM2nGrlK8PbCMz6EAMa2jJ4orEM+AgXvIC4/0Ai1CYMy0Wq
         y0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551174; x=1724155974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EUeHYBgIOyxw1cJ/tffLH8sMTL20Mo78lidlSUpQmE=;
        b=P0WkxQkaxEtKhB0wFWGhczpr+Bb3ZNnPN63OdJhE36TMnNNUqICBquyMgrqH10/5k8
         /M2eGAQOMI5+vHaNsX9OEX2BfA4inUf45sY6IwqM198bmR95UxGTk5z3qD3wpa7KatzH
         2JSDT3V8+EDMzzrkz5U22Zi4ajLYU6aTOLDGM3hW7JR42/0mRbNYRMCrxHtu0jrJVDwR
         WvltAkc/wl3+fzudnQLS7yrJZwkvQhztfIofdf5QQKaTwAUSRmyIL6TC4yEJ7H+YttFI
         /sKYcQPglUIzFj2nH1TCJlNKkA0bo1/4sM6T0cFdHKVvHA5PWrIDeWu63nbtTzX9WBLy
         1yBg==
X-Forwarded-Encrypted: i=1; AJvYcCVXcKz0GhkXCWNIgSOnVWxTniI0t+ovYxbRkiQO8R9TFo6A39DSdb3Pps6Ul/s7sd9uxkSgzFQtcrCFBF7vtYhfZVqlEgmSIpTb
X-Gm-Message-State: AOJu0Yw6ZpoN2/u1Jr6E+cXOcGUCjBSNFZEcLgsE8qv+CDAH/gAjQ3Dd
	N6OpYNcGdch5kvhCPZYZZnnmgCSlYVakaqYsjROsR4Pn4TgxAOAujJ52YcCJS+uLvAdGXZIOTJt
	FcsuVyv1d6gbRcLwjN7+zWfO65OL++cSsWytWOg==
X-Google-Smtp-Source: AGHT+IG+5ZFirbaJq9uj/YXf/F72dBXkXh+6sqJjhFlzF0Sk7mFjDz2GXx0obFufVKkNfw4UwTPe451tzZyRmdCS0Bc=
X-Received: by 2002:a05:6870:a11a:b0:260:fd20:a880 with SMTP id
 586e51a60fabf-26fcb8753e6mr3450729fac.42.1723551174451; Tue, 13 Aug 2024
 05:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812133127.865879-1-jens.wiklander@linaro.org>
 <20240812133127.865879-2-jens.wiklander@linaro.org> <2024081346-dutiful-stalemate-0e07@gregkh>
 <CAHUa44HYQVhT0=E9py2JsO2X93wLhZ=YvH0fBqQpzFBujSGgtw@mail.gmail.com> <2024081346-riveting-unwired-d9dc@gregkh>
In-Reply-To: <2024081346-riveting-unwired-d9dc@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 13 Aug 2024 14:12:42 +0200
Message-ID: <CAHUa44GnG1uonKASAYHSt=rNC=73svDFgCfe6XyQT+c+xs+_XA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Manuel Traut <manut@mecka.net>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 13, 2024 at 01:26:18PM +0200, Jens Wiklander wrote:
> > On Tue, Aug 13, 2024 at 11:29=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 03:31:24PM +0200, Jens Wiklander wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/misc/rpmb-core.c
> > > > @@ -0,0 +1,233 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > >
> > > Fine, but:
> > >
> > > > --- /dev/null
> > > > +++ b/include/linux/rpmb.h
> > > > @@ -0,0 +1,136 @@
> > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> > >
> > > Really?
> > >
> > > Why?  I need lots of documentation and a lawyer sign off for why this=
 is
> > > a dual license for a file that is obviously only for internal Linux
> > > kernel stuff.
> >
> > I'm sorry that was added via one of the patch sets before mine. I'll
> > revert to GPL-2.0 only.
>
> Please be sure to get proper legal approval to change the license of
> code not written by you :)

The dual license was introduced in
https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.or=
g/,
but https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-toma=
s.winkler@intel.com/
uses GPL-2.0 only. So reverting to GPL-2.0 only should be OK, don't
you agree?

Thanks,
Jens
