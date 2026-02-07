Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CA286417;
	Sat,  7 Feb 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770479505; cv=none; b=puN3aokfwy/hskceEuRXOn9LTyw3A6LUSTRkVkBD9glC3hmQHKygEC9e+oXkSwPbgsC1JKyreJH8r3NCWP/uO9BV64VpyoWGGDj8vz/wr4knl+udBwkZEMT7A8uLSPNivTDi4ewfVuu8Yrn7HCaRpl9j2kemqqP64MlZPpFoXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770479505; c=relaxed/simple;
	bh=K1GMEmHwvabSXKd7mho1Mbhlbf+jhk57iB1fEiec0OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4ewRo9mNQUQudEBxPA44csAhex8iUrY4gXHhg2E4lhfaN9DSn7Oxrizcds1xAphsoSptzfnHNIqnxW8T6JYCEpm/uv9fpvXqvWtcm3rpjNx0HNGcJ3LMzoSGQiUBN/JRU8NpoKuajDOADMkSMWyfG18NbZzPvLrztE+iHpGAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=swvlT/Ur; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="swvlT/Ur"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=AoggaiyVAyb8QjmFP6pOfv4pN97nDngEM6ydYz9BLbk=; b=swvlT/Ur7F9XYtdzm8HrB8aF0q
	fXor2IMXOgUfQkIOnEgCR8wJTVYHZkldX4JlQ11nFSReubwKNxobw4YUN8EVdcLhBJD4G39SViFyr
	7g+3SMlQulVIzw0ycDo+TxNNen43joYxMcu47+BxGHxuxh9VyFC9ovmKn4Vo2zHhTCPKfbADBxjPA
	qUTyiXFW7fckYwUHjkZ5P0vpnCS9hAV8XASjOTo3JGfrFtu91cJLyVHlWH0TYzTCJxT15SqrEzj64
	WlxokL55YH5pmmOhWt8zVLv88/osb6vzGdy3gRgrDZD7k4wtGILavWa0M2A+YdEVPLkioeA78LFoQ
	wqqPYKZw==;
Received: from i53875bef.versanet.de ([83.135.91.239] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vok5p-007SEG-Nh; Sat, 07 Feb 2026 16:19:30 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: ulf.hansson@linaro.org, Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Fabio Estevam <festevam@nabladev.com>
Subject:
 Re: [PATCH v2] dt-bindings: mmc: rockchip-dw-mshc: Add RV1103B compatible
Date: Sat, 07 Feb 2026 16:19:29 +0100
Message-ID: <7496856.UjTJXf6HLC@diego>
In-Reply-To: <20260207131041.2833840-1-festevam@gmail.com>
References: <20260207131041.2833840-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 7. Februar 2026, 14:10:41 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Fabio Estevam:
> From: Fabio Estevam <festevam@nabladev.com>
>=20
> The RV1103B uses the DesignWare MSHC controller compatible with the
> existing Rockchip RK3288 variant. Add the rockchip,rv1103b-dw-mshc
> compatible string.
>=20
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> Changes since v1:
> - Make commit log more concise.
>=20
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml =
b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index acb9fb9a92cd..a75209bd2710 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -43,6 +43,7 @@ properties:
>                - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
> +              - rockchip,rv1103b-dw-mshc
>                - rockchip,rv1108-dw-mshc
>                - rockchip,rv1126-dw-mshc
>            - const: rockchip,rk3288-dw-mshc
>=20




