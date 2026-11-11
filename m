Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392098;
	b=xqGrOj0ybemwwKVNVlDysZjG2brg7D0OuteLOadyw33f92u/knHOR7Tdx6IqtBa9S3e1
	 bdE64RFhVFeTWQuQPYVXLZCwj+PgBMWMZgSBdhiLRIN7W92+obYY/CbsM6NWrgBjMamxI
	 PhNQFbmgVeAP8purqGGkmxFAH9CSaz1VbJVIYO5PVzbIDKcMaDvHMjrIZ5ZHU+TeH67Fc
	 PscH3XH3EmvdCYdRkCTTfn3tr8e2NX3Zh1A+qiZFAf7iSZrCKRQxaIQjQb4PhTQq0RuHy
	 RpkcKCLAA+BIVEVRyTx7ry6UTmbu963o9tRx/0mHpBgLH+/rC3hlaCkR3S9cI+Q/rMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392098;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lp+t3hRjxL5IFyviaZjgCI7gTo2Zcgy+Stw2L1SIlYc=;
	b=4ZANqT6kmxKSuVzYgjpgJv+6whbeT94NXSgo6Dn4vB6gZDI4Y8sbGWg3eF1FzGpM8/re
	 3/AYRv5tCG9sOqvVHKeSY6eXvWHR2CrswOK3x34/ua8+XnN+DEgtGuybLMqezVUNhNyOg
	 cWvuPkg6PhhJIv3I3C6/c1iPhgA3vLUEkWaG0VXA/WIkR++hRjlpHf/cQBbXoJwbsDf7v
	 iH/AcRKGUuUV8vlhh41b/bJ4WvViSVpMWR+38ymKcEiSsgypkLh4dBCIZPpiWazpeiygv
	 1/hhGvKn5w0YyLPuuoATP1BTX58u5MCfQEBCubGx9KBClx2K/QY8hSpWQYl0fgHpGIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=W3eeflAR;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C25606A336
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 10:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C25606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=W3eeflAR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lp+t
	3hRjxL5IFyviaZjgCI7gTo2Zcgy+Stw2L1SIlYc=; b=W3eeflARskWQiVTIXBlj
	28P69SPEnCj5IW0/mTi68CZanbLA6BWZU9u8x6veYMkwvNglY213Ub6N5LWthoPM
	Ka/T+TUU5e/xq0gj/KYkSdo3fx1rwiuPm9S/TmzcBUDqonliVVTkelowKKsXUmpc
	uDmTKAJnv616MP2/YeTT7OutnKjw9iWiA4lPI8AXzlkUfiA7xvemItsnYnef/q9a
	vAZ2XGOA/g+WyknOkdv0B9tIMRZPOZyhlKkE0lxx/JIzJq+5nikrT7aG+JMbUCJi
	BXHGmkD421FGmDOp0QM141NXGGvKqYkDhIvAi8+f/lzv0vkkV3zWEVfw0TXyPSB8
	Ig==
Received: (qmail 565967 invoked from network); 11 Nov 2026 11:14:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Nov 2026 11:14:54 +0100
X-UD-Smtp-Session: l3s3148p1@FdJdd/1fDrQujnun
Date: Wed, 11 Nov 2026 11:14:54 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v25 06/11] mmc: renesas_sdhi: Make clock divider mask
 configurable
Message-ID: <avRAHpFcXIAStJpE@shikoro>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
 <20261028-rzg3l_sdhi-v25-6-57f16691c2ed@bp.renesas.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YRG0+FJlDArByPdA"
Content-Disposition: inline
In-Reply-To: <20261028-rzg3l_sdhi-v25-6-57f16691c2ed@bp.renesas.com>

--YRG0+FJlDArByPdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:51:23PM +0000, Biju Das wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add a clk_div_mask field to renesas_sdhi_of_data and tmio_mmc_data
> so each SoC can specify its own divider mask instead of the
> hardcoded CLK_CTL_DIV_MASK used in renesas_sdhi_set_clock().
>=20
> Default to CLK_CTL_DIV_MASK at probe time when unset.
> This lets RZ/G3L, which has a wider divider field, reuse the same
> clock-setting code.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--YRG0+FJlDArByPdA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr0QB4ACgkQFA3kzBSg
Kbbg8g/8D7xNXyQjqyFx4RqHuX+IddyMKkIytq3+COoau4CUejcf+eSMuqflgFcb
foDKzXOqbaiAkbQ3XPiU3BQ37kZTAtu69uhXXK8zKtqXcVhwDE9808s15Q+qrXz4
47I6Uemj/7fwj2+MstmTOW7ANwQZwZcSAf/tEMVUUWLQyRlSNkW1Dy+cx+BaQTYE
+o+b0DUbeRnqdsQL4kRuHwbgCBv4iHKuFJE2UeL5MMdIgLYSKa3QzD6oHAQ1LZxE
Wtxg4hc2IoNyZ7VDEMrokSsx4znNk+QjYpOBKrjtps6QP0rek0MRMRwKUb5Uezz8
Oe3OLiqCojmdx9vwhZSvShcW1g8JTyWZc8DXyz57i3sVxqtG+t22xX4YXT4AAiLV
Xdy+6EpPEJchO1rNnxJ5c8ks5pb7atFX4dzOgXuMhODUGzmXWCcUL3TvUp8LTcqN
Q+zE1/ck1qjfpqHydF4U7qKo9dZ0muiI2a7lnpK5h7sjHimO7rIwmZ0u0pxgfYmk
tLxPDcveKbvJMS65uFHobqe11Qqz6ApxH7RhM4PWhNvehGuv8RlHEj8+mH0RvEC9
4pPcinB4Oqp1TZymO3DK9GJC9guCfYCk1+AFF2Ij5/8p120aLdI0gcNhgozVkvB7
2pXT5f+WBP2V82GRoDxaxIvbrksdN2rIsgWfBuawj5IL42rpJvY=
=76PA
-----END PGP SIGNATURE-----

--YRG0+FJlDArByPdA--
