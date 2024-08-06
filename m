Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB661D27AB;
	Tue,  6 Aug 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950814; cv=none; b=krSHa9l1demTCZ1RCELzq3FDJMvCqK66yyY0i2gNWkk92gpJO8uYoPVPusTJs3yV84gffAM2bABCiWJedp7TWwybze3o2cKgt1PHkMxwc8mSxj32ccaUn0QPmIFfV9/1bXB2RTtoo4XzCo0T1GTytNDtnH8Lt7XD1CIv+vMjk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950814; c=relaxed/simple;
	bh=bZOBpmsyTzK8v1YYpAeTeDxlbWCsIOtryxVDKATcLaE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY56NzHrikZPVg2FjxCqhvitRgXRbqSw/F19vKEPpuOPHX9iwhYNu6RYt735tySonzQpm+YCd7yp6Dj7Rrfn/q4+CvwpDsCCLoJ4gZ4PZdRFSPeHUr7CXnlM4ynaKBFeJnLiCpYQ/3/e4rM8W86eH0vWoE8kEnlWzNbEAECMdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyeQavgo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyeQavgo"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a843bef98so66293066b.2;
        Tue, 06 Aug 2024 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950811; x=1723555611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WJLq6wZ3V9tDfVtOdZGITLF+SX3fZ5WHv+sByglbu5s=;
        b=OyeQavgoJQBU2RyuQUGDQP3efzAKVKEJmw7NgCovi3DAJyfdcCYOwD8nko8CK1FIXN
         FBz+HFMCHUiQ2TqWI8rv5d7Y6khsth2grGsP0Z40jC2/kfv94OuYRAPsKLYlRA29Pv3O
         2KoJpyJAFCn6Puq0EolylU8p6W8c9WTSVZbKLRoMIPDOgXQIZxdicUlv/+xa4vw0BLUN
         +1ooNIZ0IX9kheeTGDGYVDii3OXKC1VSBM7P037z+y0RxwifTwaCeOKDMCSFji0NqMHU
         GtIg7Bf+Qjqx7ZZ+RhG5FfPcPX/wi83I6wBrol9/bp6NhZRWFSME0QUrwT6prSjBtPoK
         GbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950811; x=1723555611;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJLq6wZ3V9tDfVtOdZGITLF+SX3fZ5WHv+sByglbu5s=;
        b=A6u875gleyj1taVxVOiKB8wBHUNPNKoFTrnvOPeO59KSGjo+RSIZ8p5qqg9LE/WJ3W
         Fd/bm2MWtNkDLJeBZ0D7IOLkDVyqTxGet04ZIsrsMzNmsp6+cM10jZ8Ip3Z4QWRivQG+
         XNHwboiId7hL0yVSMfum9Y+itDWVe/yTj06NMdMGzA5XymUYgpO5g8ULjjGsmUaqvn+d
         wu+K9rzYCSQUmUM4zFZoKEk8PVGvu5Nkz9tbsYuoKMFOnI+k3iXf2PIYmJPPSuhs7rVl
         Zrf0KaDqHijSVESluVFHNLUpQVOp3Z9s68Zvrwc5o2GOrs7HTPGRJD+DOAd9GgcYVhDj
         Aikg==
X-Forwarded-Encrypted: i=1; AJvYcCW/oaDe3yVBBE4UxOUx0ji+jly2tY3dq64EoCBZV/1En6lMHE+telaCZg1o0GsgVG2lkJ1URL2SgjhSmKKz3/YMb6vCXf+KXRoyiHlItoFJOk3s5hRKv1iEdffzx+fO4DLY8Wnvrg+Gwv2eOJ6gpBTZX+ePI73HkrFIVId2+SriKBdGcA==
X-Gm-Message-State: AOJu0YxfQGD7GEydlhXqX5cOGra/7GrB8NquPOZKpUAfBhww6l5NF0ai
	SB6LfwsB9853DPEeU+axlMWJfiwzzMXvbiAq4l+jU0S6GqHI+lzt
X-Google-Smtp-Source: AGHT+IFCZboMdtGhjAjAlddCPcdXU/2ru7VniI37xRcVSX5ZWE/iyT9EsbOEIdYyKoXwTHhvEvlGlg==
X-Received: by 2002:a17:907:7ba1:b0:a7d:a008:abca with SMTP id a640c23a62f3a-a7dc509e2damr1049187866b.56.1722950810418;
        Tue, 06 Aug 2024 06:26:50 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec285bsm545048066b.188.2024.08.06.06.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:26:49 -0700 (PDT)
Message-ID: <66b22499.170a0220.cc48.fa2b@mx.google.com>
X-Google-Original-Message-ID: <ZrIklQiyQvFIIPz8@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 15:26:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-3-ansuelsmth@gmail.com>
 <20240806124312.GB10156@lst.de>
 <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
 <20240806130938.GA12231@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806130938.GA12231@lst.de>

On Tue, Aug 06, 2024 at 03:09:38PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 03:03:24PM +0200, Christian Marangi wrote:
> > Well on embedded pure PCIe card most of the time are not a thing...
> > Unless it's an enterprise product, everything is integrated in the pcb
> > and not detachable for cost saving measure or also if the thing use PCIe
> > protocol but it tighlty coupled with the SoC.
> 
> Yes, PCIe has a bunch of form factors, including just soldered on BGA
> devices, but none of that matters at all for the logical protocol.
>

Correct, for the context of soldered stuff tho things can be
malfunctioning (problem in the PCIe driver) or working so it's possibile
to make assumption and attach OF node in DT. Consider that the thing is
probed only if the card is correctly detected. Card not present ->
nothing is done.

> > This implementation is already very common for all kind of pcie devices
> > like wireless card, gpio expander that are integrated in the PCB and
> > require property in DT like calibration data, quirks or GPIO pin
> > definitions, i2c...
> 
> Do you have a document on that/
> 

You mean example of PCIe that makes use of OF? Pretty much ath10k-11k
mediatek and in general all wireless card. Example ath11k-pci.yaml [1]

Compatible is set to the ID. PCIe will attach an OF node if found in the
pcie child nodes (already supported)

On NVMe driver side, the NVMe controller will already have an OF node
present.

We are now just adding an additional subnode "nvme-card" and attach it
on the root disk when it's created.

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/wireless/qcom%2Cath11k-pci.yaml

-- 
	Ansuel
