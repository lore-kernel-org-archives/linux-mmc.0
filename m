Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6051123D
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466317; cv=none; b=bXwgHPzPBCwuK8Gf39ucY3mYyt0CMn9WImua3La54//jMzHE5/VjI6Tk1Pv+OCNBaUVByoRIasbzVaJTErI1eDEWChjzKy6Spzk4H3HX5Ij21C8YtlwfN6XTkETQQkn9mflAzlGcKZ4MJXLm+irFw0rDiS7sYe5Si6+ifTLi4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466317; c=relaxed/simple;
	bh=vmH0h3WK8ZD57844TEFW/v3WxY4vsVlqFAWdc0w4qDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doFJgwNowxXwwHzZ3yfrofcyxfPCfHiwRLJ5JQByGmIvw+58KRpKqgLlxXqrAVbjxfr4VtaQihuPaZzaElM5pVR6S3MHNKMvL36BoMhMQVe6FK/yhaFKKCJRKZCUPOMqGDfNNweEMhzT5HtioPcXbsaPoOXOcYQifOH66EjjURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=j/yhbIOG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="j/yhbIOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vmH0
	h3WK8ZD57844TEFW/v3WxY4vsVlqFAWdc0w4qDI=; b=j/yhbIOGWR5UXucdwg+e
	f9SSQWfvigGHOUE6drQChlLsmg+zoCYIw3Cy5DpybVZyZCEwdxIfi0R9gHPmTZEi
	U4yDhNhK22lG81yO+TM42bttmOYcvvaynowsaPdo49j0IiZYtGTqFIv3pSXQGCgC
	ac3hpejp1zAZkBT8Cekwfplo8fqRM1OjhwUSGIFdz0rpkNhmSFqySMUHFQsLGdor
	QTr/8pAXytTClDC0a3eFNVRiYzn05d+gaFd/0jMZprBTjTkCQWkc8ES/a2MJJbB+
	oeZThBZdR+tG1s56ma0IMwkjylFbl4wOmT+3GU8yehqpq0c6BQa9nwgkegU4EnCC
	mg==
Received: (qmail 1175407 invoked from network); 3 Sep 2026 22:11:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Sep 2026 22:11:46 +0200
X-UD-Smtp-Session: l3s3148p1@rFLewplaLM8ujntC
Date: Thu, 3 Sep 2026 22:11:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v24 00/15] Add Renesas RZ/G3L SD/eMMC support
Message-ID: <apnUfCIcTG4bmYZF@ninjato>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yOE/FRGSfTSAVCGO"
Content-Disposition: inline
In-Reply-To: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>

--yOE/FRGSfTSAVCGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Although there are still issues to be handled, I tested this series on a
R-Car S4 (Spider) with HS400 eMMC and on a R-Car V4H (SparrowHawk) with
a UHS SD card. No regressions.


--yOE/FRGSfTSAVCGO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqZ1HwACgkQFA3kzBSg
KbbZ+RAAmh7Bk/uuR0hRrNkdvymdbyBydX8Nh4YqTkh4g4/0YEVLbBpJCK59Sjxx
d3FRxJzRAPEmsxlcflWuGh6oEiK4LXh2wVfzBZur6yIGybfRFeYJSWaArDGkMuWM
omc+Lh9K/33Rz1EAH+a/z86ve1ApKDcU0leVx6BbdfmoBmSbFA08NkBJpvSwmr/s
jvtMOlm/sE13c/ZjAi70CxY8KHwsZpd+3/z5JZBqHcx4jpBtkqa/7BH06dacbl4h
RH8ja4xPC8HZAlmLoYqAyhUV5d1T1E/J7xK8GDJzf+KjaH0a5x+xtTXxBcQkvebQ
D0IEjuEDpR3C/unMZVDndyGQ52wBlm3KPAlIyGox8HaCIRbDMnquHK4hrLzp/pjT
Gh0FosMu2Fdiz9I1ux+vgidb2ycsmEprsm4YbShm/elsHuwlGbhf7hjJiU6tLula
HFD4F2N9OqB498w+7TRafVPHJgPkRn6fdKz4oHZOAuJCc0RhNF5+TZjeeJezL/6Z
J+5Q8hmzjcAXWEywMexHiObS2u0t5J8v64w3NlyV2WAZd3Mx5/4WaweRa2pfSsev
mmEkF0aPmfnP3PiTOYUKnMcunQGCD38FKj+Ya1vMlJklyAXQEw1u2Yx3mJ0asOFs
BdcVb78D6jNFSaC7wTSg862j6JLdyUaLh7XDQvBVb0AREUYfk0M=
=80b8
-----END PGP SIGNATURE-----

--yOE/FRGSfTSAVCGO--
