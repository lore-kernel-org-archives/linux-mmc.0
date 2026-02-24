Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3A3ACF04;
	Tue, 24 Feb 2026 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955892; cv=none; b=YoZbfx99OU9Xlsw5/Mv4Rh7F3bjM8sy+RvWJpig+M+JiVC9wdTcO69pdnYpjEJBOcxezXNlYCcmAgGWxPp3R95bIGzi4vIspHpWnyNH8ay08KAbU5ctTbUCAfPHsasK1T8zQ0lWZcHUildfczaAWojTE3mON0vEGid4ORu8MR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955892; c=relaxed/simple;
	bh=8MqGwWFIxb4Lml38KorT8a4lyqWubshzajnY4LCZvbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as+tSXuan+ueSKABf6bhqUcQPYhVM9SskIelm/Z8BqwzMNJ5Z4uHC3R5MCj7p8bemiMhd31DXhkjEPpoEXGklyY7mogHFHwlnstfuWx+hwYmrCw2CyjeI3QPNvhbRAVAmSRhpNqob33QL5XGx3ojiE/SxDiMkxIikwrgDwMSfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SljPjdE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SljPjdE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54A9C2BC9E;
	Tue, 24 Feb 2026 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955891;
	bh=8MqGwWFIxb4Lml38KorT8a4lyqWubshzajnY4LCZvbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SljPjdE4CMINN2eG8ECkcgTLd9wdfONF4II4FfWPdze7eOiBo5UZevZcOBmyGR6RA
	 MA+2bxKnUyTD8BMcEp6X0Xj4qLtfZdFaJ1fHQyH6j88BjsirpTnTn8JLGtCvkfbxm3
	 tcm13GW4BhcU/x2zTZOJw/9XC/wZVIV5PR0Bg7DoERBxjmyarzirPiwuE40r2AC8dx
	 9IDn0lfX4UT3TvJiutYDIsubDLDjsQJAm7X4/WkQisOrI09rUWmQehiL8NOjYHzZ1U
	 H4bv4cKSecMRf57O1Pyp8ZNGZpX+Dv2Aj9c1a+qhPQOs7FkEaxFNOqkxoRVTgtGZom
	 J2PI2ONXpNLEw==
Date: Tue, 24 Feb 2026 17:58:05 +0000
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
Subject: Re: [PATCH 2/4] dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
Message-ID: <20260224-remote-deliverer-958fcaba8bfa@spud>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
 <20260224111533.3194883-3-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jmI0Gm51aFR3a6xs"
Content-Disposition: inline
In-Reply-To: <20260224111533.3194883-3-ciprianmarian.costea@oss.nxp.com>


--jmI0Gm51aFR3a6xs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:15:31PM +0100, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
> NXP S32N79 series automotive SoCs.
>=20
> The controller is compatible with the existing i.MX uSDHC controllers.
>=20
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/D=
ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index b98a84f93277..014b049baeb6 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -35,6 +35,7 @@ properties:
>            - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +          - nxp,s32n79-usdhc

Ditto here, no driver change?

>        - items:
>            - const: fsl,imx50-esdhc
>            - const: fsl,imx53-esdhc
> --=20
> 2.43.0
>=20

--jmI0Gm51aFR3a6xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ3mrQAKCRB4tDGHoIJi
0qfqAQDI6LlvQVGHvIQUweme/W0XRbJVBLfwH9uELrcWstO43gEA64VdLMQApYzA
lr2KKEuvi2uLGyjfek++zN+gjJ12XQw=
=Az6c
-----END PGP SIGNATURE-----

--jmI0Gm51aFR3a6xs--
