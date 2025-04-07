Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7977DA7F
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019166; cv=none; b=mDZqqO8/Jd/felzKtXWl3OK0BKYqR1XIsp7UFoNH6H2cmrrt3/FfhzD1OKh2vR25CtpKuJMgq4Quyto73mjUAiTF8uC9uhZxihKWLkrjBNccM//nNQtUOJ6mRyTCVBhwCs7+pKUrS0kP+RF/L2uWHCkZGRZP65AZHtpQwo2StBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019166; c=relaxed/simple;
	bh=ZsDvlVUq0LO/yHLeODQBGLoNbJJ1x/G7o+kv4rtMpJQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZmhWo4u/gmQ9vcVW7bzsxoZkqNwQ/Y06r+/wCLvEh8oD2Tik3EckNdU45+hn9uWXBH6TJoPKtZF3HOCZQ+w1u9v7Sz9B6mMv0clGpTWsowcStmJHTuIp8GV/srA1XqvJnlCHY/yI5KnFwpoeJs7IdP0CizGmK3noGbn5+h2jJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PrzvoRDs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PrzvoRDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ZsDv
	lVUq0LO/yHLeODQBGLoNbJJ1x/G7o+kv4rtMpJQ=; b=PrzvoRDsKBZkYZ5hl8om
	1cGyrhMnPigjFwBZptWnBN0mn5pX2zrjux3mSf/kwFOm87GrG5ws3xbOWzmcJUWp
	QCprJl91VTVN1tD+KBc3K4cwgM3AD0Mxa7YlLmJzgUTReJKhSP7e0MJ+IHrICeok
	Nq9yLFbBh0sisPBA4uKm8MG9UBvPVAgAyA10fomBojQU2stoQ9jfnxaTsoIJOEdb
	Lg+/CVuMYrLt0PTKHnxRGWk1nkhIrGwJu1HeqAFM9c8FUVIAwGx7tkNFKawRMbq6
	i1EtAbnsAhUYIdPeLAaTHYFaqOKV1gozfSC2RygSv0XrZ+u7XzoMttLxIyNf8zGS
	lw==
Received: (qmail 3750208 invoked from network); 7 Apr 2025 11:46:00 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Apr 2025 11:46:00 +0200
X-UD-Smtp-Session: l3s3148p1@B4yBGi0yyuwgAwDPXyfYALbiJ46yNPq3
Date: Mon, 7 Apr 2025 11:45:59 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Use of_get_available_child_by_name()
Message-ID: <Z_Oe1wLHxXB7skvL@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
References: <20250407092144.35268-1-biju.das.jz@bp.renesas.com>
 <Z_Oc5_tTbbE30m35@shikoro>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+rlPRmxOrbrHn2Y2"
Content-Disposition: inline
In-Reply-To: <Z_Oc5_tTbbE30m35@shikoro>


--+rlPRmxOrbrHn2Y2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 11:37:43AM +0200, Wolfram Sang wrote:
> On Mon, Apr 07, 2025 at 10:21:41AM +0100, Biju Das wrote:
> > Use the helper of_get_available_child_by_name() to simplify
> > renesas_sdhi_probe().
> >=20
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Yay!
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

And FWIW, tested with RZ/G3S which does not have the internal
regulators. Still boots and works fine:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--+rlPRmxOrbrHn2Y2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfzntcACgkQFA3kzBSg
Kbbjzw//TKoKMrVfjLemyX2XN4BgUjgliIMdy2FPPS4D7x2XYCghaONQbxjuRL2q
i0id8tyel+z1B4XIvW7s3CMKShpzyr3x3AJFjBJtUGImpTz0iV+oyDFGvvAtTsam
L1+PC60BgBfSU66yhAVo0nZcWckpEA/kPClaFuvWSS+elzk/jser3jQEdbMMMRr9
vG3JBCo7Cy1IZYsUrxplqxN9Or+7EZVKNSy+cIs2XL12TXVC+unfrYEK+f1p6IZa
Bbmepa2Ze1WH8LZn8I5lejac9aM/I8mZLMPcnKQWnl9RFrlMov5U4NG72CltN4PB
tK5DX81bK4adpuZPrVdU4os1lpN4wfUCopYwFZUQSvmLAmkf5AXtA9UqOgpEsox8
p0JB1O6rASEb9H5NQ2vHOeyXKkjt+yP6lN0HOFbThgpusMCdkN3KzKAUhmVlJ4LF
wFs/D24aHOJG1S4lXCvS+vbasJdsBboHTdItDYgTUvU04NPiGKZahWw9Dnqk9yDQ
IbVbfKzVmRgUOoC2NHe9vsnODqH9WujZrHtcX/4RNn/D82hoedSb4w/WCNMUjvhG
9ozhpQD8WXoQxcTB2HzZHSdD52gPiAG/96HjB04JsRof6ZDtvwJnXSd0fzxlSF7b
ZA5ADJ03ZSvvdPeRIXPOipthDH9GxjNfvTGFTJUQG67kzmG1VLo=
=3RXm
-----END PGP SIGNATURE-----

--+rlPRmxOrbrHn2Y2--
