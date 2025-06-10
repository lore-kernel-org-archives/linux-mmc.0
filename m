Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AF28137F
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543850; cv=none; b=k6Iv6dNj+foOWsPRaPAXrtfnygGT/IbNDSOKlnuAOZF0Rq6X1HBNDtps2VATwtZTzQUBECu0Rb/fNcph5DcP9QpkU3TL3wD+11gP01MkFJQsXiVR+ixw4lpMlSuPkRlHgWVUoGi56HqUlp3bJUvAOp+R5HrHn9B6FTO6YPnCJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543850; c=relaxed/simple;
	bh=UZYQMg5n38OqHXTazUXfA/Myqa4stOgAiucYefGEcIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBSL8AEpL99ngA6aXg1SArJpf4sz9g1SnWLsO7z6mem+12HwacjpsylMpGrIERHWzCaT3TNl2P/1auLOnBoGF0SzQInRArdsmeEixNl2Cu9u5oIkrThYne8oecdsrTNzFdRTWGsXtHGw/uwSfoowp4WLbaz4GANRB89TRPq4DFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SvJKeHaz; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SvJKeHaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=UZYQ
	Mg5n38OqHXTazUXfA/Myqa4stOgAiucYefGEcIo=; b=SvJKeHazzEylViGeMGBk
	RMMczi+yT6q7zmOnv7UFu8HBK7qg2Kz6Jk/JhCMbgr1Nh4rVqlxeWXM4d3Dds46w
	zsy7s6k8Um/2ImFcxBm+jsD08w1REwp3TtBQxmAd3AxZuR86RSRc1wOV5IkMWwbM
	4eS8sgJayD7pEO3JaMsdEdpZZmWj0n90OYoPE3j1G9525d5U2LWdzrX3guNlUtHZ
	YhvqdIbjINKJloyFxPxuzh25yJLPGzcFFlzsNJzlznqCkVe/fjRh7b/nnsLWETGT
	qnVlpLsLMCK6ZeyeU/+QDGOhceRInIrTmCP3qUoYNZEASobr8Kf2acczqa+rDiiW
	rQ==
Received: (qmail 2790248 invoked from network); 10 Jun 2025 10:24:06 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2025 10:24:06 +0200
X-UD-Smtp-Session: l3s3148p1@hElzazM3hsoujnuC
Date: Tue, 10 Jun 2025 10:24:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: host: renesas_sdhi: Fix incorrect auto retuning
 for an SDIO card
Message-ID: <aEfrpUA7WsyiOjX1@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
References: <20250610072545.2001435-1-yoshihiro.shimoda.uh@renesas.com>
 <20250610072545.2001435-3-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8z2x2Alxj6iV0BSc"
Content-Disposition: inline
In-Reply-To: <20250610072545.2001435-3-yoshihiro.shimoda.uh@renesas.com>


--8z2x2Alxj6iV0BSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 04:25:45PM +0900, Yoshihiro Shimoda wrote:
> This host controller is possible to change incorrect tap if an SDIO
> card is used because DAT1 is used for interrupt signal on SDIO standard
> but the controller doesn't take care of it. So, in the worst case,
> this behavior causes a CRC error.
>=20
> To resolve the issue, this driver uses manual correction mode instead
> of auto correction if an SDIO card is used. Also, even if DAT1 is
> mismatched on an SDIO card, this driver will not change the TAP.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I tested this with my uBlox EMMY card (SDR104) on a Salvator-XS (R-Car
M3N) and some debug output added. Works as expected:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--8z2x2Alxj6iV0BSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmhH66UACgkQFA3kzBSg
KbZd4RAAqAlFOBeygogPlbLRQPOfiYRbGMJBG8+qsJJTboXsNms3FIl6Otaz8pH9
9ESx0zlPZvglRkPuTffT0ZtNhdMAH7mgzvAJjqkN/uL/pBXN2UwkHtT4Owf0g9Hm
JhAQ9/Ndk9Rajc/DLIukt7g3yeXNriOYs6x18QtL7GQWnutEr4PJ0jg20Zg5osq8
g6nza5p2tp5QchqMCelORa1KuCnGWy4dBp8lem1Ib/cKUvIXnIUCEqhh6j3XwltT
i1fZHhutpgbMQ+hYSfZkYvWKIAO9YNX1E6kbHRqMpFSAcH0rNDlyXtnYwEAVWAyH
YsYO/Cd724IclQTAVyh/YzLiJpRv2KtK3yBmfJzPLGUOx5SV8QQagkeVU7SmF1Pj
hx7qVU+9Jvk0AYckwJtri69kSe2Cu3Wr+KA/JQixwv676NKoSOlxkdy5APlOzJKH
i9nQRPk2BLBRkkkCsbodofu6FroyABxVqby/4py/QnrvBQPKiGKiBwqU7Y0FjUzB
4OpGPGXUdRdBQrQPkIhs/CKaauYx4n0GfD379BDglPUr1E7+Y6Yz6sOm6j/77XxS
BdQCM+NWioeQ1edhk/5YAYYom47IU3mnpR/yJf6Jp46rvHzER5mT2thkyBMuU4mj
i1NrzSk5i5YoSXM9ir7SO4J1zRMiO9EDif/5uAwXqi5ZBkLY8Y0=
=fLnr
-----END PGP SIGNATURE-----

--8z2x2Alxj6iV0BSc--
