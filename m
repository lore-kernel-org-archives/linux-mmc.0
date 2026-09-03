Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F7407570
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428910; cv=none; b=auv8lT+NR+eNzj7tCAU3NsVp/sF65pZ0FTU7z3zFw5nUitietur+xsUehchZgUWPJo8EbqfNtvQGZkdpsSteyunhRG3nmj9oZ/tvg61JL/9Mxg5FzCQh65l33MN0ZVP2JEPL+rtuzgQyorMqNdhsnwZLB8sVEXq1HvvX7J0x0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428910; c=relaxed/simple;
	bh=BTEgKy4Gh25q2th/WQQ2Pct7aAu5yVuumnbiBDrNuQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp3LengUFfev2oK8QYZGkzo3Ki35g+q2BuS4PKJnFrhP7wY8mElZf/xbFM4SdDkyTFthw1s7jM/VAtb0HFmVega5P7i08+kN56jSodgVxumb4tkVTfjG6N0w7ibESRzINLTwKx0sgIL0cSj3KaSvKvSGEldi/mwqnh+CiA+esvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DWqB0iUA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DWqB0iUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BTEg
	Ky4Gh25q2th/WQQ2Pct7aAu5yVuumnbiBDrNuQ8=; b=DWqB0iUABLBuZXBe+a7x
	JUhJASLwo9ftBdII60oxcvM4VK3z3bgFibtgfimyYikPrz+99QYGu1AoLSJ6Ncm3
	4lvCx02yhbgvNIy0gkebuqIE16yOfgU+/F/RkzwuuAgzo8FZRtzADMOAGPlrXyC7
	OeiABg0ymlzsbW/8LNR4z6v35QUfjnp1BKJjT5K8BqzN0dpkOGMXizInUD8h4J4f
	/WGIs2yDbzOF0MFwuuV86ZGANBCKt4jQ0gSCmqhDegPGnPR6MUr0Gz5O2yXzfF2x
	bk7LL7dRABvtpdgtJC6CjgoqcGDH9bjOaGBkTYgf9C8pdA00m5JF1nLDwIHre+1F
	zw==
Received: (qmail 995934 invoked from network); 3 Sep 2026 11:48:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 11:48:25 +0200
X-UD-Smtp-Session: l3s3148p1@gf6WDZFaCIIujntC
Date: Thu, 3 Sep 2026 11:48:24 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 09/15] mmc: renesas_sdhi: Add optional axis/axim
 reset controls
Message-ID: <aplCaNKX5nr8AqXB@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-10-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tVq6OMIMLm0yDqZH"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-10-biju.das.jz@bp.renesas.com>

--tVq6OMIMLm0yDqZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 06:16:39PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The RZ/G3L SoC has axis/axim resets compared to other SoCs.
>=20
> Add two optional reset controls, rstc_axis and rstc_axim, to the
> renesas_sdhi struct. Both are acquired at probe time using
> devm_reset_control_get_optional_exclusive_deasserted() with the
> "axis" and "axim" reset names respectively.
>=20
> Include them alongside the existing rstc in bulk reset/assert/deassert
> operations: triggered together in renesas_sdhi_reset(), and managed
> via reset_control_bulk_assert/deassert() in the suspend and resume
> paths, replacing the previous single-control calls.
>=20
> Being optional, these resets are a no-op on platforms that do not
> provide them, so existing behaviour is preserved.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--tVq6OMIMLm0yDqZH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZQmgACgkQFA3kzBSg
KbaA6A//apbP6oGXAaySC7bDf9qEa83VCT+SIn0lF1qMkdR5FXj0mLL/Db9poGj1
XCrjOPYhSH7XowpZaH0LhBn2HQViEgCS2b8PkbxdaHPW/qKbpmbablDKQIrswpAE
9z9ySdC48MHKy+yaGyt2thEBNd+RrCxX2iwI8biEmvSGm0XshBn/dp1LUbk2DCwJ
i2MeoVfjwjky1pQoOx+XodHwUeGdZvwK9TgDt/s+dWmH6nIzbACpvlZuZB0YQNFN
vLBQV/Ct+4MzkrRXNv7Xd/6M+wZgZQJVjXkyw95Garp5olutuvAg+E1W2pSnGkQt
wJviWAwJ8gKyIfP4fs5V9RGJRAK0jGmMDkchDsA3tqqpyPWjLTy+N1QDCO7NN0GR
NzVnoPpGNEbREmknhrCy7uGSrawVUKrwLzb91QlFpXf5mqHKEHdBX1TXl8EkOkYJ
nrVNb3K21bymsx8qycL/+AD7H5PVBJNvusoFZlK8Rr+w6w/f+Jkw1DLcQ3sOLuVt
herAUocmtnrsLXFTORxDGVxsvOrpkkXsqu06iKzHTRDf//8G7xDw+iWo2Ny2aeT8
MzmafCpd5sceUXjazgRrpnqXBdN9neF4Nl5uHbh6AuUv5B73Lx6M3rbHEwojFhwc
gKA1vtutKFYZ0drzJHL6XIciZvzzW5W6MIcqcbcjj7PnLLkKK4c=
=/cUB
-----END PGP SIGNATURE-----

--tVq6OMIMLm0yDqZH--
