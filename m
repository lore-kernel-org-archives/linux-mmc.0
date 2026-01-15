Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227A32573E
	for <linux-mmc@vger.kernel.org>; Thu, 15 Jan 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465397; cv=none; b=GmP33b3Z6a+OtlXNL6uyudofCAadR9JdVO9xQEzHVEkc+ulnkcAZvlWwmhU8Y0w56lCnvqAW0eYgw5ZLFmXwsZy8+iK72skrZhFSO1jm+Pv8P1D8860tjZNGgs3Oqf+XCP4cO6aJv4Zdvo/aeAn/ga5I6/GhijiPxnE0HFRygIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465397; c=relaxed/simple;
	bh=B3HwfPJFuJ9qhqTSYN12QXbBifOB6xUxmW30/F+wHSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4p6RWwIxSVmSw2HIh1jArfPwx2pAqufc8E6GzCFtLYS1MbQ6Nnzx5EyzXk0prl07CX9IwhUh6rA8+XZXHVcmZLbGgmSsPYX294vk+/XyKKTpbsPIfAVBfO4vyi++8smTqxrsN7RmrQqNWa4HZiT+TczHpzKufNZ4e51HZiPR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QsocxAqI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QsocxAqI"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so486934f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jan 2026 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768465393; x=1769070193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5++VQZ27CKoWVUD7F6f6Txd9Hy5VfTZoa9EVoIz3nw=;
        b=QsocxAqIIP1Jk97+dKo9/2yDJvXRBPK7HxDiwsDc+d5ihY8hLo7pFWR5JaYdrCa8eh
         m+f3Kssir+gb58ODFoy2Y48Z+5UhLLluYwN5xrrxnv6Liep47MbssnTasURDDT/7ZHfa
         +/pNpjY2oH7m1+qQKfnKDiwfZRxtNKJnVvvprZjebpakrWJfrOxhhH455MeG9hw9rWn5
         h3iGbUwsCSf5QEYtHZX0HsJjfKdx//8IDzJKX5kmT4y3x5m6+vXT+1ONMKucnCYGp7rV
         J/ARXy+WitLChUWMeTTsIb6DjWG/Ty03idmexnYEm/ltSVrKSpcB9dFwz6YOSh2RTuSo
         WZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768465393; x=1769070193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5++VQZ27CKoWVUD7F6f6Txd9Hy5VfTZoa9EVoIz3nw=;
        b=J4JMVh/I6ssfFIgPLVDj7HdNGtOEk5KmNwro+d1UJjfAGxse3sxpqg0ksJ+ngoRF8k
         zuEQdN2BlkB7WacwXFFrup8XaULyitAT4b86TBy1s6pTLlZCipeZX4YHIhb5UkcdzzSH
         ilsIkSx9qUDfQByTcoam63kZNEummKn0loLePw4N3EBMJc/1w0oIC6YEuN0HHWOHKdmE
         oKktbU44H41qsPHE5uZH8ETVGrXeUPqzFKNub1zswIeqxWqoXnIrxo5gmGY8MZLe3Vux
         N3PEvu+wj8SEyQqZ393CTj9iAaVZCXiWtSPX4fTsn5BzzxBwLRskNOhxtG4MTBtFdf+N
         imDw==
X-Forwarded-Encrypted: i=1; AJvYcCUcOSrFm9T99jPfD7N39OG/DF9qK5S9413qIy8wNCoeqzZICwOIs+7r6iz46yOm947iuUCDs6iY33U=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQJ2ph0rocppkRo+gfQaABU83lVcoT18fStfuoPznrmU3iU7f
	lItv7DLmwT3P6LYXShmw2SdNjXrqFnPC4wDrMNp4sRVPzeD3a5FpJ60vHiUnu+MRH3s=
X-Gm-Gg: AY/fxX60Y7RhKjT3zo7vLN13G3Gfv/OMcQBbXQa8Ua6IKdjhSuLO+e/QBg4rOWwVCOt
	m+8HSK+qnObRAGsip47jnVuK4JW9+LOq8WV7+p9L70YpZWRL95tQCZS+VZPjV3Ih+YR9BWvKtYY
	i55Lgj39J36X8Tj28lCcjqAQR9PyHYtPrFR+WBxyF9i4TrHL4iA3WL7sPflfn0xXT328YoVvx5M
	r4I1eMuJ40nbWUYrVZo+UimGtaIWJ8Jo5dkQsDLJhfxapsTTd1fRFIp65Aj1QhXXnS1NPOAyVy+
	kss6xRfjkVZEgtl85Ld0npvIT9ZDY5BcA4EaUQOVNmFf+14cxm4XS+18dZ+iV1L3xjVXOmmE5sG
	McdygtNnRHXz9LkFUoOObV2x6n2ketfVrnLx1b3FZn0dC8NfxQCn00Idt6QMkCqsPLIYpoP9Fl5
	i9LbcjUqpxQKnOd8jpcOpPBi+gmqTKfh64Bt2xm9J37RPwfNRshtdXPDuh8CJeg1ZtFScDDPMGu
	kM=
