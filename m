Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173B189BAA;
	Mon,  7 Oct 2024 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290018; cv=none; b=rNeP58LjuRi3/Eb8IRrycYtKgq0RFYReao7C7FqOuSEQmcC7KdFVpCa3sTQdwRF2nOJ1NH7bHMyf2xvtEbW4swx/by4JLnN9vV59lIqAeRTu4VUbgXGpJVEKqH2EFITax72N4YlCCLolb4acA+H3RD973IFgxuaE8mycnpmJsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290018; c=relaxed/simple;
	bh=LLYlGS766hCR/P7B0kmypyyrTWhsQVvkYC1p9s86LCM=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=ucLr4pSX2guXp/5/6w6pOnBx+v9q8yrmSu9ucNuQlz3azdp6CRZPHplrfOWjNxA1eWCRwBqbP8W70ntETQRxg5qCLVigB66h1BCSbTiBuHbeZau38e+H+CfTe/xEt5kp0817xIXzRRdfXjTgWp5BET7RYCf+mFavTLWl1tCywrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=ZNWgu8Dr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="ZNWgu8Dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1728289985; x=1728894785; i=frank-w@public-files.de;
	bh=A2fZLF7avs5DMWOiIq0KHN70cPnOtcv4SASIDsj8Bss=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZNWgu8DrAe/eKpJcC/I90IMyOuylpe8velQNLGn6gPt7kHRWfqimqZF2nWRmMhht
	 cers30UCLltSbGOKHcL/ohELzk1jrrSnq12CSbeZTiRVtV1kGQcPpDqyIAmQknu55
	 MwnM9ZUL4h5KjXp3wiEHEWMIg1cwuDwP+ogKuYuJrGQmg4FoO6DNcuiUmvtoES5i1
	 0FhYlribWvfLqEOn5Rmh7VgaNVauwtRVpEqxiWi0CGIGKlVFQXzmpr39G5RTl4bVD
	 +WwvMZ/BjW8RuTntoP8MIRC0YkDdWvuDeyYnAhO3FtkquPZPkcsPmSdX/qUphuRKx
	 W3UBnLS/vdPum/7m1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.101] ([217.61.153.101]) by web-mail.gmx.net
 (3c-app-gmx-bap03.server.lan [172.19.172.73]) (via HTTP); Mon, 7 Oct 2024
 10:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-6fcf3e00-393c-48ee-9aae-26057be08645-1728289985089@3c-app-gmx-bap03>
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <linux@fw-web.de>, Chaotian Jing
 <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
Subject: Aw: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
Content-Type: text/plain; charset=UTF-8
Date: Mon, 7 Oct 2024 10:33:05 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <b41c51c4-775c-49ca-84fd-1137b61f42d5@collabora.com>
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-2-linux@fw-web.de>
 <b41c51c4-775c-49ca-84fd-1137b61f42d5@collabora.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Ngq4NbOlruE7F2nvSl8B/hBNQ0cqZUCijyM1oY0+exKRh5yziWcQFPujSTI76d8tuiNlN
 ePhetGWdhfwlPwuroZR+LeQ52I6zrO+BaFlRauwM/LGrHf97qDEYvi1vbIsbDCtHoz4y+GEbJ96y
 NdAf1bdyUr2PA4xUWNua7cFJA77ZCXImJ3vBuVzOyHgVvGvPX9ElX1FmANCS+1CjuH3oo7LdJTuy
 Aa4kyqqTVb/FFJJ5DVKmSJVoHHfGqUXJbNSS0qMvEi6jaTmKYLUyzcFziPhevpHOdRBJu0fpb76K
 3c=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ReyKzSXbLaU=;4XGj64i7glxekjhy0Bn5tOpJD2m
 W5QpJJfhz+SgNilocL4rJDFuPMmtYrkXEhlgHsqy6f49qbDSzDOY/uO0LY0wTeH/zDKf9YtB4
 eBntgQuH0TIQD5QiYd5DMLNX1fPD4b4Df//xF3XPNjT9+kt/k51Do2C+QrFAeIxZDnj/iN8VT
 X3Yy/gTwT+2LDU6I98Oi8YJLitliJOtsxsWVvsedCk6fEEc28Rn5VELQ4gMiBsc/N8ofBndBo
 t7x2duAYQyY+IPIpyV75Mx1r0pCLuE9i0bmlwyW2l+dZjF8hoLfbUY4tqwRfn0sJIL5Mx5QCb
 fibzPsaWP1ZvN/B83gI7La/50xAYxtngVW3HhvXr51ucmJDxAponFrPJPHN5iFE5a812kjH3T
 3c3tgxbaBis70rTnhCb7MoPv+uwB+VxVuHiSnHk4rVdzvogY0/aIpx5Gttp5Vv/b82bmj6Ile
 qzhQRAZjdNfReL+xe4rArgEyCC239pKINT9WhkUqX2YeKBoiKFEwTkOU1XcAW1LLn8cndTo26
 N8BsGp8sGRaE5tDIMra1hUQ8qC/nHSfAd9oW7ZMgEUuAGs87uKTYiXUH/pgQf3owtdLFYy491
 ucThy4yU8vYfWZTpJ48v5hl2Ephh5tJ+1EWkVIWF4k8CcVRCAyoKP8IModnEUpjwWqHffDmIk
 V4/KzGXLsyap2j3YY16lFV9TzG1nZz9h85/uLfNy5A==
Content-Transfer-Encoding: quoted-printable

Hi

> Gesendet: Montag, 07. Oktober 2024 um 10:00 Uhr
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> Betreff: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
>
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
> >   .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++=
++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Docum=
entation/devicetree/bindings/mmc/mtk-sd.yaml
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
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - mediatek,mt7988-mmc
>
> Are you really sure that you can't reuse the MT7986 compatible?

have not found a way to reuse mt7986 binding because clock-config is diffe=
rent...
from driver view we can use the mt7986 compatible, but from binding view i=
t is different.

regards Frank

> Cheers,
> Angelo
>
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 4
> > +          items:
> > +            - description: source clock
> > +            - description: HCLK which used for host
> > +            - description: Advanced eXtensible Interface
> > +            - description: Advanced High-performance Bus clock
> > +        clock-names:
> > +          minItems: 3
> > +          items:
> > +            - const: source
> > +            - const: hclk
> > +            - const: axi_cg
> > +            - const: ahb_cg
> > +
> >     - if:
> >         properties:
> >           compatible:
>
>
>
