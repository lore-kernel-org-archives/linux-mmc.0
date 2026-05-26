Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417335CB6A
	for <linux-mmc@vger.kernel.org>; Tue, 26 May 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788300; cv=none; b=l9Wn68RMnvDOl5bsbBBktf2VnzJpCJNG9YgCjxUtu0y75kA15z3v1N1oy5DZJSU8OWiBo0HztX1fuLLfQRawltRNHEtHrC0+Vt8lSxPxeF5yzCtYxxyilkCU2Oq3gYxehKjOGeMJLmfrBkcD3Sbj97sKu1zjnW47RSnqFG2LKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788300; c=relaxed/simple;
	bh=RXJWIuO8bbHBBvc8hAmAJEeX88yUO/65JWt4BhqEy1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5kuVhdP9lU+MKTHya2HTXkmHCghnQLPAkuh25ws494dWu0+bSl4Xjac544Q0QrKt6TsrVPxEFrdlOn4dWi/BfmyGG/M73xb6m+bNe1+ayd4+uyqX1fWGUavd8vKPfHhZcmsryzYmMwzHsvnCHkWWm5ztiqAUyDWlv13Vby8MWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lEKKrvK4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lEKKrvK4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so6322601f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 26 May 2026 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779788297; x=1780393097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXJWIuO8bbHBBvc8hAmAJEeX88yUO/65JWt4BhqEy1c=;
        b=lEKKrvK49QgmB6x/y+qpXA1KA0bnbMEP6IO3yJzfYm3FBYiPa5hAcQMU6Z9eUMT1Ot
         y2U+uCnwT0Dph9Fy9Wu73sypiEmroqtd7H0h358q8bgNpXyTvNsXFkG5w/uKC4Qt1Aic
         IftxxMPtWO6sVN3DJ1bwOS2pmDQlaSlNlRSiv3fu9mhf0UoMeKUaxH5ByfzQWHn6nnK1
         GlIqILqAaaPTbQ3PoNcAKnmiOzbz0r5tbaTbBAdfObngsANtyBiOXgkdVDLygd30rzys
         VA2yfKASkWiYh9UoDqDQTzHe3OrNl7mGvDRIQxHWoVXEUoWMIdhTceUwajQ6ZOftmbBw
         IbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788297; x=1780393097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXJWIuO8bbHBBvc8hAmAJEeX88yUO/65JWt4BhqEy1c=;
        b=ST7dy0RAu723ycjwhY7NBs2tcV+sxxF+EshFi/kcnqOOQkA+SgCjxotEEf3V48R6yX
         1du6kPzqS4mE2oGOU5KavarCM15hK0PQdNGnJc9X394ziEJNZDpSEygK67auqpLq8bnF
         P6aRCsLSgo4QxkyXr1PV2Lzozx6P1sfNtRQNskqy/T+W02LKaqutzQwKOOB5dmWQyuNh
         b8ET4Ab3QN7zOjl2FrcVzQ0VoejmrJGiY+ct4L6WDATl8VW2g/ExdnRXBs1CD23vJB6X
         J5Ni6ked5Lq/7uGjFNX761LSz2Bznvsd7tD11oe4NJExxX8m2m7DhfTamIZenkKu8nLq
         qWfw==
X-Forwarded-Encrypted: i=1; AFNElJ8TEAYSNbSu+vb3yMs8PYG1yl7xxEevNvzAI3ll/eDbQWJyMfoyDOw7rJzvQl98AYC6w/4AIZT3s8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekmQnv7xOHwFaJilkXqdwoZYPY/zE7yKffwKoJ3AMdJYv/tL9
	5/DCx5YcLROm5xP+/gYJylWkRWIzfz4lhCXIRefjfOAEuebj71VAGnRrQB2POO7MHk4u5yE2bC8
	as8XK0CQ=
