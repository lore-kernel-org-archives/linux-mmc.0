Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D231D1752;
	Tue,  6 Aug 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950244; cv=none; b=eSAiTsO4PrUcmrLJp4+Sk0kgEkoIK+PSRWe0xLCLdUdOY6foa1a5F7JOhlDrpeQywCkDhr0rETKzGcMdHYppcfDEOxqMhsB90OgBNu/Hu6JlLyh4bfn3MmWlvM2xUvq5yj1r7oxyBvJzNQKqMUPoTBz2+AgAoN/x20Vwo7dh/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950244; c=relaxed/simple;
	bh=Knmc7o0S/SSJV9dBfvgE9sDSlGBHqmcJXbEUqr/HB+8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+beXqmnSWF/tBuaE64zyY5xTn0Jtw6hnsfhsZg12wP4ILo6USUIaY8jZ74xpDn2vIeeWQbUR14+khUyur/EtvGBMgom9EGrsMYRC25VWuGODZlMgJH9UnuPncLiQkwvOIHE5j6+RCNtimRUgWBBOgkwCtknvdJJz+Tk6tD1yBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDu7xOBY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDu7xOBY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso3941635e9.0;
        Tue, 06 Aug 2024 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950241; x=1723555041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q7zPzbWeT3ajGHr373KRI//jHW9eGHoTwTI24+zUeFk=;
        b=NDu7xOBY1+32cHh/S4JNBEePMhqbDYtRtgnrwcLApuaJ9Ld1pxHl3Wp8wXrBhfyp2C
         1AgS2zE1ABJS/MvJSP2IXwyEeYveaMEMFiJ4bXYJc6J1DajVqTfe5G1ctx13nmf72ovy
         PHH3ehx4+XYGjIPcfkccutNiqEA0ALqJFCEAhyru85ADO7UTQd6gYGJJQJYXqDBqTyEH
         xsTU0LrTwB3rb/0b7nWZi5R8vNblnxORlkJ1HTpt9FqGkmEXmb00x6RHxU/uhFGB0Lfi
         rCuu0S6uQQL3ZjWxfhPA3rgWxQGMrURnCsu39oE6Su6pDGlhhlD+L9NoixazwwVqjY1k
         n9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950241; x=1723555041;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7zPzbWeT3ajGHr373KRI//jHW9eGHoTwTI24+zUeFk=;
        b=dgHM46nKZKulpgBS/tW7ZnSOQgF9615zL061Vv3NIF6rZA+aH14vCHNPOxVDOpj2+U
         5UAq8dvQNPJ4+hNe6PRiW0iTUgfmyZJkn4TCNwLswpUi7M2PDKQdfGuTRNvoQMDijO5V
         fMbSMqDF09DPp96zrA74iXLogMG4VVJWFMivtNr84/Vp2L39vTFaBiRYDrPPaCs+G5s0
         zp5lJGfbL/NmkSl1BdNH9IuP2mKv/D266mG4ZZSGIlE7KgBg30vWZi66GvRAWGDQg6SG
         psvYhuaoPuqsxg/ggl2OJnI8tjzBakdNTR+PIyrQf/0bD6ty3Mk58AvNeQHr6ehXXm5o
         S7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMSRZfHGxzKk9oRVnAXK+Purxq8jOiRLaGMKL/0QCaFKNlkLS/r4oG8x/c21hz2qcGJBEAJZQKHy8cRG9wtpjJKCbzHu/OfX7gJVNIo1Z/ygn3O9/CEAkscjJsmND2bDKI1LtUgMofzf7Fk5x6czupND4f3tvjiIOS7poAc4ST8UaHXg==
X-Gm-Message-State: AOJu0Yxun74uOkMlTz+i/dq1pq1bGOd38KZ0Tpj+BLjP4keIVqzz9k8n
	8XWrWVlAhMaXniMh9ySX4qvVejhXY29R4xiXJ3198M2ilu3SJX6C
X-Google-Smtp-Source: AGHT+IEut66y9HBGYWpB8iEX0ePNj2Rw9qoCD9Mj6LeeUaFBErVh4YbDclRk8F/WRbu/POoNdZxUOA==
X-Received: by 2002:a05:600c:35ca:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-428e6b7be88mr102599445e9.27.1722950241128;
        Tue, 06 Aug 2024 06:17:21 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adaadsm242847475e9.12.2024.08.06.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:17:20 -0700 (PDT)
Message-ID: <66b22260.050a0220.18f4fd.5a4d@mx.google.com>
X-Google-Original-Message-ID: <ZrIiXBYsm8a1WjGM@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 15:17:16 +0200
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
Subject: Re: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-2-ansuelsmth@gmail.com>
 <20240806124224.GA10156@lst.de>
 <66b21d35.050a0220.3799b3.7e8c@mx.google.com>
 <20240806130003.GA11766@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806130003.GA11766@lst.de>

On Tue, Aug 06, 2024 at 03:00:03PM +0200, Christoph Hellwig wrote:
> I don't see how this works.  There is absolutely nothing nvme specific
> in there, and we really should not bring OF into NVMe.
>

Thing is that OF for PCIe devices is already a thing so NVMe already
have OF support. And that is totally OK if the PCIe is not removable.

So it's really a simple subnode to keep things organized in DT and
permit common code. Why this would be problematic, the implications of
adding support for this are really none, only additional support for the
new devices that are taking this path. (you would be surprised by the
amount of hacks they use downstream so about times to stabilize this the
correct way)

> > (alternative is to have in block2mtd all kind of extra logic with switch
> > case to check for major block ID that deviates from a common schema)
> 
> What common scheme?
> 

The emmc one and also nand attached to spi. They all follow this.

controller {
	card {
	};
};

-- 
	Ansuel
