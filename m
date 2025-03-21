Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAD22ACFA;
	Fri, 21 Mar 2025 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573936; cv=none; b=rr67ehQuX1L3QQyyweZpjaoTEBxXQdyEnAnXsRFsT08bW6AzKdQ6uZrdEvjVSF9XqhKSurDEEXOk2j8MnxvKfcdXJjMy2mauYNIL1Bz8FeXioVkCQiiZsoEei9cNmQGPrdLd7HzuSRiiJPaFO3MZ6HwE7s5sU1eaz3gDhpYcKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573936; c=relaxed/simple;
	bh=YWZ/cjyQth34+4wEpvDKa7ez8+2hDJpFf95FAjoIHCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSQsf9mrcNJacJtDYOcaoiBieqsaXoA2OBgwT5m7LcScyd0tEHbsKTry2GOK3seQWGe5WFhD+ktRzzHkMvQ2yH1EPsO5EiduELyA1YjW9bU+z4Cx6INnAjOwTlbj45LfNh5UIFYUGtZHqRbdObiH58Jo3dtPPuIeWgevSuiFeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGVwc9Bg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGVwc9Bg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681CCC4CEE3;
	Fri, 21 Mar 2025 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573935;
	bh=YWZ/cjyQth34+4wEpvDKa7ez8+2hDJpFf95FAjoIHCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGVwc9Bg+gWRF809tfjsLtFASXqBzVg8CoNj9TAxjcu7yX8yTtiyFLwfGSKIE4crl
	 MsAdNaZbEeLFRKo1lGAJ/tOWhO1sAW2mJsHftm43ghWxhXrbX7V1j/fWPd91WvT0hr
	 rELKOr5E09MV3X5p/rxO6r2soStOMBYcI4YQasGFLLb+Jjjn+LzHq402FHPNm/in3P
	 NlrhWtVMppM5kOC+QqPJa/8Nw5oG1WafCHTXMf6FQLgn/BpeDp1ltNBeWUNZ5MF05u
	 aCB71yHyeaH2ukugHUM4VUuwyfJCnNADtOAfQ+sPvTRwdfrOfZU/BSFm8UawECGfYN
	 Vrb+z2YvMfEiA==
Date: Fri, 21 Mar 2025 16:18:52 +0000
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: Remove redundant sdhci.txt
Message-ID: <20250321-jersey-upswing-0eb4b055de6f@spud>
References: <20250320211922.1135669-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wnNz0ZGNWG6SJzeG"
Content-Disposition: inline
In-Reply-To: <20250320211922.1135669-1-robh@kernel.org>


--wnNz0ZGNWG6SJzeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 04:19:21PM -0500, Rob Herring (Arm) wrote:
> The properties in sdhci.txt are documented in sdhci-common.yaml, too.
> Remove the txt binding.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/mmc/sdhci.txt | 13 -------------
>  1 file changed, 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Documentat=
ion/devicetree/bindings/mmc/sdhci.txt
> deleted file mode 100644
> index 0e9923a64024..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -The properties specific for SD host controllers. For properties shared b=
y MMC
> -host controllers refer to the mmc[1] bindings.
> -
> -  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> -
> -Optional properties:
> -- sdhci-caps-mask: The sdhci capabilities register is incorrect. This 64=
bit
> -  property corresponds to the bits in the sdhci capability register. If =
the bit
> -  is on in the mask then the bit is incorrect in the register and should=
 be
> -  turned off, before applying sdhci-caps.
> -- sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
> -  property corresponds to the bits in the sdhci capability register. If =
the
> -  bit is on in the property then the bit should be turned on.
> --=20
> 2.47.2
>=20

--wnNz0ZGNWG6SJzeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ92RawAKCRB4tDGHoIJi
0hGHAQCSV0LGwhHXQ8bzmA18hum8IlkZMIZhgvHIP7Vvl246cwEAmuB7cxwUZ8yu
IdZNoKzkOtsRf1sbLvX/UbjP3Bjjjw0=
=3KwP
-----END PGP SIGNATURE-----

--wnNz0ZGNWG6SJzeG--
