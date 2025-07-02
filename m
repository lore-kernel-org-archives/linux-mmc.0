Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA62DE6F5;
	Wed,  2 Jul 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489864; cv=none; b=sJB20PH0yhPgWLwmXDA0PRtYCQaxV233032m+hnCIjX4Wlan8bmaNLN8toWsjL3I46ka6AB5+Vhvnf7mcS9h5D6KZHa+waW/bOoNN5ffR+LraIDVy3+sih7+ck0Xg9yEh+b1pqPmg6f/VTv+w60p9ATgxtdNcnplw30GQ2SDMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489864; c=relaxed/simple;
	bh=ueVYBf/vvIdXw8MFHMMhsOsTsQ52WkYR53FawATwmKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4BhehIOdNHBmX+3swweDFIkrbVhxB8jh/9Bj0O/Y/wmNanjuVCVhOk73EFRC4RI/5BGGWHm3zl0+q3SfXQfP6erDxCp02aS0zPAXSMKJSiXvpnD3bcoAYuZjmSWm3wKixn5kjta7T8E/BzH0eJbGXsktVnHWjRlIZaH0/zYP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=goukj6F3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="goukj6F3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234fcadde3eso64668205ad.0;
        Wed, 02 Jul 2025 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751489862; x=1752094662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueVYBf/vvIdXw8MFHMMhsOsTsQ52WkYR53FawATwmKc=;
        b=goukj6F3jMQs5Cs5faSOT2muGXw9Ss04Jf08C9/1MfOtj58XzmKlKN7aNNubDNxOpz
         Eq3lHya5yp6JRl6n69kyKgC2i4hrGlbCnPPg28uMVFhwhiP3wjftSCRVPQHKJL7vA+Px
         yYEYvr+E5c8h9xTgO/FGoXoJcavhZONnj5oX+RIbXzW+XtUj5pg8uQS+u0yonMhj+4Zh
         mIBfRWeSlgNHumoTZGyP9UaWXKYI5TFq8lSWB/gwwMLYkJI8dk/86AMz4SowXM6YROvr
         fUBZif9x5uVxIPgzTKAwdhfoZ/QvhRedTiFAzyrsG657GxHHYH36zSF09IP5Xx1OXzqS
         WzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751489862; x=1752094662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueVYBf/vvIdXw8MFHMMhsOsTsQ52WkYR53FawATwmKc=;
        b=WDXivzKL7CLI6GmBwOtHsfr2U/B5GToj6IcwaMJes3qXOiM4/Q6ARAvqrxKbmIFIYF
         m20hDoRMyUNLtmwfWlNNyvJj0C/uhe1ry++p2OHAqxkNpK813ioHme6BsI0uMKYB56N9
         JLDdtPzAqRcL7U3BLS/AWORPut3i9y8WMMpgBJE+XcZR+4dwsfc97VTgDbe8nM7lY0Uh
         gIpWrIBWZrPPrVcVGUzJ0PDGONHVI4dHjAgqp8zTNP5zkhqzfwMd4P+xWd0LYIDVDCcA
         SGHBBBgpXv3WmrGcz9gLB7bWNCbFYWAK1r041QOUAeP4J2Jw6pUrlH5z/ZqHTaS7ZTV6
         bOdA==
X-Forwarded-Encrypted: i=1; AJvYcCUDyCm3mpk/d385DViJkmJu1GVOLyj8D/FG0lRo4Kq8jBdIU1HxzQC+oBYRA82oOGXDutAipaE6Bl/I@vger.kernel.org, AJvYcCUPdhSnLffQoFw1LX773vGCaE+qNmFTDYFrUPIsZ5Oe+K8pEZbzjYfFvms9QSiYzJGVUloptpCbzMoZepY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEpmyPZXQXtDft/mC9hOvNw/0So7CwT4i85sQ61qQ0RnTgzjN
	CLYL5hzk+J76BlfWMxiSIm3673AU+4ayznnxPsica+nGP8intL3c32SOcOeg5B4wEs37VjHWERC
	viM5tMGlcyGm556MF7eHjKzgHtlIxzw4=
X-Gm-Gg: ASbGncuxUpcOItC914LG+B/t9A1imKAXaOnO8bjwhwqjK1XSbRl3JVAO66lwtfBeKhC
	2C3jkvHn1PVC2Ife3qkpy1swJU49b1ze0rGZfXD7dGL8ZWWZo0nXuay0iUdRDP5MupC8MG3hcpa
	6TAhNcFR91aiRNGTFz7D+7EkeL892CiLewb3fndSIlP9maxU5CFRLFFCkEX6n/+Hrt9J0mCmjtP
	ULX
