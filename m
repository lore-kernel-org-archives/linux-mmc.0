Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94835E92B
	for <linux-mmc@vger.kernel.org>; Thu,  7 May 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147647; cv=pass; b=e5ks9vFXk05VP5j78KRh6+AI6xv4blkJjqL2J3M78wvfmfpXk+BmxxFbHAaYzdk0oaifWPsSgS1kiDm1zAVNzTkmYpbf4KyviWbLf/wdSgkoEM6JMWuYe48UuH5OBurZ54QfYjjTcm8hnkHmUTUUCw5MH0b2XS2sZX9SZPtd5fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147647; c=relaxed/simple;
	bh=USp5XzZA4eJ5QU73YEjZh5z27WHNeqKawicUWQrwGfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3cnaGm0wQgwNGKxKgbViYzm7YTngsrNIa+n+JmQh+6ETcGFENbnSbBjTBX+i+dQZJ4o+/qhFWiCsrAKXuhlI1X3erilYBGUdNTKShHdx1I0PvNDRE6kmwRaiYQPzEqrXSu5MPNm9I44QMcJtJyA1sUdoG2QMqG0Fo+IVdQdH7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMGrqY7e; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMGrqY7e"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651c5d525f6so634292d50.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2026 02:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778147645; cv=none;
        d=google.com; s=arc-20240605;
        b=BR9AixouOeprJqSTJyCL8Q/29nc52TZq0phJPZPE7uNPOHdMsOG9C56siQFVpZrLxy
         NrzrY0TvSm3FVTVODZbCWIuzlu/GGScIbHNC7wqF3D2my2opFKx2DcFYQHGAy1ooRQGG
         7V5gGGPxv49Z8HmsflD0zbg9bjjjHMEAeETzm2CUqur6zTZJIvaZFmR4uX498AoAW03+
         XG+WG+YTwY/CxSy1yGQV/DB3PKKoWUzDAyu2QMI3UtLIFT4IU2vfN4f/XnNMOif1fDkp
         y+h7Q+67NlqY1uzX98wsjAsuNgz6R3YrlMpmsCpmtgS3523qYBKIcVqsGPt96YQLvR9d
         7yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wrndUsEYmqCY5OiromaQ3GnufO56h/c2hiAzI8scZ9A=;
        fh=L8uHmWvTN6eKn9w16BgcqmfSQIKsuvh1nV6DH2s8jH8=;
        b=X7MRjfGwweg5BBfukKmgMYnXSbuwZlOltRLdo0lWcNM8Isi4QTGeZ6eW2PnEe3hqMe
         1jIiOpxyxJTfHWwyIpzGI7DlavDJmOg0hom+/d6wYqtjutEqhRyXntwpSPS86YbM1gJf
         p0tqkfIciPZJLhhM3lXmqsnyqkT/24ZHpFCVJCm0K1F7yGvQHYg+SUo48tka3aIgZK0K
         UhgCdQngEVOdNNwqNdGioaER7ubqn7iDUCIuhN80A38Mk479CvBDGPnYoegv+by9tiBb
         aK7peNAMO9RupeXwRVKyLWi4rAySXgcXbuPPyRJQBB4lf9mkU9AVtcEFRioQfW0tmdmP
         qVzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778147645; x=1778752445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrndUsEYmqCY5OiromaQ3GnufO56h/c2hiAzI8scZ9A=;
        b=KMGrqY7ejfdfkvfLBNDr/0hJtukFOX1xA+AEUCwy1n7Pluh+AtZ1pjaBZy1pLVzBcu
         vueawmtL6r1aO1/uwtJ1EFvtxua7vB++XbbW3WVLLwBsOSAYkaS4dNenxtHICB2+GwiJ
         M7unnTLb/9S8V+ywxUscWaZraovN55FBm3Tw30etTI3tMLLBupZC6Q6k5ifwKBGirdx3
         QgZe2SYm/Bhli7YKnDDDGGv/NjpQGc/s5bbsp7CLfoRow/7Fb0jTOouYicNKAaTHuCva
         3AUD5paJs5IQep1aRVdiL0jMs4iCwkaw8Ne4x54rXWKL1Mtkyqoph7XDUnGlgt7CSJ3H
         1Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147645; x=1778752445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrndUsEYmqCY5OiromaQ3GnufO56h/c2hiAzI8scZ9A=;
        b=sn2xQaThzIQEZtsVhLdpR/lT/Repv2rKwCmpQvszGcAAj7JcK17DIPUroEI5EzO9Ho
         hFGnz/bK3Fuw5pZX0bGVsoRzWI73ZbYLj++2BlY2CPc+jtDbtvpiy0Mc7z/JfQGzASje
         OUQvL5aCZlleFdraCtB9TD4cXNanDXzykDPscOL0fuHrwOFP/UHKGXFnhPLefhmbKMKG
         Bnevs/YkZL3uNdXHgm9LwfFm3TSyzp+wd0WfJDumJpbMcXe5oYybnjgW51/DrS62KjrT
         mxPiWFwPZiZGaW3Q/mVBZhXct0MR6sVPSmqyE2ysBf9ntzOZHLPQybaaqoDYVIqQupGM
         sUYg==
