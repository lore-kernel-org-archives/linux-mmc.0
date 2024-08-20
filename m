Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D51B2EF8;
	Wed, 21 Aug 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263144; cv=none; b=by/PxSZrjl6uVd0NkXMlCCnPSjZL3fK33w4bQMMRYE0CRLzV8Wd2C83O4rH1lWmZCJ9+VnCQN3S+SgGl+mEQ0FeKv7ogrRMVQ9DZrCGX5SIwt4btkxAPmF4AHayDoP5AZl7Mrduk7OEK1fgom5tE93DPS8nGWwIskt5l3PusJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263144; c=relaxed/simple;
	bh=dyRA1jq9Zv01X8oTa22rjJUibpU5DPyhXBcZFEmyuRs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvUDGpI+h54AwugqEWLwp/AXxZp2KiXZ1MTnwkCUPtj4A6ifOGTsQRTi6my/CoLcL5CeL8o7ft89GmOKYiP8Oj6sJE/OcsnoaRrYrFfcQZsXrFtMvCk8sRIvB4qAa96RaRuN4i6GqBWBt0oTfBF915k4zJ+zdtJX+GN55rzoBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePWKVEhe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePWKVEhe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so50584115e9.2;
        Wed, 21 Aug 2024 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724263141; x=1724867941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOD5WjK75PEA5fwbhiWZMV4CDw+nr+tptFdJXihO9UE=;
        b=ePWKVEhe/Ljau4oiGirt1KwxfferUwHXFrCIB7qhBIJNA5brXgMNjnQ7M6snOVYMWS
         JlaBUA4f9h32oHjGDybomEq7uySFDJLqFG9ezqfqTdGqXgMcOnfjKymgq2t9E0kG0d9x
         sTr6i1cEcP5ieQHBU/fjULW4dUk8HbvxcZDrwuOORej8bcDBWaGI/3BMeTZ67OyL9ppK
         CjvJlXlmWRK2QbQsPRpwRC5pXUiUvsl93L/zrfZdnmOGmMIY4Hx4M6kxneTdscib4EMQ
         wX4AmgcNNIXv/HzE96sAdW4yxbj2xsnsDGpuneRie23VhVE8FgKc2wZqiJxCfaSHCCqC
         oNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263141; x=1724867941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOD5WjK75PEA5fwbhiWZMV4CDw+nr+tptFdJXihO9UE=;
        b=UYdBnUBwkVVWiCkIBp093ccFYi+0MqBW9AuUn5sM5CFoSUWoa07bEGlxyt5buWNO5h
         qgHLQf8MLBY2FMnAqD8GCIPZCKVCgxo9/hw6dx+RWt0v8vYKSgsKHLTYqiEMnuxcFsxy
         LaAbVshgtRFZxFQ+N5Ky2VAKu167l4FOk87m4jhv1ILOt8tYUz7nAAvkQSDb3Y++O2GE
         R+aAQmL17lnKQPssWhJjVxF/SGxM1gUvsEAyx3wrD0R2ttmaA1uw64aiPb+zvqjQ+9Yk
         6JVqgE4Nr1qP8Vu6eSt/qg/XUOKkAFtv5dy6gH8yHtj56Zmo/BlcFwbD2Js4GKa+rlHu
         VCuw==
X-Forwarded-Encrypted: i=1; AJvYcCUrm9rWWhwBvL5A30wO7AdW6WDMeIJyJ03XZgMv5ntqOw61SwZOwglEi5mHUScbMtW/dtxw1pmx9bDi@vger.kernel.org, AJvYcCW4pf7D3bK4pnym2Wbz8TuGDjEgRsnAtLjDFZHSmOA2BD5ZuRaXyiYa2tUFFdiWrB1RR48jUs7GAb2Eg8O9@vger.kernel.org, AJvYcCXZ1ZY2CYvBwGuoM33aFOmhT8B4Of5r/g/xTUegSexTZps+/+67U7TDDRKTkjo9suJSC8UXgTDfRAAv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2awE3x4WuM58937o45bpVmdT/FutaCPdr/ion8WdkX3SFu8cc
	7MnxvOdkqE7/L8WINzYZmsV8oAufB3Xtmu5SzuuChNirjv0uK3h6
X-Google-Smtp-Source: AGHT+IEwkWw5dB6NoT1uzj+jGodXrd2ZHv9kY+EwOC9MkKKnONqtqhgL6b91WJgkEX4JHEbGx1Tg9g==
X-Received: by 2002:a5d:4ac7:0:b0:367:4dbb:ed51 with SMTP id ffacd0b85a97d-372fd4cab05mr2238221f8f.0.1724263140422;
        Wed, 21 Aug 2024 10:59:00 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-209-141.retail.telecomitalia.it. [87.1.209.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeba89a5sm34619255e9.0.2024.08.21.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:58:59 -0700 (PDT)
Message-ID: <66c62ae3.050a0220.2344f.a560@mx.google.com>
X-Google-Original-Message-ID: <ZsUQwPuprky6nVl1@Ansuel-XPS.>
Date: Tue, 20 Aug 2024 23:55:12 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions
 node in mmc-card node
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-4-ansuelsmth@gmail.com>
 <20240813200734.GA1659224-robh@kernel.org>
 <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
 <20240821151249.294590ec@xps-13>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821151249.294590ec@xps-13>

On Wed, Aug 21, 2024 at 03:12:49PM +0200, Miquel Raynal wrote:
> Hi Christian,
> 
> ansuelsmth@gmail.com wrote on Tue, 20 Aug 2024 22:20:59 +0200:
> 
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
> > 
> > I think it should be acceptable to introduce in DT support for defining
> > fixed partition for block devices and some kind of parser system similar
> > to MTD. What do you think? Would this be more acceptable? Idea is to
> > just have a DT schema that makes use of the values that can be set in
> > [1].
> > 
> > Hope we can find a solution to this, I'm totally OK for dropping NVMe as
> > I understand it's PCIe stuff and very dynamic but OEM are making lots of
> > use of eMMC and are starting to use these strange way (block2mtd) as we
> > currently don't give a proper and easy solution for the task.
> 
> Thanks for the summary. I believe I now have a better understanding of
> what you want to do, but I am still convinced you should not abuse the
> mtd layer for that. If blocks can be partitioned based on the cmdline
> (or from the DT) then the partitioning logic should be specific to
> the block layer. However, the parsing logic is probably very similar
> and could be extracted into a lib/, provided that the mtd bits are
> moved away cleverly. You only need the fixed parser anyway, and you
> probably don't want all the weird corner cases we keep supporting for
> backward compatibility reasons.
>

Yes I also agree abusing MTD layer for this is wrong and I also love
introducing and actually "stabilize" support for fixed-partitions for
block devices. So what it needs to be done is creating support in DT.
(interesting that cmdline is supported but nobody cared of adding
support in DT as that opens to lots of possibilities and is generally
better)

Yes I will check how the current fixed-partition parser for MTD can be
generalized and moved to MTD. In theory the DT schema should be the
same. (it's just offset, label and size after all)

> > [1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmdline-partition.rst
> > 
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
> > > >  1 file changed, 40 insertions(+)  
> > 
> 
> Thanks,
> Miquèl

-- 
	Ansuel
