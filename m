Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4B2E3B07
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543980; cv=none; b=NQ6sZQMc1OYvoDAvhgM+PK0Et1Rx1aks5OjQgcEQT15xJvFLFcnx8bnmnStFFOGtTtx7TKzwU//dqzQsOu63E8uSYVUydGJBEGPxzAYTCPLfrkRcShjqTVdekRntVl1vP03xLX7L/9QsqbA1FyYH5irmZdxhd6J/pb1/agl69Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543980; c=relaxed/simple;
	bh=pefmerJdn8/jbn5cGxudCHFA3qaC/GYL41dyFZHwfn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfD5/YakaRLZu8IiZtJIbrapc92A70HR1vjjTo+KM+Ckvxz3Sxnx3iZpllFDmHhvZT0tzg6jaYq56rw0ZgbiE03zynCZO3zxyIPRK9bTuDQxWu+oe6ugQt9v/Z9YE73iS3PX0/OppDAQAp43BfSPxW5IQoswh8qu15h9soi2z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ub7S05Hn; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ub7S05Hn"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso6967735276.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751543978; x=1752148778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pefmerJdn8/jbn5cGxudCHFA3qaC/GYL41dyFZHwfn8=;
        b=ub7S05HnHQbTw/Vi1Rxca/j31cTcVDhT+0sn+rh7QmwQnO1NGY90W7jqQAoJQ9U6Zj
         tZincjQ8TgQs9IdEyT+0YRWorEzPgHB2I6DOPDIkkLR0MXfX92gYXbKkCFI9//pXeTBN
         1Ifz6lCsF1rQzTfW5v57fDdC9Y3m2XOmtgUN5I2j7z5Eh/d46wsSRI8VZU6oYa8hGAPC
         /zUn+gyu7mzdrE9KCXAFNKOre7/7S5bDI982yr6+YYxbyVzBrC16pcuk1Kj/7MGtCf+a
         Iey80H/GbzkJkyCmLqRp8lkB5JyYzMaQS62pmnfQYjbR2QzdRelRUfjD6p36oT6SOL0d
         vFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543978; x=1752148778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pefmerJdn8/jbn5cGxudCHFA3qaC/GYL41dyFZHwfn8=;
        b=ZW/KXa901w+P3vm94/Y248KI9kgEumg5PhBxZ8qosF721d/dNxJnVirlllqbnYJGuG
         v/5G8ckKrsHq+JUMOzM7dW35edjFgnhGp+LNHrckxdGcUIRVNo6p+1XXqvgHI1k1QvaX
         fca604fvxlaSkIiVTJoakHSIW6dqRsVT6Pke79LA/jey8mSL6C1b+V2zeuu+u8PpXkka
         AQgftp/AyaGsgjGWWwhE53MsfsiNv3MJqgKHG0hhIaWulVRiwO7Qszecz2oGLwBI4BiI
         VcfvWDw3RGvK2eauWoLpguhlwh6wpt8SVH6IPqZmkR9QpSlNT2D8zb4RwTMx95QakO6T
         d5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmT7GpJBwygV+HXyTAXWuzoZFba0ijCLzy8g5cWodMsot9xN228S9/ze5t56u7tmT/afcST3rB5Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUp4xfnp2vSoA8Ti4sl92cxi7LhD7zCoGk3E2Dpzq4zaeloA2O
	sRFrFNtXgEAHmKxy6lHoCGIPYB9aviVKUwATsMyOJ+cs/dFRTu8thyDRJFmZletcyBBlgRPWux8
	XS1+V+ZQhYrs4YODH8MY2opvpy383kQWjNSoSdrk6Ow==
X-Gm-Gg: ASbGncsqxvUV+dLHMY+IfhkwuiibHunrgNZsBWAAgHuFQAUp/UVrQwasASxqec/MPLk
	i0nHqXirp1JojVk+L/XINRX+9mgIuAJOzWScLH3LgKfwbzL+quhot7771M3Nt0FgynWH2jWSOog
	UXyZt5+tKOFOlRc9RAecpXfbn67ymZ4I0FN+pmYP9AwJTc
