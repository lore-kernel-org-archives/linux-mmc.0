Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111405;
	b=qAjfEebaJGW21f3HySlxs6pap2gBb9NLPcSXQc3X9wEUUXxWEaAKAw8OzrHJhP+KMfb1
	 OLL/35w9ES6IKy5NGCVeCCn+OArQvj/fv9yXuYUgsap+mKYKTh3/VvIRVxrhGlfQe9YCO
	 nEy9egUEiAVWZ+n2QmVDIx/IDExzpUecTFiSiY/crJn4FXmUGUkASh5axIiaN9cOR+Y5Z
	 BptIik6b803XutjZn99E2m2mCMf5W9dPsV3fQIrFINmMAHaLcgaW3q/YzJVsPqynx9o9V
	 0ZEcn32MmzY3QQXCYUjlRgIr/ON2B6eGWlTk/pPiwQQi6QhwdFrbKA+wd+Z6TxAkzjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111405;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LEryC18VFbWO1HPbheQHgPUZPB2N1IpxitIBjMyucHk=;
	b=wcH3LB3uLP8V0ZLwyflCsP5YQZsYD09Pm8j1I74m217BxxwFdT5DVryT/3HHNci5oupR
	 /UxQDF3n8CLvX7kQJpzrcStl58gf581qIokbbL+TKRKs3JuXz4qdpv60YaSpAqdmCJPHB
	 xmbNR0hzz2zNAzgU/UDdL0AzIM5zAdC3KcXUy0ZYPGhAsNbzfno4xRtA323uIsCqoAKC7
	 f/W4U8UB06b9DMK2mrFFrM+fJz67Le8C2YRMeBmo9eND0fjnBQ13hPMzZMHwyT8YYDQNk
	 NHRFWWrUzby/JneBCoOQoM0r2THrep+eAxKFzN1oFwAxZnvYg9zxWLA66c9luWd2H7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjdPdCkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF3606A330;
	Thu, 19 Nov 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjdPdCkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F921F000C8;
	Thu, 19 Nov 2026 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795111405;
	bh=LEryC18VFbWO1HPbheQHgPUZPB2N1IpxitIBjMyucHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MjdPdCkSwnt33PZfZyUIMwFkfT4x+BqPKic/kfs7Fam0eZVNloCQfb0vrGPHibUJ1
	 OWWfL/VA2yINkCoC6r4PA7jz0ZTZD35SmUxyzMpIKiDun+pYqC1R319lEkt3kkfwxB
	 9R5vD+ZcdeMci9Dt6Hr9fby9/1HAvpfjIVFhNz+cC3oOljgzOQeZR9ItL8JEQKNAgP
	 DcHuq3A4MM1EF5IHnp2OkVfcgAgruZv0NHPUqWvBDsP5lmlGlYt1VHLsfQKt00yhi+
	 WZW8JEfjwzroQi8TKvOQ2qMGRXssmU2HSnx+qUijE8Wkyv2Ed2UU42+D5XgtaqjN35
	 fXb/unQE15Z2Q==
Date: Thu, 19 Nov 2026 18:03:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Arthur Heymans <arthur@aheymans.xyz>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 06/10] dt-bindings: vendor-prefixes: add
 XRadio
Message-ID: <20261119-upchuck-gentleman-8c787eedbd90@spud>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
 <20261119175002.458988-7-arthur@aheymans.xyz>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="krfCA9TfosKVFfvN"
Content-Disposition: inline
In-Reply-To: <20261119175002.458988-7-arthur@aheymans.xyz>

--krfCA9TfosKVFfvN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 06:49:58PM +0100, Arthur Heymans wrote:
> Add the vendor prefix for XRadio Wi-Fi chips.
>=20

> Prepared with OpenAI Codex.

This should not be in the commit message.
pw-bot: changes-requested

>=20
> Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5471a06f93f1..066c2e90f289 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1959,6 +1959,8 @@ patternProperties:
>      description: Xilinx
>    "^xnano,.*":
>      description: Xnano
> +  "^xradio,.*":
> +    description: XRadio Technology

Gemini seems to think that the company is called "Xradio Technology Co.,
Ltd." or "Guangzhou Xradio Technology Co., Ltd.". Either is appropriate.

>    "^xunlong,.*":
>      description: Shenzhen Xunlong Software CO.,Limited

As you can see, we have existing examples of where the city is included.

Cheers,
Conor.

>    "^xylon,.*":
> --=20
> 2.56.0
>=20

--krfCA9TfosKVFfvN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav856AAKCRB4tDGHoIJi
0p/1AQDruarz8maZkuaP27EFqJjPas+l2x+sf/Ec0zNuqfmr8wEAmcuYePpOTaTY
bNjUdggkVftSm2FhvcIz8aAdzs5A4ww=
=qxxz
-----END PGP SIGNATURE-----

--krfCA9TfosKVFfvN--
