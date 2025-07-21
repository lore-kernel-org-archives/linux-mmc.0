Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA182E36EE
	for <linux-mmc@vger.kernel.org>; Mon, 21 Jul 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065118; cv=none; b=joVWUK0uhRf4WiPK06t/q+J1Cz9nedD+CST4wXTm1esy+Lul3Tn28ay8sFGh3iN+gqJdwoht9/1O0KrAloYG/3PRi1Hd+Zo2IAp3p27HGYxgkRb3S2oJsWxWXJv0B/bg6sDv7dj1T7DjKWPynIfWqANeQmN+4vkU6vBe8P65CKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065118; c=relaxed/simple;
	bh=rdpUsZudLIihvHlw8s6RGyY68kSWWDYVobQjYQevUdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRnGcRM4eA24x8byDyU5dpwhrADIWnfJEDLXOxKvQwgXQRI9g+Bq1rotFon+w1zfOIZOfqyGySsvsCkJ2uAmbIQbgC+dDAhroD0F6CD179HB+BDc4TKuSDZaOGiUWxj1JxJtJl08tykci5C6bJW3cHGOJc8HdBqmq0DohtHlFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsDP+5c4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsDP+5c4"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so7913267a12.2
        for <linux-mmc@vger.kernel.org>; Sun, 20 Jul 2025 19:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753065115; x=1753669915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdpUsZudLIihvHlw8s6RGyY68kSWWDYVobQjYQevUdY=;
        b=JsDP+5c4T+v2Xl7WKnVAf5/DS+538rTzKO3CgLZ7l6obfSokt9IWenVPXi6dJDo2uY
         2JQAN3pJD3x1V56FHrY5xJ1hKAet1KbkTyRQSQGsUUwGSWGcgsZ4crBLT1vwSmb6NXkb
         D7ycni7KhiP/kb6KQo8Vw63lhf6dW1uZH1uYYTjWRr4CoIdT4Bt/oQSRgNxmWMr0Y1RL
         QW2LrF3VyMsYodC0AAol/BGNccMJClKTGZk4VQ+fq3FJ+Y6RRh6tmE2nrfPVOSF4EFyJ
         uBO9jAgfLiuN49E5DuxMcxo0sauC9PBIrKcctTRjd1cJg9arADQeOLDmKEyejzJHdA0v
         D5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753065115; x=1753669915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdpUsZudLIihvHlw8s6RGyY68kSWWDYVobQjYQevUdY=;
        b=KGkmAluGsbGji6ewpmeBZKaXmI/eGf77d52zVLA87Y5aVYJDLcxS0T+oGctp3hvpzt
         Qq1RgxS/r9H0ZvRbxtpWTQzycucOYpNSmYxjtm4LXjRT55upfz7Qpzm5WHyEmXstrHqA
         7fDiIn0eQ9/rP84FIFoDNXeb+x2grauha09C/QLYy2JeU+q0s/Tc0GbvX5GFvtMjC3dS
         DnfZOz2JHOb2Lt7JAdSKWppFyEJYi2aaXWvynavuUygHYn311ysDTEJxnzIds6KymjC3
         Z7c1DfOqRQpD+aP3ptrjkf9h82mTkrCgZSvZvXqPYOqNWjFCYWt+hwjnJyh+WjQGFFCf
         eEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQRlgemPqhGPhD7NYDLNEX1JrJ77GCwYWRZGu18E70CJORO4UC+XJbZ5FfZ0U4KqMTTNQUMeD41NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzav54/3LaP3bMNpdEPlxpHwoenSSx7pwsYQXa1Dk8KpZkKLGey
	ChWI33PsISB5+IUrtHAv8gtAAxtBmZhziPNSHPwCZVjkEB30Bfi5icnUCfJKov6kzDJGsO1yxih
	kgtzxAvgV0E2nMs35HoM51K6eZNV3sPOhxdt1
X-Gm-Gg: ASbGncuqkqxpIkzj1lwjyqZzxvN3Ko9CMlwdOxWAskaFdMJtkr/QFopXwY8ROgDloSF
	zahFRptayKTYONpHDA+ECZg/odLkdZZUm7fOY5CjJJwMgNYDHDxeMbaZKrInkEgDePlFodfCyB4
	pCRkuak7pV03VjvH1rMgEqvvwNk0lxf0g9gWx8Ww/stejJBx3wilLsXiSnYdGVqcsNH7PpUq+Ku
	XjBF6Y=
