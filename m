Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10B3A7F58;
	Tue, 24 Feb 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955857; cv=none; b=gciV9Rwo1+zhYR5AwyeVMGlnPlZ1+muzL6pppsoeS4F5JxLlTl+pEDXEfPKE3vsWkfLcjlavLCHoDbftHK0ed6w0n8WtsKxvVyuj/H28NRCAVqfltNikdT+49qnT8MHA4XkJtIGJv3VURVnhEKjTRPslr0yYFe6NTVjeF34UEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955857; c=relaxed/simple;
	bh=TzQ9hiwv1duoPQIf+icd1+Um2qUulW1YjH1zN1xDt68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esx1tXVt9jBdM/NDM+0RhnN6ssN4dElEl81KxI4+OTAxiY/i8pno5PyqhpuDA38ow/3vf3VJxs5ZkVqNT8kMSFK+W8PIPKu+FXTxw6BVhLawdRh8val8NxxFISaNw6LgCkOtx6dQd6rrnch5CSjiUTc1Gqrk5MCz98M852K5C3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOR0QEC/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOR0QEC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3EBC19422;
	Tue, 24 Feb 2026 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955857;
	bh=TzQ9hiwv1duoPQIf+icd1+Um2qUulW1YjH1zN1xDt68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOR0QEC/BXqWwiRsLqCDj+hKFXDeCpDJKGEBro8VkPqauUXM1s+JWB2o4c6F+fk4W
	 pElZ2VQ29xEmb9FWjB0b3LoPJHPJT7gCTXCuvBkewtpLheh1CrihMi0Axw/xyjzzLt
	 iEDejc+3ttX5TEk0i+anE2bq3noshZ7hNuItGZC3JCy7HEyrhHRqo2UZvvZJx4UW1p
	 DZlOr+fBCJaHYFFzxxcUe6WcrPBCd9raWOYCTUm/qgIqCjJ5r+qYId8XYEgUaGZgjz
	 o6Gpx403ixbT90VYRmvTzGE9fzqDRhM9mmUt4HoY5UMqw1roWqliz+rw5w+cTMIgD5
	 /YHioJIPzBjDA==
Date: Tue, 24 Feb 2026 17:57:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 1/4] dt-bindings: interrupt-controller: fsl,irqsteer: add
 S32N79 support
Message-ID: <20260224-tracing-undesired-e53512135f11@spud>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
 <20260224111533.3194883-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45NNQJw36F4ACibh"
Content-Disposition: inline
In-Reply-To: <20260224111533.3194883-2-ciprianmarian.costea@oss.nxp.com>


--45NNQJw36F4ACibh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:15:30PM +0100, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add compatible string for the interrupt steering controller used in NXP
> S32N79 SoC.
>=20
> The S32N79 SoC differs from the i.MX version by not implementing the
> CHANCTRL register, but otherwise maintains the same programming model and
> register layout.
>=20
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,i=
rqsteer.yaml
> index 5c768c1e159c..caf3e4a1f26f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer=
=2Eyaml
> @@ -22,6 +22,7 @@ properties:
>                - fsl,imx94-irqsteer
>                - fsl,imx95-irqsteer
>            - const: fsl,imx-irqsteer
> +      - const: nxp,s32n79-irqsteer

Should there not be a corresponding driver change for this?

> =20
>    reg:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--45NNQJw36F4ACibh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ3migAKCRB4tDGHoIJi
0jNPAQCrg61L2aRaTJVqK4vMTJxNN++kcY0aHCaUJ0mKDHXIBgD/UW7X0XXe9khO
FPIZw9m2B8CKjCi0+VBVQj2I3rhcJgg=
=9tI4
-----END PGP SIGNATURE-----

--45NNQJw36F4ACibh--
