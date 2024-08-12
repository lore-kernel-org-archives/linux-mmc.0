Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839261D699;
	Mon, 12 Aug 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468682; cv=none; b=AKTqgzUPzmMeHyFktSRAagmuz37fZ6YFvYDVc+h/hCB954v7y+uao88AQcQg9OP3icn4GHksRN12ar/ZiWTntJ+jP5AHvoOihfuEQfJxTyxQleokJgvo5S9S2U2YS6WUn1IG2w7FsWhrW4d1q7DvJBRqnR3x3+Sp1wryB2CmSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468682; c=relaxed/simple;
	bh=aoEG7LVugUDhTzLFYA5r9vLpssJzwnJp6xpB5GyAH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWXTZiIh+wmlUjrPiiTMaAnUAPmOWjXJx22aKk908i7oOd0yEUcNruVN3Nroq0ueuSoxQaTnSjRG9kpbRko0ELwzDn9addDMU08ZTvzToGJdySTkEqEv/d3nVnrcZSPjwPwkxi5ECVWr5WiiZLJFK6w2RNnwn41/ZlEgpdj50as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T1DGM4+f; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T1DGM4+f"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41E7620002;
	Mon, 12 Aug 2024 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723468677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdcV2kRk9M7GFAK/D+USec3altBfiWngrF1bMZJR0h0=;
	b=T1DGM4+ftpehFe4HTk9kRVwPAVKw3AXm0nD1T1JMZhEdelkbXoOfgy4NgYAKj95rVaLvIp
	nZnomFB1XkmKUg7BHzwy2Zpp7FfDaMYjbRXKCK5jVbxGkA4HSJ1kb6ERXFei+u8THVVKQK
	AB7ydR869hd6hCgePz3L2ncJBB48RgAJbw3nqvRXWZ2bnwmJrOyzsbOyD1LgGLVygbOXe1
	h2sXickvc/8OCgBUceYdm1WA7UmkQX6+A8msWci8Mu3YNPv7JKtz5mpXi+/Z91kCss8Pbp
	noYDmTyhdrsEflAz5id8Ax4oD5XfbGH/ORmkMLDhKex9GquwQMFbGoeyrW6ljA==
Date: Mon, 12 Aug 2024 15:17:55 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan
 <saravanak@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
Message-ID: <20240812151755.0feab4b2@xps-13>
In-Reply-To: <66b9df7c.050a0220.3574aa.d5bb@mx.google.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
	<20240812104954.1e8d55f7@xps-13>
	<66b9df7c.050a0220.3574aa.d5bb@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Christian,

ansuelsmth@gmail.com wrote on Mon, 12 Aug 2024 12:10:03 +0200:

> On Mon, Aug 12, 2024 at 10:49:54AM +0200, Miquel Raynal wrote:
> > Hi Christian,
> >=20
> > ansuelsmth@gmail.com wrote on Fri,  9 Aug 2024 19:20:58 +0200:
> >  =20
> > > This small series handle 2 problems.
> > >=20
> > > It does try to ""standardize"" the usage of block2mtd module with
> > > MTD OF nodes.
> > >=20
> > > It is very easy to add support for MTD parser by just adding an
> > > OF node to the mtd created for block2mtd.
> > >=20
> > > This apply only if the root block is used for block2mtd to allow
> > > scenario where the full eMMC or an NVME is used for MTD and it doesn't
> > > have any partition table.
> > >=20
> > > To also support NVME, similar to how it's done with eMMC, we introduce
> > > a subnode to the NVME controller that needs to have the "nvme-card"
> > > compatible where a dev can define fixed-paritions for MTD parser usag=
e.
> > >=20
> > > This series also add support for the Airoha partition table where
> > > the last partition is always ART and is placed at the end of the flas=
h.
> > >=20
> > > This require dynamic calculation of the offset as some dedicated
> > > driver for bad block management might be used that reserve some space
> > > at the end of the flash for block accounting. =20
> >=20
> > Who is reserving this space? And this is not reflected anywhere in the
> > partition table?
> > =20
>=20
> To be more precise Mediatek use a custom way to handle bad blocks called
> BMT where they reserve and store data at the end of the nand. This is
> loaded before the flash driver controller so when MTD is init, the size
> is already reduced. The reserved space can change and it really depends
> on the tuned values hence it may change.

Is this supported in mainline Linux? MTD handles the bad blocks and the
bad block tables, so I don't understand how this hardware feature can
live together with MTD.

Anyway, you are talking about MMCs, I don't understand why there are
bad blocks, nor what is checking them and when. This is all still very
fuzzy to me, I'm sorry.

> > > New aarch64 Airoha SoC make use of this partition table and use block=
2mtd
> > > for eMMC to treat them as MTD with custom bad block management and bl=
ock
> > > tracking. =20
> >=20
> > I am sorry, I am not used to such use cases, and I really fail getting
> > why you would like to use mtd with an eMMC. Can you explain a little
> > bit more what is not available in the block world that you really need
> > from mtd? =20
>=20
> Since vendor needs more space and doesn't want to adapt to block world,
> they are starting to use eMMC or block devices in general unpartitioned
> and raw=20

Okay, why not, it's easier for ROMs to access it I guess.

> and using block2mtd to simulate it.

This is what I don't understand. You can very well access your block
device by offset, why do you need the mtd interface at all?

> They don't care about the
> performance penalities as it's something read at boot time and only new
> firmware or some config files are written.
>=20
> Is it more clear now?

I still don't understand the need for going through MTD tbh.

> > Also, did you consider nvmem layouts instead to detect and define the
> > ART area? (just asking).
> >  =20
>=20
> They still need a MTD partition

Why?

> and most of the time userspace tool are
> used on the ART partition. Using block2mtd and DT support will permit
> the use of nvmem cell as a side effect (and that is a missive bonus
> point of this honestly)

MTD also registers into NVMEM, so this is nice if you need both, but if
what you need is some NVMEM area derived dynamically and you register
into MTD for that, then no, I'm sorry, that's not the correct approach.

Thanks,
Miqu=C3=A8l
