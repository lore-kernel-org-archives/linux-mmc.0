Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2C21E0A2;
	Fri,  7 Mar 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363033; cv=none; b=n6C4o1DYh6tdcH5XTGIJVoqMIlwRFUEp+ycr+YJ68HiZjZAve4CaPmGoY8etELB+IBTDxd3bNaRaZMpspG3HHRvXGGqS1no1l3jpTzjUtBW7tlztUtluXQb+byj1yXIiinniM0QVJ47cBw5inKPurxX8wKTgJT3skVQWBf/ELGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363033; c=relaxed/simple;
	bh=EmpRHggy5GjvVIT0duWQl0IWhuJDRxSDhATt469mtFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmscIx/3hKlJb7ewNmpO9Gp94hMMtfkfQLnUHd8xbZQGPTjYCDwvRkBfaDq/c/ySF/OWj63Pwsgii5vukcnTgO0uJjDH2Qynu+fOCaKlSPkIFtObyoXJnR/eM5AxKbwH1uRFHuPw99JRCyJ0f9FLHvTf57T1uKWXxYOcDCN/V/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbwdaSex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbwdaSex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A87C4CED1;
	Fri,  7 Mar 2025 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363032;
	bh=EmpRHggy5GjvVIT0duWQl0IWhuJDRxSDhATt469mtFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbwdaSexawmGG+Xv5BuwBQNMDlSnh6UlFKlxL7wJGrm4J6ZXTV7zSvnahjARaApTj
	 YlVDWzpeHDccHdtH20YRsuIhR/OSNoEw1vnZ/KZRVFG+uVJxImuAvEyyG+8YPXQyY1
	 T+LQa8yzn+CeskX8paolAgKtuzv5CrT0xBOJm/TkU2x5Dnzv+V7w+tPMDAXyDqt8Es
	 uHIGp0I3+vlBfjVL29msAdEv4wmTDEzMfl7cOdjLy0et8s8p+NKCtdNm5sn6J2N1Tv
	 K98fOQen85FCRz/Phtm7x3pXIYjh+Z6R6uTQQhKTqprytV84N88XtjUkX2x98Y1Tv/
	 2D2o6renZHAog==
Date: Fri, 7 Mar 2025 15:57:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: Add i.MX94 support
Message-ID: <20250307-darling-alto-4ad82d5dd20c@spud>
References: <20250306170937.242183-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYpN23PbLVfjPCHe"
Content-Disposition: inline
In-Reply-To: <20250306170937.242183-1-Frank.Li@nxp.com>


--WYpN23PbLVfjPCHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2025 at 12:09:37PM -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-usdhc" for the i.MX94 chip, which is
> backward compatible with i.MX8mm. Set it to fall back to
> "fsl,imx8mm-usdhc".

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--WYpN23PbLVfjPCHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sXUwAKCRB4tDGHoIJi
0nbXAQDXtgw//BRVfcxZWeWP78cFq3Sym85AsObMUrTxtRtYCQD/eQOM0xIWbK3F
WGMtZmLz79WsWahdW3LsJ4+PFmn6/g4=
=bxlQ
-----END PGP SIGNATURE-----

--WYpN23PbLVfjPCHe--
