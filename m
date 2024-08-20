Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B61494D1;
	Wed, 21 Aug 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263763; cv=none; b=Uiozq5oOlAVljA3RbJd76gy375Ct8l72XXt26Qc8OT7lLPpPtOXGI8i9EaEpXTi+WRNGGkWwG8c4AazAzp4kKH7GN8YSPcFhKfAe+mZSgyvyzePIsaDhpqFujZJhAis52drJxu6w0yUDoN0XCb9oOwvAEK8CUMhZx0pH8MHOSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263763; c=relaxed/simple;
	bh=6RUWiLswkU4+N/s6gxHNbPztJbiSeibiIMt0ZhSB/II=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcVuwvxnbB/YxM71hNp3SY9FVdKjrBeEyqjf3LDHXs4BNSyIT5AoRK/IYnvWUxFY/iNMMxOYw3OTYJFcH+IZVbn2YCl8KmHOI8v45nYAaWkA9VDYKFJhlUrnXeUO9iOLsd1TwVLlUyGM9UAkomVzh7a+8a6/If3xFz21/6CpYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK9AoIy2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK9AoIy2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso59236905e9.0;
        Wed, 21 Aug 2024 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724263760; x=1724868560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RbJQfh8oH+/6H+RAIJN5JcyecchC2478JTd/lzRXn+8=;
        b=nK9AoIy2VNoGXWiRZwKFxp9aPFHI2hYBv+cxO9xUXDNy7XvgISUa0JkUDILYzuAdpQ
         2/Vyx5ZGm4dJk4AEWp2T7GbpcQl1PI0RCJERu6z05EhYcoqY/T16egJYWZ1mpMps7NOK
         vq73xd/uV5ZslmtlPB6cRg9zuAbDEYi9mDz5e01lbnsDx4+IjU78kRCq3GbZ1eXDWXoa
         2mCJaec7IdqleD2FCszihjPpfQGX0q0/qKja7RGnIjm/8siKdfMUQ9fOFTxqdiVHyTgg
         Bdeoz+UUM01MoBRub7Z+oow2dosLd3AHzUbBe0ZE3xSew2wUaCj340arXm8H1OUVBi4s
         Yy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263760; x=1724868560;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbJQfh8oH+/6H+RAIJN5JcyecchC2478JTd/lzRXn+8=;
        b=qs/BWoBz8Cf2znWf91IJwaUxrXhsy37HERg0VjHm9eQtgpyJQdqjXTqZ0BQhLj4t5x
         lyuIPTnbcEFqzfa9iGzl2cs9XyzQTHfTt7u+lvVPUB3EsQc194I5v+RJnJhmFxLfITYv
         XX+PNqC+hx8gSh/Fy72vAiEfks68oR8p70MANEGis9x7IL732AeQoEZk9vM75t1jnDRi
         0u90e3taHDJ6HokW7dhC0epwAWN6l2HYA0tBV/lRB8Sjumge06Dv9Qy6S2Zy8NqSQrKF
         ZOjBWdgCJwRkQp+ZlbiabjdsyHwVvhc/nWOf/u3F5jQT5CrTJk3iteaSp8CpEY39TAgM
         MXUw==
X-Forwarded-Encrypted: i=1; AJvYcCV4uYQT/HA1JDhRO5YzGya1MeKpx4L/7RcV+zHjRNJ/ro/xhPJW2/N6sLXCjOpQ4fVbdzt2Dp8fjo6L@vger.kernel.org, AJvYcCWJXb6nuaWEfblhzuHuo0Dvzd6Utq0zkaRrCP6enSdBPgQ3tTaQ6cOY0ML55QPaks2VoO8gWKYzX457@vger.kernel.org, AJvYcCXQvq8gDUsrzZHB4QQHe3oY60MDnxkALK8J9QDSKHqOKN2E0sarGc3WCu4AmNFjpnObNSXBG9tMuU8nBoXL@vger.kernel.org
X-Gm-Message-State: AOJu0Yygvgdve+LAVSR2ivG/fBXU5D/NxjizpbFzBf0MnvXCNH+1IB8+
	RTD8E5ltCX/hVrpFVgQG5tQ9EZbpLfgAOQXfoL92lfGCesUHvGqj
