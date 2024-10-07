Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA31D1F40;
	Mon,  7 Oct 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300979; cv=none; b=vCQL7mvMgnpedHAVVamKZmdXnki/U0ltKTEzRXlp6FVNfZ9Y5IDCuKFls7NzkrsbfxwJZinCX7yvj3T+IQ+gGtg7TgjGrCZAW+hu2UewIJpsMUC9AVNNlb/CDSXqVS7ArUfTlmV5B/+CKs1xyTYy4TSEtCeR0SoH4gjiYhxrDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300979; c=relaxed/simple;
	bh=fJESMTPs+fQRs6bk8iVWf9SUl6L+IiJU7ufzITmJIQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnLGugwAHFMKENwUUWwQHIm+nWmg5M6fRpmytaG8qR8rDfILmuWxgz4AuzlEu8Dg5eh/LIl4j4aAMkxM/Fxb5JpaehcumMvtZlYRY15BCdwyukc2wuJm3YLNwbADhDGefnfWUhWLwBN2Qg5wX6dDKLDR5CZk1qyqEJs7IBctStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sxm26-000000002Mf-2WkX;
	Mon, 07 Oct 2024 11:36:10 +0000
Date: Mon, 7 Oct 2024 12:36:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <linux@fw-web.de>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, john@phrozen.org,
	eladwf@gmail.com, ansuelsmth@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
Message-ID: <ZwPHp9l3Fx7f2lI4@makrotopia.org>
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-2-linux@fw-web.de>
 <b41c51c4-775c-49ca-84fd-1137b61f42d5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41c51c4-775c-49ca-84fd-1137b61f42d5@collabora.com>

On Mon, Oct 07, 2024 at 10:00:49AM +0200, AngeloGioacchino Del Regno wrote:
> Il 06/10/24 17:34, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> > 
> > Add binding definitions for mmc on MT7988 SoC.
> > 
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > v2:
> > - fixed minItems to 4
> > ---
> >   .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index c532ec92d2d9..7380f72ea189 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -21,6 +21,7 @@ properties:
> >             - mediatek,mt7620-mmc
> >             - mediatek,mt7622-mmc
> >             - mediatek,mt7986-mmc
> > +          - mediatek,mt7988-mmc
> >             - mediatek,mt8135-mmc
> >             - mediatek,mt8173-mmc
> >             - mediatek,mt8183-mmc
> > @@ -263,6 +264,29 @@ allOf:
> >               - const: bus_clk
> >               - const: sys_cg
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt7988-mmc
> 
> Are you really sure that you can't reuse the MT7986 compatible?

In OpenWrt we are doing exactly that. The MMC controller of
MT7988 (and MT7981) seems 100% the same as in MT7986 and hence
works just fine with the mediatek,mt7986-mmc compatible.
