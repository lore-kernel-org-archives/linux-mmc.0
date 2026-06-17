Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E63F1AC1
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698796; cv=none; b=bH+6zZpjqGO/7TpY22mBseAtgA2QGyXZFfySj7/qSb+V6+vykLEVVSzJQuM+/KgeOtBRH2oqSPh86neoLJhsg76NFn4Mh/NxgSC3hvYXiZiNW7T1NmpV61lAV5nGz1e4QsXWPNqwDTehM6eNNDQMw2nK92RSd6oAP8fcUTD6BxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698796; c=relaxed/simple;
	bh=wo5u5o+P/8to5HqjbitjQ8PWwxZfTG2jaGG3xTLCk/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9po29Ru27zMNvtVLtka8l6WTjIXBL3fvcbh+4/bnj5/a/+bOKxtalip2ZlEE6UzepcIMNBe06WCYAR/Etq+6Dc4IndP9W8NLP1XHJdhTSP8Gykhj7yumfM4OVZzhmuBXod3rYcA+dALdCPyuK3MmT2jx1ARjZl20c4ElNCnlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AxBAGudq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AxBAGudq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/I0l
	haoFT33pxZ/PYaXqQdGg68ctR9A+xZaGv25YhwU=; b=AxBAGudqHdiCwNzYfqEY
	lJ2ZIbMuGbXvomikq6tcghpTbaaxvaJMmDAzR51gWdQaEqb3nwxlZi7OJ5epbETb
	KRtwlSLSG3KOggjVmSNi5qkXvhWueoRiFilTugCCUFqLuBiGghA9YtKlOi2Ouwif
	H/7yXAtRoUJvT2vmua/qLGcK17Y3ugNvDZpZk8mIpwib8fjQ3UEBlnFngLM5xxGR
	dW8LwfHamXy1HEHJi4XKzsrmT3t49U22b9+pLx698un1/+167p9z31AcMtlexahR
	ou3oBIMCQ259Xf9pKR5W9rJZqoCg+dQuFDGRmzQWQVTclRQPNvyCqZMPVw9nA1Ww
	CQ==
Received: (qmail 160292 invoked from network); 17 Jun 2026 14:19:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 14:19:48 +0200
X-UD-Smtp-Session: l3s3148p1@gNVeE3JUVKQujnvI
Date: Wed, 17 Jun 2026 14:19:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v17 01/17] dt-bindings: mmc: renesas,sdhi: Document
 RZ/G3L (r9a08g046) SoC
Message-ID: <ajKQ5OzGvWg3kBYa@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <20260603065731.93243-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nYIkyYfhRcPpAu3x"
Content-Disposition: inline
In-Reply-To: <20260603065731.93243-2-biju.das.jz@bp.renesas.com>


--nYIkyYfhRcPpAu3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Wed, Jun 03, 2026 at 07:57:01AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Document the RZ/G3L (r9a08g046) SDHI controller. The RZ/G3L SDHI
> controller is similar to RZ/G2L but has five clocks (core, clkh,
> cd, aclk, aclkm) and three resets (rst, axim, axis), so update the
> clocks/clock-names maximum to 5 and resets/reset-names maximum to 3.
> It has an internal divider for all modes except HS400, and a 2048-bit
> divider compared to 512 on others.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I know you work on v18 already, but some high level remarks already.

> +              - description: ACLK/IACLKS, SDHI channel bus clock.
> +              - description: IACLKM, SDHI channel bus clock m.

What does 's' and 'm' stand for? Is it mentioned in the docs? Would be
nice to have here as well, if so.

> +          resets:
> +            items:
> +              - description: rst, Core reset.
> +              - description: axim, SDHI axi bus reset m.
> +              - description: axis, SDHI axi bus reset s.

Ditto.

Happy hacking,

   Wolfram


--nYIkyYfhRcPpAu3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoykOAACgkQFA3kzBSg
KbZXkRAAlPkxfJBU2AOJai06gq+PcuZ8YuGMnCfztKN1A1YkcHIjKxffWe+QN9f2
+GzFT8psEN6UFSQOPO7J0zJ19UcLpeP6ly6VlJBhSg9Z5c8oxsS7DJFxZ1PisIZ+
WEoWLfql4I4OHILot6NCAdsIVM1eXhMp82jSGVb9vUqLGFHhYyDiD+DIOwePGcQJ
mlR1oSSHmbL4nNcKJzBM4cInKrfOfiNG7kA531rPzKAO7RxUDat1Jr/oBKYqo3z9
VOd96YgYGqCfuhY7PHtUU43bgNLyGLCdn84eNU+LlOMzDpNLDrsJW4SvZ47jFjOx
GrYQtn90ouU8BI8Bm2WikzvLgzsuEvDx3nNcgMbCol0H7FPJ3kv5ejOVZKVF3go6
uxuArNWfRXSnP9pGvrGbsaE1UmMYOXiw2W3/1ShLP+d3Pjm71wsDD9gzIKktKiEr
CdHQPFj+R+Z/1JfMrMp15yQqHeeLXboy2XA7d0izXmE9D8ukPlsGMiNgVlu3ZBDe
LDDDDpV1F1+YK4N+GX31Rypmcshf/zTtFq49KgLOViY8oSDnvs/s2yP97iWbr5oS
yVYcKQE27rKXRpJfzywwRdmdXYn9dv0bgnOo4KwgBifcu+rGySmSoNy0jJC3Zl2a
I6+EJt8SgIDmYGP8YbM6RfOaWF19V1snDBUeDxh5TDJnhCJGI+o=
=cLl7
-----END PGP SIGNATURE-----

--nYIkyYfhRcPpAu3x--
