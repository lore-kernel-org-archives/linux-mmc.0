Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDB17A931
	for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277274; cv=none; b=KUsv6eL3X/Zh6IW61WhrN9QpBF3KSvT1/G42l9Z4ASHpW2wWMnfFJVk29MJTitv+Wb1ZZc50Jk5FFZ9TyJT9PRe4JPISUs499ZsUYxPEqWAD8ySFe2qLGTYNZCLWhDEDSdReLKOH9634EM87CO2LRcCjOOej9USj2c9Nijtg9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277274; c=relaxed/simple;
	bh=OWEY/Oe8ge2ZZVlPSGKPWDKhRL3cgLiz+mCQB5vlko8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J73AS+PWiK+sidXe8nFSSn50zvrWbi8vr+TCLjAin4UZInx+eecJp2Y3TEkXAzfbkXTRdowMgONxEDVVaxGoTQ5vlpoxxWdwV39kXOsjrTHRU7J8tnnIyhHGf9eBTk8Jj6L9scLcO2f2Rk6OBEZDy5JKp2AtHIRFblWne4lfRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TVe3qpBh; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVe3qpBh"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e165825ebfdso224942276.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Aug 2024 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724277271; x=1724882071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qkHIbzE1O2+lqb74KEvCCR6BaqXgelXIBZ+AgizTxyA=;
        b=TVe3qpBhHS5f8rwa3OT/pfJg7+6r7LxqcP20m1BEnV6S13fb73IoPyFZjvtbpkSEy6
         /rLRCR3KsMJ9xHBLzhQjSfyFbh2L1ro/x20b8LYD+NsiWy5NJEJQIK+MzfTrWR4BJ2Qj
         iPx4WfGBKADbQflgjSYYjKYeXup1Tb+4+cHZr/iDB2CxGyewdYK65e+cpskK0Xd0zG6o
         +lUVn0iKhFELOLbPKcSUyh7DixmgbGmPk6UacI5nyWVvprVgj/I1uIU0BCmWax4AYVX/
         OZKu05vxjdYiwVPAwl7lsSteoBiO0ftnKti6XqERbP1AB7bmRWl0ecHBI3BGGqz3Ma4R
         888Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277271; x=1724882071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkHIbzE1O2+lqb74KEvCCR6BaqXgelXIBZ+AgizTxyA=;
        b=qf9cCnQ8HppghIcBu54yfMqg7aw/nCspH7KNOnDIx8I2+jRT09Z+qo2NGs1IVOGesW
         ooM0s2P7yjF3c51CVGM4RBwauiKb8j0PaNb679muuN9k+AViYOl1XUlnTNIDuPfJHt3m
         DHRuS8N4Rw/6rk9jwkwrCDuCe3AuGN6gF8fdxzoAKq9hE+BPmRow4TQfZaX/s0mNfQUl
         9Z9cXtiuts4Q3KTBP7NbMHp/jNx0le9z7n6FbU/92x0E+/NUNytYklG8UEKGrMe04/pf
         S2p5YSD0EToY6xnQr/VuMrgO+MsUOPKEark/xlWZW0CG5AZoUbNYOc3DJpQLhOawpD1y
         whKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAs1CU8P5TPM63qmHMcqfwZLdBakBFP1TqMLkKCmJaW3phD8VyG+F65sAfY+RxjrYuYlpIqyjs4LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmYGig/sK1sco0VQOjBlTK2VvAk418/NIrNbboX05rHiLq9w/
	K/mcSeFIXcQOJMz7Tr0EdxZpdYOOeVelsTTcXEYo3TjSQHH1J8WBpfG6S6sNzH0jMNi3PDPh1wT
	7ozkwZHOn7y3YLFmjigUgrEo4zQLsUbUCYXL65ltBBQmlyoTa
X-Google-Smtp-Source: AGHT+IEbLEfHwFyYNcri3t1w7o7tWbS6oBaWx4DQWVSFv0w407zJOJ7W0eTL+KNzshnbYP+06yOh2I/iVUNvpj/p1kQ=
X-Received: by 2002:a05:6902:1444:b0:e0b:28ce:6156 with SMTP id
 3f1490d57ef6-e166556617cmr4277142276.55.1724277271228; Wed, 21 Aug 2024
 14:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809172106.25892-1-ansuelsmth@gmail.com> <20240809172106.25892-4-ansuelsmth@gmail.com>
 <20240813200734.GA1659224-robh@kernel.org> <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
 <CAPDyKFq0cR10d1jUc5gnoUR5P=cbDEZy2iA-HOq9oNcWZevbDg@mail.gmail.com> <66c62d4f.df0a0220.3305f1.f86c@mx.google.com>
