Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87920B218
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789191; cv=none; b=aD3Uph6RTMFwVTh+MIlyUOsu/uIYruTVuDOMJYOb1G+4H8rIRaWLagEYoAlXmizKsCp+ceKHiFFBEjR4TfVFD+KMSheWktFgftqi+4KLd/b6H1gT4JKA30nyCdlKzrvbmrFEKzrtT5YcvKBTR8NxNwByafw1WvqR1m62dLbyRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789191; c=relaxed/simple;
	bh=9nQwhppjTEwgUcisyV4d7XyXTyKaChRyMGDsYQad9o8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSErJb2XS0b9Xbaz9lcx2IJeOWGx2ZcREpFSi+0okKJtJG8iU8Ua1it2xq4BiAQNIxryBCnSuuS9Ep5yiAFgkTw7AeO6mkwX8ufj/EUTTVAF4f3X6l+m+bgFYfYYyGa6SEpxBHZmsktsEs3ProC6yoXT5Q5K6TEzp0SEOgXzeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G4Ns05Zt; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G4Ns05Zt"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-6188b70abdfso1376314a12.2
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755789188; x=1756393988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xtxRuaoXngMWzDes/bLKJ29G8INr9oKLKpCWom6nFQ=;
        b=G4Ns05ZtejOdEM1fPpWd1dKNjGt+h7dkwglwxgHpPFOmWbvAsf3OWICaSmQiL3ZFtq
         sT2gVGjcN4BZbJF7YNgiWsCDIk0ziesqptb8RcUaIxob66oELeYFerX8SU2Dr2KeXMvu
         5dcp3DTefexDtsPaWuypX1MZgV91Ug6vQT8Nt4s/Wi16DtiAsryb3fPicbeo/YkeVjLT
         kYc1cyHHwKzEQYNw9Ls+xdjF9IVjxB9zvOKey3oI1b2WstiCMSl5gNYswiwLv3eFmy4+
         w/NE4w3in73iilQVvtScRGusvocaFJROUmDo+JUksKEWrAC3fdFSOKtZayT52COYMDlK
         DC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789188; x=1756393988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xtxRuaoXngMWzDes/bLKJ29G8INr9oKLKpCWom6nFQ=;
        b=Znn+/GP+1OSo3jWTYatur17r2gDPcKsm7zxtbwJf2TrADnSOEvC1kwLp21LrSssokL
         dJDNKahKzTTyNWAywN5cQpVjdIQlR3CvfYE883SXP9aIm4KJupyqfcnNVXYqZvv8dY7A
         VXrvpkaNctqZ/X2/hehHcPUysHoeDTLDwLhA2vQ6TtKQfJ0KPumaN5uaIZjYDD5qjAdw
         021nTGZpua8VumwfAwXjJbOK9lKcJCx43/Fyk8heLcPa0H9VvpJw2D5Ee2JFwzS7hpNW
         KqXvLElwT7xmqMRUUHozr70tgZSAIh/8kwbUAF1LiYxyJBiaJzOosoZz7gbjPJQ0ZWwi
         /l2w==
X-Forwarded-Encrypted: i=1; AJvYcCVoRVsOpyMLR4GIg5UmqZj9xI+I9tx7RIZEuWl08fm9HERshCeDhub18TwwruJM1XuD9ieKfNxmS+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YymyLOcsE27hkiFOqE11qrpX/bsr4BrWIDbh1CHHFfGxTvhHW0F
	bGKGh8U3AwN4Jn/OB625L/KSlb7Pz+VgYE4mGy98b/YO34RFXfOkFzQ9k1qwSQEYFHU=