X-Google-Smtp-Source: AGHT+IGjgIPfifmbYpcB2lF3QfBA5zuc6wFJQKxRY4/yEEmq/VYap82lAwrs8+bzvEScw/tJQqdROF0TMX1gsfJcQ+g=
X-Received: by 2002:a17:902:d481:b0:235:f078:473e with SMTP id
 d9443c01a7336-23c6e5cade9mr66917995ad.43.1751489862178; Wed, 02 Jul 2025
 13:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628015328.249637-1-da@libre.computer> <CANAwSgTH67T9SBQSFQgFjvyrxNCbtfd9ZaCDZFACWA=ZQ-PYtQ@mail.gmail.com>
 <CAFBinCBwTkVwcBTWOzS+G13+rRM2eftMXZ3GHzW+F+BY0bBBzg@mail.gmail.com>
 <1j4ivued2q.fsf@starbuckisacylon.baylibre.com> <CACqvRUa8EqMbCd2x=di-a6jbMWW8CMo4kgLH=0qnsqHdO16kxA@mail.gmail.com>
 <CAFBinCAkW+G9oV+SOJdac50oLezQnbc358dBgs56-RfjPd-zgA@mail.gmail.com> <CACqvRUYwwgRqid8AbLJ7bp+gTyHw2c=o-pj435Z0PDriJcnnKQ@mail.gmail.com>
In-Reply-To: <CACqvRUYwwgRqid8AbLJ7bp+gTyHw2c=o-pj435Z0PDriJcnnKQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 2 Jul 2025 22:57:31 +0200
X-Gm-Features: Ac12FXz6XZtGm-3ti_MXvq5_F1onfeA5_tjNx4dcE-d4NTCOTzJlhlVHJUTnayc
Message-ID: <CAFBinCA-aFNd+UQR5oWBY+HtMcdefeiH4Oc6bvZTaYDxowYCjw@mail.gmail.com>
Subject: Re: [RFC] mmc: meson-gx-mmc: add delay during poweroff
To: Da Xue <da@libre.computer>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Anand Moon <linux.amoon@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:07=E2=80=AFPM Da Xue <da@libre.computer> wrote:
>
> On Wed, Jul 2, 2025 at 2:40=E2=80=AFPM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > On Wed, Jul 2, 2025 at 7:22=E2=80=AFPM Da Xue <da@libre.computer> wrote=
:
> > >
> > > On Wed, Jul 2, 2025 at 1:07=E2=80=AFPM Jerome Brunet <jbrunet@baylibr=
e.com> wrote:
> > > ...
> > > > If, as the description suggest, the regulator framework somehow ign=
ore
> > > > the timing set in DT, maybe this is what needs to be checked ?
> > >
> > > The regulator framework only cares about timing for regulator on.
> > > Regulator off just turns off the regulator and returns without delay.
> > There's an exception to this: gpio-regulators without an enable-gpios
> > property. My understanding is that regulator_disable() is a no-op in
> > that case (meson_mmc_set_ios() even has a comment above the
> > switch/case statement), see [0].
> >
> > > The code makes incorrect assumptions. Then the kernel resets the boar=
d
> > > without having enough time.
> > Can you please name the board you're testing? I'm worried that I'll be
> > looking at one .dts but you're looking at another one.
>
> https://github.com/libre-computer-project/libretech-linux/blob/master/arc=
h/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi#L481
>
> vcc_card is a gpio regulator that gets toggled on->off->on.
Thanks, that clears things up as I was indeed looking at a gpio
regulator while this is a fixed regulator!

> I traced the regulator framework a few weeks ago and forgot the final
> regulator disable function call, but that call basically returned
> immediately while the regulator-enable function complement had delays
> implemented.
Yep, for fixed regulators there's an "off-on-delay-us" device-tree
property (which translates to "off_on_delay" in the code).
Its implementation is smart enough to not waste time by adding delays
at runtime by implementing: on -> off + remember time -> wait
remaining time + on (meaning: if there was enough time between off and
the second on there's no additional wait) [0]. On system shutdown it
will not add any delay unfortunately (where Linux loses control over
time-keeping), meaning we can end up with too little waiting time.

Also my understanding is that it's not something that can be fixed in
u-boot or TF-A. This is because bootrom already has trouble reading
the next stage from an SD card (which is a valid boot media).


[0] https://elixir.bootlin.com/linux/v6.15/source/drivers/regulator/core.c#=
L2754
