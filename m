Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C448BD27;
	Tue,  5 May 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998722; cv=none; b=D3TiqbyUxrB/A6pGcgUC+ru+IxataRcHMYLbdeoqT3YY32nPV8mbtbx93SKaUl7dGW2bAof1uk80gKr+V1jEGTI05GQNcOisvJgCMYELnVC6gXVOfwRD4GafOFCw3YkU2cQl4YuYOUkJOyIH46EUKfDEHRcVNmZ2OaBtAVLLc9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998722; c=relaxed/simple;
	bh=+L8m/p9IEyMYT1UnbyJiPTjD5qfi3vt0C0WteZRYkKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4lfUzc02yVeUdAbnLzQIjxU5g4qGIvaosWGciOryilFmuAUR+UvP30GfSlkpNvqYgmq+hEMF81NJ8XuCdRe/EGBxaSFfVoxBzjwIzpvhEWrngUIhAfOiJnJeu9Sh44k4gu82w30FS6dj9pIvye8Cku3iVgNKoWy5asYA6VRFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGJQnsTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGJQnsTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77549C2BCB4;
	Tue,  5 May 2026 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998721;
	bh=+L8m/p9IEyMYT1UnbyJiPTjD5qfi3vt0C0WteZRYkKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGJQnsTgoMjZoYLgTsyP6vL6jauFF73n2pNkYTif/o2WInikA1BclPC/FkUvPq0+7
	 wqa5s5zTc7Wj42snBK7Ums9sYe6zVqi5acuF3a9eLmXBkVMzTnVEHxpFGmh1oMNGIe
	 HJgyx6Z91thzEihdPko6G8SYzCazJV6sDpsk0B18qgzsItM4533rWIwpfAAma9sCHy
	 7RbeTHUeAglPUu822wZmhCSKFo8YdWjvER31vErKd3orFZMDOry8OI3zgxrVYgZEhW
	 dLlwg0mqvwTyKTKGlA2BuxJhf2Emu5A4YL4BxEf/lUqtHAtdi2tcoOSyYbH4NSGY9V
	 J+fGY1mlO1AOQ==
Date: Tue, 5 May 2026 17:31:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Brian Masney <bmasney@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: mmc: renesas,sdhi: Document R-Car
 M3Le support
Message-ID: <20260505-freebee-unclaimed-7bd3d1d5fc84@spud>
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org>
 <20260504144534.43745-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CKnv4REyRk1oKXCq"
Content-Disposition: inline
In-Reply-To: <20260504144534.43745-2-marek.vasut+renesas@mailbox.org>


--CKnv4REyRk1oKXCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 04:43:23PM +0200, Marek Vasut wrote:
> Document support for the SD Card/MMC Interface in the Renesas R-Car M3Le
> (R8A779MD) SoC.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--CKnv4REyRk1oKXCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafobfAAKCRB4tDGHoIJi
0jQ9AQDBfT++JVm1H/VuOc28cNbFV/Q4uuX+2DRkrk6Do/lUeAD9GdaCI3FQ467T
o9yqpxAzCpz0T6Zzl9vMwB/7kPnE1Qk=
=9qFT
-----END PGP SIGNATURE-----

--CKnv4REyRk1oKXCq--
