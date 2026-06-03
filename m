Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4739A4CE
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471170; cv=none; b=BlG6McWzEGtOHnY02U+DXVmzMVdGHWi9hF3WfXYELzuQThwxTPpFK8stmNwW4pviHFig7QdwmF1lfKxKrNXwmTqp5FSW2/PMcidjNI/Qj+oZzmK4i517lsGhDudU/9nAJS9IqENrVQI2YL1kbERZELb2NTjFhgh5Vw71xt7jeGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471170; c=relaxed/simple;
	bh=isQWyrVE+AEdcnOVp2BzHrZyGYpDqrdcau8Wk5dWc3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqwxgfPwswub5jMujEsu49vzaPMq/WZKcVeG6QWi74mKsvoeyBfypq5JAv0jhpYJWP+BzK4Iskncf0rgkMGAQlP2A+jrZBzu9EZI6woPp8EC5IU0oSodOl8KIkyd1hGOQZAHfvPST2LsqjQutPsFrYDO7Iv+x4UMZBmtBH/SRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=D8+tQfNv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="D8+tQfNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=isQW
	yrVE+AEdcnOVp2BzHrZyGYpDqrdcau8Wk5dWc3U=; b=D8+tQfNviaIlP8oA5l4c
	COhQq+GSJTh0YqO+zVgiEav5w3rU/aypfE12u5i6awlrNItZaK0jRbzzPuEFepr4
	BfiujfgAn/pHca2hRULimJrI91dvwXlS8mF8H2p6Too77heEWLjjj+qREIyjqh6a
	KnovaW70iqWZHgf3hsdjAbnda/XVd42JlydJfGfxWe25U/ZhET/WkM5eq1R9kLDl
	yz1tIGzVUkZZFbZNiEvX8bibv0ArqMZAiEUrYk06LmHEQ1JdtMHD6ui2PoWr8QaE
	QuD7u2YpuWIT1mM999vkmj+ZjHsw4ozdtw/4XaMiyzzhSLbrGA4v+R5aLtu4DqZt
	Iw==
Received: (qmail 3173096 invoked from network); 3 Jun 2026 09:19:23 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 09:19:23 +0200
X-UD-Smtp-Session: l3s3148p1@6iQ9P1RT8pAujnsK
Date: Wed, 3 Jun 2026 09:19:23 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"magnus.damm" <magnus.damm@gmail.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 00/17] Add Renesas RZ/G3L SD/eMMC support
Message-ID: <ah_Ve65DvPhlTZ7a@ninjato>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
 <TY3PR01MB11346485C16AFB6299B1711FD86132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E+zmNv8waiDrnk90"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346485C16AFB6299B1711FD86132@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--E+zmNv8waiDrnk90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I will fix the issue soon.

No need to resend from my POV.


--E+zmNv8waiDrnk90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof1XcACgkQFA3kzBSg
KbagyQ//YbOXNDZ8LY7TvmANTK1JEeI8QQ20H9VxQQ1tEBdsu9UKi6Ejc2lUDge2
GTMxvGyjVJkFhpEkwfOrswLpaaAsQKH3peuQcDMeocXy/W7Q97xWinAfOnZwa7EW
+TPLPOc/3fmkQa2a+00j2yoRJ6awF8Ek60g9bAVbp4nUQ/A5iCAPWfabUrcXdI5w
o0nEx4t5wOdX86brXnW2B/wAXw8ul8bXeTc1O0wbD9wUbbpoQtZawIG0g02SKgro
b+porJrZQtFGdGtllUJhH0bvD2b4NHFq926jPVNP+v1JELgG1/H2QvJLMdnGMJis
Kkh8bXh14QERURdW7JleZnErxAi+4X5s2PX3cZ6nr+nAq3IoeHMdyc9tJ85kKNus
wnzBlWTvcbEPiA8iLr1bBXJ8j3DKJxIye/gYPDXbNki5ee0D8KxFjZdl3UtAfsWX
ilK4pr/1UaLm/nml3eEGipGUejh9OVHDEi2g8rXs116zU6z6KkMmaInaNDBTyFZa
N0TpRmducyocbUiAqi3O9FqPBv29/2YNrjDmnSnYo/IQDiwYQBiCy9CFV4o1EoAl
5AJd2Qd0kF1QCFH46CQLPs9t1T6lCvcprhFQi/wRPvwr6rXlNWNustP3yIYZk8ah
gz3XquRg/k03ZUIKMbEOVr3EOe9iOcj4xQ8wJILJazqHtGL5OEk=
=5yEy
-----END PGP SIGNATURE-----

--E+zmNv8waiDrnk90--
