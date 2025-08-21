Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBC1D6DB5
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769750; cv=none; b=jckikm6hJUPZyRo47M5u9D4g+jTViUxwmc33W5YGHRaF5oI1cc/2rOJ4OGt882QNfN2drbjGclHYHWVXDOSslXKFRHVEtJzO/si+TiJYaoFrWhmXdFYiU1mWFfQ7MENjsv0B+ghD4TPI/iONH+8c3Qv9qY25dj1O0bu4xco+WAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769750; c=relaxed/simple;
	bh=UX8vDrYP9J43R0NqZ59BYrJtyCp/7fRNdMeiXHHFz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev1l+zJU+RCOOhgxRobWKOpBlH2G4TVdly7Tf89QyLGnWNAtyHnCBV8SAzir7OCX1hrvW7w2OtbaHYvTNW5UpRMS+LmIxAYAy/O+Kd/DFxaklAOJDk6XwKcriKFkmqohLd9RgatKv34diTQLyZo4B0U+OdY5d6sSqIYldjvx/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KYbIUPfl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KYbIUPfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=i8vF
	pk8TmmV+YC6PJkN1DrzCRj0bWcV7pvsCKuGxNPc=; b=KYbIUPfl6I5BcGIuIK7R
	otIvCUUJCkASuxN9fN2kCEtTfrHn6VWQ5rKbM45CrqMdryGkp8eSBf26NCwSo5L8
	UooYzaW5jl2V/iNOQaoGaY5BstdPdDCAts9Utk7OP2prFX6ErNmvbelkf30262rg
	tRodVPpvoSaqq2ujSgyK/txpy+vSc+fklzcNaNpr2FcRCa0Ej979X5HyWOBbQd0t
	KfoLXy/L4L8zrnO2nkgjpftqgrYAqORgXuvgpPtFWM22A6vEm3p2o/9+LWIAHA9b
	OZPIO8Rrhdi42i0XXToT62WWzNPB/Gvu5PKmrtWWvhtGovWLH1c8+/WqcmnB5jqX
	+g==
Received: (qmail 3463209 invoked from network); 21 Aug 2025 11:49:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Aug 2025 11:49:04 +0200
X-UD-Smtp-Session: l3s3148p1@mUTp/9w8mKrUtcd1
Date: Thu, 21 Aug 2025 11:49:01 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH RFT] mmc: host: renesas_sdhi: Fix the actual clock
Message-ID: <aKbrjc0ltDx5yg8K@shikoro>
References: <20250629203859.170850-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yD+fujFlbOdfoXZG"
Content-Disposition: inline
In-Reply-To: <20250629203859.170850-1-biju.das.jz@bp.renesas.com>


--yD+fujFlbOdfoXZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 09:38:56PM +0100, Biju Das wrote:
> Wrong actual clock reported, if the SD clock division ratio is other
> than 1:1(bits DIV[7:0] in SD_CLK_CTRL are set to 11111111).
>=20
> On high speed mode, cat /sys/kernel/debug/mmc1/ios
> Without the patch:
> clock:          50000000 Hz
> actual clock:   200000000 Hz
>=20
> After the fix:
> clock:          50000000 Hz
> actual clock:   50000000 Hz
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--yD+fujFlbOdfoXZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmim640ACgkQFA3kzBSg
Kbbr3w/9FfBjqWBpWAJFW0Sptv0CXrGqsLUKy6Z5qtC+oqL/K+RekSS/d//NYC+z
FqkQIQ/q3vjiz8EtJP5sYqFE3VCFhyhUlsDGf11qsk3RxyysHUa+6j62t5mx0JmZ
5IogXFh74ZcT0gREQyAeNcCV1uC1GlDwpR/z2Npfd7wJx33ap3bSdDhMefl6e4Lf
iqaQ9OMRGTj5zPJc0WrLtU1t2ALdCu5CjgB1gxuH2NP2vVvskTihQxVThuMEm6ZC
CCutOzTz7bVirVo1TLI8pdQ3T6jiO6lmxhSJlCqrGzKF9Fzh9/d6IYt1Vhhuw2hD
zQdz3SIbXK9DHbc24BwQjQGAIaJXwaHwjQ4gxO6V6E+Gm9aw1+NMkOoLHI1yBE9d
0bJueGrfdDvgUTdilXvQq663El9NKv64tNXZHlW+ohssG3XXHC7XSeP7RsJVgfkr
EEQ3D/ZiKEcGUS0XcxG0NZq9MCYpJjTl9tQR/f5CcKC4GWvxaqMmrTl9eFK9bZ77
okVtPFPWUfctm47dMUGC6uzA9CD2K/sPcZUQ3f2PWtqyRvXeZV9ghJhbI+eJNYqa
mr/Z8N+HK1CQTphEMQk6sW1vMc8pv0pelXi5QNN/x7DrN4MIikza0a97oCMYZxmE
QqUqYxv77upSa4g3WJFY7A8xRol8htAUWcJfPR8A7pw5tFoUyeI=
=C2nU
-----END PGP SIGNATURE-----

--yD+fujFlbOdfoXZG--
