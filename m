Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AED4690
	for <linux-mmc@vger.kernel.org>; Wed,  2 Jul 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490303; cv=none; b=WTvgY5oWZkWxDmY4MAbIcJG4WC0ElLg91Tpcen3vzs84MIDrKEGO2+zCT4fHipiGM+NC/5P2ykzxNmIu0CLfedhE482O6jV3TVtQTXOaYBUCvbBEBogRq/jXRe+O0+e4ALwxa99mPO8Xq8nb6Srzri0q+oVzkoQcGMOWcLwB9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490303; c=relaxed/simple;
	bh=KSFjoXjeVI9Q7mVA0gaQA96egYKc8irfnFONjI0h9KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCOErgi8WxG6kyCDCLMd6B4uaRt0gIhPrHCNi/oBrEANB9rSVcrIPxntnx/JPJJyKqABxpJoErW8otZpFLpurIz2hBwsalSa/7KThO55vVfxrC5GDL3IDzCHDwskoFjo2RDOUGjBPB6aBpx4EfhKIDZ9teg4849NikupGNsdgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=NqTOh7Th; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="NqTOh7Th"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-711a3dda147so79674697b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 02 Jul 2025 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1751490301; x=1752095101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSFjoXjeVI9Q7mVA0gaQA96egYKc8irfnFONjI0h9KY=;
        b=NqTOh7ThpWVsSW82H4ajqE6vO1eoM1at9NaQdDhfECT2LYXf9GgihegkcOX4S9c1hN
         sf985+9OCdbLOAeSeYWPGF6e2EX5D9WG8Tfz4RPd7bLco0c+3laceYynreyWB8H629pG
         C27kRoVTV0LCafFFBkTkjNZSv8eyOzAh/J8T9+VzTRWikI9qDs36Dm+Tz3UY/v3gcb4S
         QpP2zEIbiYtVERTcndDz/RU4Q86GbbC0hYz67N2Pe4Shf5o89EThyPwrgxWMYhva3pM8
         WzgfsSJGW50hM4mY48sm84R3Dbq1XqI2t7O+ks0q+EuVut8NJjxLn3cLZKJyPmYAaar7
         696g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751490301; x=1752095101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSFjoXjeVI9Q7mVA0gaQA96egYKc8irfnFONjI0h9KY=;
        b=afs2lQbdFWdmx8h5G3UOC1WHG8ERzMs+FogSJL2BnW8jnIQruR1jI8IOHgbQZcS6Je
         4LOdbkR8GrdDwf2Odt98cSRVhQsyaqTwmEG13NqLhYr6jGNHrr6OXS3zTIOD2cF60RbS
         DFQ0jYiDeTJkFnihSH36EEGONzrbWDikSM7VjaAX7/7TymqWIL39qdpSxXQOutrdxxJw
         WLo8aiRaRsHrngZCnZ54OeRGH0I+Jl4MEmpFLdpzzsLPbieBksX8GgOIse1XmMJ1VeA4
         X1u81RpDHN/aSvhkKlC/SSMbnuZZvKyxvsyEFnnA5wgbhw5M9apzMz27+TPAV4DWr5NE
         clww==
X-Forwarded-Encrypted: i=1; AJvYcCVuW2mxoFsdT4TuE1piBRb8kScCRlXaoG45TCM9ZKCLaDzRZixFKtG3rWZJwZGRRO09xVKcRtDhvd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylsk0w65acenJeewdKMnUZpoKp2qiWX9Km6pqyY9fI0TEbDMxb
	MLiNeXcMtqQwBW5KJJRSz3+1epR9fkgxKLudQWtrHxJEqUWbhmCdlX8rglkhhKLUM5nJOUVx4xH
	VgUfNYSNvgG4vD+8gGldhWVGOGxZpaT6pzqaRC7Tu
X-Gm-Gg: ASbGncvEM3hTIklJVznq+nsc4joRMhLe0jY7DYGnvJ/8yB0nyTvTB8KXiGg4G7xauvc
	1zRujTYWVyHHBDzivqpZdOCb+TCcLORzYDAxjZ7ftERT/vCgd+YxJchpwgbS2RCfEhQ6LPQ9JWM
	VtfIt9j9X56zZElSD+ojpbVYji1xITeWF4UFyoi9XpPl1+MX8fVUITqOXg8oV7ghNtjed06KOLh
	UG/
