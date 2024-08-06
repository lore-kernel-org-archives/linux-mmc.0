Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD521BF311;
	Tue,  6 Aug 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949412; cv=none; b=hsW9p0tlgfGk5l26HbrFD0QwLjMvfZuzXVeBM6VOQFHzKM0kwGYidi2w4tgHHjbFf/aE9DYtoxyJfe75S7FNftbiIsLtedo2kMl3se+LbFB0GrIO+rNBH8K9y18ssU7jtirycwbfw+tHqqvL/QKf6qWyuVI/S8aqKMypV4wYLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949412; c=relaxed/simple;
	bh=m350d+WN75F9JftrWFkla/yq9m1ER7FZxk2iY9CXx+I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL2PQVfskri6K3JkQdu1RpnyfPkvDpLSJ9ErXfd4jWVu0zl5TpEt+2w4QRu8cgZbokGBJcPwKD+UTMgEnJKXgFmdEnSQY2cAUpYdZkoobsLe5/BK7P8cj4nAJOrWCbof2a2j7iCvvywzRGx/oS0oTy2sUzPRhLRUXEVgHqzG+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4rPxxA5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4rPxxA5"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-369c609d0c7so465175f8f.3;
        Tue, 06 Aug 2024 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722949409; x=1723554209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NXqcooF+h0MdP2Fz1xLEPngVq2SpaVVQUfokhORQgX0=;
        b=B4rPxxA52mg0bGLWv751MdZb0wA+5vM83lxSqPtjZ5FAk2T2hRzPJHMyqi1Nq3dT6r
         WdwhqVTBGUfaytK5zhstjpE4ymUVDsM3Cam/t+s9P2WSHMXRelrWTPnwS2V703DehHZ5
         icJ9pBVdZeUPxYvDcufv3ru26j8QZRUgsMithkAPizLebVX/ePowMzfQAeQc6MgnTymh
         2PqUIgLhiNY+RWxm3X040MGqW0tXKOflX8DrzdSnoI6Vtir3fxEnGIDAiTykMp6MqLLi
         6k1K2IcA+VGjpHOr9j4KvEkW/f9cYunPG1H9W+8rNSVLVNGIOQLAdNqX4tAMDm1lRqqZ
         GOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722949409; x=1723554209;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXqcooF+h0MdP2Fz1xLEPngVq2SpaVVQUfokhORQgX0=;
        b=VaqJocJUA+ZuOTx8HmipWT8aQZBHn8OManjs0JttQInPT34zGlEYBVvdUSAXLnBNUM
         Jv41/D/flgUn83qE1timvbf38obOFkbNKtXL02KvVVTQ9lZN29QiTdMo4QF3yWoYsMsW
         BCUeqEtyO0pxCuqOfnfeiOwJN15QHisqI7DVzfqJLLBQeCzpt717Q5JEQSPG3DP3S4km
         /aU2mN8EFQQXGx3ITmVsCRu4nfAEr9WVxCDLTeXMVgFnTi0BYtV5O0ThewtSznw/r3gP
         tH87QX6BV8gAblEkj6vB2+42gP8rdR+JB8tAUUZlRFdbbdtNK8JkOHG8IvecpBDHqrl4
         2L+g==
X-Forwarded-Encrypted: i=1; AJvYcCXWvCM7fLfU7UF09/bFam1hdKU097+P6uNyfdyl4v8NuhRX9ikpvtth33N+2NFaDmEl8BLwU4VqG2+RIZrNKKiKJZb1qF3e8vyULgbrAeUrGh45EQjSrSMRRamgC3D9nF1uFVwNJmAq2emc1NmXXntXpkMcp/3yDw2mfzb470FKtqPOzw==
X-Gm-Message-State: AOJu0Yw8fmm5u8X3jsjlJRa8AfgeksEgmYSpJkN3qx4f2jK0eEa61AOY
	1rxNst5yrj5T9XviCzotwOjNFeQpoSPkXIP5dSTUneTLevVVI4ga
X-Google-Smtp-Source: AGHT+IFE9bmHdwlb1KsEb5e3xHweTxoHAD/CnO0l3FUpup1/tPLMxcnaiVALbAIQ0dYjYRMgUd3Syg==
X-Received: by 2002:adf:e7cf:0:b0:367:4d9d:56a1 with SMTP id ffacd0b85a97d-36bbc1a5f49mr10771026f8f.45.1722949409137;
        Tue, 06 Aug 2024 06:03:29 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc9csm13026496f8f.17.2024.08.06.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:03:28 -0700 (PDT)
Message-ID: <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
X-Google-Original-Message-ID: <ZrIfHDm-fNcmSaHZ@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 15:03:24 +0200
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
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806124312.GB10156@lst.de>

On Tue, Aug 06, 2024 at 02:43:12PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 06, 2024 at 01:41:12PM +0200, Christian Marangi wrote:
> > Introduce support for a dedicated node for a nvme card. This will be a
> > subnode of the nvme controller node that will have the "nvme-card"
> > compatible.
> > 
> > This follow a similar implementation done for mmc where the specific mmc
> > card have a dedicated of_node.
> > 
> > This can be used for scenario where block2mtd module is used to declare
> > partition in DT and block2mtd is called on the root block of the nvme
> > card, permitting the usage of fixed-partition parser or alternative
> > ones.
> 
> Err, hell no.  Why would you wire up a purely PCIe device to OF?
> PCIe is self-discovering.
>

Well on embedded pure PCIe card most of the time are not a thing...
Unless it's an enterprise product, everything is integrated in the pcb
and not detachable for cost saving measure or also if the thing use PCIe
protocol but it tighlty coupled with the SoC.

This implementation is already very common for all kind of pcie devices
like wireless card, gpio expander that are integrated in the PCB and
require property in DT like calibration data, quirks or GPIO pin
definitions, i2c...

In modern SoC we are seeing an influx of using cheap flash storage
option instead of NAND or NOR as modern hw require more space and price
increase is not that high... Almost any high tier device is switching to
using emmc and even attached NVME and simulating MTD with them for easy
usage.

Please consider this well used scenario in emebedded where PCIe is just
a comunication way and the concept of detachable doesn't exist at all
and things can be described in DT as static. Also these storage are used
for rootfs mount so userspace is not so viable.

-- 
	Ansuel
