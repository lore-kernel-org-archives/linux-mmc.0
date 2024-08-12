Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC616F907;
	Mon, 12 Aug 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461133; cv=none; b=pi4/IpvsaH+oP/c6hET8VcejYYC4qczmL8lyqEa3/5LawpxZEVCG/WrVWK0AvlCXpiZ/6b72Uu81rbfkMtRFiOwRkm21dQC8O5IUQwvWz6w3AAwDldwzlZ/K08hYjr6raLzqJTs4P8yhBWv1fPBwhkcfPBm8emXwOjv9k9AaiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461133; c=relaxed/simple;
	bh=lTkO43XlXsBUfQhW+gAh0hVjdpjqZL7wA1jPRyBW4ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh6bmtnSnB/01XSmwzpqJPocNIdmgD4u7EG9IIhiD+MQj4OuXSKfg4UkfcqyBfkunmey7azbuCRXPz4IbJCaHF3F2VwSVXZetIsT9x93O+wdXyQ/CJyuPYKge7vYECl+cqF9Kb8ce4DrkJu/KN0PKqF5kF4WAgKYNqIvLUH75ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C778B68AFE; Mon, 12 Aug 2024 13:12:05 +0200 (CEST)
Date: Mon, 12 Aug 2024 13:12:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v4 2/7] nvme: assign of_node to nvme device
Message-ID: <20240812111205.GC14300@lst.de>
References: <20240809172106.25892-1-ansuelsmth@gmail.com> <20240809172106.25892-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172106.25892-3-ansuelsmth@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 09, 2024 at 07:21:00PM +0200, Christian Marangi wrote:
> Introduce support for a dedicated node for a nvme card. This will be a
> subnode of the nvme controller node that will have the "nvme-card"
> compatible.

FYI, there really is no such thing as an NVMe card.  There is an
NVMe Namespace, which is the entity that contains the block data,
the Controller which corresponds to the pci_dev for NVMe-PCIe, and
the NVMe Subsystem, which contains Controllers and Namespaces.

> This follow a similar implementation done for mmc where the specific mmc
> card have a dedicated of_node.

That's not a good explanation to be honest.  Most eMMC host controllers
are OF probed devices, so of course they'll have an of_node.

Binding PCIe functions to of_nodes seems completely weird to me, and
you'll need to explain what this totally non-obvious thing makes sense.
Maybe it does, but it needs to be backed up with a very good rationale
that is very clearly documented.

