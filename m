Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51621D3C0;
	Fri,  7 Mar 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362530; cv=none; b=Ni7uBcce2qygdhRWxdHjAR3RToOKjXpo+BtDWSMySE+3hekicRDRSavwbv15ckSCAFMr06nMKqe0e5IoyihkhDhKgIHAQJMDqzjleeG0syBbqztEtff8lZGbDLZiH4Ntd0M0xCmXloyyVacfX0eZJZb3zMvAlOqfE2vAuM8PSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362530; c=relaxed/simple;
	bh=cbQpumLmb4zRxxzXeh/NJGWOgnbL/WBEsGAddfW0Fcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFSYQal552DnwhRrbqQpib3X76PHyER3wSfDrbv95coYIGKWFiSKWlNtWcsl6Ht6hmrP2eqPfqBHErSDnjQH0ZotXUqFicAhefzLWclUp0JrZ7ZXYGtsP8trzFKpDH9BO9yzlec12bzEA0jwr7I7GyIaAo9V83WN9/CQbpWxF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N65vVkRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N65vVkRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C7C4CED1;
	Fri,  7 Mar 2025 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741362529;
	bh=cbQpumLmb4zRxxzXeh/NJGWOgnbL/WBEsGAddfW0Fcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N65vVkRX2qnTNsHI/Mryj3yrgzuscpAKf0NbItOKxb932B9Tb+1GNpcL+r80CVzSs
	 /ueBhWKSiB3bJ7bGUc1946kLvdkvQc9PnKTvdKitZbw9VWvnl/A3JS+AA/JzYA5dXE
	 PQvQPLjOSpKbNoA4Fyit4SuXtAyX6VeAKycEphJyepBR1hmKfg8MLhwIxbE9HWbtSq
	 4vjrXvxpZSuGt7YkqB1uZskUNPLxeruSW3me2Zop8Z7Aaf0Yex6KHzNVSCuwlEY9BH
	 1cJRbxta4F2xG52gXmzZVKXk2/Uk6IOiTaL8dO0oBKAcEDBjcHYQsuPnC9OdxUwiWE
	 EJq3Hj/sTn2hg==
Date: Fri, 7 Mar 2025 15:48:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Axe Yang =?utf-8?B?KOadqOejiik=?= <Axe.Yang@mediatek.com>
Cc: Wenbin Mei =?utf-8?B?KOaiheaWh+W9rCk=?= <Wenbin.Mei@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Chaotian Jing =?utf-8?B?KOS6leacneWkqSk=?= <Chaotian.Jing@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Andy-ld Lu =?utf-8?B?KOWNouS4nCk=?= <Andy-ld.Lu@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yong Mao =?utf-8?B?KOavm+WLhyk=?= <yong.mao@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Qingliang Li =?utf-8?B?KOm7juaZtOS6rik=?= <Qingliang.Li@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Message-ID: <20250307-bust-diving-a57644a51543@spud>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
 <20250306085028.5024-2-axe.yang@mediatek.com>
 <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
 <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JvgKecrTkt2V/rEI"
Content-Disposition: inline
In-Reply-To: <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>


--JvgKecrTkt2V/rEI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 06:59:03AM +0000, Axe Yang (=E6=9D=A8=E7=A3=8A) wro=
te:
> On Thu, 2025-03-06 at 10:19 +0100, AngeloGioacchino Del Regno wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >=20
> >=20
> > Il 06/03/25 09:48, Axe Yang ha scritto:
> > > Add 'mediatek,disable-single-burst' setting. This property can be
> > > used to switch bus burst type, from single burst to INCR, which is
> > > determined by the bus type within the IP. Some versions of the IP
> > > are using AXI bus, thus this switch is necessary as 'single' is not
> > > the burst type supported by the bus.
> > >=20
> > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> >=20
> > I am mostly sure that this is not something to put in devicetree, but
> > as
> > platform data for specific SoC(s), as much as I'm mostly sure that
> > all of
> > the instances of the MSDC IP in one SoC will be *all* using either
> > single
> > or INCR.
>=20
> No, actually MSDC IPs in one SoC are using different versions.
> Usually MSDC1 (index from 1) is used as eMMC host, the left hosts are
> used as SD/SDIO hosts. They have similar designs, but there are still
> difference.
>=20
> >=20
> > So, I think I know the answer but I'll still ask just to be extremely
> > sure:
> >=20
> > is there any MediaTek SoC that has different IP versions for
> > different MSDC
> > instances, and that hence require single burst on one instance and
> > INCR on
> > another instance?
>=20
> Yes. Actually every SoC has different IP versions for eMMC and SD/SDIO
> host as I said.
> e.g. For MT8168, signel burst bit should be set to 1 for eMMC Host, but
> 0 for SD/SDIO Host.
>=20

Sounds like two different IPs that really should have different
compatibles to me...

> >=20
> > And if there is - is there a pattern? Is it always SDIO requiring
> > INCR or
> > always eMMC/SD requiring it?
> >=20
> >=20
>=20
> No, there is no pattern. Both eMMC and SD/SDIO hosts need to be
> configured base on IP version. There is no binding relationship between
> eMMC/SD/SDIO and the burst type. eMMC burst type might be INCR or
> single, same as SD/SDIO.
>=20
>=20
> Regards,
> Axe
>=20
>=20
> >=20
> > > ---
> > >   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > index 0debccbd6519..6076aff0a689 100644
> > > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > @@ -100,6 +100,14 @@ properties:
> > >       minimum: 0
> > >       maximum: 0xffffffff
> > >=20
> > > +  mediatek,disable-single-burst:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      Burst type setting. For some versions of the IP that do not
> > > use
> > > +      AHB bus, the burst type need to be switched to INCR.
> > > +      If present, use INCR burst type.
> > > +      If not present, use single burst type.
> > > +
> > >     mediatek,hs200-cmd-int-delay:
> > >       $ref: /schemas/types.yaml#/definitions/uint32
> > >       description:
> >=20
> >=20
> >=20

--JvgKecrTkt2V/rEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sVWwAKCRB4tDGHoIJi
0hRVAP9JFaU0LfHys70qFKw8YsFg94BJakg2ezMs8dUwmp2z1QD/cUINRP2md0VA
qLxlWwCzLY6tY2JS7ftifR6/W+OfwQg=
=ZH2G
-----END PGP SIGNATURE-----

--JvgKecrTkt2V/rEI--
