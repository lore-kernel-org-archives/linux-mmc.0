Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE82BCF45;
	Thu, 26 Feb 2026 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130642; cv=none; b=SACnwMR6JAW5wSRPnqCwg7MzVDV0F7Y5UtTezN6YeqrabHHXbWmWtmdm28LD+drhYO984+rebfT/FVpnWx5CqrzkFAt7UmwCjoqNmJ+LqbUpZtn7RmBtL1+glya3/NBAdrhaVzcPvOmrWMP87Cr+iKeqVDlFVgqIv+aUo+6sumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130642; c=relaxed/simple;
	bh=ooQ6613FOxl28UBORsVNyo3Q4mu19qXN8bOmyNjNBtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxnOEm/Qf0ML64SRSMrSkFqhJhwz8cRtsBodD2GF+eH94CpVITeas2vf4FrZ9hHDXJEWWpr/2UokhrGh7S/n23Y7kl2DesfGcsZV2CnjY/kvbeMGrQXTfYIal+t/EVyWpT4csJNo1tv8BLn980zwTyEwT84SyMejGjI3DzZyKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXonYp9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXonYp9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DA8C116C6;
	Thu, 26 Feb 2026 18:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772130642;
	bh=ooQ6613FOxl28UBORsVNyo3Q4mu19qXN8bOmyNjNBtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXonYp9b+kbGFH+NmnmOE5Biw0/YZo8IsUqZjZ7NA9+Bdwc1oQvRscPdyewfD/iuP
	 +evHJeHw+77HI7cE03eyEsNNYQPo3MubFW7mgsyqgOZeZVAV/Kph7CsKtz4jSMAaiZ
	 IURjP1qMjEnBkG5uAJU+Ba6TiA+YQ0JR41iLWnKvznYW6NWrmOGob9O/OYy3wr3K1W
	 LJyTP2WwkMtExQghTG4rE5WjdbvIjD8kOdjn+/gttTtKvI7Z7xHtBY+/k2SuL0PuWp
	 8Doe6Qeceb11kQGFFM2ruBgQRtZEUCreTF7O23YUof6RYVsGVfrM7nxa9XDLUgrYgs
	 EIhKIy6fkHwAg==
Date: Thu, 26 Feb 2026 18:30:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Cc: krzk@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn, me@ziyao.cc
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: Add sdhci support for Canaan
 k230
Message-ID: <20260226-compress-numeric-8de6b177ab30@spud>
References: <20260226115923.75670-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260226115923.75670-2-jiayu.riscv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PTB97KGCvVHNpIBd"
Content-Disposition: inline
In-Reply-To: <20260226115923.75670-2-jiayu.riscv@isrc.iscas.ac.cn>


--PTB97KGCvVHNpIBd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 07:59:21PM +0800, Jiayu Du wrote:

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5

> +          maxItems: 5

This maxItems is not needed, as 5 is already the max. Drop it if you respin.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +        clock-names:
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: axi
> +            - const: block
> +            - const: timer
> +      required:
> +        - canaan,usb-phy
> +
>    - if:
>        properties:
>          compatible:
> --=20
> 2.53.0
>=20

--PTB97KGCvVHNpIBd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaCRTQAKCRB4tDGHoIJi
0jmzAQCXtTuc+dTvEFmME0odNPOCKTG7oRRm9zp/zJWTjD4HyAD/ZEMA+g6KeEMY
G32ztbqM/Vz1NbVdTlcr4NC9mRkY0gI=
=Mp5e
-----END PGP SIGNATURE-----

--PTB97KGCvVHNpIBd--
