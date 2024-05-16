Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA6140E47
	for <linux-mmc@vger.kernel.org>; Thu, 16 May 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848582; cv=none; b=CtdYEDHL6bE+qDTteNDzA7ZZeAOyF5GNSaCvj6CO614thpiWywd6lxWytr/jXsQsHRdyZvSrCYXtMPC8bjFcCx8pMG0NxsM2ikIJoSEICgnx65VIUkDqWZ/npRXgnbTqWXWZdedRjINYwFBvY+Y3BBjpEplBsKZf8yWl/xJxycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848582; c=relaxed/simple;
	bh=dwC6cRbODnGd61OEFofYN+ABCksxryw+47FpuuIGhpo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc1BehF1WcpDMaMliJXyaBDb67wnJA2nvBFf6yk6XKfbDqemCctOobxoAt6MklSS8y1hI/baT0lY11/D7/rSlzhfo8jE53PohqyB+tJoCW7PMtf7E9BdOQMKnRNJA3QIQENxjeb0ReUKwyYbg+LeGAvr9JYC87hgg1Qo+sFVIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YmM4KM2V; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YmM4KM2V"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso277395966b.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 May 2024 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715848579; x=1716453379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6SlACI4eez2IkJWPlonbnYSeybNPJ5ifMFU+WZkjDs=;
        b=YmM4KM2VK5nG/kADiU9qmVdh6HZXlOu5VLmZ7M17FKbCQx9H/kwz+Zdk1B1MzyQmq5
         qhzferAMZGxkh7dv6hH9xpfowkhCtRAZm657XMAVbQ13PsP9K5zkV/YvKgSL5EVIzPPx
         neLFExMyn6+RV9lohTobxO9dF2p7iqEXxFJNdmfN21ZtLOVlmWXsp74WnJqXfaOSveZO
         kMmmgYFfsEIKxit2AWj6WevmbFIv0N2Knhw1dS/3MKBtJeDLA6TdLlxohoDXJ2BWtvZl
         ZY/mI291Z88BYLov2ikwq8zTgrOFeOUuUDVmps92gf2A641t+q8zieqZUO2s7YzHkrKY
         Ginw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715848579; x=1716453379;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6SlACI4eez2IkJWPlonbnYSeybNPJ5ifMFU+WZkjDs=;
        b=DYxxuWmn4xKDvO6KGY2S6QVNyRDybMCFGE5GpKhQ9NwMWh3MirQZZVBAW5idAWbiq0
         dfouvXUzBY9odYjwPad1nItkZ3pf+QHQcOvjIBfAsow8hkGzdp2VPG55/dYo3QUUoyvi
         Ax+JeRlDa8yA/FaBiOW/eyFqubKY5KyCM0agUIJlrU8WjDL9ZhsXvEPUZAvPwgokwo7J
         ZOB9DJdXUcP8UJo+1NEPc8VMqNHtx1xGT2se42CUt1xPlGhk8mkS3+i8hIDqhtrPQddp
         OlDS8pvyEwLDJvBgZZQvHesf4NxVyJKtGrvuftKN8j2Bh9JfsHlEPwe7t2r6C194VFWF
         glZw==
X-Forwarded-Encrypted: i=1; AJvYcCUNSa+I9+lr/MOOxvLRZymQGJ1LUEdR0KLDXTLdR4gf+E8ToAlf9+v2KXfYxJ6qB01weFYxfU9RI+tNBTxXmOZPg7r3cZlBGxjG
X-Gm-Message-State: AOJu0YzOiR54JRk4XhUX00etyec/O69Ruzv3VTzYawnwY413J+3BA/Az
	yPZ8sVhyw31dB1ZGX/1QcVmrS7wCYXq7jdua2ibQMr2oSL6V5NnM8rKBMlsxGMk=
X-Google-Smtp-Source: AGHT+IGGFxatrdPISpX+xAY6+xCuM1eumthYKhRaUXY2RINVYNPzbNBTe5QAL9ecMqHyH3zvIKdvOw==
X-Received: by 2002:a17:906:2708:b0:a5a:84c8:7710 with SMTP id a640c23a62f3a-a5a84c8b9eamr483964166b.55.1715848578649;
        Thu, 16 May 2024 01:36:18 -0700 (PDT)
Received: from localhost (host-79-19-230-33.retail.telecomitalia.it. [79.19.230.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a8883344bsm289752066b.9.2024.05.16.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:36:18 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 16 May 2024 10:36:27 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: broadcom: Add support for BCM2712
Message-ID: <ZkXFi6_2DkXRNgSL@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
References: <cover.1715332922.git.andrea.porta@suse.com>
 <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
 <786bbf35-e9fe-445c-b6f9-21119e60fb34@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786bbf35-e9fe-445c-b6f9-21119e60fb34@broadcom.com>

On 09:14 Fri 10 May     , Florian Fainelli wrote:
> On 5/10/24 07:35, Andrea della Porta wrote:
> 
> This should be #size-cells = <2> to be future proof and support over 4GB of
> DRAM, because the DDR controller and the memory map on that chip have been
> designed with that requirement.
> 
> > +
> > +	interrupt-parent = <&gicv2>;
> > +
> > +	axi: axi {
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <1>;
> > +		ranges;
> 
> The AXI peripheral window should be defined in the ranges property. The
> aperture is from 0x10_0000_0000 to 0x10_3FFF_FFFF.
> 
> From that point on you can define all peripherals under the axi node to be
> relative to that axi aperture, just like what you did for the legacy Pi
> peripherals in the subsequent bus node.

This doesn't seem to match with what I have here:
- some axi peripherals goes beyond 0x10_3FFF_FFFF (e.g. the interrupt
  controller is @0x107fff9000)
- downstream dts have that ranges going from 0x10 0x00000000 0x11 0x00000000,
  so to span all the peripheral (included e.g. the above int controller)
- another comment in downstream dts says: // 10_00000000-1x_xxxxxxxx = up to
  64GB system RAM

I'm a little confused here, of course we could also define multiple ranges
but I don't really know what the boundaries are. Anyway, I would opt for the
extended range (0x10 0x00000000 - 0x11 0x00000000) unless there is concern
about it. Any thoughts?

Many thanks,
Andrea
