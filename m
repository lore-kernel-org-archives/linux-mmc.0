Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B73254B03
	for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847110; cv=none; b=bTqORnZvNmB6lDKLG2MO6ZN7WjO6gRKiOGrl4KO2QRE8H8bnXSF4xgOITlLsJh/O5/XcBkuAL1BHMaDS3BbnQdfWxDvwaSIr1QrK+TXpQrYpJIcYEXnGsneIpW9DhRJmBksUnOnP818shZX0CETRXgug+sS59dAy3uuJCMfaFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847110; c=relaxed/simple;
	bh=bbRORiYyfxrPjQV54dNp09qU7YK4BDPulecIRKoDveQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHtUCNMAh6GrqiOSXKvCNXsYJ1tSmxBjx0vqlkxPnKcF4mu8CqSrnV/YfCzL5lt69Q0grFT7kvnjCxTjTvZNqEZQvJfbUC/zv2H7k8bJJaHy0tJA2a/MsnEVi60H697wd0VSfc0/ftJAJj2Yw96l3PUEJJOdO301rOu0Wx8U7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IFwDejXY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IFwDejXY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so27456465e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2026 10:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768847107; x=1769451907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQIGn34bZ1Heol3pK18U6IBla2vE71bF/d7hIpG3ME0=;
        b=IFwDejXYXOUHncOSZSshYOpClrCvmn5ipUjT/OWVz48c2wNEpgUqc2LslgoXhcCzZJ
         qVhMvyljneGdwW5JF5hMxv9ZSLc5wfwovHiREU5uABxw+xQ9Kh0/DZxkED0ixNxP82sp
         1ezmf/bh+GynBI9N8Clem+ndrC+iXFxNgZGg9gg9b/K+riAsFAxQVG0hy1TcFmdeskzj
         9ZxNoF7VVnl9jDT4B1lGUOTsOWisJ9zm2I5mfHigYqOgMN8yN19FkX3PKaNmkes9XllW
         m0i0sMbBbKZJdpNFzI5aJPxY8TLOWfgANhIkHcnHtelY6nh+ckCnTAlDEPnaheklSfpC
         +8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768847107; x=1769451907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQIGn34bZ1Heol3pK18U6IBla2vE71bF/d7hIpG3ME0=;
        b=Vl3i89/M/+SKsZJfxUm9a/KOtSqPjOnTmDlDlPrbPcqLlV4Jt/B5dZPM5NwM4tVIbV
         5fvmpwbdJyjm+tZTIoRl6oOsuNiMLrKw34R44zX1N/jv0Rc0QpHTae68FN0FqZytjLMZ
         NIrniGRTI3YDBORCk45QTC4ZIazZe2D7qe1chnu+F6QAYV3NnUuAB0ndlaj1F4L/LDkt
         u8sZL3pv+v/LF5YbKrisrLiqPTy2MApGcGOXr4z8LXs2YntqV4uFmADQwCHQzL2YhHfZ
         6v9l8Z0jZlPDfmVy97kEJcBeG1wmJeNy20iKRBhFYIKjqq+oKwp9DHm0ySLWE11h26Su
         JoNg==
X-Forwarded-Encrypted: i=1; AJvYcCUd3xqTxOzrcbueLMQ0uA3C4NPWmQxg9X8Z9cKjAJmrexG1zzJWMS/dDJZtGtYDWuV4adBy2LWBDfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQ2o+mJalSZRSvCLHfArB7LdUoie5P4SkI1tB4uiMf7GotWAG
	c1//d+22k9WKIFknRk8IHo/wtraBZzXt1ptxaonbUkCKM6Euc9lJZxorlTadkP6+AHE=
