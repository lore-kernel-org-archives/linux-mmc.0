Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF01DA2E0;
	Wed,  4 Sep 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459544; cv=pass; b=JcRHWa9MzjbZv8RB9KAVDsUJBWG5mQt8gk574/n7KcWCkWf8K2hwA6mUN9YI42vopqrFWa21TwrK+ZrGPcfHe95myRASBqBEPvVHVpXlXia2oIuGpUn3c659K73aQSB8wejR/LAS+MGXJy5+9tx5cfL1RzNn1BVBUca8fLGepwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459544; c=relaxed/simple;
	bh=uU7gMuNDVjC+V3qMSXEmiadluh61s2DpRze3K37Z3Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAHLbIMLAG9GTcjk7meas2tgEryEyD//PohcwQFfocd8Cd/EvaMLhCPYnGM4pbIq+h/TPC4cZd4FXKlzo3IugoInZwReRXLymznknDQi1Nfwo4NN0Rl7fM254QYU/XsGa8ruG6jycSZswRohKZQbaS9dwi9uRe4j5scN3TlW+zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=ADmuRmyR; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="ADmuRmyR"
ARC-Seal: i=1; a=rsa-sha256; t=1725459526; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bhWJVVBbEcTjCy8Y1IwhWSJNggeRmhEhex4xMRAezmIOYXfrw8oolU+JIS9r3bRLDNTeaFC+UZYA7drUxXI0GIhaSkEGGwEzFZszBKj1WnGB0/f+w4WXWklyS3w8s/rVkEgrvEA408pA8HVYpBtzNg+ftUdXUwRW378lJUPoqeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725459526; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NrB5Eis6keev0BLIO3EvM0mmuwnm+jdjAUtFc7Pc2Yk=; 
	b=edbKMlbnBz9R3UY38BNfoyQyJGOaVw8tue1lD4lCtk0qRVOsIa5bACvHjsOGGHoV87jFME9HNZp100C6MNW7vWdkRw72+0bEpBzfkqsK+2D5UZCaMlR6nyE1Gmb93nMOXWhykJVFhtEWdUyMmxR6+hgp7oMFIrUWF+a7dZTz66M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725459526;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=NrB5Eis6keev0BLIO3EvM0mmuwnm+jdjAUtFc7Pc2Yk=;
	b=ADmuRmyRo5liqlhTpyz9i74G+rFRwi36HUcDvnXsYfq0cGScUXbfntRbFaU2ekzv
	cdZzO2MXuGArsnWbfDZAvETvsSr6BGOo6v+VDQXQdR+10FsicsIpiCl1RctOsUVOuIS
	PwqWnyvxhEF2n/p8wanNhb/7Jq3yrj+l+7f7g9fg=
Received: by mx.zohomail.com with SMTPS id 1725459523885377.12512494542716;
	Wed, 4 Sep 2024 07:18:43 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
Date: Wed, 04 Sep 2024 10:20:44 -0400
Message-ID: <1896150.tdWV9SEqCh@trenzalore>
In-Reply-To: <0d4d40cc-9885-4933-a6d6-933e4705a68c@linaro.org>
References:
 <20240903145615.9302-1-detlev.casanova@collabora.com>
 <6077666.lOV4Wx5bFT@trenzalore>
 <0d4d40cc-9885-4933-a6d6-933e4705a68c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Wednesday, 4 September 2024 09:02:40 EDT Krzysztof Kozlowski wrote:
> On 04/09/2024 14:56, Detlev Casanova wrote:
> > On Wednesday, 4 September 2024 02:00:27 EDT Krzysztof Kozlowski wrote:
> >> On Tue, Sep 03, 2024 at 10:51:36AM -0400, Detlev Casanova wrote:
> >>> The device is compatible with rk3588, so add an entry for the 2
> >>> compatibles together.
> >>> 
> >>> The rk3576 device has a power-domain that needs to be on for the eMMC to
> >>> be used. Add it as a requirement.
> >>> 
> >>> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> 
> >> NAK
> >> 
> >> Drop fake tag. It is impossible to receive a review-tag from me on THE
> >> FIRST version.  I almost never provide reviews out of mailing lists.
> >> 
> >> And since there is no changelog here and no versioning, this obviously
> >> is not v2 or v3.
> > 
> > That's because the patch was from another patchset[0]. Only this patch
> > needed a rebase on the mmc tree, so I sent it separately. You reviewed it
> > here [1].
> > 
> > [0]:
> > https://lore.kernel.org/all/010201919989e3de-60b56341-85e0-4869-89d1-3624
> > 07c4f2ec-000000@eu-west-1.amazonses.com/ [1]:
> > https://lore.kernel.org/all/m5ua5jnbv4u36glqt2qrps35asuqfycxedgjrfhodi5bv
> > s2r2h@xvy4qxt4gx74/
> Hm, ok, changelog should explained this and the versioning should
> continue, including history of this patch.

Sorry about that, I'll send a v4 after this one with the corresponding 
changelog then.

> >>> ---
> >>> 
> >>>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 34 ++++++++++++++-----
> >>>  1 file changed, 26 insertions(+), 8 deletions(-)
> >>> 
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> >>> b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml index
> >>> 80d50178d2e3..84a667f0c526 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> >>> 
> >>> @@ -12,14 +12,18 @@ maintainers:
> >>>  properties:
> >>>    compatible:
> >>> -    enum:
> >>> -      - rockchip,rk3568-dwcmshc
> >>> -      - rockchip,rk3588-dwcmshc
> >>> -      - snps,dwcmshc-sdhci
> >>> -      - sophgo,cv1800b-dwcmshc
> >>> -      - sophgo,sg2002-dwcmshc
> >>> -      - sophgo,sg2042-dwcmshc
> >>> -      - thead,th1520-dwcmshc
> >>> +    oneOf:
> >>> +      - items:
> >>> +          - const: rockchip,rk3576-dwcmshc
> >>> +          - const: rockchip,rk3588-dwcmshc
> >>> +      - enum:
> >>> +          - rockchip,rk3568-dwcmshc
> >>> +          - rockchip,rk3588-dwcmshc
> >>> +          - snps,dwcmshc-sdhci
> >>> +          - sophgo,cv1800b-dwcmshc
> >>> +          - sophgo,sg2002-dwcmshc
> >>> +          - sophgo,sg2042-dwcmshc
> >>> +          - thead,th1520-dwcmshc
> >>> 
> >>>    reg:
> >>>      maxItems: 1
> >>> 
> >>> @@ -35,6 +39,9 @@ properties:
> >>>      minItems: 1
> >>>      maxItems: 5
> >>> 
> >>> +  power-domains:
> >>> +    maxItems: 1
> >>> +
> >>> 
> >>>    resets:
> >>>      maxItems: 5
> >>> 
> >>> @@ -97,6 +104,17 @@ allOf:
> >>>              - const: block
> >>>              - const: timer
> >>> 
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: rockchip,rk3576-dwcmshc
> >>> +
> >>> +    then:
> >>> +      properties:
> >>> +        power-domains:
> >>> +          minItems: 1
> >> 
> >> Why minItems? This does not look right. I don't get what you are trying
> >> to say here.
> > 
> > I'm saying that for the rockchip,rk3576-dwcmshc compatible, 1 power-domain
> > node has to be set.
> 
> The top-level property already says this. You need to disallow it for
> other variants (:false).

Ok, something like this:

allOf:
  - if:
      properties:
        compatible:
          contains:
            const: rockchip,rk3576-dwcmshc

    then:
      required:
        - power-domains

    else:
      properties:
        power-domains: false

Detlev.