X-Google-Smtp-Source: AGHT+IEiQuh5LjlsCcA7qaI9oQhIPWCsjEyB7JTNTj6XFbJ9WVg7qPtMe5Tz7PrvBDjuqNqnia9yn5ArtcfzXOoCqd8=
X-Received: by 2002:a05:690c:6ac2:b0:6fb:b37f:2072 with SMTP id
 00721157ae682-7164d4db0b0mr64094247b3.22.1751490300545; Wed, 02 Jul 2025
 14:05:00 -0700 (PDT)
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
 <CACqvRUYwwgRqid8AbLJ7bp+gTyHw2c=o-pj435Z0PDriJcnnKQ@mail.gmail.com> <CAFBinCA-aFNd+UQR5oWBY+HtMcdefeiH4Oc6bvZTaYDxowYCjw@mail.gmail.com>
In-Reply-To: <CAFBinCA-aFNd+UQR5oWBY+HtMcdefeiH4Oc6bvZTaYDxowYCjw@mail.gmail.com>
From: Da Xue <da@libre.computer>
Date: Wed, 2 Jul 2025 17:04:49 -0400
X-Gm-Features: Ac12FXz2eBEQpE1uXBge_BXeozibSAfNnKLrTRR6ZVdJLMP7Abjjpj73aBSCXy4
Message-ID: <CACqvRUbQD3HS=_DH-ZW-D8JTkC_o2PbBkOzcZ44h57JJWW4-mw@mail.gmail.com>
Subject: Re: [RFC] mmc: meson-gx-mmc: add delay during poweroff
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Da Xue <da@libre.computer>, Jerome Brunet <jbrunet@baylibre.com>, 
	Anand Moon <linux.amoon@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:57=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Wed, Jul 2, 2025 at 9:07=E2=80=AFPM Da Xue <da@libre.computer> wrote:
> >
> > On Wed, Jul 2, 2025 at 2:40=E2=80=AFPM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > On Wed, Jul 2, 2025 at 7:22=E2=80=AFPM Da Xue <da@libre.computer> wro=
te:
> > > >
> > > > On Wed, Jul 2, 2025 at 1:07=E2=80=AFPM Jerome Brunet <jbrunet@bayli=
bre.com> wrote:
> > > > ...
> > > > > If, as the description suggest, the regulator framework somehow i=
gnore
> > > > > the timing set in DT, maybe this is what needs to be checked ?
> > > >
> > > > The regulator framework only cares about timing for regulator on.
> > > > Regulator off just turns off the regulator and returns without dela=
y.
> > > There's an exception to this: gpio-regulators without an enable-gpios
> > > property. My understanding is that regulator_disable() is a no-op in
> > > that case (meson_mmc_set_ios() even has a comment above the
> > > switch/case statement), see [0].
> > >
> > > > The code makes incorrect assumptions. Then the kernel resets the bo=
ard
> > > > without having enough time.
> > > Can you please name the board you're testing? I'm worried that I'll b=
e
> > > looking at one .dts but you're looking at another one.
> >
> > https://github.com/libre-computer-project/libretech-linux/blob/master/a=
rch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi#L481
> >
> > vcc_card is a gpio regulator that gets toggled on->off->on.
> Thanks, that clears things up as I was indeed looking at a gpio
> regulator while this is a fixed regulator!
>
> > I traced the regulator framework a few weeks ago and forgot the final
> > regulator disable function call, but that call basically returned
> > immediately while the regulator-enable function complement had delays
> > implemented.
> Yep, for fixed regulators there's an "off-on-delay-us" device-tree
> property (which translates to "off_on_delay" in the code).
> Its implementation is smart enough to not waste time by adding delays
> at runtime by implementing: on -> off + remember time -> wait
> remaining time + on (meaning: if there was enough time between off and
> the second on there's no additional wait) [0]. On system shutdown it
> will not add any delay unfortunately (where Linux loses control over
> time-keeping), meaning we can end up with too little waiting time.

Yes, this is evident on quite a few Amlogic boards but occurred rarely
enough that it can be overlooked but never-the-less should be
addressed.

On our SM1 board, this occurs more often than not. With this patch, we
can reboot the loop indefinitely.

>
> Also my understanding is that it's not something that can be fixed in
> u-boot or TF-A. This is because bootrom already has trouble reading
> the next stage from an SD card (which is a valid boot media).

Correct, not fixable in TF-A or u-boot.

>
>
> [0] https://elixir.bootlin.com/linux/v6.15/source/drivers/regulator/core.=
c#L2754