X-Gm-Gg: AZuq6aKee9hHJ0Ou/kFaQnoXJ6QF9vuS+ULFMGYhLPBAQd18/a7JjoeMFtaJvyyZFJq
	7VMf3aafRsTm/fr+JMCEN9BwJiH7wEpMerM0HvdXEckmaC6N4Nuy8RryLq1I95cOw3AbGNyvjuN
	176o+yQ6u4yUYMvX//JXwWdBA+n11fEsY3pTyZSK16BwKdxVGKy2IIgMir4BlrflfpV2bDI0T9l
	/g90uEuWrp0pDuKu3jooqfgLl6PkSUj+QDkSXL/qLB+7D0uaEZH800VrcG77R4q4nm3DpWmoDDT
	jY+S/5te/c50a8pGYjnvHx4WOI/O1x/AkvNOvwYDJ033UzcJbwv57c+SmODHXZWdVuMqDbZ7KXd
	IYE1a+rmqfNr6kM5V8I+9qOk3vB6aYTjVSDA4pcKUjybE8tq2EntX/bwfE4bw/RsVw7uUy2pmz7
	3TG7WNzVcgznhblolObpSxeAOU0N6Benqc1uegO2pfmWAjMhUUpW6tgiCtW9zfn92wZa+Bne2HR
	x8=
X-Received: by 2002:a05:6000:1448:b0:430:f59d:4dfc with SMTP id ffacd0b85a97d-4356997f09fmr14869580f8f.9.1768847106647;
        Mon, 19 Jan 2026 10:25:06 -0800 (PST)
Received: from localhost (p200300f65f20eb047c0c6442f0dfcf4c.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7c0c:6442:f0df:cf4c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4356997eb0bsm24377554f8f.34.2026.01.19.10.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:25:06 -0800 (PST)
Date: Mon, 19 Jan 2026 19:25:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
Message-ID: <v5jqdtpdj3zpuyo5owlujvifphjjxyygfrgqnmql664ck6vpc4@yvihqvp4lgka>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
 <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
 <CAPDyKFrman8YodyPNy6fSOYahoFKBuJRN6+Esz7ojmYqessEYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vcuelbuistjeync"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrman8YodyPNy6fSOYahoFKBuJRN6+Esz7ojmYqessEYw@mail.gmail.com>


--2vcuelbuistjeync
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
MIME-Version: 1.0

Hello Ulf,

On Mon, Jan 19, 2026 at 04:00:48PM +0100, Ulf Hansson wrote:
> On Mon, 12 Jan 2026 at 16:47, Uwe Kleine-K=F6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > @@ -272,6 +290,13 @@ int __sdio_register_driver(struct sdio_driver *drv=
, struct module *owner)
> >         drv->drv.bus =3D &sdio_bus_type;
> >         drv->drv.owner =3D owner;
> >
> > +       /*
> > +        * This driver needs updating. Note that driver_register() warn=
s about
> > +        * this, so we're not adding another warning here.
> > +        */
> > +       if (!drv->shutdown && drv->drv.shutdown)
> > +               drv->shutdown =3D sdio_legacy_shutdown;
> > +
>=20
> Is this added only to keep the series bisectable or are there other
> (except those you fix in the series) sdio func drivers that make use
> of the shutdown callback?

It's kept because I don't know if there are any other sdio driver in
flight and these would break silently when they are applied between this
series and the removal of the callbacks from struct device_driver.

> In any case, when are you planning to remove this?

So my plan is to remove this in a series where the last patch is the
modification to struct driver.

Best regards
Uwe

--2vcuelbuistjeync
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmludv4ACgkQj4D7WH0S
/k4ZYQf+JwzMGRZcuVEXfZeTKhIj4GKevVvgzopTKnGuC1WvnFnZCW8SHoskHm6l
xVQJKVWDPoX1lyaDHbc+Z4mqMfWbBl5+BIEJR8BXIq4iOfkzAG3Uks2q+JgbnQxm
EdsRf8ZUTiaQzNrthpHp1rM4fREr2O6h762cX6cT2AkeRlxcgcTuTphXji6sfBJz
g1BxAG9yEE/DUmFtVusuSbOv0dHhf8HEXrCb3SseDjEuldZSi0hLZcMcmkVQlbEs
iuL/cQKezDjU0plyGCcdWjDPTJxHz6N/y2UDIlBDYnJ8y6uQNQ10QdO9dRHej2Ip
piJMhA0srQiMW9vgz4HEHnNDpnuEJg==
=yKJc
-----END PGP SIGNATURE-----

--2vcuelbuistjeync--
