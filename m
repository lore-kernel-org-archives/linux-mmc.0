Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B818FC74;
	Mon, 30 Sep 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704154; cv=none; b=d4i6qcvJyfTHZHl/KZtDFKg07aucIvw7dCSI2lLQSxHgepyjYYmygv2kzVzo90sxat4LQxVE4DpC/6AsXi/qh1emDwGoQUqMxmZnNJY9jw3rnTs0BqIvyjAS6rzfYqpY+l+5sy3eWs0kF1TEjRuNOjROhpYwmr38BgSm2/y8Xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704154; c=relaxed/simple;
	bh=SkKdWR6Zc3Q+WJ73XbYu0E7L3E7jp16JZ4FTbmoEYow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBuvYHZEy0P8LDzrGoeaCOyylx6LrhWZIo7UEXzg3GeIkMbwJdoZSynZ7R7e+L7BarIBK5mKBwHoMeRxP5xR9iYGpBZJguv8Ws9wUa2nPcN23hsEXSI+lR2lzrNVmbIOH0IhhMiExfL1wZ4QC6GgHXcKCMJSo4tHyAam8hQIxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+C1Aw4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+C1Aw4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1ACC4CEC7;
	Mon, 30 Sep 2024 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704153;
	bh=SkKdWR6Zc3Q+WJ73XbYu0E7L3E7jp16JZ4FTbmoEYow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+C1Aw4BGq8+xPUColHxaqwGn8bn497CTJ/3ZKnacQdt68jlva79GJinOgc4OoG03
	 QebsMKFlHSSUKK/5fRsaeIZ6NsXoq+8/vwF4xltfD9zOdqI4VHQ6T9ED2Y8L/+pwXm
	 AHwhBKB+0fnuPOKKq17S31eVMDbJpY8ls5A6d3nQrmc0Lt5kldiTE4uKaQ4RiwY1eD
	 ozR3cW0fz2Tud+uCHGVqR/nddW4qHzN/RHMI6hLBXO5HA2UwpkvUBR3TAY87MOLwiN
	 OLzdywjVluVPuttI2hCh/9QY4R6tKFCh850bnFooWRnXlF8I1jVxKznc7HrPZ6YGEm
	 fBuXZ5lxxiIMw==
Date: Mon, 30 Sep 2024 14:49:09 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 11/20] dt-bindings: mmc: cdns: document
 Microchip PIC64GX MMC/SDHCI controller
Message-ID: <20240930-chimp-comma-6db698200b62@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-12-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOdBjTLrXI5lY4Lo"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-12-pierre-henry.moussay@microchip.com>


--hOdBjTLrXI5lY4Lo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:40AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX is compatible with cdns,sd4hc without any additional feature
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--hOdBjTLrXI5lY4Lo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqsVQAKCRB4tDGHoIJi
0oOKAQCU4R/1xo9B6pPOR3TbYx9IffvFqwHarfzW6jfN1QcgIAEAzfaGJijbvaMD
i9LsJJTBZhtJTwZBS0t4kj0xWvPEdwA=
=2x+V
-----END PGP SIGNATURE-----

--hOdBjTLrXI5lY4Lo--
