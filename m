Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869A1D86F7;
	Wed,  4 Sep 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454499; cv=pass; b=OCl7oTFsi/olsNQRIA1BeXeGiuPCTGCnC78AwYSThcVXvj5idW1ktWt+5zx7z6cziLbBvcoSiQjjWbXUCJWTBG92cPHYSYZZAB9+vI//vGJMKem+h7W6BugovUxg8+ErXgPISP44wgAQ7n4YnAcG4w05186n4s7bdOtbn4h/T2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454499; c=relaxed/simple;
	bh=Albu5sRQ0I+S2aJ2p3y8s3vyJ4WN595Y55KiK1JykBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teyiZcrfJ1IMOsxDC1H4sLMQIS04HtBxKpx9Xrhi65KRbQxhBUqc1U0oTdBNr2HT/aeW4mQo/XrKIe2Z14bx4UT+zmZfXebzSS+keBPlVZZ9QBvvWmjPUkjwEWkEjZkoB1eXy/7a8bydxsTAPeJff6H3O6zPgfqeprKeEHe+4Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=hiEKGlHy; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="hiEKGlHy"
ARC-Seal: i=1; a=rsa-sha256; t=1725454487; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kF1yD70P2vaaQrzk8Y7dRKktmWt78mCzlEuwEPlykV1/X3+AY1NBzITsExMJwK1m2DZkYSNXEZuxi/8fEi5tkJ3T56JZ5cZ/KdmY2B8W8U6r/2D4pU7/O6RWvKVsR1ruaB8Pb8Z5rAQRLOB7yQ6srjqA7xHq/KW9sKihtN4kq9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725454487; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YCY1tSj+dIFHQAkVxVxdKyLUzNjSk2r1e9kB6YYQRIo=; 
	b=ADftAVpJt/BV1K2REIjNWIx6ro/BUuW142qfWp1pzLcA/OWUFsSjBjBfKfYz6lKDTmf1e6kM2T7DitJBhBsZ+WA67ZD9+zjJ8wU0ROZYZh8VpHr2CO0iRwI3UOJ8KDLppGkdLZBH8hjQixuu6V4HnlZJ/4yCcIwKfRILAthFCeU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725454487;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=YCY1tSj+dIFHQAkVxVxdKyLUzNjSk2r1e9kB6YYQRIo=;
	b=hiEKGlHyXQlPkw8gVixfw6Oi8geX9ZsfuT+Y4OiXGqKek+98tR1njA6vqbpSUCZu
	3/ectda7cjSwFco6GDi2p8tqsFQRL7T+CZYnDq6YonvycRZnpHg90KyK0lH2oxF8dgY
	FrhQrRuAI7vFtPAPav4hVt+JyevaGGVed9nhiW/I=
Received: by mx.zohomail.com with SMTPS id 1725454485680542.2054998188497;
	Wed, 4 Sep 2024 05:54:45 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
Date: Wed, 04 Sep 2024 08:56:45 -0400
Message-ID: <6077666.lOV4Wx5bFT@trenzalore>
In-Reply-To: <ag7hzh4crzuqkvborkqz4elastaodaq6e63xbssztfgoz5dhka@6bsjq3v37u54>
References:
 <20240903145615.9302-1-detlev.casanova@collabora.com>
 <20240903145615.9302-2-detlev.casanova@collabora.com>
 <ag7hzh4crzuqkvborkqz4elastaodaq6e63xbssztfgoz5dhka@6bsjq3v37u54>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Wednesday, 4 September 2024 02:00:27 EDT Krzysztof Kozlowski wrote:
> On Tue, Sep 03, 2024 at 10:51:36AM -0400, Detlev Casanova wrote:
> > The device is compatible with rk3588, so add an entry for the 2
> > compatibles together.
> > 
> > The rk3576 device has a power-domain that needs to be on for the eMMC to
> > be used. Add it as a requirement.
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> NAK
> 
> Drop fake tag. It is impossible to receive a review-tag from me on THE
> FIRST version.  I almost never provide reviews out of mailing lists.
> 
> And since there is no changelog here and no versioning, this obviously
> is not v2 or v3.

That's because the patch was from another patchset[0]. Only this patch needed
a rebase on the mmc tree, so I sent it separately. You reviewed it here [1].

[0]: https://lore.kernel.org/all/010201919989e3de-60b56341-85e0-4869-89d1-362407c4f2ec-000000@eu-west-1.amazonses.com/
[1]: https://lore.kernel.org/all/m5ua5jnbv4u36glqt2qrps35asuqfycxedgjrfhodi5bvs2r2h@xvy4qxt4gx74/

> > ---
> > 
> >  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 34 ++++++++++++++-----
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml index
> > 80d50178d2e3..84a667f0c526 100644
> > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > 
> > @@ -12,14 +12,18 @@ maintainers:
> >  properties:
> >    compatible:
> > -    enum:
> > -      - rockchip,rk3568-dwcmshc
> > -      - rockchip,rk3588-dwcmshc
> > -      - snps,dwcmshc-sdhci
> > -      - sophgo,cv1800b-dwcmshc
> > -      - sophgo,sg2002-dwcmshc
> > -      - sophgo,sg2042-dwcmshc
> > -      - thead,th1520-dwcmshc
> > +    oneOf:
> > +      - items:
> > +          - const: rockchip,rk3576-dwcmshc
> > +          - const: rockchip,rk3588-dwcmshc
> > +      - enum:
> > +          - rockchip,rk3568-dwcmshc
> > +          - rockchip,rk3588-dwcmshc
> > +          - snps,dwcmshc-sdhci
> > +          - sophgo,cv1800b-dwcmshc
> > +          - sophgo,sg2002-dwcmshc
> > +          - sophgo,sg2042-dwcmshc
> > +          - thead,th1520-dwcmshc
> > 
> >    reg:
> >      maxItems: 1
> > 
> > @@ -35,6 +39,9 @@ properties:
> >      minItems: 1
> >      maxItems: 5
> > 
> > +  power-domains:
> > +    maxItems: 1
> > +
> > 
> >    resets:
> >      maxItems: 5
> > 
> > @@ -97,6 +104,17 @@ allOf:
> >              - const: block
> >              - const: timer
> > 
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: rockchip,rk3576-dwcmshc
> > +
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          minItems: 1
> 
> Why minItems? This does not look right. I don't get what you are trying
> to say here.

I'm saying that for the rockchip,rk3576-dwcmshc compatible, 1 power-domain
node has to be set.


Regards,
Detlev.




