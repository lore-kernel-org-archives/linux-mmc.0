Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB73C092;
	Tue,  6 Aug 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948152; cv=none; b=f9crhqhJ7EXhkOkCt5LoxZ/131pq1Xk0eHGEE7EVX8CxL8xFQUoL0rNw2iGByXmcY2/Hk1pNLWyc7wOutTM+x8jl1x61eV95JW2CQor/HD7hopU3Q9QUiAQbAqM98Ges0JPSJZN7kA9c77pYiumg963bInNPlMg93Mk9XCGkOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948152; c=relaxed/simple;
	bh=UvFAaD7XWQCz5+Y+Ouj+T+Tb4CVsSxOr22ZJmNPkMmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nucs1UJPzCGZMHoEkWqyeIHOpwTl1UVOkxQpqhb129fKzvRNsxnHBWCoGg6U1h97fr4j62QuC6MUn9otJ0YRvg7e8EosCppy+ojCf3TrDNPtw7+Cu2GumVFc/OCek+gd7O4GKrmoH+BYEws7G32Bdbkc72oH8u6AdUBUJq+BGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5887E68D05; Tue,  6 Aug 2024 14:42:25 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:42:24 +0200
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
Message-ID: <20240806124224.GA10156@lst.de>
References: <20240806114118.17198-1-ansuelsmth@gmail.com> <20240806114118.17198-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806114118.17198-2-ansuelsmth@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 06, 2024 at 01:41:11PM +0200, Christian Marangi wrote:
> Document new nvme-card compatible to permit defining fixed-partition in
> DT by the use of the block2mtd module to use block devices as MTD.
 
What does nvme card mean?  Is this about nvmem or nvme?  If this is nvme,
are you talking about nvme-pci?  Why would that needs a device binding
when it is a PCI device?

