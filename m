Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3053F5BC3
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699753; cv=none; b=GAlDCPHjKKxeeu3yOF8mq2mAE9/elIXjlXDuTk+wsws4Xrzz3Tf+7oXBUQ/cMNLFcH02MukkcFjVioCrV72iK39FAQiwtxFNIpRAqIJ8h6dOWArEC7lAoROkhbypgHKA5abK739L1Nz5Ln+kwX0z1YjxwTuKwnbVIBmb+4hEHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699753; c=relaxed/simple;
	bh=KC+ZXjDxPZVDDLH76UG2iit2I5xfbD2dPJeQblzuMzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAnuHr13NHHiDe9e1kPtrW5zDWnpcL3xgKhCUmEX90D9mA35PxLsZ7Oebe6eLAEeMtlfQi0wzG2S0PR9VEgE6bMjgA++iINqQLf+fcBnw5vG08BaAI/a+W0soCHrsnu9rjMAdg2SGhOb0bQyVcjBiNE8atyamUId+n2iUt7GoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ae/6khS8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ae/6khS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KFZ2
	yxL3BFsZUdUfuDksN6EzE0vGtrKj9GOXVWnTgAQ=; b=ae/6khS8QjY2U7vQdp+u
	b6oR4Vw1pBstNY6z85lzSN2ewUJcujLjiJRcP9OH7Ohvn0dQQFQmR+mVLoCjmpKX
	L3YS15MFbgIUx9vI0XiwEVsIjJmnk/T2iM5d8N76O9R7WK9w8C5pAZv2d3OOHSDK
	nOe8AsOpQQmSa+T5UB1xsPswr6tpWVckUdxqVUKbKiZSG5rOLuiOC+jY9SdKbGwS
	P/wFW1XiXh/4JfHUPTeySddphhQzM/ztwem75571WeO9Vi79mps8lVQKC/DeS2W+
	a6qBWlIo7OASy22EkBWIrQil3HCO3huVHl80pQsTRU5gw54TqNlwj8cwq8mC0lWN
	gQ==
Received: (qmail 165056 invoked from network); 17 Jun 2026 14:35:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jun 2026 14:35:48 +0200
X-UD-Smtp-Session: l3s3148p1@ufmdTHJUUKkujnvI
Date: Wed, 17 Jun 2026 14:35:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 06/17] mmc: renesas_sdhi: Introduce
 renesas_sdhi_hw_info to abstract clock mask
Message-ID: <ajKUpOHCaufy42NH@shikoro>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <20260603065731.93243-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/uvNf059UeDEhJ6G"
Content-Disposition: inline
In-Reply-To: <20260603065731.93243-7-biju.das.jz@bp.renesas.com>


--/uvNf059UeDEhJ6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026 at 07:57:06AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The RZ/G3L SoC has 11 divider bits and requires a different clock mask in
> renesas_sdhi_set_clock().
>=20
> Add a new renesas_sdhi_hw_info struct to hold hardware-specific
> parameters, starting with clk_mask. This replaces the hardcoded constant
> in renesas_sdhi_set_clock() with a value sourced from the per-device
> hw_info, and widens the clk variable from u32 to u64 accordingly, as
> clk_mask for RZ/G3L exceeds 32 bits.
>=20
> Wire hw_info through renesas_sdhi_of_data_with_quirks (internalDMAC path)
> and a new renesas_sdhi_of_data_with_info wrapper (sysDMAC path), and plumb
> it into renesas_sdhi_probe() so it is stored in the per-instance
> renesas_sdhi struct.
>=20
> All existing users are assigned sdhi_hw_info_generic, preserving current
> behaviour. No functional change.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> ---
>  drivers/mmc/host/renesas_sdhi.h               | 12 ++++
>  drivers/mmc/host/renesas_sdhi_core.c          |  7 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 16 ++++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 66 ++++++++++++++-----
>  4 files changed, 81 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_s=
dhi.h
> index 09bf9b24a8c3..a7fc525b7218 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -41,6 +41,15 @@ struct renesas_sdhi_of_data {
> =20
>  #define SDHI_CALIB_TABLE_MAX 32
> =20
> +struct renesas_sdhi_hw_info {
> +	u64 clk_mask;
> +};
> +
> +struct renesas_sdhi_of_data_with_info {
> +	const struct renesas_sdhi_of_data *of_data;
> +	const struct renesas_sdhi_hw_info *info;
> +};

? Why don't you put it in renesas_sdhi_of_data and tmio_mmc_data
instead?

You wouldn't even need to put the default value in all other of_data by
using:

In the 'if (of_data)' block of probe():

	mmc_data->clk_mask =3D of_data->clk_mask

and outside of this block:

	if (!mmc_data->clk_mask) mmc_data->clk_mask =3D <default>;

or something similar.

The main thing is that we don't need a hw_info struct IMO. It should be
already all there...

Same for everything which gets added later to hw_info.


--/uvNf059UeDEhJ6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoylKQACgkQFA3kzBSg
KbbQGA/+K4DFfGUrP0eZsG1su+fQ6V40Th+vxpM8U2EfrAKSPkj9ae4ZH6Ckf7qd
dpjkGAOSzpK/fy5aFqViEFZf004NX33r0ZNRs2WQ+wlvKfMkMR3o21BhqY/raZK3
dtBzq/uy1JHA5kJPKOXldQOyF5tIydfKjHpIxPPwkdU1CilXPVpytLhqISylRYQN
OOl8wBBiFfDP9IkCQRhI/leXt4Y1YeP2h/N6rDRDUTIp0COPd7PeIN0rGuciJgPw
pGVO9M/k3cIpv0Vath3Pt02tOd7TuedEZC0cLviJUHq/E9QAqSHdRsrMYUsyPOYM
c6U1yH9ly5f8evR53fTJ+mSCV8TaveqaTrbCE7U5B/PUr4FJiRUlhRojz4cJKPx8
95VUFa5dB3kowQwK1QxQfP8v8/uxs/+f2PB/m9z9Baq9RsvTihKdw/BAD9ya2kjT
S/DKfRx/QQb9Vv4gL5ZjuirLTduFLQzcSo//08znAP78x1YpVs6j76c0SFALtjra
7il8rL1UxUtFDc3+rD2tC5Ct/7w/e+AzEOm66eVmsKRBSEmB47dTsQepxrkZQVzp
S/bVZIobuE6/gw7geLPssZdGnzfrtl9vkuuzmDM4KkH316kwonai4N7+dsVAF5Iu
khCj0wNuymOxK+x/QZXyRB5ZG9FXaUNPUcvB3nOjzGwHT7L1oa8=
=7dhg
-----END PGP SIGNATURE-----

--/uvNf059UeDEhJ6G--