X-Gm-Gg: Acq92OGO4mXVZm87Cmbmp+dRNCOvvxEWAm4ZZ5emEP3pOz38JdyMNKqKQ7+h3TTlopn
	cZA+tKRXlx7X6/YtzwJNZabMnNzvAX+e64N87GPp4XdOD+xGJ5eZndfA1zTMMroQFC6WgsVRWLZ
	4qKwPhF2fB32oXgmou5tmKpXmyNN3qjLBmVkO/OSrhaIyjMt5ViU3COeCT32XHmxF5hbaGB6tfX
	Wdu9TziKtmzenqHSmGgRmaGi1UlTZnYX6KKDcQ03mhwtIftYoP9xCODHfEO2Cm4VxI1KJE1jjob
	KlGPIVVFwse5CJ9PJsBRlr8F9uhbxz14VL14AFpbDlxCAAlyWY0HLxawRA20bGXWuguQuCJ0SSh
	ZMbFFVL0tuTgC3MdPCw/JPm6/083ggqQ2SSIaZpdWg5SmJyUwyUDKkvagCBAvduzTE3GBDjO2ym
	7au8vLe6KiPMMZ3I/mFaFZ18og0/+Qn8nI2GgTLOpIVYYFjIfe++uo4aKYXofgjOg+MSXAWrDZd
	FQHXfA4LO9LpA==
X-Received: by 2002:a05:6000:1447:b0:452:d03a:7abe with SMTP id ffacd0b85a97d-45eb38b91c3mr32067787f8f.17.1779788297057;
        Tue, 26 May 2026 02:38:17 -0700 (PDT)
Received: from localhost (p200300f65f47db047ec792ae18ec05cd.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7ec7:92ae:18ec:5cd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6d49132sm34150219f8f.24.2026.05.26.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:38:16 -0700 (PDT)
Date: Tue, 26 May 2026 11:38:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
Message-ID: <ahVpRY6lxiWbJ7Qc@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtihelpcu7j6kvgw"
Content-Disposition: inline
In-Reply-To: <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>


--vtihelpcu7j6kvgw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

On Mon, Apr 20, 2026 at 04:46:56PM -0400, Luiz Augusto von Dentz wrote:
> Hi Uwe,
>=20
> On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Hello,
> >
> > On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub) wrote:
> > > On all current Linux architectures sizeof(long) =3D=3D sizeof(void *)=
 and
> > > this is used a lot through the kernel. For example it enables the usu=
al
> > > practice to store pointers in sdio_driver_id's .driver_data member.
> > >
> > > This works fine, but involves casting and thus isn't type-safe.
> > > Additionally with the CHERI architecture extension there are machines
> > > with sizeof(void *) > sizeof(long) for with the traditional approach =
of
> > > storing a pointer in .driver_data doesn't work.
> > >
> > > By replacing the plain unsigned long .driver_data by an anonymous uni=
on,
> > > most of the casting can be dropped and it yields a working solution f=
or
> > > CHERI.
> > >
> > > All users of struct sdio_driver_id are initialized in a way that is
> > > compatible with the new definition, so no adaptions are needed there.
> >
> > sashiko.dev found s/sdio_driver_id/sdio_device_id/ twice in the commit
> > log and once in the short log. If you consider applying this patch
> > please adapt the commit message accordingly.
>=20
> No problem I can fix them up once applying.

Now that Ulf gave his blessing, would you please merge the first patch
and the bluetooth ones (#2 and #3)? I will follow up then once your tree
hits Linus's tree with the remaining patches for wifi.

Please don't forget about s/sdio_driver_id/sdio_device_id/.

Thanks
Uwe

--vtihelpcu7j6kvgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoVagQACgkQj4D7WH0S
/k5P8Af7B8UAQJSjX3WHqmRdJihAfbJzuB0qsIl9eOVYHCAaEiAnVpqnjNkntHIU
lX0CcswR4fXl9pEV+1mobDSLHsbDhg9BtXTuAm4pavvYRoS5isVyCkasNUeNDGt9
B68NNR4oKyApL/DFvXCG4CPWrhA8TL+m9HE7DCkm2IYcH2TB2WdUCQnnQFV8E94x
1eyEfCrTCqn5UlW+2urdJLmngSk7o3yv1wJ36pgHxMNQMXU8mPWN4nOCqEZAvtmP
CrtRviKQ1QpRXNBA7blduSvvqqfr7uQEKta7E2argdEhkor6XY/fTTlu687QRi6n
Po62G/0XCxIUYpanmYULzD9YbpSlyA==
=Zdz8
-----END PGP SIGNATURE-----

--vtihelpcu7j6kvgw--
