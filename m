Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399453C092;
	Tue,  6 Aug 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948198; cv=none; b=GhLX0hqYO4J0Q/vzl3dkT0ZSvef6uC/FWaynOhqvc+ZYXUtr56brLqoEgw3eUgbcO3QA2AmEJI9BKKVJMGjx8eHsPG6H6W3B9mgi9xnJ5Sa7GffabvxKDhwjQ0z1RBsKMmly6expB8To/zzw6wKiXGK+KO57dV7P/XpF66LjqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948198; c=relaxed/simple;
	bh=Jxs95WxqTOTbej/MC/EE2Y/4qbnLFWKRijb6jexAO6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNC5QN3FQwA1lgLGXbLUnCAIImHHTs77EekBMeN26LC0cOdRB+3VaI7s0mn1EXmh9u0O5q8gf4Ia5UpTAaBkxC+sVyBAc1UH6Kj6Cu9GMbP2e0JQemlzDHWJ8EHGvAZdsvJ5lgwFS/RCp/+nZEfGBG5j/mrUjrZ7Zoy9ABotiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8173668D09; Tue,  6 Aug 2024 14:43:12 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:43:12 +0200
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
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
Message-ID: <20240806124312.GB10156@lst.de>
References: <20240806114118.17198-1-ansuelsmth@gmail.com> <20240806114118.17198-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806114118.17198-3-ansuelsmth@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 06, 2024 at 01:41:12PM +0200, Christian Marangi wrote:
> Introduce support for a dedicated node for a nvme card. This will be a
> subnode of the nvme controller node that will have the "nvme-card"
> compatible.
> 
> This follow a similar implementation done for mmc where the specific mmc
> card have a dedicated of_node.
> 
> This can be used for scenario where block2mtd module is used to declare
> partition in DT and block2mtd is called on the root block of the nvme
> card, permitting the usage of fixed-partition parser or alternative
> ones.

Err, hell no.  Why would you wire up a purely PCIe device to OF?
PCIe is self-discovering.

