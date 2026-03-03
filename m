Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37926FA5A
	for <linux-mmc@vger.kernel.org>; Tue,  3 Mar 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546307; cv=pass; b=UYvM85yl7By10WjH+fajgFaSyK2NzSXk22h8mchzwhHaSb2LfOYQ3FfAh5Cx3Rn5OpyLeWXCDSxu59TdS0mouzIrtyrjx+d9fXs4woTi0sNUWA+kfm8L9jP4EwqYwT1RJ5V2M6x6mFK7yxRd2NmdnxSjvNpT2gX1MYz4CGdXYhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546307; c=relaxed/simple;
	bh=cHDl/UGxVI3bg2xIA4BoN5IYdh6+l3v4+cbwiHeVBNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4Tt9RYH/Zlk+L1npw8VHDG9jiSn+B1+zQs6eP6RnTZ7adp9aA9fDtdEYXw4keI2GR+WKfRFDbMZD8nq6Am5cwWmgdT6C4EikUSR9XaYi2RKcwZLqXQf4cyLwoCPFisovfESVmyXQyuIGkRkuM6vwFqfpHm+LevVAkL9cGwNbG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTQFqQD9; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTQFqQD9"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7986fb839f5so47637397b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Mar 2026 05:58:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772546305; cv=none;
        d=google.com; s=arc-20240605;
        b=WLM5gbWJjfIbNqjvgzBPnNkBrZb38DEGo3nQ0vaD0ukMdKPE+6yWtKlmyhJIahZxdn
         lPgJ5YC/Mp+uKHBZdoksgjT6QtDKJOXTJ3AUt0QFLlrDtQd/vWqxP4qt1EyON5gJE9Gd
         sRhfVdtblF5j5GArwx8zuiOTuRfSxSckIjJX5HAvE6CvGXo+LHWaNZjmX6Za5RXbTP4v
         MW33zP+a2nn8rMR9A6cik0N+fkmw1QdnES7RaQnRCD66Y69xOyV/th5mbtU5OtMIn2DV
         UjH1BBbnMbMNNg0aPT1WNZMCu4sVeOc6LH8pmRcL1KcqIgDyBjYpMak4010U1BI/nj58
         I8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25Zk0eBlVyMNHvv/kU7Q4vGl++ta3IdblXKrhWJCrxQ=;
        fh=jfws2Kx7QgOPVZJMHKPO25EgBhAwWZrnOrXFGZjevhE=;
        b=INUj1aU+adZ6ZSxSX+QSrH5fvy5LpNe3fJ9XqdZfNYo5fW+iDDsvH8XwqwCbpH34jk
         eDavUuZJackCSZXhhbHTe7WdP5sAF9ii/W3mMudL1T/5ilFPj8tZ5HWs1bfgtoe/yojN
         dzdGbaBIXyQH4jl+QrYtK4vjhloL74sAt60Gh3MrlaVHwW4tP8ksRG7zhqwo6lngK7Tr
         1goDYZEYnYUGKtAi0HIKfVjkOgoxUXZIdVVx+twesHFbJcloKRQ6Dmp6rszAQAePkTGU
         38a/Ev6m5qPgvFRgAhoC5uzLAG/4+uEp3KKKaVTv7GoLhJbd86NWMrKXndSySJMAhuLV
         DTJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772546305; x=1773151105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25Zk0eBlVyMNHvv/kU7Q4vGl++ta3IdblXKrhWJCrxQ=;
        b=fTQFqQD9S03rdJHWIx7FV1e4PAtmVkSVhz08nudyJdkDjA3gMr6VPadoRc+0HXIu2x
         UiwfRVyLoK2pMnnlm8WNgHuSe2E+yDdutXLWvwG+HfjH6vvPvTpsBySJgEazp/y6wKwb
         mBw/TfJv8OsMwIrru91NHJEm65LEEM2s41tfBOQRMemxZHkEWtToCpXt0VGICzm46zZP
         ygZtw0sWX7XI5a9YLA13mYQs0orpBei+esC0i2ks0axDkczQHRY5tbeetnAlXtlBpo9+
         7FBsppjbnnumkO8V5Pe9sNCUTP27KHY8yWEAzAfG2P6LtxXm9+zS912RYDoMvoSwt9dH
         V1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772546305; x=1773151105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25Zk0eBlVyMNHvv/kU7Q4vGl++ta3IdblXKrhWJCrxQ=;
        b=rflPaUsVftb+7M0D7ipUU509vPQJTf93SlvK9PF+M2xbTT6TDwnH8s1jtiaQ0VLasf
         a/p3yVJBbJdgux1BQ5CeU+wXl8Kn55fduZ0nSXpvZ8R7flGkZN9C85If4mM5KiHeKzKs
         c1P/Ac35qr6GsKdhPbwQ/FO9kzSh6tbaTTaNHoWWG5/vM5N9Z7v0nR4lxj17d74EO9U3
         Mscwec5PWNi8ezFlJWPpmakKUwkhqNvNNvl+nSn2J5cm/VrW7tnK+7oy9mDbMABVuV/U
         uPnuBTK8a5wQEv6ingNQ2jMHKx5e4rMEmatLOfXYvThkwLgas5gKYv/5edozNYP7yVM2
         +jHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsRjtzmX1kdEOBeEIX0M4prE4iVAVUSA5PNDzwRS8jAO8D5CaV+pAT/263jytJIKTEDvnTdWbJhNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHlNrsDe1HytHO3uwn/BjaVh7vsc8Bjt3KMEFn/UWyBmIl5H5
	5TFnwxk89t2xxAfrgxQ/PixdEzZRSuDudYGS9PRURK9pNZYbzaNLbriOl7FOni3XvM7kXBzhooK
	7yi2MvVT+pv7p8MAFhMUkYF0sQrq3z1A=