X-Forwarded-Encrypted: i=1; AFNElJ+2dQKcCs49YFjStretbb+bWPSss9dSwjmKC+UejTSZp957zEGr+KLdusdJvFzL1x3ZVQcJaN0ls+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Qxc5V3nb5fWwSLsnV49PZmp62l09XGWHksa8FPNl2TOV0qy4
	v4PUoxcx0QBzt45eC1fiPLJQvWhEGTrJYsUTegSAbpspWNUFGA/9ik1gZ3ztGPOysh0sVh74zsY
	Vm6K3y1FHrToVNLAplspTAcFAIxcqAxE=
X-Gm-Gg: AeBDieuX7Dk33nVdFOPZL657Bu47bOPJTEZitIQ2h+p5VVbZQ1xBo4/tiuThTJ0nP19
	rxexsBgmn8zUXSIHLYWG9ptBBtLl5NI4ckhfWO+0lcdY9jdwXI50/VfhTwKEuwrq99NQjrDapQQ
	2imPn/kTRkkokhl9xQ9Q+wrLfzZVCg6xwlOpn7Rhl4rMvZTWYFgGqfcAO5RqGWRh695H+9A8DJz
	KLrAysxlBgAgCy8zbywSIGDIGkYEyG66zVc3Fn7UY8Eq2Fz3Ju77CgFU5bdfWlc0jfjim1xnm9K
	wgwI3GlTw8SU1excBkLXUBQOiDIXtw==
X-Received: by 2002:a53:bf12:0:b0:65c:6220:5fcf with SMTP id
 956f58d0204a3-65c79e5a8a0mr5462411d50.62.1778147645342; Thu, 07 May 2026
 02:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com> <CA+Xcp4nY9GVMOmtMG-PNhY2vqP4Cc_amAMSa+M3vuDjWUkuCHw@mail.gmail.com>
In-Reply-To: <CA+Xcp4nY9GVMOmtMG-PNhY2vqP4Cc_amAMSa+M3vuDjWUkuCHw@mail.gmail.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 7 May 2026 11:53:53 +0200
X-Gm-Features: AVHnY4LT9e56Cweesam2LzF6uMchLh2zxP8j2JRmkUPbJrDgBoSBvkiVcFsuGIw
Message-ID: <CABdCQ=OsPva9=YPdBd=3HW1OO7=_zJtpXjvaiA0WLEDT5Scs_Q@mail.gmail.com>
Subject: Re: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
To: Margherita Milani <margherita.milani@amarulasolutions.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

