Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A0221F0C;
	Mon, 20 Oct 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979712; cv=none; b=RRPJ6/kdftncGtiJ5s0F5QlAb1yfH5X2VQLi7mwHnE7ju15Prrq7o5g9tnpJKAtt+7qZuizCmJ4RUtMBiLaE3DDGPVNFu/o43HiSY4kEpndElWJjoDQNjvXujSyzFwhWEPCnlhEnUm/nwjS98NISp6k5Z9lutxzmKzPGa/gaKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979712; c=relaxed/simple;
	bh=VgEmpr+DPqtaWMUYgEbrJ98w8woA/zo2OlQgPflSiFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6eiu/Mn2N5yS3xLbDBoxjL+/5Jv/9iJ2dCeRrBVpRZ5J1pvmMo6FE+jH+7k7/l/RvnAjRjhqw6Gds5h2rFihD5gBubznZbLVTcz2Byq5fcgnuTQ6XYvp+bn1TQYwToGK6T+BnYOXfUd0rIt0E4q41PDsQq890Slet8Hh79z6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Luoy03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2Luoy03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA178C4CEF9;
	Mon, 20 Oct 2025 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979710;
	bh=VgEmpr+DPqtaWMUYgEbrJ98w8woA/zo2OlQgPflSiFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2Luoy03EDvu0clu6JA7SA0dQOS29Zxvy2FtjX3BmEjnuWElr2tnDj+TnGhNjqJBl
	 V0OWze8jjjiQrK7DmVWlxF+f+mf6BxyMI7ZBj9885uQYh2/g0ydLBJOvFsiAYcV2mo
	 0K/QtBBU2nMZRWEzFpW7N+lJuPbXUT0xqZfc/tvXykWhoFoqT/LG0V9alenXD53fdA
	 eTzBaFMJQg/Tz+pN62LBj835+TJ5h8Zlj8haoCbOOBTLs2ubHCfFJ2QbqG/ZeiQcls
	 hKVx7VX7V26R2UtDjRpwkz5Aj3Q7bQ436rqxyvZVEIp9u5iT2m4y7G63Fw5L7ZKu1U
	 csB0/weYKKYhA==
Date: Mon, 20 Oct 2025 18:01:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
Message-ID: <20251020-blimp-gravel-ca7f43294ac7@spud>
References: <20251011-davinci-mmc-v2-1-355da3e25123@gmail.com>
 <20251012-nickname-morale-e1e21796f1f1@spud>
 <bffddadc-4235-4ccf-a0ed-7a0de68e2fbe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZoahM1thDyeEzw2g"
Content-Disposition: inline
In-Reply-To: <bffddadc-4235-4ccf-a0ed-7a0de68e2fbe@gmail.com>


--ZoahM1thDyeEzw2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 07:28:49PM +0530, Charan Pedumuru wrote:
>=20
>=20
> On 12-10-2025 19:05, Conor Dooley wrote:
> > On Sat, Oct 11, 2025 at 08:52:07AM +0000, Charan Pedumuru wrote:
> >> Convert TI Highspeed MMC host controller binding to YAML format. Define
> >> 'clocks' and 'interrupts' properties to resolve errors identified by
> >> 'dt_check' and 'dtb_check'.
> >>
> >> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> >> ---
> >> Changes in v2:
> >> - Modified the commit message.
> >> - Removed 'interrupts' from required properties following the old bind=
ing.
> >> - Changed the maintainer for the binding to "Conor Dooley".
> >=20
> > Bro, what? Where did that come from? I know nothing about this device at
> > all. Find someone from TI to put there.
>=20
>=20
> I checked for the compatible driver and found the author but no email add=
ress, so can I add Ulf Hansson <ulf.hansson@linaro.org> to the maintainers =
then?

What about the author of the original binding? In either case, the
original author's email should be attainable from the commit history.

--ZoahM1thDyeEzw2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZq9gAKCRB4tDGHoIJi
0gHNAP9omX2gwSwH6uEZFZVp/REqDzLbsEAfRlr96cKUgLRLWAEA5qs+d0xO7EdM
kRwYqTGUqtoHaZc1jcHjkA40F9A5uQY=
=7XgR
-----END PGP SIGNATURE-----

--ZoahM1thDyeEzw2g--
