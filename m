Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A002331EAB
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276200; cv=none; b=uenainVNeLEOpQ7eB7kZZdEjyd4lFEKZs8yUKMJ1UsMHhPcBi7FIHxWL4Y2xYJIVI8eTfopzzI6SjZ+gWbEPJlBB+dUvd17oBbCGoypJi28LaabzcmCvD9xKMDfA7y/jOytp+3FDrpz79OoLlc9iZr0fipdMD/7Q5dZvZ70vGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276200; c=relaxed/simple;
	bh=J2LmqgUcUVJMBphOubibieqG2LCPlyZR8S+/n4fRHSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV2Jp2yFy/n7Ik9+/t2pqFoBD5Nk0jZYK0eayt7aDYwNmtjSM4MHTxLCSa4A55gp9CqRsSr6xi5Z/4Yo/zSku6EkPm4MEAI4sp+L+uHrl1KLBHSbgHApA1LYz9JZReQNJ8F6mXrGg7XeSg8PP+vOMqsjssnlbh5a7BU/80Vkc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RfWBzs1L; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RfWBzs1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Sg4b
	lf4wWbCSHna4Dl4eAW/U4a7ASNHGSnV8mUJreRQ=; b=RfWBzs1LV5L8G9ioj7nf
	BF90yAty3e3t0DGHGgSriSoB3xdJZOsmmF8Q/DDJDHMiNEF8tzEciGcpxT73EA0j
	Uz4qPhIrshJS5F+h89jtfMGoWbxq62Tth3vjpDIH52Xg6vJTBI2RFMD7oGu2N86P
	ETkNVVIW483lPxBiGr/LnzbuwapD4NklehxSY5jrs3j3mdFSwaaCxmCv6X14WcTt
	AT1V0Cl/rUz3ATIynQ/I3I5MpqTp0iq0hZSdO48NGZQg9voDCDHVgGeCvhOsmP7l
	T4+IFmAxF76WKkSMJ2F0WG2hm88BY7IzeJ5+mUo1DbfxTaELvsDboPWumVTt+IXK
	VQ==
Received: (qmail 2568402 invoked from network); 12 Jun 2026 16:56:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jun 2026 16:56:33 +0200
X-UD-Smtp-Session: l3s3148p1@Gf+/rg9UKExtKXKQ
Date: Fri, 12 Jun 2026 16:56:33 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"magnus.damm" <magnus.damm@gmail.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 00/17] Add Renesas RZ/G3L SD/eMMC support
Message-ID: <aiweIQwqkT2NQfvT@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <TY3PR01MB11346485C16AFB6299B1711FD86132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ah_Ve65DvPhlTZ7a@ninjato>
 <TY3PR01MB1134651DFD308D3DD8AB20FE386132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113460D9FC3AE79E9391DF4C286182@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0IL2selWreKgYn4x"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113460D9FC3AE79E9391DF4C286182@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--0IL2selWreKgYn4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Biju,

> I will send v3 with these changes, if it is ok for you.

Sure, sure. I will review the then latest version once I have time for
it. The more issues already found, the better, of course!

Happy hacking,

   Wolfram

--0IL2selWreKgYn4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmosHhwACgkQFA3kzBSg
KbaP9w//abMvZMd/enqGxr2nNHkf8fts1l0q2n3Rts6qta3vNBTtXWtpIqH+VJkT
Uxp4mRWUc0s9rRPfQ00WleRnwUnfa/J/f3NIn4bBBFV1LSYXrVi31vtsF9juW1+q
uiotNxuwbJyFaLVjmh84wNId6SL+dkmT8x+COwSZ+i3goISL2lrrVZJSEyIJJi0B
iSyqFgmso2bGqeYaGZjlQG4kzIjDo6h9NQQZQUShmG+ITDG1sZBVlHvK6qBCiFND
Y4+T4NpczHRFc6fhMJSuyeEE6TtkxH/xu53AwGm3V/l1DfuqrO1NbhKBU9KLjoFQ
G4wLDJc+Xzc1aCaheS6nw8g1i9klPrUediq26e3RMg5ovu9ppvxuuqbOro6sqw0Z
L4ss2vk0ORYJiACpIhb0nFhP0S/yVgVmoog4IfKbgJEg1JY489JGEkmboW3vophW
brV0OY4di7BhgzTMR/z6b9ILEI16Y3piGXcV6GbYlehkYuKNUPVn1E0FstdlAoao
NaUOrknrZ5t8dfEAvqzUsLwqbW2xMibGgR9Fkq1e7dvmWA0rCzCI663BQ+SmvQkD
+q0GYiN1En7vDWIvoFZYSTEtMkdEf/uaYjdKyfeF5yZUyKy07hqJro/gVs/eL8oi
l5EzImdmkBHdH337yo3yw1v4lz6A0F/f5D52ypkF87isxIz21Xo=
=Vjmr
-----END PGP SIGNATURE-----

--0IL2selWreKgYn4x--