X-Google-Smtp-Source: AGHT+IHlmPMhYFA/1JwECTX9lRz4YGienXe2XSehw/xBGz/6Mtvd7mIdvA1vsaht0gA/54QHizdnxQ==
X-Received: by 2002:a05:6000:c52:b0:36d:2941:d531 with SMTP id ffacd0b85a97d-372fd7013a0mr1846525f8f.44.1724263759586;
        Wed, 21 Aug 2024 11:09:19 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-209-141.retail.telecomitalia.it. [87.1.209.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aab44sm16293072f8f.91.2024.08.21.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:09:19 -0700 (PDT)
Message-ID: <66c62d4f.df0a0220.3305f1.f86c@mx.google.com>
X-Google-Original-Message-ID: <ZsUTX0MBt07_EKPA@Ansuel-XPS.>
Date: Wed, 21 Aug 2024 00:06:23 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
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
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions
 node in mmc-card node
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-4-ansuelsmth@gmail.com>
 <20240813200734.GA1659224-robh@kernel.org>
 <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
 <CAPDyKFq0cR10d1jUc5gnoUR5P=cbDEZy2iA-HOq9oNcWZevbDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq0cR10d1jUc5gnoUR5P=cbDEZy2iA-HOq9oNcWZevbDg@mail.gmail.com>

On Wed, Aug 21, 2024 at 03:14:29PM +0200, Ulf Hansson wrote:
> On Wed, 21 Aug 2024 at 11:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> > > On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> > > > Add property for defining partitions node in mmc-card node to define
> > > > partitions in DT by the use of the block2mtd module to use block
> > > > devices as MTD.
> > >
> > > You justified patch 1 saying eMMC already supported this, but then here
> > > you add support.
> > >
> > > Both are a NAK for me as both already have a way to describe partitions
> > > with GPT.
> > >
> >
> > I think this got a bit confused and hope we can find a way to add
> > support for this.
> >
> > What is "already supported" is assigning an OF node so driver can
> > reference it. This patch was just adding the nodes in the schema to say
> > that partitions can be defined.
> >
> > I think what is not clear is that block devices might be used as raw
> > devices without a partition table defined in the device. In such case
> > it's the kernel that define a fixed partition table.
> >
> > One example is [1] where the partition table is provided by cmdline.
> > Similar to cmdlinepart MTD parser.
> >
> > The use of block2mtd is just to make use of the MTD parser system.
> >
> > Considering
> > - eMMC is soldered to the device (no dynamic scan)
> > - cmdline might be not tunable and hardcoding it might also be
> >   problematic (as some cmdline needs to be used)
> > - concept of fixed partition for block device is already a thing and
> >   used a lot (android AFAIK)
> 
> Sorry for sidestepping your discussion, but I just wanted to add a few comments.
> 
> It's not clear to me why we need something different than what we
> already have today.

It's really adding a missing feature. We have cmdline but we don't have
DT. And in emebedded many times cmdline can't be changed.

> 
> If it's a partuuid/uuid/label or a fixed block-partition from the
> command line, we still need to know what partition we shall use for
> what. So why is this problem different from how we manage filesystem
> mounts, for example?

In the context of eMMC there isn't any partition table and the cmdline
is hardcoded by the bootloader. The cmdline might provide the root
partition to use but doesn't declare the partition table (with cmdline)

And the bootloader with the hardcoded cmdline might provide a different
root partition in dual-boot-partition implementation on switching the
boot partition. (this is used a lot with bootloader using a env variable
and a different cmdline passed based on the variable to signal what
partition to use for root)

> 
> >
> > I think it should be acceptable to introduce in DT support for defining
> > fixed partition for block devices and some kind of parser system similar
> > to MTD. What do you think? Would this be more acceptable? Idea is to
> > just have a DT schema that makes use of the values that can be set in
> > [1].
> 
> In DT we can describe that there is an eMMC card soldered to the
> board, because it's a description of the HW. But describing what
> stored inside the eMMC-flash doesn't belong in DT.
> 

Why? This conflicts with how it's done on MTD. Also consider the fact
that eMMC might contain calibration partition used for NVMEM.

Describing fixed partition on a soldered eMMC that the bootloader
expects at a fixed offset and won't ever change (or it will result in a
brick) sounds like describing the HW to me. (it's the same principle of
MTD just applied to block devices)

(I know it sound strange as block devices are expected to have a
partition table in MBR or GPT but reality is that it's not always the
case)

> >
> > Hope we can find a solution to this, I'm totally OK for dropping NVMe as
> > I understand it's PCIe stuff and very dynamic but OEM are making lots of
> > use of eMMC and are starting to use these strange way (block2mtd) as we
> > currently don't give a proper and easy solution for the task.
> 
> I certainly appreciate that you are trying to solve the fragmentation
> issue around this, but it looks like we need a different approach than
> using DT to describe partitions.
> 

Well it's either DT that can be tweaked and is part of the image or
cmdline that have tons of limitation due to bootloader having fun
hardcoding it or also actually requiring the bootloader cmdline and
adding overlay on it. Honestly as I said adding DT support is really
compleating the feature of the cmdline implementation.

> >
> > [1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmdline-partition.rst
> >
> 
> Kind regards
> Uffe

-- 
	Ansuel