X-Google-Smtp-Source: AGHT+IHQIYXAoxfDV05bz0G8EOujDsEy8lqbRuBgkJeD5IzP/s3LbqWC1Mh8bGFvoMFFshb5PQ13FESi5nq5ELfaphQ=
X-Received: by 2002:a05:6402:2111:b0:612:ce8b:8e3a with SMTP id
 4fb4d7f45d1cf-612ce8b93famr8753203a12.18.1753065115196; Sun, 20 Jul 2025
 19:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510031945.1004129-1-git@thegavinli.com> <CAPDyKFq8evHyh_0QacZq=d36vXfrs3vFPsAuCyFdv3BKh0SP2A@mail.gmail.com>
 <CA+GxvY4ByPW4HVJfww2v674f-y5kuqKmY=EB8mD5jnRcy+HmPg@mail.gmail.com>
 <CAPDyKFrXnVkOatAF_adg67LxfU7YOqeR_49_u2mOQLntQcCBfg@mail.gmail.com> <b843b011bebd4dc18f9b9da290958ded@realtek.com>
In-Reply-To: <b843b011bebd4dc18f9b9da290958ded@realtek.com>
From: Gavin Li <gfl3162@gmail.com>
Date: Sun, 20 Jul 2025 22:31:44 -0400
X-Gm-Features: Ac12FXyRcHPYnz-1Bml2GTVMc5BhQ9NYwFO00j3XHXZA8XDo8_3XnN15CEPysmU
Message-ID: <CA+GxvY4=sSrhdPCsp9nUDVwNKH=FnH_fCPe8fv06pP+bVpQD9w@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for
 card presence
To: Ricky WU <ricky_wu@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gavin Li <git@thegavinli.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ricky,

This issue appears with the SD card reader on the IBM Lenovo
ThinkCentre M92z, which uses the RTS5179.

Assume that the rtsx_usb and rtsx_usb_sdmmc modules are loaded at boot time=
.

If the system boots with the SD card inserted, the SD card is detected
correctly.

if the system boots with the SD card _not_ inserted, then the SD card
is inserted after the modules are loaded, then the SD card is not
detected. If I then run `rmmod rtsx_usb_sdmmc && modprobe
rtsx_usb_sdmmc`, the SD card gets detected after the module reload.

Additionally, if I remove the SD card and insert it again, it is not
detected until I perform the module reload.

Setting always_poll=3D1 fixes all of the issues above.

Best,
Gavin

On Tue, May 27, 2025 at 11:10=E2=80=AFPM Ricky WU <ricky_wu@realtek.com> wr=
ote:
>
> > On Sat, 24 May 2025 at 05:37, Gavin Li <gfl3162@gmail.com> wrote:
> > >
> > > On Mon, May 19, 2025 at 7:50=E2=80=AFAM Ulf Hansson <ulf.hansson@lina=
ro.org>
> > wrote:
> > >
> > > > Moving this problem to userspace seems wrong to me. We should be
> > > > able to do the right thing in the kernel.
> > >
> > > Unfortunately, I don't have access to the datasheet for the RTS5179 o=
r
> > > related chips. This is what I could do to get my own hardware working=
,
> > > and it doesn't make sense to revert to polling mode for all users if
> > > the interrupt mode detection works and reduces power consumption.
> >
> > Agree!
> >
> > >
> > > > We should be able to detect if we are running the broken HW and in
> > > > that case, set the flag based on that, right?
> > >
> > > I don't know of a way to do so, especially since I don't have
> > > non-broken HW in my possession. On my hardware, once the device enter=
s
> > > autosuspend, inserting a card does not trigger a wakeup. I'm hoping
> > > that there's a way to detect the broken HW via a hardware revision re=
gister
> > or something similar.
> >
> > Yes, something along those lines would make sense. Let's see if Ricky c=
an
> > advise us on how to move forward.
> >
>
> Hi Gavin,
>
> I=E2=80=99m not entirely clear on what the actual issue is at this point.=
 Initially, there was mention of =E2=80=9Csome RTS5179=E2=80=A6=E2=80=9D an=
d later,
> =E2=80=9Cbroken hardware=E2=80=A6=E2=80=9D was brought up.
> Could you please clarify =E2=80=94 is this problem happening only on cert=
ain platforms? Or is it something else?
>
> HI Uif,
>
> Is it generally true? That devices using the MMC_CAP_NEEDS_POLL flag may =
not fully support runtime_suspend,
> Since they rely on polling rather than interrupts.
> This can prevent the decices or host controller from reaching deeper powe=
r-saving states.
>
>
> > Kind regards
> > Uffe
