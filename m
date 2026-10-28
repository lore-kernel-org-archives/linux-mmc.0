Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206118;
	b=CIJUPPU6S10aiXxHtv2MdlosxGEwygGdMmo8nmOmenqeHQnX2q9Y9CUb9Wzw2Z93WO6h
	 yMC+q8Hi76HBxDgjhsdIYc5nWKk8kC0qgx52DcLCnk9ZmqseKcjE4FGS9Tb9J/MQE39zR
	 tB5FLChWweysn6RcmmLNDoK12NN9P03OgpkwpIOvsqG6zb0Q9r2LKBoWcGtwrM8QKs3Uc
	 IOYxJRI3vSd/eowWFzAxZw1tGfHFafH3YM9ePYC+q/Scnt5wc+LyV2pQKTKYdkTaWclbu
	 CfUdI5ialBCNbd+inLlbfHdiXImzZsSm+TOI9zOluGHElcxljeZ6Rsx4BTlzzloh6pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3TKL45EGjOvSJq9RcZeBcdQfOCRHkAFNmFcBB7UbKPw=;
	b=THRqaNs/FG3sI5Gvzx8OfbthcDmb+DoyCCz/GiifVIMfQzEJm26oliZN2kLiBICcO+ZN
	 2NwPNPhIz57Mlg6zqt5/VCJAJzTuOEo38W44D28Rb1jsq8yTy6MPJaYlVm1HWx3+sXF60
	 Y/5GNXTBuRwhbBUCU7moip8oEo+o8pCoONIUvrsNHTI821jxLzUJ/FbIKO2BgKVxFMo1w
	 XFHfsHte1HppiL4Sb4KUmDZZ5+S4nn06jTi/Ri0lqSTNGpUEsNwmv0e9bu2/r4di4q+A+
	 xyILJkbNFiuxW6CFZVbEGOfEuDRUHE5oZhlhF5qcoR9rO3xO3TMjYBckcdRs32jBhmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AWZCxGkZ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64B606A31D
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 16:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C64B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AWZCxGkZ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a208d93758so12808165e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206117; x=1793810917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3TKL45EGjOvSJq9RcZeBcdQfOCRHkAFNmFcBB7UbKPw=;
        b=AWZCxGkZoQdesLGQrrnvsYGQNrqcDiUUTccIA8g+LjGGdy9Zlpf6SAWSqBYBU/N556
         XqnM1yNS1SG4KQqokLrnmkSge8vkg7/p2+IbdcbgIc25S1IyhSjnUNQvZtezTHBCG8uD
         52Xw4fOgrcqrE6th6EPQdWEWwPgtZ2ftMMJMNlOxYeldBQE8F7+vwnKuUJc1AWvN0FYb
         9Yi1OsWmdqEUOLdCLt2ILHohZj4gq1CX5ARDHWnF7DEjqJcJMPN4HqxhnS/h+Nq108O5
         8wGK3UKv4j336bEvuU5MhQiP7ZwmAEYyAZYRe0VeoPgrzoafGwnzsKbwFXMmIo62SRdE
         wYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206117; x=1793810917;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TKL45EGjOvSJq9RcZeBcdQfOCRHkAFNmFcBB7UbKPw=;
        b=0LQyG4C7kB9X6+rcy65/ahGwIqR93Grc/FSFxvr7weWCSmqjkq75ki+QnlGDxhyUJA
         eNngy4rjwHevWZY1O0ZqiQ2D0aw9SvyBQh4L9V1tsFXIN9ithO6mHJ0q0vZC56C6iXzH
         0C1uMSpwYLnmRfEB+dbzfvDEUY7OkjUB/POi9ATpEBq46c2wUf5weRl2rZMU6FbGhXRn
         vOY4oxEn7tzTbZO9SJ0ZZ4iYAv45x5/P6RHwEQrQ0ePs1n4cE+vlOQ7gC0CmMNQcvMTP
         NXf+raJV7rCQYjqEIRxODm5X1dXQc06+02mXj8kOm48JgJiUPQ/KVfBNBtke35kUT9Ur
         JCRw==
