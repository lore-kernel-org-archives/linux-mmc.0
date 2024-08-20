Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BED209746;
	Wed, 21 Aug 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233969; cv=none; b=Bj6RKmudI2XGkVJ0913n/zNiS18tV65dPlqqaA0Einp4Lw6jkwXStNVItGqA9M85rL0ejCvMis96grXa3xWGBOgbjYZrjKVbG+uJC2pPRtoClPoZPfCbX24VO6tfltkanDSm4bN70ec/nfc2na/YHlsMsflpJTM6sd9K7stbCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233969; c=relaxed/simple;
	bh=JdEMT7lY6TmTa1wl8ZbqGL7+iY0+jlLlU77IumvbwgM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlV4usLk+GRQH+QtAGo8ek4xbhHw88KfF+oyQxX87WSSZRRiATJY7KJb0L4BHxvkzch0gionH3Yj8fiiz7tlavYqdQ45LSHvugzj52FJu78RlRVo6m+TXscTsuOvZntO5z/a/ZJvbaBzaBVV/9hH3IGBedAo+3chASfCLA365Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+9K4F2q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+9K4F2q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42808071810so52464425e9.1;
        Wed, 21 Aug 2024 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724233966; x=1724838766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NnOrzKMcyDUoMSvS/S7wX/qCak1X+CvKtxdgt9KzAEE=;
        b=e+9K4F2q6LKyMYOOIPNv/E8YGLIWdCI3BNp2vtRTJP/TCWAfoZkE2dX65cZ+V66drq
         bXt7Sh/q1Xt8O5PuFnbeagMRVvuCjJxtgC7bGiLtHtRBKVl58Snf+qiR/lm+3oII9oFh
         WbnqRA3lDNcUQwIf4Jf1mpsqyUtt9/czkLlmNBu3l02PoD7KDn/eLaUoskchQjprrVVf
         o54UbO+I473+nUlaAkM5qsHDoMRQc8KbrVCuUUTyBz7wT1ynPl1dnfU47mezWla4U0xL
         g256pgyg7zU8sHTVVW0Gf7xPwj1PwX+yEopN1yz3HHuDLGlwViCiqF1DvPm74pjnECQJ
         1qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233966; x=1724838766;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnOrzKMcyDUoMSvS/S7wX/qCak1X+CvKtxdgt9KzAEE=;
        b=JnvXhNk4Yb7jEkV5j9fP+ePI/PXe7cegcoPUURc/REXSz75FUMXqXnwz5Xrwd26j+/
         giHx8kUyB+8VVAWwzv3ZIUltBp4TIMsjm7Jky5QaoMyGiLvfmv8ieDTjDLRpon611wsH
         x9KCvF4VGr6SmUqSQ8OKhVvSBsTqVTb0yQ9oTDQGzz6a1CSioP4Ivzoa0ryCaVjUuLj3
         99vh/hSQ67HWP/iOEUfnheYGHIazuUODA4tZgEEWsBUEMKi2JcDFqNxT5O03PQKBfhkR
         0Apnw3pri/NOajl0MCOKsgJAiSso7J0CtEZTxgw0LuvnDNUDvql1F36/kGn0ls3C/kry
         eaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZvTDyNSBR5hx/e5I+J4//DKKyTxy9hqKLjmrxaCZoUfgHIUVkbSyJuMtdu9tDHzl6vUPpwZ850Zjb@vger.kernel.org, AJvYcCXVIgNn0YfAOW3e1mB5z3jsov7Z9GPxQdDhEO7+KRlJwPRIakkfqqpmSrkoTkoS6wuzdx1gk8swHsQOVNoU@vger.kernel.org, AJvYcCXXWAIRqFFes7s+rNvZBgtrk6j2EszRfxIWN4CBhFUiLfHKrW8X20Bbo/TKGDU86G8UQFfvQkEsa5e8@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1cAcWCGYvswjXXEXNiYf61RkGUYY0DHHR3pvw3dx3mTddtu/
	88GNOWfcZ1wuxVIRFIdTKriSUTGHokJKbWvfIhWni/H6oKJk4MuL
X-Google-Smtp-Source: AGHT+IF+o52couZdaHJEJsihSkCGmNimy0lgypKHwcww3KpUeXlqaH0DcS+QnsEyqQhvoHcsbtMK6A==
X-Received: by 2002:a5d:4e91:0:b0:371:8d9d:d824 with SMTP id ffacd0b85a97d-372fd4d0932mr1175077f8f.0.1724233965429;
        Wed, 21 Aug 2024 02:52:45 -0700 (PDT)
Received: from Ansuel-XPS. ([109.52.145.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2e2sm15236412f8f.16.2024.08.21.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:52:44 -0700 (PDT)
Message-ID: <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
X-Google-Original-Message-ID: <ZsT6q4_ULOc5aPv8@Ansuel-XPS.>
Date: Tue, 20 Aug 2024 22:20:59 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813200734.GA1659224-robh@kernel.org>

On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> > Add property for defining partitions node in mmc-card node to define
> > partitions in DT by the use of the block2mtd module to use block
> > devices as MTD.
> 
> You justified patch 1 saying eMMC already supported this, but then here 
> you add support.
> 
> Both are a NAK for me as both already have a way to describe partitions 
> with GPT.
>

I think this got a bit confused and hope we can find a way to add
support for this.

What is "already supported" is assigning an OF node so driver can
reference it. This patch was just adding the nodes in the schema to say
that partitions can be defined.

I think what is not clear is that block devices might be used as raw
devices without a partition table defined in the device. In such case
it's the kernel that define a fixed partition table.

One example is [1] where the partition table is provided by cmdline.
Similar to cmdlinepart MTD parser.

The use of block2mtd is just to make use of the MTD parser system.

Considering
- eMMC is soldered to the device (no dynamic scan)
- cmdline might be not tunable and hardcoding it might also be
  problematic (as some cmdline needs to be used)
- concept of fixed partition for block device is already a thing and
  used a lot (android AFAIK)

I think it should be acceptable to introduce in DT support for defining
fixed partition for block devices and some kind of parser system similar
to MTD. What do you think? Would this be more acceptable? Idea is to
just have a DT schema that makes use of the values that can be set in
[1].

Hope we can find a solution to this, I'm totally OK for dropping NVMe as
I understand it's PCIe stuff and very dynamic but OEM are making lots of
use of eMMC and are starting to use these strange way (block2mtd) as we
currently don't give a proper and easy solution for the task.

[1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmdline-partition.rst

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)

-- 
	Ansuel
