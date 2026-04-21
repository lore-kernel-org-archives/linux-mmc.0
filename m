Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47972631
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759167; cv=none; b=KsYphqrV2NBCGF9gTOK4SkdqUkPy77Nclom5V76RGyJgezDjeZisTM1T16HlhcUNb+0Be82uodvH0vGrxNXR/4NFcHUEU8uTaus687XLtLjE+TQ7zkiS73u5f5zMY6TbPmx7/gwwxbmD9r0W+VWgt6deNaDovCMl7aK3sthoKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759167; c=relaxed/simple;
	bh=RXcEsPkaE3nBchm7YaHAcD5u2O6FyVBqda9tZxmDoL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzboqDN4WRpDCgj5AiPLxq2Ix6B1xjb3bkb9LeJrv9CxyF6+AyIpm2NTFq1ZZ9V/s45InNe1UHTl8NZgMi1E6F8XFJRbK3OEy+lPcqi1/HrtbVSvqIYW5rVgZoULGmuPLaaY+Iuik6vpb9fqpZqLKEbWZxTdQILZyyvntObee3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=d2GffH6+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="d2GffH6+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so50445215e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776759164; x=1777363964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXcEsPkaE3nBchm7YaHAcD5u2O6FyVBqda9tZxmDoL4=;
        b=d2GffH6+aJqxEtb9FwtEW1zi7cAagx14LPltCUFLgNrA8etjDodpu8+02hSSgnd/lA
         jjw+7matkAaJi9jJLhOpQrVx1B09ndqTXJGoupFQ5kUkeswkeoqRVQtG33pJNZo0nO4O
         QLFcT1saJmG9W75QchuyXCaG1D2Rn6Iv4ETUfxbk+nCGF5GrBrOuQjUk/kuGHcHz2xzb
         YkQSyrNvUik5BNaHut5d15sNpknbUqOAXiOfzpglxaPaH4nhl7hKU7EslliCBW+5jzUk
         jFlO1LIxuowV9C4avtxwjeCtMrdjgBFG58F1YjuoIIq8RMtSgC+rOfq2ynutDfMD/SaN
         lETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776759164; x=1777363964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXcEsPkaE3nBchm7YaHAcD5u2O6FyVBqda9tZxmDoL4=;
        b=YxabgI2HIJ6XWK/fJnijZOE2qpDkPAj0fbwqGfUxOvFyboUememNE5bz/Q8y4BG7qB
         PlVDuFBwvdshxGsJOg+gTy75KObLGWB3P577+DbDqgtW6Zw5DqJx++pcTT++Yxkzgu6I
         DwGjGZtiqSCkVDZzyQ4pHBnUdegJyg6jRNzTUBYikTz42kELRwNKZ00ubD695B7yS5/P
         7VlQ/Nw4HiFzAbRBYWK/hTDcBUu3X7efxv8nNSYJC1YCDet5G47f0Tu9Toej1qQnWN+B
         XoUX0oUBiMEfDXwgx1bqgAGrgZfcJe5Y1V5j5BfrK7s1UV210/Am0F4jxCGG3xR2liSK
         v3aQ==
X-Forwarded-Encrypted: i=1; AFNElJ904cQd7Oj9DPzZv5o+ubAFAiY9SEJzQQO2138UuVhIz8MtFpZY4PZr0yPXjLkxe7oN8oZp/clpXb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWiL8UXju4aFsRvNd0jpnGcgsiBbFM7jhm3VHK9nOC5dl2HFB
	jWY/575i8GJMnLzaqrLx7NYeGTzVOkN/K1CqMEevWANpcU2NESEIuH0AHSBlghcbwKA=
