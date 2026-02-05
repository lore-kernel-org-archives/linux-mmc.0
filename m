Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB62EAB6F;
	Thu,  5 Feb 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319182; cv=none; b=am7hv5eILBgZkkQiuSXZLe1mkGBpTpYuwHCUly48c74a/qS1FbDjWAF3g03UadSpNcg7jC6LN0PfYpUUAbebrJD8FZx1u0iS5dJPiH5T9X2edjqoQY0cKYl7aXkXc6NtJWFQoyxuCuSaCSbwoy+wM9Z8NIRMcYeYnMalkX8Bd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319182; c=relaxed/simple;
	bh=UzMdSswZQOZGh4NcKoenKaqT+G8h9UNzdi6R0YEqBmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp33T10aRE1V5JA1XEmnURN/MGl+KZ9Y9ClwmqzFh3PYbBbeNToz5J5CZv6wUtHdR5eCEYRnPZUj3pwaA7ME6Uy7fy4jJW66L9KthmuBdQtuWJTIj+3v3Tgn0Uh8yw3VrhVT6Ay2fKOdoXbU6s+GL8BTSX7vBf+fM8UHN8Y9qLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai/KJBM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai/KJBM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BA0C4CEF7;
	Thu,  5 Feb 2026 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770319182;
	bh=UzMdSswZQOZGh4NcKoenKaqT+G8h9UNzdi6R0YEqBmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ai/KJBM5LyRPQQ2DGzHeSO50lRZttbq1SqxlhyAG4gi0p9v7TqhtCBd8kvuHpfNUR
	 4eDk5nABTSIglVGhtglj/6IOGTyQhSiflETD2EfCxS3LUeFhKqbEse95aTH5KDQSqA
	 bL8QVxCgYC6F5IHCHU6lHnrg3rhIGSjeSwo8zpj94DKFSS9qXs0zWB8oQN2GPZ5/Vv
	 ZoCHHmXNsV7HQl6ZAVWCjuWO8UsyKroSdKrZ0ZjgQAPFdMViS7sx4A2OvLUN0xdPuK
	 DqkmeReF9N5XjxWQ+zN0H5Bqvm2IARNHTtAnbo078J39gEK8eBzkJFvLPjEQLuckkT
	 lzFNrO2Lf4rfQ==
Date: Thu, 5 Feb 2026 19:19:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn, me@ziyao.cc
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add sdhci support for Canaan k230
Message-ID: <20260205-choice-require-1794796b10e5@spud>
References: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260204082908.27501-2-jiayu.riscv@isrc.iscas.ac.cn>
 <20260204-imperfect-blitz-55fe5a85590f@spud>
 <aYRC/JVvyI6znWS6@duge-virtual-machine>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7eHTfwTxGj0wRf4P"
Content-Disposition: inline
In-Reply-To: <aYRC/JVvyI6znWS6@duge-virtual-machine>


--7eHTfwTxGj0wRf4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 03:13:00PM +0800, Jiayu Du wrote:
> On Wed, Feb 04, 2026 at 06:10:25PM +0000, Conor Dooley wrote:
> > On Wed, Feb 04, 2026 at 04:29:06PM +0800, Jiayu Du wrote:
> > > The Canaan k230 uses the SDHCI from Synopsys. Add compatible strings
> > > to the k230. The k230 has two controllers. MMC0 supports eMMC, while
> > > MMC1 supports SDIO.
> > >=20
> > > Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> > > ---
> > >  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 22 +++++++++++++++++=
++
> > >  1 file changed, 22 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci=
=2Eyaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > index 7e7c55dc2440..cab33da3af7d 100644
> > > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > @@ -23,6 +23,8 @@ properties:
> > >            - const: sophgo,sg2044-dwcmshc
> > >            - const: sophgo,sg2042-dwcmshc
> > >        - enum:
> > > +          - canaan,k230-emmc
> > > +          - canaan,k230-sdio
> >=20
> > I don't understand why there are two compatibles here, when the driver
> > is able to handle them both identically, using the common properties for
> > mmc controllers to differentiate. Is which is emmc and which sdio
> > actually just determined by how the k230 boards use them?
> >=20
> > Or, if there are pinout differences, would pinctrl allow each to be used
> > for either?
>=20
> Hi, Thanks for the review!
>=20
> Actually, the two compatibles aren't just board choices. They come from
> real SoC-level differences between the two MMC controllers.
>=20
> From the K230 Hardware Guide [1]:
> - MMC0 supports eMMC5.0 and SDIO3.0, usually for eMMC chips.
> - MMC1 only does SDIO3.0 in 4/1-bit mode up to SDR104, and the manual
>   clearly says it can't handle eMMC because of pin count and limits.
>=20
> And the driver treats them a bit differently, such as whether there
> is a phy and the initialization method. So I think keeping separate
> compatibles makes sense to show these hardware differences clearly.

Ah, I didn't notice that there was some logic, I just checked the match
data and I missed that. What you have is fine then I think.

>=20
> About pinctrl, MMC1 pins can mux to other things like GPIO, but MMC0
> pins are fixed in hardware. In next version, I will add pinctrl node
> for MMC1 in the board dts.
>=20
> Link: https://github.com/kendryte/k230_docs/blob/main/en/00_hardware/K230=
_Hardware_Design_Guide.md#mmc-circuit [1]
> >=20
> > >            - rockchip,rk3568-dwcmshc
> > >            - rockchip,rk3588-dwcmshc
> > >            - snps,dwcmshc-sdhci
> > > @@ -87,6 +89,26 @@ required:
> > >  allOf:
> > >    - $ref: mmc-controller.yaml#
> > > =20
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - canaan,k230-emmc
> > > +              - canaan,k230-sdio
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          minItems: 2
> > > +          maxItems: 5

Additionally, why does this have a range? Why is it not minItems: 5?
You've got only one instance per compatible, so the number of clocks for
each compatible is not variable.

> > > +        clock-names:
> > > +          items:
> > > +            - const: core
> > > +            - const: bus
> > > +            - const: axi
> > > +            - const: block
> > > +            - const: timer
> > > +
> > >    - if:
> > >        properties:
> > >          compatible:
> > > --=20
> > > 2.52.0
> > >=20
>=20
>=20

--7eHTfwTxGj0wRf4P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYTtSAAKCRB4tDGHoIJi
0tZjAQDTymGYi6A5F3OEmHSp98izoRjyvyN6cbDuLn5AnhU53QD+LbK8MUALBaaM
mkOTaJUMInjD97RaMG7Y8s7Q5BG7GQM=
=WnK+
-----END PGP SIGNATURE-----

--7eHTfwTxGj0wRf4P--
