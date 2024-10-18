Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F620100F;
	Fri, 18 Oct 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247989; cv=none; b=moP6S3WBJLutiJkPS3viIous0NSD7tCyOXUrLnz+n/kR8Gn5r3Y9rrWLcDBcvK8TCkY1zFlXnh1aLYvgyTM0GkODKjsQuD6uGimqIfXfX2xq2+faVHfuJ7bIugaAHZcbowY7qug5FDsOQ43+pVKnVwwHvKEvtOLpzLKAyuyVsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247989; c=relaxed/simple;
	bh=GyP5R1sqyB3oHftu8vlZv+ZSS2Pv3n/wDR/3Mn90H1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjpTZysynVEqXE5G4lWknFoNYS4pbR+YivSOwLS+F7hz/VEbxOmzeLMf6+zVhqafdAIkTlz+7kqDIvgYXsd2b7sjE35N/YoRU29oYVkRY+GczIq25Ia7cL/w4Ostn2k/ZSZvMaIwxcwRPZZwnaJgPYbvdZkyhyKKHwnngQhjym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYiQyWz2; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYiQyWz2"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fd057a993so675612241.3;
        Fri, 18 Oct 2024 03:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729247986; x=1729852786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWN7rSl/szRs9AEJZ/wqPmbYSzwqi4KQlM7z0+3Bf90=;
        b=KYiQyWz2/IIC4iWt/ZS8iLvGjx8FzbWLiYCi2i2ia++1+MN81rnqKv7kr0ZuNlMj75
         xtWasJKX/m9E9MWTQ2kDGgdCXCU5dvvWqy3B+68VHqpba6VqRethDBvm8E/yEqlzrUB6
         kzRZndt2nrTC+d6hOS9/N/HTRwvFVP3lNwSuiZjR8g/a7OFlZ07GrxO7wjeWpdmeOfk2
         Ra0fzajBXscRjmkfcCl6fjR1RkX0M9h91sDHF5psCfmC+Tqn27f4PO3Y96jwbVH8hJD2
         ty7btQ860i3v+393eaTdHuJbaHNMbWMTiIhSmxLJKWL28Tk7fs4nWpltyUkEyDg0fO5r
         pxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247986; x=1729852786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWN7rSl/szRs9AEJZ/wqPmbYSzwqi4KQlM7z0+3Bf90=;
        b=Gfk9HdvcLx3JCpa20lukcUYXfmBFjq4Xl3yFFTbXvdVYMEIuWLdiB5J6/tLnYtn74B
         vDxnZSWNxLDoBleh89tLcl3Fr8HuK+SDwc1QymWLZAgfiqNM4XwP6EguXpZ/KqyUoa2a
         E1XsZvH5h5hJ8vyu0kjO+7KGqLmNDdjZaZpHUlR5sWdb7T0SDjGD3IT9oDNg3iBZaSD3
         W3gi9U0Q9laKx+eM56JOUjzm6jlT2HvjBuh+nHb1IEO4ykZteSEp2J15JzKXUNBqZ8ax
         iE89mzYn7w+xVAFMRLN4CcTuI9BiZCA/2P1RH7FUC1Ic94+7yO5NZUvoPlqqa1LzIe00
         VskQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSadVyOpozCEON17lQy/kABWfC6igLU7nCegzb/mA3ofacKaQc+w/z/CsaLzQi5fMAsIxXUAkbhxXa@vger.kernel.org, AJvYcCWMRlUs/85ahRZLSgeTh173upv2UD5wTU7SNqPuPB07jiQy8O3DmDdYDFa8Mcyo82xLzmMz71ToW2t861c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HKypmyLUtv1s6et7R/JUbO+OyaYBPAoCNi8+CPluLrfDHiJd
	aH1WYca8TTTSjYh+aPEtIV8bQ6bqrk7fKUKHNQrqUYsXvwZ1IDasL+uO0GI5u4EC3WeCj0efsti
	wtp4Xnk4i7WHkZ1UT9nXTVLz20iM=
X-Google-Smtp-Source: AGHT+IHyWFAXxIY8a43l8JBnDzykDlfyFyIsFuNfgUNB16YSMENlAjx+TBk8TzIgYecD2vUKznssuHLrFbqifdQMkyU=
X-Received: by 2002:a05:6102:26c6:b0:4a4:8b67:4f6b with SMTP id
 ada2fe7eead31-4a5d6ac0071mr1978480137.12.1729247986359; Fri, 18 Oct 2024
 03:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <20240913102836.6144-8-victorshihgli@gmail.com> <CAPDyKFrbVY3OGmCn0wx8yv2n61ALAa54-vkUVqU8+bLo_=y=6w@mail.gmail.com>
 <CAK00qKDC6yciJS9JEjGjmqwEe4FRYGmppkYyFG72b3SFxzu1Zg@mail.gmail.com> <CAPDyKFp8jCf9dq2WyC_4ss4KvQXx6TFv9f-6fkQFQDjKHnA55Q@mail.gmail.com>
In-Reply-To: <CAPDyKFp8jCf9dq2WyC_4ss4KvQXx6TFv9f-6fkQFQDjKHnA55Q@mail.gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 18 Oct 2024 18:39:34 +0800
Message-ID: <CAK00qKD20R4a=2ptDrwsoNA1jRRcpEyi5REKTuW-7EupDp=VKw@mail.gmail.com>
Subject: Re: [PATCH V22 07/22] mmc: core: Support UHS-II card control and access
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Jason Lai <jason.lai@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 7:22=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> [...]
>
> > > > +
> > > > +       /*
> > > > +        * NOTE:
> > > > +        * Should we read Externsion Register to check power notifi=
cation feature here?
> > > > +        */
> > >
> > > Yes, this is needed too.
> > >
> >
> > Hi, Ulf
> >
> > We have the call sd_can_poweroff_notify() in the _mmc_sd_suspend() and
> > _sd_uhs2_suspend.
> > If we need to check the power notification feature here,
> > do you have any suggestions for the type of power notification that
> > needs to be confirmed?
>
> Right, I see what you mean! It's been a while since I read these parts
> of the SD spec, apologize for my ignorance.
>
> In UHS-II mode, the power-off-notification is *not* supported. This
> means that we should not use it from _sd_uhs2_suspend().
>
> In UHS-II mode we should instead use the so-called "hibernate" mode
> (hbr bit in the GO_DORMANT command), which allows us to turn off
> clocks and VDD1 (corresponds to the vmmc regulator). Note that the
> support for hibernate mode is optional for an UHS-II SD card. Thus,
> the support must be checked via the corresponding field in the PHY
> capabilities, before we try to use it.
>
> That said, to not make it more complicated for you to get the basic
> UHS-II support landed upstream, I am fine if you decide to defer the
> support for hibernate mode to later. Instead, it seems like we should
> just do a regular power-off in _sd_uhs2_suspend(). In other words,
> just call sd_uhs2_power_off() from there.
>
> Moreover, reading the SD Extension Registers would still be valuable
> during the UHS-II card initialization (even if hibernate isn't
> supported), as it allows us to support the "cache maintenance"
> feature, for example. However, the support for these features are
> optional too for SD cards, so I am fine if you decide to defer this to
> a later improvement too.
>
> Does this make sense to you?
>
> [...]
>
> Kind regards
> Uffe

Hi, Ulf

I hope that this feature can be implemented later.

Thanks, Victor Shih
