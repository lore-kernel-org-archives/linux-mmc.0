Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF83D88FD
	for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781708; cv=none; b=tjpntV3+BZTzq8A6O0dz6KxvXcDRe31vtlyzDqHqfmPTap3edyAXGl2zmKg1QWl1mZB4cRKU018ejVQZ8ouGHedGyRlhyk7aEIbc92O6PDP2g2pmgxKIotKEUT2Su+TvxkWN8pyISi44QrfisV8vYmE0wEXfOPkW66Kg+lln/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781708; c=relaxed/simple;
	bh=8Al3yrm/3hSvEPA958SWnVaUgmCGPZw8rcFuTzB+JYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISLuH0OjxPQMeBGjIgQuK6plrGlo4CGQKuziEjL2svPUJezArUy4DIEnknYt33s4/8ZFZghYGMPtncH1S4cfDVFU+gcFdZgGsAtuxyJZY76rq5vmytKewi1jyz3t5sdoVhNwy2Cg0L7ceZoPJdI/vdKHvAZkCvIQc062m7maFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=oBVIiZfB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oBVIiZfB"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d64313c39so3403748f8f.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2026 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776781705; x=1777386505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Al3yrm/3hSvEPA958SWnVaUgmCGPZw8rcFuTzB+JYE=;
        b=oBVIiZfBEcXZc5iULO3eapa8JPyWTctIIEypve1SXZdvi3j3pV7EpNbYAZg/H2dmW2
         sYFC4FfjX3WXGmbiyTRvSnLjwPGNV7O9irYpHsWeWY6cOAurQ59fhNWOjz05zKMCmmj4
         r8FBkOTWsxSajQTpa4COqK9VnAFdzWmGelwlXm5mBWC38gwAeqV6BHVUp1rcniR5Gcub
         ArEhKTZFywzIU30Kto5c4IZOKNVkt6TS9kFKjBPVu7IYPwWJ4rN7kSka4ioiMcL58Bdm
         tR/GOu30faYoHkD0U8vsjiLu6Tm1jQ1t1YOCIjXs8we09C/QUM571zEFe+J6s4WpWkKh
         QSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781705; x=1777386505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Al3yrm/3hSvEPA958SWnVaUgmCGPZw8rcFuTzB+JYE=;
        b=A1fOrIAkzYnyrkkM5KWTeT/f5dLZ3rUMkDdM4JbiGiXDcVVRydX0uSXvSpNRUtFN0R
         ZTpcOWsR6TZW9ptSLbWS6zNFjffrp5Fu0trQSRIx5fp2Fpp3Hb/N0RDoNXcDjPN9gBfi
         GUavdpDzGAY7zPmA0mRC6r9vgzuJW4TNkVdNzWQplPHCqXiy9Xl7C7gosiz3jl17npxY
         5ZJ1g2EzdDFOP4EGtffzcxjgPPvVqMe9zdBsgbVqsyd1p9fEFgmXjVbwFQyb0BKo2b17
         RAoVqS12lhthAMuV0dfhq7Y6+4OyAVYa0jj88uNEURqcGJxdqizcXQ2ViUtOr0Mbh0uD
         v1cA==
X-Forwarded-Encrypted: i=1; AFNElJ/aAwp0ekZxmAAclo5ssfS85SZP4S44cW37rUKlkUxC7Z0xC2xcQTaPOuq1kb3oGo7WgpkiqZW75Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSx3bwzOEZOY3TFVJMXw6Lfb9H6b4hstxNqWq14rsSBhPDfV/9
	GL7G0wyIwX2DDbVor3R6xKAF6yI6uhE8FNts/YaVjd8oiaqzvXWutEMAO+gNeiGS46A=
X-Gm-Gg: AeBDies2r3kSMcXz6p/7sPEAP0CKJQswAhINwSPYyo4A/vK5tOJSjLAdiV3zeNC468x
	SBrrGOfj0fm0YyH2hnt+IEUXKyBCHKFpMrTaLhD6qDvJaMmBQ8wQ7oTf6yphIoyBV3gvKBXj3Fo
	a3u57300OQtSBhrttPheqsE3wH5iyEyKGz6pOYHqri6CwB/HMex0nA60QBqpI30t2Thocfi03d7
	0EdUZ5JoxW1L/2KIDS8A2k0Ih/lmfNu/gOi90/zbZdSGIGDz0+4VRrgB0t8n8CzFO+I72qkzeMx
	5lUJ1+XRbqO0vOx0eMYs2pgX+UbK+S8jdulG7R5+rpzksvc9U4carpErnGH8v0Mq2mtyZwMfEIU
	GY39nxSzoW0j/gD0MqfJxo7octzSHs/L/mkffKEx0xgiaQwzHAOnDwUXyFUvzu+ssY5mAqpfa0l
	712Gz9RBFLgD2ml1/ozZE48nFYlfB+UDR30e3xeQ08SZVjZJ++DYwQ1Klu+d7w5EshPGwGtAgCj
	TOvL8oYQ9Eu4tf+0t+hbEJkYg==
