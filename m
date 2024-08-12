Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF8178378;
	Mon, 12 Aug 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469132; cv=none; b=Z5Rm5GWgdLA5OA/NuyJv0EWbwYypAQ5NeEgrYW/q76O2rHM4i0SZkbwI9mF5J4/qId8l8iyShuIhiLzgGExz770765TRE9QPRuxD78FeO+suD0gCTepA67TCQcygnFWX84bflXfrUhBTTEGe51MZdcNBqmlupcpBGV3r3XFJdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469132; c=relaxed/simple;
	bh=Kdy9J9Umq3Vxa7sxz5VvOjRZRG5HLxQzbAY1KaBp0aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUdv3BOvHL/578nkmC4P+kSlufYmtCWhxHVUrIDaxdQuS0VH7X1XwqkvbGAypGcLjsEzw9sIxSpucqS3OybrL6NNKceCxNXtPjACQI5Nx3ITxHe+2dmRVOxhml7Tu4ngQt5LrVmfnRWjJZK4d+kHVsMh4ro7W7Chn7uTAXC/6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5AA6268AA6; Mon, 12 Aug 2024 15:25:27 +0200 (CEST)
Date: Mon, 12 Aug 2024 15:25:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
Message-ID: <20240812132527.GB23655@lst.de>
References: <20240809172106.25892-1-ansuelsmth@gmail.com> <20240812104954.1e8d55f7@xps-13> <66b9df7c.050a0220.3574aa.d5bb@mx.google.com> <20240812151755.0feab4b2@xps-13>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812151755.0feab4b2@xps-13>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 12, 2024 at 03:17:55PM +0200, Miquel Raynal wrote:
> Is this supported in mainline Linux? MTD handles the bad blocks and the
> bad block tables, so I don't understand how this hardware feature can
> live together with MTD.
> 
> Anyway, you are talking about MMCs, I don't understand why there are
> bad blocks, nor what is checking them and when. This is all still very
> fuzzy to me, I'm sorry.

Yes.  The idea of using block2mtd for anything but development seems
a bit odd to say it politely.  Using it to reinvent bad block management
on top of a block device that needs to do that as one of it's fundamental
functions seems extremely odd.