X-Received: by 2002:a05:6000:1a8f:b0:431:808:2d56 with SMTP id ffacd0b85a97d-4342c4f4d90mr5886640f8f.1.1768465392843;
        Thu, 15 Jan 2026 00:23:12 -0800 (PST)
Received: from localhost (p200300f65f20eb044d6ddd06d23e100b.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:4d6d:dd06:d23e:100b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-434af653787sm4335417f8f.18.2026.01.15.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:23:12 -0800 (PST)
Date: Thu, 15 Jan 2026 09:23:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, 
	Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
Message-ID: <jxq2nfu5tlxlsijl4qyqz3dvjgpklnxbgz6zmkgldoec5a6y65@k5d3zqyf4ckl>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
 <397f45c2818f6632151f92b70e547262f373c3b6.1768232321.git.u.kleine-koenig@baylibre.com>
 <ee62632a-34cb-494a-ad87-bd18a58d6a7c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oumu7b2e22zeoei7"
Content-Disposition: inline
In-Reply-To: <ee62632a-34cb-494a-ad87-bd18a58d6a7c@rock-chips.com>


--oumu7b2e22zeoei7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] sdio: Provide a bustype shutdown function
MIME-Version: 1.0

On Thu, Jan 15, 2026 at 09:26:21AM +0800, Shawn Lin wrote:
> =E5=9C=A8 2026/01/12 =E6=98=9F=E6=9C=9F=E4=B8=80 23:46, Uwe Kleine-K=C3=
=B6nig =E5=86=99=E9=81=93:
> > To prepare sdio drivers to migrate away from struct device_driver::shut=
down
> > (and then eventually remove that callback) create a serdev driver shutd=
own
>=20
> /s/serdev driver/sdio driver ?

Oh, indeed. Thanks for catching that.

> > callback and migration code to keep the existing behaviour. Note this
> > introduces a warning for each driver that isn't converted yet to that
> > callback at register time.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > ---
> >   drivers/mmc/core/sdio_bus.c   | 25 +++++++++++++++++++++++++
> >   include/linux/mmc/sdio_func.h |  1 +
> >   2 files changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> > index 10799772494a..6e5bdc2f0cc8 100644
> > --- a/drivers/mmc/core/sdio_bus.c
> > +++ b/drivers/mmc/core/sdio_bus.c
> > @@ -232,6 +232,15 @@ static void sdio_bus_remove(struct device *dev)
> >   		pm_runtime_put_sync(dev);
> >   }
> > +static void sdio_bus_shutdown(struct device *dev)
> > +{
> > +	struct sdio_driver *drv =3D to_sdio_driver(dev->driver);
> > +	struct sdio_func *func =3D dev_to_sdio_func(dev);
> > +
> > +	if (dev->driver && drv->shutdown)
> > +		drv->shutdown(func);
> > +}
>=20
> Seem bogus check as a few line ahead, you used dev->driver to get
> sdio_driver already. Otherwise the reset looks good.

to_sdio_driver(dev->driver) however is only pointer arithmetic and
doesn't dereference the pointer. So this is not a bug in the class
check-for-NULL-after-dereference. TTBOMY the code if fine as is.

Should I resend for the typo, or can this be fixed up while applying?

Best regards
Uwe

--oumu7b2e22zeoei7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmloo+wACgkQj4D7WH0S
/k6Uewf/eptVHF/tx91qbHtZ2Jh1dbpWqdOZAjbHQyOc7CCWkkt9tIHhfDBa05hH
yda1VDqHSmakRVc0Vc8qt2OwaAPE6NqzXJtQMCfrxgNwz/eI3E0h7NvLLsM7dAX6
QOs8ntUSFXDo1SJbqb2xvSjBylxhKCKA4DjPCOD7lH9LAsNnxBFPyadU2bIxbRAS
NvyWN+pn32vS0yb6OIiox1Tq8QoEOmz21E1xtk8N/wEWmNSw7AeaGOAx9u1hihWO
4qD0gxQrGaLiGTXH6WSyGXEY+Owm7nS2NynuT6RiUKs7tBHK2VNaZ7xythRz2C6w
K05ueuDz/dwG014ATh0TmtwvTHGSuw==
=hhH4
-----END PGP SIGNATURE-----

--oumu7b2e22zeoei7--
