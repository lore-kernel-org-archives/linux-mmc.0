Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383B2253F2
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018672; cv=none; b=X9RfQz7E41DxGj2WO1itnhRqLLObOgN7ZG6+8aANz8Bfy5Y1v/jUKhEMcQxP3r2HsxknMAkF/Efefar6UrLgjPOvO9YkBlBbBR2YfxuiOr/meY8gsZgKF78LE6Vi12y0zsqBS0Km8W5gyedv4xzXMW++GhT+XPsj39Ncv4SH2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018672; c=relaxed/simple;
	bh=mQnvaDZ1Qzr1QmuEgS2iPhquoOkwwoCCxw1nPAElD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCEEa1paa/2ZjlrurgFF+eM2948qG4L+zsy/DzLr6fVUGO0x7vUeFVaDLIe2Qzqu/wJIfnAiU/5fHVIoDEEYx8CWaMaF+yeBXAHhtxrDSrc9D4kVxpKiN1xPfd8Y3WEWP6hYDaoxJ6s0/lvTGukHRkZYXAXA5ed+8uYsLksC/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ouqafc8+; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ouqafc8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=mQnv
	aDZ1Qzr1QmuEgS2iPhquoOkwwoCCxw1nPAElD7U=; b=Ouqafc8+GxrtR+orBBNJ
	GD4I9NuhuBND8SaZbD4jy+rWM1XrjBg7fWgihzgOOrBOzSolJrC6ny1by4YTiYQD
	r/m4y3/VxYETRWxgcRJW8pjdIH+A5bDgF6/WeNGMdhuh7N0K8m4sIWKUPY9tjPTs
	w8ExAQiszoXscp9HS3w8zNcjcPS9v6f4sWxY8EWFx28Z0sWAo4kz+C5iiW6qNTih
	ap1YXel039bAWDoL1d5sRmq+L2wASGi+EzNX4y7ssa5+1vd1+JH3xoatbTEMYoal
	JZ4jAzS3gQ6xq4Gu1nU4zDK5hgo5u8LmjTpnYD2rHo1PavsFQh9SkE3fdWnQtzh3
	3A==
Received: (qmail 3746610 invoked from network); 7 Apr 2025 11:37:44 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Apr 2025 11:37:44 +0200
X-UD-Smtp-Session: l3s3148p1@ALTy/CwyUswgAwDPXyfYALbiJ46yNPq3
Date: Mon, 7 Apr 2025 11:37:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Use of_get_available_child_by_name()
Message-ID: <Z_Oc5_tTbbE30m35@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
References: <20250407092144.35268-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="42IXCas2vryM+yI7"
Content-Disposition: inline
In-Reply-To: <20250407092144.35268-1-biju.das.jz@bp.renesas.com>


--42IXCas2vryM+yI7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 10:21:41AM +0100, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> renesas_sdhi_probe().
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Yay!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--42IXCas2vryM+yI7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfznOQACgkQFA3kzBSg
KbbXGQ//bnhuFX2HeeCSmqJLVz/GrMxxX7P9mY/7ef4SniTTNGHdk/wXWer93HfT
x1t6JdI/AXmgrYcSs6hRtwqVJXoTwIuU6kNsPf3KErTVLMPeyJneqY+i5ke5iFHD
u9vBhUSROGUyIokZk4g7aO/HfgPXe1z5yyWQg4CyHbFIw/d+euhV5NLH/uHb+4qv
lNeKt01zBkOjJf1n8Mpt7eyiXAxqKa67UUIrpKPhnQos12Y5hlkSna3Ce3cWtSbA
9P/WkTcRW448bmxwltEXUG5Zo9B/a8+oiea1BVYACot2Z1iCRAOm2FS1nSQchKuv
z7fBc442gu84Q1qbGCQmLNW2yo/zWkrNebXU9OSzVb/4OrY1vxEajxaDBHBjH3s/
Qv4Xtw4PTN8uCIT0U2o5JOXcKUGTYYS91CXLrIZX9c1lqBmpQWekZN+2DLOqNc+8
KHP/4k5AQQD4y+PlDYBRDLeIlQ3PVkpHzaMFq5dXOv84JxaiVWln/d2l4GvePukI
5g2YSwg4/r1rsyq6en6TT8gKK14JZObi+bX7T+hBHxFS3EMBGNJGyyHq5rDD+jig
pp0f3YPZUE9iHq4NNcnfu3vbuXnEYizaja+vEAV+zkZCF/fWI8M2E4wBAWHvkeeP
a9hgrOl+nvNmXsRBYC3X+uoN1VXnLDg8yFIYXwauwcZu28BcVJw=
=aFPs
-----END PGP SIGNATURE-----

--42IXCas2vryM+yI7--
