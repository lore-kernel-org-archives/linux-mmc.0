Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360983630B9;
	Tue,  2 Jun 2026 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420012; cv=none; b=AKTQzNwau6SmFkCUdrv4lBVPFEh1KOn3+OEnSTC9V+Qt0IB6RsdwOwRMjc0yIZWvhdpCSd2fXqXoBaW7fbiWm1OgZaQo7SLLiOmNzKS1iIY7R9UaC38nAa8JpwE1apcz4iArSgTuVlv7rV4smj9hr28EZo16/uK/XU8Q9js2XUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420012; c=relaxed/simple;
	bh=JvxaA6wLGak/yScDoDzmcGWAWYWevX6q0IePQv9L8z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvT1rQipIgyPz1+BF0/o268ps6GrZcTw5V+LOeLA37ppN5e+n/0S3YnIIk7Ra2+3i/I1qiwTuu95GTwNTmDfmifCJv8HVkUTlmMxT5oO0f5mMckOUdxbEONkcbY10c/sFnVNH8dUDr7pK6pkrZmfBUk6YzffjjVD+9553vWOTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de7iioJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de7iioJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A211F00893;
	Tue,  2 Jun 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420010;
	bh=JvxaA6wLGak/yScDoDzmcGWAWYWevX6q0IePQv9L8z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=de7iioJ7xSO3IExCUfBkzcWLtfP29drdiVXjTMUQym0gjcgHsMrJVlI/NbCviNM2U
	 NvCPFg16YNWudw0QSBb58CS+VLKbA/gbE94MdXP7hMvuTE/GtTGwx/mHakKt/OPYeW
	 C0k5i6rANfaNemqCOvvorEXtGNhn5OG/Oyprjq7fvhY0FBI9cKZ6dHKIGGkA44Cd0y
	 Of0aC/O5TDI8j+IOWFWRdUqsfnDOLYbGfSEUHYmLfET6fT7iQ21gr1G3EpXIFgli9n
	 pf4V4xNihF5PFgGM7RW7RwsEh3hc3EiGuY7LbGeV72RJnQKtXBw82E5rA2ucIP7Em7
	 kdNjiY5/n1lxw==
Date: Tue, 2 Jun 2026 18:06:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 01/17] dt-bindings: mmc: renesas,sdhi: Document RZ/G3L
 (r9a08g046) SoC
Message-ID: <20260602-rogue-deliverer-a31566cfe35b@spud>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
 <20260530160823.130907-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bYqJ8tXxQoBZPBpW"
Content-Disposition: inline
In-Reply-To: <20260530160823.130907-2-biju.das.jz@bp.renesas.com>


--bYqJ8tXxQoBZPBpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--bYqJ8tXxQoBZPBpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8NpgAKCRB4tDGHoIJi
0l6QAQCYjEsal5suzX4C1XiCUsI466bNWYMUQPuZkulex7BguAD+PQC629ifFQKL
mM0ycGlv5ihKJxQWSvYUBJLlctuRTQc=
=6++B
-----END PGP SIGNATURE-----

--bYqJ8tXxQoBZPBpW--