In-Reply-To: <66c62d4f.df0a0220.3305f1.f86c@mx.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 23:53:54 +0200
Message-ID: <CAPDyKFpHaWar9Mbdg74CGgrwqkoLwt5HjvVOtUDU+z+sg9aT3g@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions node
 in mmc-card node
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan <saravanak@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 20:09, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Wed, Aug 21, 2024 at 03:14:29PM +0200, Ulf Hansson wrote:
> > On Wed, 21 Aug 2024 at 11:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> > > > On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> > > > > Add property for defining partitions node in mmc-card node to define
> > > > > partitions in DT by the use of the block2mtd module to use block
> > > > > devices as MTD.
> > > >
> > > > You justified patch 1 saying eMMC already supported this, but then here
> > > > you add support.
> > > >
> > > > Both are a NAK for me as both already have a way to describe partitions
> > > > with GPT.
> > > >
> > >
> > > I think this got a bit confused and hope we can find a way to add
> > > support for this.
> > >
> > > What is "already supported" is assigning an OF node so driver can
> > > reference it. This patch was just adding the nodes in the schema to say
> > > that partitions can be defined.
> > >
> > > I think what is not clear is that block devices might be used as raw
> > > devices without a partition table defined in the device. In such case
> > > it's the kernel that define a fixed partition table.
> > >
> > > One example is [1] where the partition table is provided by cmdline.
> > > Similar to cmdlinepart MTD parser.
> > >
> > > The use of block2mtd is just to make use of the MTD parser system.
> > >
> > > Considering
> > > - eMMC is soldered to the device (no dynamic scan)
> > > - cmdline might be not tunable and hardcoding it might also be
> > >   problematic (as some cmdline needs to be used)
> > > - concept of fixed partition for block device is already a thing and
> > >   used a lot (android AFAIK)
> >
> > Sorry for sidestepping your discussion, but I just wanted to add a few comments.
> >
> > It's not clear to me why we need something different than what we
> > already have today.
>
> It's really adding a missing feature. We have cmdline but we don't have
> DT. And in emebedded many times cmdline can't be changed.
>
> >
> > If it's a partuuid/uuid/label or a fixed block-partition from the
> > command line, we still need to know what partition we shall use for
> > what. So why is this problem different from how we manage filesystem
> > mounts, for example?
>
> In the context of eMMC there isn't any partition table and the cmdline
> is hardcoded by the bootloader. The cmdline might provide the root
> partition to use but doesn't declare the partition table (with cmdline)
>
> And the bootloader with the hardcoded cmdline might provide a different
> root partition in dual-boot-partition implementation on switching the
> boot partition. (this is used a lot with bootloader using a env variable
> and a different cmdline passed based on the variable to signal what
> partition to use for root)
>
> >
> > >
> > > I think it should be acceptable to introduce in DT support for defining
> > > fixed partition for block devices and some kind of parser system similar
> > > to MTD. What do you think? Would this be more acceptable? Idea is to
> > > just have a DT schema that makes use of the values that can be set in
> > > [1].
> >
> > In DT we can describe that there is an eMMC card soldered to the
> > board, because it's a description of the HW. But describing what
> > stored inside the eMMC-flash doesn't belong in DT.
> >
>
> Why? This conflicts with how it's done on MTD. Also consider the fact
> that eMMC might contain calibration partition used for NVMEM.

Because what is stored in the flash (eMMC) can be dynamically updated.
It's not a description of the HW as such, but I guess it depends on
how you see it. No matter what, you need to convince the DT
maintainers that this is the way to do it.

In my opinion, I think it would be better to invest our time to try a
different path.

>
> Describing fixed partition on a soldered eMMC that the bootloader
> expects at a fixed offset and won't ever change (or it will result in a
> brick) sounds like describing the HW to me. (it's the same principle of
> MTD just applied to block devices)

I guess it's somewhat a greyzone in this kind of case, assuming you
are referring to a bootloader that is stored in some ROM code that
can't be updated.

>
> (I know it sound strange as block devices are expected to have a
> partition table in MBR or GPT but reality is that it's not always the
> case)

I fully understand that but there are different ways to deal with that
too. Maybe enforce to write an MBR/GPT when flashing, assuming it
doesn't overwrite some data that is needed.

Another option is to let the bootloader parse some platform specific
data in the flash (unless it's hard coded in there too) and then make
it update the block-devparts for the kernel command line, for example.

>
> > >
> > > Hope we can find a solution to this, I'm totally OK for dropping NVMe as
> > > I understand it's PCIe stuff and very dynamic but OEM are making lots of
> > > use of eMMC and are starting to use these strange way (block2mtd) as we
> > > currently don't give a proper and easy solution for the task.
> >
> > I certainly appreciate that you are trying to solve the fragmentation
> > issue around this, but it looks like we need a different approach than
> > using DT to describe partitions.
> >
>
> Well it's either DT that can be tweaked and is part of the image or
> cmdline that have tons of limitation due to bootloader having fun
> hardcoding it or also actually requiring the bootloader cmdline and
> adding overlay on it. Honestly as I said adding DT support is really
> compleating the feature of the cmdline implementation.

Another option is also to parse the platform specific data in some way
and create partitions by using initramfs.

Kind regards
Uffe