X-Received: by 2002:a05:6000:25c6:b0:43d:7a08:a5f8 with SMTP id ffacd0b85a97d-43fe3e0ae91mr28509500f8f.35.1776781704476;
        Tue, 21 Apr 2026 07:28:24 -0700 (PDT)
Received: from localhost (p200300f65f114e0838b25d7f2f2f49cd.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:38b2:5d7f:2f2f:49cd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a18csm42923276f8f.20.2026.04.21.07.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:28:23 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:28:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Johannes Berg <johannes@sipsolutions.net>, 
	Ulf Hansson <ulfh@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
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
Message-ID: <aeeFun4zdz360GCb@monoceros>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
 <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
 <aeaMkfk_1t98e7SU@monoceros>
 <CABBYNZJzbEmYzTk2m+Y8SoHVouTMA6Gje_55iJsQ6cYtDLftbQ@mail.gmail.com>
 <aecu1ixyHP2hQvgE@monoceros>
 <2d6e902083d693cdbb15fc62c6bf92db34fc734a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wkasyawrdb76jdw2"
Content-Disposition: inline
In-Reply-To: <2d6e902083d693cdbb15fc62c6bf92db34fc734a.camel@sipsolutions.net>


--wkasyawrdb76jdw2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in
 sdio_driver_id
MIME-Version: 1.0

Hello Johannes,

On Tue, Apr 21, 2026 at 10:59:04AM +0200, Johannes Berg wrote:
> On Tue, 2026-04-21 at 10:12 +0200, Uwe Kleine-K=F6nig (The Capable Hub)
> wrote:
> > >=20
> > > We only received 1-3 of the 6:
> > >=20
> > > https://patchwork.kernel.org/project/bluetooth/list/?series=3D1082520
> > >=20
> > > Or is this on purpose, and we should consider the set complete?
> >=20
> > The remaining patches are for wifi. My expectation was that they go in
> > via wifi+netdev once the first patch is in their base. But of course I'm
> > open for maintainer coordination to let the series go in in less steps
> > than I expected. If that helps I can also create an immutable branch,
> > but I have no urge here, so if only the first patch goes in during the
> > next merge window, I won't have problems to keep track of the remaining
> > bits.
>=20
> It's probably better for everything all around, including the various
> automations that test patch series, if you just flip a coin, send these
> to either BT or WiFi, and then resend the others later :)

The first patch of this series adapting sdio_device_id is technically
mmc material. However to demonstrate the upside of this patch you also
have to look at at least one of bluetooth and wifi. So even if I drop
one of those there are still two subsystems involved. And then in my
subjective view it doesn't matter much if I involve two or three
subsystems. Regarding test automations I would assume that if the
bluetooth bot sees patches #1-#4 of this series it can do something
already (involving either testing the series only partially or finding
all 6 patches on lore). And then this isn't worse than just sending the
first four patches of the series and delaying wifi until later.

But I agree that's a trade-off.

Having said that, I'm happy if the first patch is merged and patches #2
to #6 are discarded by the bluetooth and wifi people. I'll come back to
them once the first patch is in a release.

> All assuming we get an ACK from whoever is responsible for patch 1 to
> merge it through some other tree :)

To make this more explicit: That would be Ulf as MMC maintainer.

Best regards
Uwe

--wkasyawrdb76jdw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnniYQACgkQj4D7WH0S
/k4HiwgApSzuIJ1URhsrlSvh9N8JDusJG3q51TwVELmNJHyiGiApzvIMI2hf1LpH
E1+5egvSwoK33C+ReJRedPagWp0Ll3IFfj2s0y3HvwrI5a76Tdf4sHvj5NHPiRIH
y9KHO4wXogmzK8jd1kjTZQfVblWyXiIkrLiylpMbymhBKeStWp7DRQSV/94dIdZe
Ig/lLo4/6IjeuI3hqDpPqnRIscxMXd5YdujPggb4cJWAEy0Xeh0UelFMr/++spDD
07BXWuy0sJyPh7Q0c6YyhUYR2JQTbfRGhdia/V1lPmvtICvopICdSWsFPvGyqVwX
F0yDYOI9syIZGhmxoclUWCaZGbh0IA==
=qXiL
-----END PGP SIGNATURE-----

--wkasyawrdb76jdw2--
