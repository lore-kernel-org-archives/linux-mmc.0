Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBF33BBC0;
	Mon, 13 Apr 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094991; cv=none; b=P4ROzgr3VZRDVpsM//sEKU9sv7aY1jaQ2kWubFbOlIY9/WeEcNUAjUTNveVPkaK62mT06zI7gnXOdplsJ7WRl5FKeJinBeX+vw57Vo8CQpOv9aCNwXGNI/RYiVP/wPwgFy6BvVxrgLQhQqB7DkWmGVeriTKSS8J3q1J9FZ8UZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094991; c=relaxed/simple;
	bh=J6M91WN4wCbUaBUzpCxhjIP7l+s0mcfpvXiabrHgDQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2jjhWJvkDrI2mdUhbn9rRdEmsaz82nnjG1MoqVKtOhgyAXi8riwlCp259dYEnwtW3yaxpk3XmnqxcuvBkTLNW4YUemb+WDX9NcqUdEkE9kUFJiHvNwHN6SH+pqgqE8j5AGxPyCqsgvi6f5ifbxbqa/8CLWfr9JCtcMMZHVOmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7aCrpwn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7aCrpwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F3DC2BCAF;
	Mon, 13 Apr 2026 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776094991;
	bh=J6M91WN4wCbUaBUzpCxhjIP7l+s0mcfpvXiabrHgDQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7aCrpwnUb1R4a7GvWyujsiZt0jFDb4IG44cdICeSBu1WJQFlZtg0a0j1TpFphJUb
	 Slk8vaaxDFtZkR5y5YPSrGJkaLiY9TPl/ZIGdFMst2FTguMDqptzOZK3oeSJBJCUc0
	 n89V1Py4jWWoBOtqQuGQus+dzpWOhcx1FAW0ZyWSo0++CjSF85bGb0bM5qWEFOj4uG
	 LhvbjkH7a8RxkExHNkdqQuFZ26aceoy99TGXuC5DkXe1dWTPeIcjzAj1zarEvDXGpr
	 V+35PZ9B53Mlt7widHkX0lvULY0b4b5cdR+nplnqCAk/McSkHyANcqNOlE+FijOZOC
	 Ut8t4eO1IOKpQ==
Date: Mon, 13 Apr 2026 16:43:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/9] dt-bindings: mmc: spacemit,sdhci: add pinctrl
 support for voltage switching
Message-ID: <20260413-marry-discover-e8357e12cf50@spud>
References: <20260413-orangepi-sd-card-uhs-v7-0-16650f49c022@gmail.com>
 <20260413-orangepi-sd-card-uhs-v7-1-16650f49c022@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="url34NB/arvIj4F7"
Content-Disposition: inline
In-Reply-To: <20260413-orangepi-sd-card-uhs-v7-1-16650f49c022@gmail.com>


--url34NB/arvIj4F7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 09:24:43AM +0200, Iker Pedrosa wrote:
> Document pinctrl properties to support voltage-dependent pin
> configuration switching for UHS-I SD card modes.
>=20
> Add optional pinctrl-names property with two states:
> - "default": For 3.3V operation with standard drive strength
> - "state_uhs": For 1.8V operation with optimized drive strength
>=20
> These pinctrl states allow the SDHCI driver to coordinate voltage
> switching with pin configuration changes, ensuring proper signal
> integrity during UHS-I mode transitions.
>=20
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--url34NB/arvIj4F7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad0PCQAKCRB4tDGHoIJi
0ju+AP4tcscdxvK3w0q7a3EslP/B5N38OkukMtHg6HhJxJm+UgD/aSGhGAavzlZG
/mHJ2SrhK59zNN/4YPhq1XaISVMRzww=
=Mk/L
-----END PGP SIGNATURE-----

--url34NB/arvIj4F7--
