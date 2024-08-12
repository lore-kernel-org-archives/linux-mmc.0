Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619E1876;
	Mon, 12 Aug 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457408; cv=none; b=VVqeAq+U4V/Oi3KowG6LrG9YDXri16GySalBO74PPMbf+m0PHexuKukBQ3bG6pOVWBb1TPirI4djTgK4l18yXaXg6oC/DOI1PaO5JOcVu7Ro54/b9kHDP/00fcAyLCARLR9EfJ8FoGv7YOcIpOWMci7kSl5E1Te37wPZpan2Tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457408; c=relaxed/simple;
	bh=CE81XtTRxGKyG4QdnMPfqDkITk7nkHR3vviOoGqo0FE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9+lTqqnke3L1Dlb/nXsmFx6hkphyvNfwQtlEZM2b0nqJZcv+IjyI3nGCNS9qnRM7Y85Uvd5QW4Ap9YJQ6N70oZE9Y/y0zK4+s5HIqV2vke0wXgDOPuBrwuRONDXK2xh43ecl9LT8qqtgbswvaGx5ofdVRbzr17pk26McGBuSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMjUARPS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMjUARPS"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f00ad303aso5584402e87.2;
        Mon, 12 Aug 2024 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723457405; x=1724062205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6AGDbHeUwy43L7QOiWatnM3/EWv9Db1La7THgNc4U5U=;
        b=bMjUARPSjLnz2P1y1p3RL2Qmp6i2gEMJNgXrNHm4dXqxWHa1JcLmNHDvI8UupEK/A2
         B82XjbsFT8zdigG8Q8xDpwybhG5cxc1FPRWzb0voftRx7e0h+6evkUzCz51GoFRODKR/
         Smyrzbytqt0V7QkJv6ESwfDRFubO9i06v3Gl2Ax07ai/180MSIHT3L3UPXCQeDQAL4u0
         JRdvjeW7kqXeqnHMTqo6/RtCV070JVsbgnN06DxQg/pRGjymhcdoA3h9niUqF3V8c45l
         dIHFu0lwYw5KHH6H6HVAAv81YtudRXYb1HgOy8pvrYs2T8p/35++2PbDOxdypMfQ0sKO
         anKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723457405; x=1724062205;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AGDbHeUwy43L7QOiWatnM3/EWv9Db1La7THgNc4U5U=;
        b=C6FjdCW/FaLJeKsA8hAiVQMvktkSs/XSGUMIwsU5f+23+seuCDda9HjaoUN7qHGF1s
         kTqYJ3IT7uyQOT2XnBBux0E0IHobeJ6jIC8ETkKkaMpMNICpXBW+R1K4OUTYui/DhXYd
         cUK/rRtF619VNWgTEUEHcTG3P/tMtOeHKNge8MWMlh+eH9V1qsVGTfjzcUdqPJggQNG5
         5Axyer/BzEx6TaYgWs4rgM8CtQ2u+MgtJ9MIGIyYXBzVFV0ayZl1VmqzzU+CIits78ZM
         lG3P6tNkaQ3PdK1UCYnVIbo5AG/Cch6xCuU0DGejoKKAzKhgi84lKnCAyQ4CDIjJJgcD
         KyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74rz1n4A/EkwyqTMsYYzI5eCgjVnjfoFNOJs0UkQGYuBWUlIzeg4OW7UgXJirlGlc7MimSaZMeBsie03ufW5+xVgfojYrqEVzJX5jtel894WulpYAJtLngmMWW9la/3ip/44dxm9jfjQ7uySzG+Nnf/YYPBc2D/+yCKmwfsvUU+74Jw==
X-Gm-Message-State: AOJu0Yx5rSQXksuCrdQa33keVtfBCBIH+VeRN3WTMygLyK36q4umjm5A
	kb6wxDy8ps1zjNep+kRvlsA8mBmwS5YWQoQuWRAhJ07toXp/nZVu
X-Google-Smtp-Source: AGHT+IF7gXVzTH4CvkvVbJhZb4UZN3i53JvW8K9dJlvL2BXg7c8PPh33br3AXeB8LmLX5nWpLcfQ6g==
X-Received: by 2002:a2e:602:0:b0:2ef:2c20:e064 with SMTP id 38308e7fff4ca-2f1a6d0c988mr58328141fa.12.1723457404706;
        Mon, 12 Aug 2024 03:10:04 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a698sm184004695e9.21.2024.08.12.03.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:10:04 -0700 (PDT)
Message-ID: <66b9df7c.050a0220.3574aa.d5bb@mx.google.com>
X-Google-Original-Message-ID: <Zrnfe21jJLJ310O_@Ansuel-XPS.>
Date: Mon, 12 Aug 2024 12:10:03 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240812104954.1e8d55f7@xps-13>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812104954.1e8d55f7@xps-13>

On Mon, Aug 12, 2024 at 10:49:54AM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Fri,  9 Aug 2024 19:20:58 +0200:
> 
> > This small series handle 2 problems.
> > 
> > It does try to ""standardize"" the usage of block2mtd module with
> > MTD OF nodes.
> > 
> > It is very easy to add support for MTD parser by just adding an
> > OF node to the mtd created for block2mtd.
> > 
> > This apply only if the root block is used for block2mtd to allow
> > scenario where the full eMMC or an NVME is used for MTD and it doesn't
> > have any partition table.
> > 
> > To also support NVME, similar to how it's done with eMMC, we introduce
> > a subnode to the NVME controller that needs to have the "nvme-card"
> > compatible where a dev can define fixed-paritions for MTD parser usage.
> > 
> > This series also add support for the Airoha partition table where
> > the last partition is always ART and is placed at the end of the flash.
> > 
> > This require dynamic calculation of the offset as some dedicated
> > driver for bad block management might be used that reserve some space
> > at the end of the flash for block accounting.
> 
> Who is reserving this space? And this is not reflected anywhere in the
> partition table?
>

To be more precise Mediatek use a custom way to handle bad blocks called
BMT where they reserve and store data at the end of the nand. This is
loaded before the flash driver controller so when MTD is init, the size
is already reduced. The reserved space can change and it really depends
on the tuned values hence it may change.

> > New aarch64 Airoha SoC make use of this partition table and use block2mtd
> > for eMMC to treat them as MTD with custom bad block management and block
> > tracking.
> 
> I am sorry, I am not used to such use cases, and I really fail getting
> why you would like to use mtd with an eMMC. Can you explain a little
> bit more what is not available in the block world that you really need
> from mtd?

Since vendor needs more space and doesn't want to adapt to block world,
they are starting to use eMMC or block devices in general unpartitioned
and raw and using block2mtd to simulate it. They don't care about the
performance penalities as it's something read at boot time and only new
firmware or some config files are written.

Is it more clear now?

> 
> Also, did you consider nvmem layouts instead to detect and define the
> ART area? (just asking).
> 

They still need a MTD partition and most of the time userspace tool are
used on the ART partition. Using block2mtd and DT support will permit
the use of nvmem cell as a side effect (and that is a missive bonus
point of this honestly)

-- 
	Ansuel
