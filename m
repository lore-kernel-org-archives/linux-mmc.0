Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7E47A66;
	Tue,  6 Aug 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958784; cv=none; b=eD0DqeTrIqAaQciijBY0N3mmwYuj8EyRHaNU3CsQobjvA9CUG9WWX0/S5iaV2biWfcGdGgMOjcIMlb6R8WRVDmAPCpvgWSlHWa4QbC8F1PJ02f/cYh733tXoI+kS3Jj5LilLBCfZYhGO3TXN4q3g4wDjh3jyymX2sH378rYA7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958784; c=relaxed/simple;
	bh=b7ozdsbwfMXW21Tyt4Tt33Hq8k141H7HbyANf37oXi0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Exu/7ZxuqQ50IVqnX8ulsJO0jY9g1patois89mH9Nw5tp7l5cEV+KJz/q1d4zd+NpV+DIn09g5ICvScnUBgFW0wo48mO3ts4E1OyH0MUZ6BJrKWQAZvR7CXoSI7lhwJIVctWkhRIq+oKsivU3C9afaS8/W59pMsnyZHmZqSRHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VfEMfp9v; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VfEMfp9v"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722958773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Chn8ymlqazavJ1DZmXPdLBrye9DBk3cugxlezlxhvc=;
	b=VfEMfp9veTf9vofJGHvARhjKJLQWxXoE6CZ4ZfPJBcyubeBt6RFYznvEmk0qhNLGaLcWIZ
	V4ZVilXZpCU9C/H3Fj/ysZ/XgET0TF1ZDcxMeq8V3CyxyQdsNk7NIj2fbogg2t01z7WsLv
	wvZqgRJCniv7XWLsHstRuSCgMls15R5RXpdkYXYEbuirc0/HNhXfXfbC+UTQp1+RTHuNyc
	HQCGgdhhrNGrjo/ZN4a8er9JdyzG+eHz0KiwhMuHq/wV0VtW6AozR7DoRbDrDnLY5G34gi
	SGgRl+hV/9eqi04hVkBzZk6CNzURj7hKvvnqvMopGb0w7ymNHesO9/LnmyrCtw==
Date: Tue, 06 Aug 2024 17:39:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg
 <sagi@grimberg.me>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
In-Reply-To: <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-3-ansuelsmth@gmail.com>
 <20240806124312.GB10156@lst.de>
 <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
Message-ID: <ceab3813dad635387e9f216203292fbe@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-08-06 15:03, Christian Marangi wrote:
> On Tue, Aug 06, 2024 at 02:43:12PM +0200, Christoph Hellwig wrote:
>> On Tue, Aug 06, 2024 at 01:41:12PM +0200, Christian Marangi wrote:
>> > Introduce support for a dedicated node for a nvme card. This will be a
>> > subnode of the nvme controller node that will have the "nvme-card"
>> > compatible.
>> >
>> > This follow a similar implementation done for mmc where the specific mmc
>> > card have a dedicated of_node.
>> >
>> > This can be used for scenario where block2mtd module is used to declare
>> > partition in DT and block2mtd is called on the root block of the nvme
>> > card, permitting the usage of fixed-partition parser or alternative
>> > ones.
>> 
>> Err, hell no.  Why would you wire up a purely PCIe device to OF?
>> PCIe is self-discovering.
>> 
> 
> Well on embedded pure PCIe card most of the time are not a thing...
> Unless it's an enterprise product, everything is integrated in the pcb
> and not detachable for cost saving measure or also if the thing use 
> PCIe
> protocol but it tighlty coupled with the SoC.
> 
> This implementation is already very common for all kind of pcie devices
> like wireless card, gpio expander that are integrated in the PCB and
> require property in DT like calibration data, quirks or GPIO pin
> definitions, i2c...
> 
> In modern SoC we are seeing an influx of using cheap flash storage
> option instead of NAND or NOR as modern hw require more space and price
> increase is not that high... Almost any high tier device is switching 
> to
> using emmc and even attached NVME and simulating MTD with them for easy
> usage.
> 
> Please consider this well used scenario in emebedded where PCIe is just
> a comunication way and the concept of detachable doesn't exist at all
> and things can be described in DT as static. Also these storage are 
> used
> for rootfs mount so userspace is not so viable.

As a note, perhaps this is another good example of a "fixed layout"
PCIe device found on an SBC:

https://lore.kernel.org/linux-rockchip/20240805073425.3492078-1-jacobe.zang@wesion.com/T/#u