X-Gm-Gg: ATEYQzw8wbDiuaiRA6as0NhLaUn0Dtd6tTUP8XT3La+CzO0HO9u/1VDUgFQ9Zuhn6Km
	dWL8qTSp9cA09n/ZjPXFz6ljo5HRShJy9x3y6wVmpGfY6o68fQao637Po1bbgJQs53Gj0i5im8P
	kdrQLiTZh6FcNxyY90+kbd3KzQzi1U4HoDj3cOdRwplizlBavfJloEPvXpx2upQKwmx/2YXEJF9
	/oUeMXBsgix2EBfeVlla+ev60zK5SNClF7ny6k7tVr1s8yMefMXNOtLr8lUkKYiVvwEfVgbAjzO
	CCiKcKEw
X-Received: by 2002:a53:ecd5:0:b0:64c:bae1:2168 with SMTP id
 956f58d0204a3-64cc201e46fmr9653985d50.12.1772546305463; Tue, 03 Mar 2026
 05:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
 <20260302-orangepi-sd-card-uhs-v1-3-89c219973c0c@gmail.com> <aaZfVZoCe3AxTzAf@pie>
In-Reply-To: <aaZfVZoCe3AxTzAf@pie>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 3 Mar 2026 14:58:13 +0100
X-Gm-Features: AaiRm52kBZDv7RHaHk__HaURlrgDL3u1uXFkZRgyX5QSdwPI4llWUBVCuA0ve_E
Message-ID: <CABdCQ=NporA_1wRZx-dG3pXE3mmqT1g=M18Utpqpewt5qXLiCg@mail.gmail.com>
Subject: Re: [PATCH 03/10] mmc: sdhci-of-k1: add regulator framework support
To: Yao Zi <me@ziyao.cc>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 3 mar 2026 a las 5:11, Yao Zi (<me@ziyao.cc>) escribi=C3=B3:
>
> On Mon, Mar 02, 2026 at 04:13:24PM +0100, Iker Pedrosa wrote:
> > Add regulator framework support for voltage switching operations. This
> > enables proper PMIC control for UHS voltage switching between 3.3V and
> > 1.8V signaling levels.
> >
> > - Add regulator supply parsing
> > - Implement voltage switching callback
> > - Enable mmc regulator framework integration
> >
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-of-k1.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>
> It seems PATCH 4 should be squashed into this one, or the functionality
> of voltage switching isn't really complete.

That makes sense. I'm still learning the best way to structure these
series for the kernel, so I appreciate the guidance. I'll squash patch
4 into this one for v2 to ensure the voltage switching logic is
atomic.

>
> > diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of=
-k1.c
> > index b703b78282ed8d89183c816477c149c0a565618a..c260cb89704ae7a25bec0f0=
7831d495553405bbd 100644
> > --- a/drivers/mmc/host/sdhci-of-k1.c
> > +++ b/drivers/mmc/host/sdhci-of-k1.c
>
> ...
>
> > @@ -291,6 +297,12 @@ static int spacemit_sdhci_probe(struct platform_de=
vice *pdev)
> >
> >       host->mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
> >
> > +     ret =3D mmc_regulator_get_supply(host->mmc);
> > +     if (ret)
> > +             dev_warn(dev, "Failed to get regulators: %d\n", ret);
> > +
> > +     host->mmc_host_ops.start_signal_voltage_switch =3D spacemit_sdhci=
_start_signal_voltage_switch;
>
> Why not assign start_signal_voltage_switch in the declaration of
> spacemit_sdhci_ops?

You're right, that=E2=80=99s much cleaner. I'll move the assignment into th=
e
spacemit_sdhci_ops declaration for v2. Thanks for the suggestion!

>
> >       ret =3D spacemit_sdhci_get_clocks(dev, pltfm_host);
> >       if (ret)
> >               goto err_pltfm;
> >
> > --
> > 2.53.0
>
> Best regards,
> Yao Zi
>
