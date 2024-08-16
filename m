Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782E13DBBC;
	Fri, 16 Aug 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794360; cv=none; b=Q5z1hBcaU65Hl9qhZkeiDtCXMqg33xZFSM2PPTM8FkOC8BAqZvoB9sa0En1qC5RCQfNqOiw70Y1SaDej/xFbg5s6nhmus6SXjk1QfcOrs38bQXp9wC70D++Ew0SZ0OWid9EEcl0KQLHpiq9IrLvYws0k9C6sus+kmVwrLsnAzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794360; c=relaxed/simple;
	bh=tVPflXbLDBP9NpqaPLzSWTzKxCdCOy2pQJM8Ph5x4sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/tPQxPQ2bHoHZ2MaLVpBfSlWN9mVfJGqZdAkJMtuKUNFjPVKFPbnDa4+ZZb5Pmt/8UuIEOch2ECIrg+qQzRnH82O48ElE3bYZYh9a/w4ouILbEw/GZFEMUlf+BrLhhvL4REH82cjmaYHeP7rnPWTRi+8sI4ET89Ec5fuI/zEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JUb7yDP3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JUb7yDP3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k1rqrEp/hgoHj2qZTKIDmCM8YN6/xOQc45Uuml075HM=; b=JUb7yDP3quBbz3YJPP4izpsuJJ
	xBdwzYZb1tEl0yUWdPhOXKtLXJRhoqyJ2qV2J8b17nEZTZQGQYfLonDsrWG3sPt6ohw5gRgm3/jdx
	inS6+iYlt3T/NyETWp+nduY/rSUIyBoLwI31FJfVOOvfPHRnwDmlAjNd+GAkhQ5XjGkvGQhp1MWzA
	S8tFBrvN6F3ZDFHBEAoOorFn4+THrVzp9WnVwbLi6cW5aeHF60Femlxgpp+dC9IJ4ehNxHDrZf45W
	9SWea14LpGJwqqzAjB93x8XxcbLZQw/dvXRo6JmlwD1dMBivKsyPz7Z/dYcb+EqtxxxCJv8G4ljn4
	/AgeigKQ==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sereh-0007MW-1Y; Fri, 16 Aug 2024 09:45:51 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add support for rk3576 dw-mshc
Date: Fri, 16 Aug 2024 09:45:49 +0200
Message-ID: <2504176.W2GruxG5Vl@diego>
In-Reply-To: <e640cbc4-6870-4607-a91e-0af41dd76df9@kernel.org>
References:
 <20240814223555.3695-1-detlev.casanova@collabora.com>
 <5057223.82XvGhxQ46@diego> <e640cbc4-6870-4607-a91e-0af41dd76df9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 16. August 2024, 08:52:04 CEST schrieb Krzysztof Kozlowski:
> On 15/08/2024 15:49, Heiko St=FCbner wrote:
> > Am Donnerstag, 15. August 2024, 00:34:00 CEST schrieb Detlev Casanova:
> >> Add the compatible string for rockchip,rk3576-dw-mshc and add support
> >> for the rockchip,v2-tuning flag, a new feature of this core.
> >>
> >> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >> ---
> >>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.ya=
ml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> >> index 211cd0b0bc5f3..0543cdb51c657 100644
> >> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> >> @@ -39,6 +39,7 @@ properties:
> >>                - rockchip,rk3368-dw-mshc
> >>                - rockchip,rk3399-dw-mshc
> >>                - rockchip,rk3568-dw-mshc
> >> +              - rockchip,rk3576-dw-mshc
> >>                - rockchip,rk3588-dw-mshc
> >>                - rockchip,rv1108-dw-mshc
> >>                - rockchip,rv1126-dw-mshc
> >=20
> > this would mark the rk3576-dw-mshc as being the "same" as the
>=20
> Not the same, but compatible.
>=20
> > core rk3288 variant. rk3288 was the first controller introducing the
> > clock tuning for higher speeds. with the clocks being part of the CRU.
> >=20
> > As we can see in later patches, this rk3576 though changes that
> > setup with moving the tunable clock configurations into the controller
> > itself.
> >=20
> > So please don't claim to be compatible to the 3288, but instead start
> > a new block for this new set of controllers:
>=20
> The question is can new device work with old compatible (without new
> features)?

the rk3288 and following have their clock phase tuning for hs-modes in
the main soc's clock controller. Hence you have the "ciu-drive" and
"ciu-sample" clocks [0].

On the rk3576 (and probably following) those clock phase settings moved
inside the mmc controller itself. So there are no external phase clocks
anymore.

So right now we have two types in the binding, the rk2928 type [1],
used on the old rk3066 and rk3188 socs, that did not support mmc hs-modes
and the rk3288-type which introduced phase tuning via clocks from the
main clock controller.

The rk3576 now switches to having phase tuning in the mmc controller
itself. So throwing that on unmodified code for the rk3288 will get you
degraded functionality, because the tuning won't work because there are
no "ciu-drive" and "ciu-sample" anymore .


And with that separate compatible we could also "tighten" the binding
a bit to make those additional clocks more explicit for the rk3288 type.


Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/boot/dts/rockchip/rk3399.dtsi#n410
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml#n27



