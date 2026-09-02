Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742F47DD57
	for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347207; cv=none; b=rKnzwDI81MTZV2E7kk22yt6za/J46KL4Ma2zliEQVU6LY4kdVtsf+Qj0ajqZbVZEy1gHjOyUZdvcbzukF1/IMtUlM0EgdZURQTewJOaDHoV0mye1dMym5qGV4qlNnPlgt//t9xERXPVOLPCFbz82tJW7NcnhOEjZy+EczXet27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347207; c=relaxed/simple;
	bh=Wz8SNm5um3pfTKzS+Q596afX6CjL+Cdo4r1tVDitD4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h744VWotw1mPc4mjQCtq6DaGe2hLKcAW14Q44Wg5bqkR0LtFRR0hmYavqdhFaW4QfBKg+mlxNJdbD7sh6EKmdcvDIf6NQHJWCbCRb7KQucrgX/LSwYkdQqtdJ/V/OAzVwCIMVyeYEtPQd394uH1USbwxH+sG1HfPUzhKXy5fGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iwvh8RLb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iwvh8RLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Wz8S
	Nm5um3pfTKzS+Q596afX6CjL+Cdo4r1tVDitD4s=; b=iwvh8RLbsTyK9ubee71f
	FBKIrEnXpa9fFilNCysYDk51rmtCNJ33vQeP31N0SwhCZlxB7lKHjTI0oPgUvXNV
	nbca4r9ybnTsGUaTgIELT5GEYMFkTazrmpwy4RzgC2/o04rDboWRZDd9jvo4N1KB
	HRoXMlS71hWNQMAugyvv+rYH5QPhFHU1tnfSfB0FwFELF9Msl+hLwr05hSBLVwbu
	0a0iWPWj4jGPulfs90k4XJOnVo9MYMLbeCVDQxuUKMhhDBMlIzbZwbnAhNYrYbkS
	BECvUbvJTPayXaFhQnVol082qyvtfSSpyvT6lX0/wgIle88bNAotBwN9jYXaLxD6
	fA==
Received: (qmail 607796 invoked from network); 2 Sep 2026 13:06:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Sep 2026 13:06:41 +0200
X-UD-Smtp-Session: l3s3148p1@esqrB35aMLoujnuD
Date: Wed, 2 Sep 2026 13:06:41 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 05/15] mmc: renesas_sdhi: Add SDHI_SD_CLK_CTL_DIV1
 macro for 1/1 option
Message-ID: <apgDQcohciLNBhsu@shikoro>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
 <20260820171657.62815-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZOgtBE6MTcQMEREo"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-6-biju.das.jz@bp.renesas.com>

--ZOgtBE6MTcQMEREo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 06:16:35PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Replace the magic number 0xff, used for selecting the SD clock 1/1
> divider option, with a new SDHI_SD_CLK_CTL_DIV1 macro. This improves
> readability and self-documents the purpose of the value at each use
> site (setting/clearing the divider bits and comparing against
> CLK_CTL_DIV_MASK).
>=20
> No functional change.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ZOgtBE6MTcQMEREo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqYA0EACgkQFA3kzBSg
KbZHTQ//WnxnoshINh6yDkXI79VW3RsIyGhbEzJbnJaQvOqKFhGHFineHhTV575C
j18g/t4dmOm6l0nxXo9VN//ylK41J7ZMN+D0zfxG1i2ZN0VBbRxtPLMxjPlvkAwx
0QlqogSWYbX0YuAfjHxprJiBfnU9lDSKAng59963TOAnlc+sY1wCFryYdXic42sU
l6tKEDWn8u/YpcDL93AbnQR+MFZIdGkUou9ix3wTCrr36mpJuWD3CR5KPjDsEaIq
f3MBfL/ZyMh5Xd3TjQNcZKZP8rX93CqKfBCnzg9klfRcShxFRleA8zCqwP3PEOqe
v5tachlcDs5ZpPlPHKMC1Y3G8OKz9MLnDF6mG2/xX5W3xHgPAj48Hyvmb+OKxuEA
mKNFhgijWJpDJF66lth4KRSC+cXFvUHuOq4ewYyqDNxh3PpxuD5b4hgVMpQKyFdk
PvN37CBrPnbDtBEOoIY7L/R2+h9gfmHmaZHHw1dX5AJzKhBGve6mJNiuqzbmhAfb
1ZD+64If1FOKSm9qVaBTK0ia1LrWKJVRFOuUY1chv/ypfiMtaF2TCEnljbcJCgFX
ePM9MQD60QT2FeyjicjIq8imcnRBX2Pgc9OEro/PKt0gTK8m9eXR7xlYCJKHNIRG
NN+7mGZgOXGIM3enVNYkMUo+tBzJGfaOs1qv0tb68SqzxcageLI=
=Sx30
-----END PGP SIGNATURE-----

--ZOgtBE6MTcQMEREo--