X-Google-Smtp-Source: AGHT+IE4ABxmPlTweefnMNsTpO2kCyQ9vfeRptaKcZLVagFwBqIk7hKHDQ6xwciT22sGwc042fPZVZE0KvPkjt/nFfA=
X-Received: by 2002:a05:690c:ec7:b0:70e:779:7e84 with SMTP id
 00721157ae682-7165a3d82bcmr36904677b3.27.1751543977760; Thu, 03 Jul 2025
 04:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628015328.249637-1-da@libre.computer> <CANAwSgTH67T9SBQSFQgFjvyrxNCbtfd9ZaCDZFACWA=ZQ-PYtQ@mail.gmail.com>
 <CAFBinCBwTkVwcBTWOzS+G13+rRM2eftMXZ3GHzW+F+BY0bBBzg@mail.gmail.com>
 <1j4ivued2q.fsf@starbuckisacylon.baylibre.com> <CACqvRUa8EqMbCd2x=di-a6jbMWW8CMo4kgLH=0qnsqHdO16kxA@mail.gmail.com>
 <CAFBinCAkW+G9oV+SOJdac50oLezQnbc358dBgs56-RfjPd-zgA@mail.gmail.com>
 <CACqvRUYwwgRqid8AbLJ7bp+gTyHw2c=o-pj435Z0PDriJcnnKQ@mail.gmail.com>
 <CAFBinCA-aFNd+UQR5oWBY+HtMcdefeiH4Oc6bvZTaYDxowYCjw@mail.gmail.com> <CACqvRUbQD3HS=_DH-ZW-D8JTkC_o2PbBkOzcZ44h57JJWW4-mw@mail.gmail.com>
In-Reply-To: <CACqvRUbQD3HS=_DH-ZW-D8JTkC_o2PbBkOzcZ44h57JJWW4-mw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 13:59:02 +0200
X-Gm-Features: Ac12FXxCb6oqZOa8O1MizlWOqoPM1IT9eH5G_i8Ay4xusdukzHzWPjGOuUZDyNo
Message-ID: <CAPDyKFo_1KHLw0_OE2ppJnA1TKmmd4EKjMKcSqOdGo91bMgMTw@mail.gmail.com>
Subject: Re: [RFC] mmc: meson-gx-mmc: add delay during poweroff
To: Da Xue <da@libre.computer>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Anand Moon <linux.amoon@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Jul 2025 at 23:05, Da Xue <da@libre.computer> wrote:
>
> On Wed, Jul 2, 2025 at 4:57=E2=80=AFPM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > On Wed, Jul 2, 2025 at 9:07=E2=80=AFPM Da Xue <da@libre.computer> wrote=
:
> > >
> > > On Wed, Jul 2, 2025 at 2:40=E2=80=AFPM Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > > >
> > > > On Wed, Jul 2, 2025 at 7:22=E2=80=AFPM Da Xue <da@libre.computer> w=
rote:
> > > > >
> > > > > On Wed, Jul 2, 2025 at 1:07=E2=80=AFPM Jerome Brunet <jbrunet@bay=
libre.com> wrote:
> > > > > ...
> > > > > > If, as the description suggest, the regulator framework somehow=
 ignore
> > > > > > the timing set in DT, maybe this is what needs to be checked ?
> > > > >
> > > > > The regulator framework only cares about timing for regulator on.
> > > > > Regulator off just turns off the regulator and returns without de=
lay.
> > > > There's an exception to this: gpio-regulators without an enable-gpi=
os
> > > > property. My understanding is that regulator_disable() is a no-op i=
n
> > > > that case (meson_mmc_set_ios() even has a comment above the
> > > > switch/case statement), see [0].
> > > >
> > > > > The code makes incorrect assumptions. Then the kernel resets the =
board
> > > > > without having enough time.
> > > > Can you please name the board you're testing? I'm worried that I'll=
 be
> > > > looking at one .dts but you're looking at another one.
> > >
> > > https://github.com/libre-computer-project/libretech-linux/blob/master=
/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi#L481
> > >
> > > vcc_card is a gpio regulator that gets toggled on->off->on.
> > Thanks, that clears things up as I was indeed looking at a gpio
> > regulator while this is a fixed regulator!
> >
> > > I traced the regulator framework a few weeks ago and forgot the final
> > > regulator disable function call, but that call basically returned
> > > immediately while the regulator-enable function complement had delays
> > > implemented.
> > Yep, for fixed regulators there's an "off-on-delay-us" device-tree
> > property (which translates to "off_on_delay" in the code).
> > Its implementation is smart enough to not waste time by adding delays
> > at runtime by implementing: on -> off + remember time -> wait
> > remaining time + on (meaning: if there was enough time between off and
> > the second on there's no additional wait) [0]. On system shutdown it
> > will not add any delay unfortunately (where Linux loses control over
> > time-keeping), meaning we can end up with too little waiting time.
>
> Yes, this is evident on quite a few Amlogic boards but occurred rarely
> enough that it can be overlooked but never-the-less should be
> addressed.
>
> On our SM1 board, this occurs more often than not. With this patch, we
> can reboot the loop indefinitely.

Even if this patch fixes the problem, it doesn't really seem like the
correct solution to me.

Would you mind trying to extend the regulator subsystem to deal with
this instead? Feel free to keep me in the loop if you post something
there.

>
> >
> > Also my understanding is that it's not something that can be fixed in
> > u-boot or TF-A. This is because bootrom already has trouble reading
> > the next stage from an SD card (which is a valid boot media).
>
> Correct, not fixable in TF-A or u-boot.
>
> >
> >
> > [0] https://elixir.bootlin.com/linux/v6.15/source/drivers/regulator/cor=
e.c#L2754

Kind regards
Uffe
