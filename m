Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCEC16E883
	for <linux-mmc@vger.kernel.org>; Fri, 21 Jun 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960190; cv=none; b=gzdYqOHogm4jHWmsGScZOiV/Y6X6xVCUemxmBhZ/c1KeGQp6R/e9Hn1xGFPbsG1osHPPW+IiELn8tyKSFmLtK427H49A+fdGz14eBO6DtT90pW6k1NT4QhJeu4BvjeU4KO9/eYE1RjVsvJEhnJkiJL+Ux5N36KQIA9BTOYmDDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960190; c=relaxed/simple;
	bh=OiAwNBD3dKXwDOjocssIYExCZyx30mK+FWFWYtwpASI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fclFNSnagkXanFzY1eGqu+nj8e+pE/FiZNGjiU6uf+JCODjK8nSaonKvgqeXDjUjI3/+H9R7Gyhx8IwPiiOubDz5qEudbYeNrx29I/prfB5ncCEgguMHEHbNy7DTokCNoCiZtoUHHRzXDqNlELXkZ/BGdayBHXOwowk3rY7i8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Z5y3LyJk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Z5y3LyJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=OiAw
	NBD3dKXwDOjocssIYExCZyx30mK+FWFWYtwpASI=; b=Z5y3LyJkPEiFbPL36sUx
	G/7j8jlfBZ7bG2GR7s0hzGe24kIgHzIYpphs/DznBuJG2eswpsQAXf2tWxn/JKbZ
	/ib2/dmS973UK4G9UBr4S7ZNf08D2i8NGY6sdD1vX/PNYzbi92OmJDG6OyXR2zQo
	eDjlwWDb4RiOq7/kG3yA95uZLzGWI2UYde2sTJlC6PbJYmfQHG/CVSgv2hErFaMq
	xqzwqpVTlFNSXKfDCbOuyaXgSxa/+4F+s2IQlD3jtimH3wKixfeOZLJBdr6ycPLA
	bjQHVNjmT8MEJZYRNzUiCKY+6Zk/Q5qyMrUJlhBpdO3phhWGTRBHE4WSgQLcnepg
	CQ==
Received: (qmail 1306307 invoked from network); 21 Jun 2024 10:56:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2024 10:56:22 +0200
X-UD-Smtp-Session: l3s3148p1@z+MEm2IbIpwgAwDPXzjQABqqX1QYyOSW
Date: Fri, 21 Jun 2024 10:56:21 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: tmio: Remove obsolete .set_pwr() callback()
Message-ID: <ny3iwr6sgdvttpywtkgd5ek5ht4ofaezzufr67mxh57gjc2r3v@nj7xwvedtdbl>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718897545.git.geert+renesas@glider.be>
 <fbbc13ddd19df2c40933ffa3b82fb14841bf1d4c.1718897545.git.geert+renesas@glider.be>
 <dyhcjodncsmeufbsjbn2okj2wnjihohzzcoqfbmbxqjquc4hof@5lk7w6ihm56z>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhhlkhozwumzae7c"
Content-Disposition: inline
In-Reply-To: <dyhcjodncsmeufbsjbn2okj2wnjihohzzcoqfbmbxqjquc4hof@5lk7w6ihm56z>


--vhhlkhozwumzae7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:09:28PM GMT, Wolfram Sang wrote:
> On Thu, Jun 20, 2024 at 05:39:46PM GMT, Geert Uytterhoeven wrote:
> > Commit ca78476e4888f1f1 ("mfd: Remove toshiba tmio drivers") removed the
> > last users of the .set_pwr() callback in the tmio_mmc_data structure.
> > Remove the callback, and all related infrastructure.
> >=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Also:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--vhhlkhozwumzae7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZ1QDIACgkQFA3kzBSg
KbYkfg/9Ey7egzKav3X54wCpYtd5bZ6+kwJzS+naDyKfMIQE9uYA+eaFl558AG5D
NBP3/COXnjWnShRVGI73Q9IOPDRcA9BHHCqkLq7jvre6jQXNgPy2O9esae7GBB1m
SlPg9EJSo/73bnu1wjEYZtxm1ONoXxYcnYohvx2wvsoc1GHmwCuShEiUfUT6D+n0
NXjpzz5KjFQnkU7HRM3hgRoeoFWODszy6MtpcYXMUDE7zK+HbqgvTaweQx1mAm94
ErN3lTXGNqFV1s5mLyWLlCvVf25SYJDhrNuUPuV9Zz2QfRKiVo/SexvvXPXqbDto
DfdBl+ldNo102ImbLvN7L6Xb8TkDNkjg7bZazj1RSv2dMR/xCNPp9LQTMagqS8JI
vTds5CnTMstJHvA26z58bZeJtxkUwUef9gR8zD1lja49cIqlJ8bI3g1bq/zUVrPY
3wjpqwdUyIk6XJJ3P3j3P5M79kw8tTFrlYgDyvrIMYTiX2L2Ooio6JbtCw3ZtBvX
zkOHgeeo/TNI5uqH4l7NB2hXbS8LGhGmIP4J14qKgeDAbCmQeE6jZ8J0/g1TGQjM
LlTjmmgyOGL2STIZVyuYs+5IqPlVzV8gMHmtpffAbqYohRuSsXdytvaBuItkEKtJ
lwzSJHFK1B2o9nGFHDpdQ1fISSt9x76Dacy8tm65W8TM9ZJrrAA=
=qXBO
-----END PGP SIGNATURE-----

--vhhlkhozwumzae7c--