El jue, 7 may 2026 a las 10:20, Margherita Milani
(<margherita.milani@amarulasolutions.com>) escribi=C3=B3:
>
> Good morning Iker,
>
> > Add complete SD card controller support with UHS high-speed modes.
> >
> > - Enable sdhci0 controller with 4-bit bus width
> > - Configure card detect GPIO with inversion
> > - Connect vmmc-supply to buck4 for 3.3V card power
> > - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> > - Add dual pinctrl states for voltage-dependent pin configuration
> > - Support UHS-I SDR25, SDR50, and SDR104 modes
>
>
> Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
>
> However I noticed it only works when CONFIG_I2C_K1 is enabled.
> Michael Opdenacker told me it's necessary to enable the regulators
> used by the mmc controller.
> Should we add the dependency between CONFIG_MMC_SDHCI_OF_K1 and
> CONFIG_I2C_K1? (Unless some boards don't have these dependency?)
> Thank you for your patchset which was really nice!

Thank you for catching this! You're absolutely right about the dependency.

From what I can see, all current SpacemiT K1 boards follow this design
pattern where the SD card power is provided by an I2C-controlled PMIC.
However, before adding a hard dependency, I'd like to get input from
the community, does anyone know of K1-based boards that provide SD
card power through fixed regulators or other means that don't require
I2C?

>
> --
> Margherita Milani
> Embedded Software Engineer
> M. +39 334 758 9111
> margherita.milani@amarulasolutions.com
> __________________________________
>
> Amarula Solutions SRL
> Via le Canevare 30, 31100, Treviso, Veneto, IT
> T. +39 (0)42 243 5310
> info@amarulasolutions.com
> www.amarulasolutions.com
>
> On Mon, Apr 13, 2026 at 10:05=E2=80=AFAM Iker Pedrosa <ikerpedrosam@gmail=
.com> wrote:
> >
> > Add complete SD card controller support with UHS high-speed modes.
> >
> > - Enable sdhci0 controller with 4-bit bus width
> > - Configure card detect GPIO with inversion
> > - Connect vmmc-supply to buck4 for 3.3V card power
> > - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> > - Add dual pinctrl states for voltage-dependent pin configuration
> > - Support UHS-I SDR25, SDR50, and SDR104 modes
> >
> > This enables full SD card functionality including high-speed UHS modes
> > for improved performance.
> >
> > Suggested-by: Anand Moon <linux.amoon@gmail.com>
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 24 +++++++++++++++++=
+++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/ris=
cv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index 5790d927b93d..a7d88564630f 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -220,7 +220,7 @@ buck3_1v8: buck3 {
> >                                 regulator-always-on;
> >                         };
> >
> > -                       buck4 {
> > +                       buck4: buck4 {
> >                                 regulator-min-microvolt =3D <500000>;
> >                                 regulator-max-microvolt =3D <3300000>;
> >                                 regulator-ramp-delay =3D <5000>;
> > @@ -241,7 +241,7 @@ buck6 {
> >                                 regulator-always-on;
> >                         };
> >
> > -                       aldo1 {
> > +                       aldo1: aldo1 {
> >                                 regulator-min-microvolt =3D <500000>;
> >                                 regulator-max-microvolt =3D <3400000>;
> >                                 regulator-boot-on;
> > @@ -367,3 +367,23 @@ hub_3_0: hub@2 {
> >                 reset-gpios =3D <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
> >         };
> >  };
> > +
> > +&sdhci0 {
> > +       pinctrl-names =3D "default", "uhs";
> > +       pinctrl-0 =3D <&mmc1_cfg>;
> > +       pinctrl-1 =3D <&mmc1_uhs_cfg>;
> > +       bus-width =3D <4>;
> > +       cd-gpios =3D <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> > +       cd-inverted;
> > +       broken-cd;
> > +       no-mmc;
> > +       no-sdio;
> > +       disable-wp;
> > +       cap-sd-highspeed;
> > +       vmmc-supply =3D <&buck4>;
> > +       vqmmc-supply =3D <&aldo1>;
> > +       sd-uhs-sdr25;
> > +       sd-uhs-sdr50;
> > +       sd-uhs-sdr104;
> > +       status =3D "okay";
> > +};
> >
> > --
> > 2.53.0
> >
> >
>
>
> --
> Margherita Milani
> Embedded Software Engineer
> M. +39 334 758 9111
> margherita.milani@amarulasolutions.com
> __________________________________
>
> Amarula Solutions SRL
> Via le Canevare 30, 31100, Treviso, Veneto, IT
> T. +39 (0)42 243 5310
> info@amarulasolutions.com
> www.amarulasolutions.com
