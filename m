Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0A2E416;
	Tue, 13 Aug 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579449; cv=none; b=SqqxhL7XW1X4kd8sUxBvTdbXvvHhwoQHIdBUKoJM1ptkQE2DJ1ruIqvYwv2Lu71CWs/ApauP6ViE3zOxCSb7/40EnRF+FR/zNJMu6ZkbVDGaT+gE+u1bxliRaIdPWrR4m/hD+lm8pAE2lnroxkb2SU3dDbYSbGN6mtKgAWDAkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579449; c=relaxed/simple;
	bh=UFOl4J9OOLeA/avOTNcqCYZZ/CpgemOJRd4RI2dE8NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czM2q5qzycUtLQnt9apym5pNGwLSifteI75ALia+n0gW/YCnASUwivdGisXeYk9RBcf+7L/+b4FCk0Z8G+7vM3loXA4Bym06xwFcB9vLt4gXLdA+2CBxfx0lJhVw9tozXawBpN3L9zs71sGL/wPhZIXmC5XZpPJvC7A9pUYGhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGcqusiR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGcqusiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEC0C32782;
	Tue, 13 Aug 2024 20:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723579449;
	bh=UFOl4J9OOLeA/avOTNcqCYZZ/CpgemOJRd4RI2dE8NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGcqusiRlC9deLr9QYPYiRhUvn4t2H3EU5OEktIDyF1qvFlcxrdD4vg+aoYIu76S/
	 WoBa1P6pMfqFoGhFbli9mxU63c/X2+p36akcstBb6nxeWI7r7sLDS+LzNV8FTQ24Z3
	 /6Yfge4f6Qd16eDjFHKPgzicqpetK8dh07WG4iAts8JSjiFtlZfWdI3eb420063oJJ
	 ZLjwylNw7SGP0cLllOjHDGGgEipimoFI/CYIYl1zkMfgsXeA8Pvf/iPLw1YG8FJ6m4
	 EAy6xNsGPcOVRfPaJPy58zCzt5RcBd9CeBc0HFYUGoligaYaP2NWAXcX/kvbSIdbak
	 +vzKfGqjh/+bA==
Date: Tue, 13 Aug 2024 14:04:07 -0600
From: Rob Herring <robh@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
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
Message-ID: <20240813200407.GA1634759-robh@kernel.org>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-3-ansuelsmth@gmail.com>
 <20240812111205.GC14300@lst.de>
 <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
 <20240812133128.GA24058@lst.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812133128.GA24058@lst.de>

On Mon, Aug 12, 2024 at 03:31:28PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 12, 2024 at 02:10:28PM +0200, Christian Marangi wrote:
> > The chosen name was arbritrary just to follow eMMC ones. Can totally
> > change if problematic.

The purpose of those eMMC nodes was to describe various non-standard 
stuff you get when discoverable devices get soldered on a board. Power 
rails, reset GPIOs, etc. It was not to put partition info there, but I 
suppose having the node opens it to such abuse.

> 
> NVMe namespaces are dynamic and can be created and deleted at will
> at runtime.  I just don't see how they would even fit into OF
> concepts.
> 
> There is a huge impedance mismatch here, to the point where I completely
> fail to understand what you are trying to do.
> 
> > But support of OF for PCIe is already a thing for a long time. (it all
> > works by setting the compatible of the PCIe ID card) and used in wifi
> > card at assign MAC address, calibration data, disable frequency.
> 
> Please point to a document describing how, but more importantly why
> this is done.  I've worked with and maintained Linux PCI(e) drivers for
> about 20 years and never seen it.  And the concept simply doesn't make
> sense in terms of a dynamically probed bus.

With OpenFirmware systems, the firmware will probe PCI and populate 
nodes with what it discovered and with how it configured things. IBM 
PSeries uses DT for PCI hotplug as well, AIUI.

For Flattened DT, PCI devices are typically only present if there are 
extra non-discoverable things (again, happens when devices are soldered 
down and not in standard slots). Another example is a NIC where they 
cheaped out and didn't put an EEPROM to store the MAC address, so you 
store it in the DT. Now we're starting to see non-discoverable things 
sitting behind PCI devices, so we need the PCI device in DT to describe 
those downstream devices.

> > Not having this well organized and consistent schema in DT will result
> > in additional condition in the drivers...
> 
> NVMe Controllers are PCI functions (or virtual entities over the network).
> Defining them in a static DT scheme does not make sense.  NVMe Namespaces
> which are what contains the block data are dynamically discoverred and
> can be created and deleted at runtime, so refering to them in DT is even
> more broken.  I really don't see how any of this could remotely work.
> 
> > If these 2 patch are problematic I can totally drop from the series but
> > it was really to add consistency in NVMe and eMMC. The real important
> > part is eMMC that is becoming the de-facto replacement for NAND/NOR on
> > high tier devices (mostly wifi6/7 consumer router)
> 
> If you aren't dealing with raw(ish) NAND don't use mtd.  MTD is designed
> to deal with the nitty gritty details of NOR and NAND flash.  If you
> already have an FTL running in the device there is absolutely no reason
> to use it.

Yes, agreed.

Rob
