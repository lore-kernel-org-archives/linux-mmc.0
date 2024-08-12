Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891517ADEB;
	Mon, 12 Aug 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469495; cv=none; b=fouzwc/3zIq4XAxGF9SUWZoXZJ13/pkzFoBXUjmpDOAseAfuRi02QiVR2P9rTggbp2e1YV94akXGw5P5qvhMKbUD1bVMOKTXThkydylRcX4pryK9A2Td7+1HWUibVwsSm1Z03arV9qlESSkzZG+SQK2VGWxJya8Ka9d8IUbt3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469495; c=relaxed/simple;
	bh=NOfZgeKAoiDqZ+R6zC5/7VaLnLVQMMzuVKrH+srwhu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVhnZck++p3rpX1FyLqfScF+AW9Umn/ajeubWWVDzcB+SRem0eCUAA65uo4Io1jmeLsIU2oGQpTgiTZ3RnzbWbqXbr6VEDkn4C834yeEwVMPICmxTo0DP7Kr7D0plEvR/SPGHscoLHLznhrPd2k8cXTF+c4L0eOIdfWdQVkKtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F38168AA6; Mon, 12 Aug 2024 15:31:28 +0200 (CEST)
Date: Mon, 12 Aug 2024 15:31:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/7] nvme: assign of_node to nvme device
Message-ID: <20240812133128.GA24058@lst.de>
References: <20240809172106.25892-1-ansuelsmth@gmail.com> <20240809172106.25892-3-ansuelsmth@gmail.com> <20240812111205.GC14300@lst.de> <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 12, 2024 at 02:10:28PM +0200, Christian Marangi wrote:
> The chosen name was arbritrary just to follow eMMC ones. Can totally
> change if problematic.

NVMe namespaces are dynamic and can be created and deleted at will
at runtime.  I just don't see how they would even fit into OF
concepts.

There is a huge impedance mismatch here, to the point where I completely
fail to understand what you are trying to do.

> But support of OF for PCIe is already a thing for a long time. (it all
> works by setting the compatible of the PCIe ID card) and used in wifi
> card at assign MAC address, calibration data, disable frequency.

Please point to a document describing how, but more importantly why
this is done.  I've worked with and maintained Linux PCI(e) drivers for
about 20 years and never seen it.  And the concept simply doesn't make
sense in terms of a dynamically probed bus.

> Not having this well organized and consistent schema in DT will result
> in additional condition in the drivers...

NVMe Controllers are PCI functions (or virtual entities over the network).
Defining them in a static DT scheme does not make sense.  NVMe Namespaces
which are what contains the block data are dynamically discoverred and
can be created and deleted at runtime, so refering to them in DT is even
more broken.  I really don't see how any of this could remotely work.

> If these 2 patch are problematic I can totally drop from the series but
> it was really to add consistency in NVMe and eMMC. The real important
> part is eMMC that is becoming the de-facto replacement for NAND/NOR on
> high tier devices (mostly wifi6/7 consumer router)

If you aren't dealing with raw(ish) NAND don't use mtd.  MTD is designed
to deal with the nitty gritty details of NOR and NAND flash.  If you
already have an FTL running in the device there is absolutely no reason
to use it.