X-Forwarded-Encrypted: i=1; AKwUvBxuEKob7X8N8r3HTvLQpfG+qgJgfhHPVsdaTZkWJzCE8J0gidzBkY17GYs+reCBQDR+UfymGzu86gY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbgCRYQk5BD8397REOGr+yDAh5O63z7rSgeUxGG8dzYbI8Tz9H
	NXvCL9w3ZR9NrxOfOpoblspt79H6XVarkewlTTZyyN2RvhSem4XTfpu/
X-Gm-Gg: AYBFou1jW0cIb1IZ/9xVHeD07xqj2dUWValeoXEU1GGR9XTkaqbVgT9xs5POY/41STt
	sUhOZZHuzJL4E/mXDDU4I96m+f6zN21of3sVNkyCGyRwGYQyWhq94DWZrooSVXD/UBStuzslJu5
	jA9sVClcAKC2VDV7VdN1+HMZpPArL7I/xTBU6/xp+3pb30ZhwgtwRjazkokiLXQut8s9g9x5bt2
	K2RrpsUCGNiROajRmNswDUDCB0fH/LfG35HTad/7I8iEEs6U8jGYjUYqzecz5kTROihHmKIQHx/
	w6HoXu4DLf+Gve3d5E2A9VVyBtuFmq/goKlAUoGJqIz/SrKHymvuBLNGYrL/7BO/n2+Rm0wDx9m
	oRkB1+qTizsxYdylOJmxsu0Du/51oQStfQ4keouOq8BS6W/uSKxlSia24UxtMD8QU0HIUfqyHwD
	nSfO7S0nLv3EciLuZWmuW63GJPKHfanpDGXsLxLqyCDOIFv8hIiMzS07Hk1P/BYduedmv99oxYo
	n85DrNsdohvfaEqZXAMAM4VRVABo09jKdn+voHLCSG9QNJSVLxMOvgqeI30ZhVOW8p7k5ZfqAeB
	DkFCPONPzEJ7DxKF5De8PRmKA+f/Hr6oLVuhuX2hQHLO6h1KoKNe63lZyPgGrSwI+2CcPX6wjpM
	bHcuyfgFkbRLcZR24aPHtBJhoLKJ32sxq2Ix6hA==
X-Received: by 2002:a05:600c:4452:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4aa4eb767d1mr22034485e9.28.1793206116486;
        Wed, 28 Oct 2026 09:48:36 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f322c46sm4600155e9.2.2026.10.28.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:48:35 -0700 (PDT)
Message-ID: <6ae22763.2bb6edcb.3bc160.a0e2@mx.google.com>
X-Google-Original-Message-ID: <auInYOnHl6n-3ggU@Ansuel-XPS.>
Date: Wed, 28 Oct 2026 17:48:32 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document support for
 Airoha AN7581 SoC
References: <20261027144002.10606-1-ansuelsmth@gmail.com>
 <20261028-academic-blue-earwig-72d3d1@quoll>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-academic-blue-earwig-72d3d1@quoll>

On Wed, Oct 28, 2026 at 01:51:16PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2026 at 03:40:00PM +0100, Christian Marangi wrote:
> > Add dedicated compatible for Airoha AN7581 SoC integrated MMC controller.
> > The MMC controller is based on the MT7988 with the difference that it does
> > have a single clock controlling it.
> > 
> > Add the dedicated compatible to describe the 2 register requirement and
> > permit to define only 2 clock (the main one and a fixed clock for HS)
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Also add compatible to restrict clock-names for source and hclk
> >  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> 
> Your driver part suggests it's fully compatible with other variant. Why
> not expressing it with fallback?
> 

You mean something like 

   compatible = "airoha,an7581-mmc", "mediatek,mt7988-mmc";

? (my concern is if this would be problematic with the current if
conditions in the schema)

The driver is very liberal for the clock configuration as it does use lots
of _optional... But it's not possible to reuse one of the current
compatible as they all require additional property that Airoha SoC doesn't
have (either additional clocks or single register)

-- 
	Ansuel