X-Gm-Gg: AeBDiet/xm5xiwU84Stso0x5N5ZdWQ299g+lBYKaWazGGi0j1eq+1jlhD126xYDb/yG
	ep4vMvfjaQB2Sv6u3vJdiHwSxlq0iFE72UlUFZbi/RH6JjTmsowHdosAyf5pZpFUaCDwlpS/G5t
	+uVjR51aDQPVuWqvU1X56ICoh3vh4QJ6Ul3D7fO/KQh2PEj73weVBgw5y3PP0Eps0l90/qsiss9
	3BC4J+8NNr65gJfqPV+ZjWCTGEeFqLTZnUJT2AP4pFvs3PGLVt9LdplhIPHSHRnPrj8zftN5Zb5
	i//+2vdZqhjoFTy6LW4HAikynMy4dkFewhfWv8v0H8Rf4QZlzyKUyZydaBj7LX2PBkc4oDeiUDL
	xQuzaeeIWXYzplp+M6f6HR3UjM6o+4PGPI9Pfxsx9b1c6LKeEMg4/eQ7A/WRFv8UanRL9Qt4ZpF
	H3ZAOX/GTPG7+TuitVU2mI3ZCy5aLYcySR9oqDI0c=
X-Received: by 2002:a05:600d:1b:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-488fb771438mr205335215e9.19.1776759163884;
        Tue, 21 Apr 2026 01:12:43 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4891bb3d121sm239274565e9.14.2026.04.21.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:12:42 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:12:41 +0200
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
Message-ID: <aecu1ixyHP2hQvgE@monoceros>
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
	protocol="application/pgp-signature"; boundary="ou2vweurizbmr2mn"
Content-Disposition: inline
In-Reply-To: <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>


--ou2vweurizbmr2mn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

Hello Luiz,

On Mon, Apr 20, 2026 at 04:46:56PM -0400, Luiz Augusto von Dentz wrote:
> On Mon, Apr 20, 2026 at 4:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> > On Fri, Apr 17, 2026 at 03:10:47PM +0200, Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub) wrote:
> > > On all current Linux architectures sizeof(long) =3D=3D sizeof(void *)=
 and
> > > this is used a lot through the kernel. For example it enables the usu=
al
> > > practice to store pointers in sdio_driver_id's .driver_data member.
> > >
> > > This works fine, but involves casting and thus isn't type-safe.

To be honest, with the involved void* this isn't really type-safe
either, but at least the data keeps being a pointer which is really
helpful on CHERI. FTR: The alternative would be to use uintptr_t instead
of unsigned long, which also has proponents in the CHERI community and
which is used in the current vendor patch stack.

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

Thanks! If a new revision should be needed, of course I'll fix that,
too.

> > Many thanks to those who created sashiko.dev!
> >
> > Best regards
> > Uwe
>=20
> We only received 1-3 of the 6:
>=20
> https://patchwork.kernel.org/project/bluetooth/list/?series=3D1082520
>=20
> Or is this on purpose, and we should consider the set complete?

The remaining patches are for wifi. My expectation was that they go in
via wifi+netdev once the first patch is in their base. But of course I'm
open for maintainer coordination to let the series go in in less steps
than I expected. If that helps I can also create an immutable branch,
but I have no urge here, so if only the first patch goes in during the
next merge window, I won't have problems to keep track of the remaining
bits.

Best regards
Uwe

--ou2vweurizbmr2mn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnnMXcACgkQj4D7WH0S
/k44bwgAnoMan1Imv3flaHCO3huDhjM34bPslVMZz9O3wxMMwFGStgpU3tDvAlFl
FisTZf//q5YDKDMU8QV1lWvbQoFEpQzTG9y9T3kx535oPPgxlG2VOVssH/fhxPgC
5WRR74C/5X9vCV6KRMHrD8GhGNsn2S9si+AjSVxGC6NWrVOrbIyK1lRHOACx6rFV
eM3s+J44T3ZGK60m180+bEFUfCsmOqCLoOTOJ2dB4hxddm0VF0MLiuby8b4v8RvB
/IPA8CqsKTVcj01EMr5853cJiCZjfq5CHdo2tTK9JScUUBXv0Azi7Rv3s3P0hV22
e9swpLSspOKoPqq6qBNNDtr19tQDTg==
=Mg7P
-----END PGP SIGNATURE-----

--ou2vweurizbmr2mn--