X-Gm-Gg: ASbGncszILgpHlBGKZrLKyX8pnp8MZZC42+U2Pjc/2ahzuL8sdSCd9jkMIWGYfZVbuk
	xQs6Qr/FDas+08B3ttt0L0se19vzuVivmVRZ34caUhbS8x1SnXwNaXpGyTNdmCz8b6gZrFQlQVz
	le4dwaMhIDjxNKBUwiMYWiic1bcXEiTslp6kPWJdnsJf3I3R8MkyMeYQ6yleJ/WKuw55ic6KZAp
	Oq+gneaFGHzaGRTiIZ77dcfWTq7Nwv/5nQco8j9PAf4JPdZu01CPLG8RWbzGAzSOF2CbudLzRyA
	9ssvQUsxDwFIhBzCIv0oLGY4Uw5UaGolofTFAZWbCfPiOzg4o5OPIEOaGcnHuhsaBnGhsQQfQwP
	EXjaiL10bs/cJSd1FeuMk7AoCYfiZkRruiFGBoR17DOSBfiRC1sgJTt2QOHKE
X-Google-Smtp-Source: AGHT+IET+pViMkmHfWuU+dAIph0lKCRKrp1cWSJUrymAHEUx2uNDRZI8YqflErDfwiyzgFbu3IhI8g==
X-Received: by 2002:a05:6402:84f:b0:61a:2cac:890c with SMTP id 4fb4d7f45d1cf-61bf86ef69amr2362795a12.13.1755789187656;
        Thu, 21 Aug 2025 08:13:07 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a8ca8660esm3796686a12.10.2025.08.21.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:13:07 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 21 Aug 2025 17:14:59 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, linus.walleij@linaro.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	florian.fainelli@broadcom.com, wahrenst@gmx.net,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, iivanov@suse.de, svarbanov@suse.de,
	mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: serial: Add clock-frequency property as
 an alternative to clocks
Message-ID: <aKc38_NsDy4G1uRy@apocalypse>
References: <cover.1754924348.git.andrea.porta@suse.com>
 <419658ce1a1009c6f8b7af22a02b278cd695dab0.1754924348.git.andrea.porta@suse.com>
 <d02626bc-a00e-486a-854e-b4555c11ee85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02626bc-a00e-486a-854e-b4555c11ee85@kernel.org>

Hi Krzysztof,

On 14:02 Tue 12 Aug     , Krzysztof Kozlowski wrote:
> On 11/08/2025 17:19, Andrea della Porta wrote:
> > The UARTA controller on BCM2712 connected to Bluetooth chip does not
> 
> Bluetooth chip does not ask...
> 
> > mandiatorily ask for a clock connected to the high speed baud generator.
> > This is, in fact, an optional clock in the driver.
> 
> ... or driver does not ask?
> 
> Please describe here hardware.
> 
> 
> > 
> > As an alternative, the call to uart_read_port_properties() ensures that
> > just a simple 'clock-frequency' property can be specified for the clock
> > value.
> 
> Don't describe drivers. Describe hardware.

I will try to test whether the driver can just work specifying clock instead of
clock-frequency in teh DTS, so there will be no need to amend the bindings.

Many thanks,
Andrea

> 
> > 
> > Amend the bindings to allow to either specify clocks or clock-frequency.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  .../bindings/serial/brcm,bcm7271-uart.yaml    | 19 +++++++++++++++++--
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> 
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> > index 89c462653e2d..96697b1428bd 100644
> > --- a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> > @@ -40,7 +40,15 @@ properties:
> >            - const: dma_tx
> >            - const: dma_intr2
> >  
> > +  clock-frequency:
> > +    description:
> > +      The input clock frequency for the UART, Either this or clocks must be
> > +      specified.
> 
> Anyway, don't open-code schema in free form text.
> 
> That's legacy property. You need clear explanation why.
> 
> > +
> >    clocks:
> > +    description:
> > +      High speed baud rate clock. Either this or clock-frequency must be
> > +      specified.
> 
> Drop last sentence, Anyway, don't open-code schema in free form text.
> First sentence seems redundant anyway.
> 
> 
> >      minItems: 1
> 
> I'll fix this.
> 
> >  
> >    clock-names:
> > @@ -61,11 +69,18 @@ required:
> >    - compatible
> >    - reg
> >    - reg-names
> > -  - clocks
> > -  - clock-names
> >    - interrupts
> >    - interrupt-names
> >  
> > +oneOf:
> > +  - allOf:
> > +      - required:
> > +          - clocks
> > +      - required:
> > +          - clock-names
> > +  - required:
> > +      - clock-frequency
> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> 
> 
> Best regards,
> Krzysztof
