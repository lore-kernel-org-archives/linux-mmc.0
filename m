Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8042D0C8D;
	Wed,  2 Jul 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473689; cv=none; b=SSFgiG3orQzjpVhsAa5sCcDgFKIckaZW2j5WWWvEa/8PiLIka1MK5ThwHWoXpPVAOxwSdoCyp9P+p9iltzU+ZKXlhgoyFT+A4n8wYObxrfSjnS89PNQlNIbACiu4e86tcZ7ULwLNElNd2ugmJMhC3xnC1jhF6iW2Ydtjw9YToLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473689; c=relaxed/simple;
	bh=ZCTshSXQVcM1KFm7TGSucuLFTkQjMwCjolHqQrquCrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roC6F+KXL4hcsKJa1Ne9iQC/l9PyWhTYHNxG1gDC11mxv1R83vu0mApftPeoKyy7VeA3/fY5X9/WfoV8YaclxYCvFT3FkOzRz7O4d3RitJb/Dd/Dz3z5W9oS0pjT5KFIKFuaqYwqq5gozAlfNvckzgoLWDe2YtpzAJrIkz04XUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PqdqjY1t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PqdqjY1t"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235a3dd4f0dso44490275ad.0;
        Wed, 02 Jul 2025 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751473686; x=1752078486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCTshSXQVcM1KFm7TGSucuLFTkQjMwCjolHqQrquCrk=;
        b=PqdqjY1t0HMPnZWtHgWQVhH7qQvZJuCp1mzKMZGAIMa7ThO9T6KC6+q0VSEUFurrsE
         mGH0MeUUPGVGyXobPgHgk+cTMuGpbkwaUzdczAnMpB8nW2ahwnEjhSmcZsbNcLUpBj5a
         0AxCfv/pDxU+RAneMFh5QAtBpDnntztBFn+3sKNQ9ntAlXCT1+vOEkKb6asb91POl5qM
         ArK3pRKE+cwJVGqZ4+95puA5lXyRXLMs9yenTR2en4W1LFF6nIj1RxSyxfDF9uu2xeyV
         cGjXKRtocR2iohFKv5mT3eAV61R23H8lu8qIlccfM7oNOX1a98qKih6cGacVddtjFGsJ
         Eneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473686; x=1752078486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCTshSXQVcM1KFm7TGSucuLFTkQjMwCjolHqQrquCrk=;
        b=rAenuvMQ1Wn/w91HiE1t4GulWldlqxt+AzBE4tVRxuUf/zHa+zYkD1jBlNYTgUQif5
         EnVujVWukPxo+jSvQdx9RqiBgtLO/qualuicAD6uYmdwRpB/81T5O5MqV0jvwgN66Ul6
         e0qsOiPZAFmz7UOsEJGlExZ6ujZBsd61LkJjo6OX3uvnSZ1Tiw9xYkn+AJQNVRQTWd0Q
         2dMQxn1hy9aS8kLi1/efZWqHmTwbk2OWeuUbi3X5ZbJvscUYt1cLA9U5k71KRHWj2JGQ
         7Jf9FWUFeioLy/b+3jd/B8IjieKM6adRg4WtqXe9r4Ggg9L+imnFacKWmbeCoZUSbz6f
         l7YA==
X-Forwarded-Encrypted: i=1; AJvYcCVf0irGCeM9f9I5D+0ZkwT10rSgF4GIbc0C2mOnn1kxZ69NPaFgI5ZPYtsEILdSDq+Tgk6fV9kPTyCeqnw=@vger.kernel.org, AJvYcCWTBrS9WEXfl3N7fg+aRalD+320rsz58ig4NKw9H3keABq5qfF1sQehKmYlHXTRfQ3qZabbV6U39pay@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZ+68U9nqNDJmj2IMkh4+O6qy5+36vWBtfB5rfLyXuKOiLicB
	+Kwui1LcUfkCcHW8Q9LKzBKAYVCFD2g8d6yJpxyuO1yzT6agzMWltlBzUKna7MKh/p8crpP9Rao
	FTVrsW6Ap3zEUAtbqszddkD0MAymLvGk=
X-Gm-Gg: ASbGncs4042TL6ogYo6A/zdwVKaurlDnE0kwhN1/Or6PFNhT6KefQpM4lFffxMcVGdt
	bvH/pALtwxEWlo56agxtIqdAxjYvvrMCj7Q3HE2uiT9kaOrgiSus0xOktpf6JQQI6uf/6zfkDNl
	Y6ttHwQ6rObCsfC9vgs54qtdRWRe/suBR11HhwZ/0ICLOY0ZbsYozghveolnVTiEg9Ew+B4/LuS
	8Qo
X-Google-Smtp-Source: AGHT+IF14YYWtSQVLNWBilfTD0yTzo9aWZ97ZCPc9J9lKF7t4wOtrLhQknUMxWAgb+WT7kDpQ/opeNe9S8UxrZAnEVk=
X-Received: by 2002:a17:903:1ae3:b0:22e:421b:49b1 with SMTP id
 d9443c01a7336-23c6e5d61d7mr51904205ad.48.1751473686514; Wed, 02 Jul 2025
 09:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628015328.249637-1-da@libre.computer> <CANAwSgTH67T9SBQSFQgFjvyrxNCbtfd9ZaCDZFACWA=ZQ-PYtQ@mail.gmail.com>
In-Reply-To: <CANAwSgTH67T9SBQSFQgFjvyrxNCbtfd9ZaCDZFACWA=ZQ-PYtQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 2 Jul 2025 18:27:55 +0200
X-Gm-Features: Ac12FXxvG-ViHEbQFCSslz9e9T4bovXAzoVxc9U88YSGNB8BC_29uQExD1MkQUM
Message-ID: <CAFBinCBwTkVwcBTWOzS+G13+rRM2eftMXZ3GHzW+F+BY0bBBzg@mail.gmail.com>
Subject: Re: [RFC] mmc: meson-gx-mmc: add delay during poweroff
To: Anand Moon <linux.amoon@gmail.com>
Cc: Da Xue <da@libre.computer>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anand,

On Tue, Jul 1, 2025 at 12:00=E2=80=AFPM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Da,
>
> On Sat, 28 Jun 2025 at 09:15, Da Xue <da@libre.computer> wrote:
> >
> > Regulators controlling the SD card power need some settling time for SD
> > cards to fully reset from UHS modes. The regulator framework seems to
> > ignore falling times set in the device tree causing a few boards with t=
he
> > same hardware implementation to hang on reboot because the SD card stil=
l
> > had some voltage and did not reset properly to be initialized again.
> >
> > Add a delay sufficiently long for the voltage to drop so that the SD ca=
rd
> > can reset properly. Otherwise the reboot will hang at missing SD card
> > especially with Samsung cards.
> >
> Although the driver defines reset identifiers such as
> RESET_SD_EMMC_A, RESET_SD_EMMC_B, and RESET_SD_EMMC_C,
> It does not implement proper reset controller functionality,
> specifically lacking support
> for reset_control_assert() and reset_control_deassert() operations.
I think there's a misunderstanding:
The meson-gx-mmc driver calls device_reset_optional() during .probe
which will internally call reset_control_reset().
So I don't see a problem here.

The patch seems more about power sequencing, where either the SD card
or regulator used to power the SD card requires a certain amount of
time (delay) when switching from ON -> OFF -> ON (my understanding is:
without this delay the card sees ON -> ON which fails to update some
state internally).

To me it's not clear if this is a property of the SD spec or rather
the regulator.
Ulf, Jerome - any ideas / inputs from you?


Best regards,
Martin
