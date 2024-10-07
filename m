Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215F1714CB;
	Mon,  7 Oct 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284392; cv=none; b=kVkynzt+PZ0x+ZNFv0I7+kchFZnjVOsmmrS9OMnzPs1qkAlEAzV3nTGn8V3vaDVcrFRwDCT+C+s32wLU5jgJH0u2cj7Z9ZcSD6EzQDxuBi5WHZyHUfJCDouyuPDZbFxjM70rivxL2JfklVRv+strauXFUseXr/4HMCnvYz2is5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284392; c=relaxed/simple;
	bh=gqiufrWug7lbmYvdLgLnFpex4w5a+2itgAUwMlOrmt0=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=UyfWW8bYrxlaFWZyLB46Y6wFLKm0mMLzsHdjUvCztvsYeCKq1zKT5CrME/qGIkCWP+V+moTrj9jxRWMhc5otRFLKdb5ykcQsw4ZxokmwlOXfj6iYzJQvyFhpMJsdj6aMv7nu/NirPqoa21meXkqn3p5ulyunfA89Dj/8gHTN6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=a504at3T; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="a504at3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1728284364; x=1728889164; i=frank-w@public-files.de;
	bh=R0AGuj5yIrzDKc34jGDi7Sop1ytF0WoQFQCgEomR2do=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a504at3T4RFK9vS1K5OsHuRPpDQ3D09FXnEbT2tAP8XH8Hzm+O8ljIuQUaltyRFz
	 GxXIbwB9AJFWK2ehw86IQBlXi0XHwIbKl+E5cJQGsjC5qWgtg99Hv8mrjpZ/et6/Z
	 qq+aGAwkACQ+5lwX6bJSr84aIAJW7+Q1GOpjciEY6nho8y8c8Nt5VEaCGtabLg/k7
	 OBLj9bHjVhL1gg8UD31We4jvPacu9x53m+XUB2aOaoc2FCVe2T4Pzfq40+RlpZRLh
	 1psQ8Eul0d35DS3B14bwoE6Ue3xfytpk3PSV7scZMpttyDkWmq1afZCGB8xCnITir
	 jAOF62e5bLO1lzw6lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.101] ([217.61.153.101]) by web-mail.gmx.net
 (3c-app-gmx-bap03.server.lan [172.19.172.73]) (via HTTP); Mon, 7 Oct 2024
 08:59:24 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-57600902-afb6-42f3-8cf5-54a07710f979-1728284364104@3c-app-gmx-bap03>
From: Frank Wunderlich <frank-w@public-files.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Wunderlich <linux@fw-web.de>, Chaotian Jing
 <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
Subject: Aw: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
Content-Type: text/plain; charset=UTF-8
Date: Mon, 7 Oct 2024 08:59:24 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <p7lqqhet6ahmvieh5xaws6ugsnasmuw6k4oajkmfcctuhrs4dn@quvrkmyof5ss>
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-2-linux@fw-web.de>
 <p7lqqhet6ahmvieh5xaws6ugsnasmuw6k4oajkmfcctuhrs4dn@quvrkmyof5ss>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:NJAHfrORCcCOW2WN7H4bEoinSF2FWIRros/25USaRXG8LWD+9GYkr8WuevawXQ3d+J4U3
 Vr2C+PSULryIEv5iClhfCZN+53sAfZc+AL/mrTFcusc+1juiHHrgXf2vX3X1CkuSpBvSzTFgIfsQ
 BH6/dRvkxdPuW3Dypod9GtfKpOfdWR78bsu2Diu/HBwsJB2tYb+QrkMaNpDk25uddO8CdSxfiZhg
 ccbiMYchPo4zoNk5bTkMjuQ/IUOgbRVoxpTqDYF/zZORH4XmZkMDww7yaqVWTX3Uy70TxR1ljSE3
 /w=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zD0Pvuez3Bs=;Po0PEr/OdsOQdAkD0FLE28bTugq
 Xpu/NvntrZGibvMH6upFmsHmHqwxchB/+RSy4RD9dA5LiJOi5OzvTPMMlrhgx47eLAnqk+/M/
 3sMDLKZUY5MI5Ab5VGZSUZZ1oEqo2Iu5opMvGCyuLjhxBtYIRui3iZoiEN/9q8/UTnC58vuPj
 /9Jrligsv6r2F0cNWWomgpaErws9JutZjvhLpIdir7nP3ORYlMqCVnYnvSVBWkNQusLrfoT6G
 DZ3zUafDXhbLV9sIj4N4cxmOQJmtKM5GEXXkJx5hIU80HG3RDmm//oARnkwnzwgbDaUvWCASf
 kKSgx4xPZyg+xKw4cg4BQkDIoJQ5r3fBQY5LH+In1t/5s5npWmrdraZXvrT9xEV/aGe6Jl7VQ
 rWIK7UCSfsIHYwIx4LkDLLpSD4NXRXJF8w1uYKvcJ2/zuk5xmBstMYbG9+C3KDloGb5uDYm/S
 ggLg+OfKtdf6jlJJUUCAXjDvd2vq1dPJ++Pck695F01WtTXyToUJ8d7FuKaieqIxPFs46C822
 pvUo7sAFUP0gTaPhBl8t1Apz1EY5bx/Tk2KIe8OaM8Fby+oCF73s5eXr7SV0oWdg7nj+O+lph
 v5sX98c9muDq6kPRg8q5pTMUKTvGdnck1hLp6cE2WNvNNcbYBlxKz8jfQUb34A2MxG9i3pva/
 EAdpp5xRoGP2U7rnqqwEZZTyQsB/xSzSRv/XdbB2oQ==
Content-Transfer-Encoding: quoted-printable

> Gesendet: Montag, 07. Oktober 2024 um 07:55 Uhr
> Von: "Krzysztof Kozlowski" <krzk@kernel.org>
> An: "Frank Wunderlich" <linux@fw-web.de>
> Betreff: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
>
> On Sun, Oct 06, 2024 at 05:34:45PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add binding definitions for mmc on MT7988 SoC.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > v2:
> > - fixed minItems to 4
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 ++++++++++++++++++=
+
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Docum=
entation/devicetree/bindings/mmc/mtk-sd.yaml
> > index c532ec92d2d9..7380f72ea189 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -21,6 +21,7 @@ properties:
> >            - mediatek,mt7620-mmc
> >            - mediatek,mt7622-mmc
> >            - mediatek,mt7986-mmc
> > +          - mediatek,mt7988-mmc
> >            - mediatek,mt8135-mmc
> >            - mediatek,mt8173-mmc
> >            - mediatek,mt8183-mmc
> > @@ -263,6 +264,29 @@ allOf:
> >              - const: bus_clk
> >              - const: sys_cg
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt7988-mmc
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 4
>
> Drop
>
> > +          items:
> > +            - description: source clock
> > +            - description: HCLK which used for host
> > +            - description: Advanced eXtensible Interface
> > +            - description: Advanced High-performance Bus clock
> > +        clock-names:
> > +          minItems: 3
>
> This is still wrong... anyway, drop.

arg, sorry again...i should triple-check all before resending.

but dropping means the global 2 is used (making axi+ahb optional), or am i=
 wrong? afaik "minItems: 4" is right here

> Best regards,
> Krzysztof
>

regards Frank
