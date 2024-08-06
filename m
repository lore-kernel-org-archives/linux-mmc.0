Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D731BBBFE;
	Tue,  6 Aug 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949213; cv=none; b=Z2K8WJYEEiSt5v4gURIKy56HvPgdxEWn2s0aoWmYbUNo1LnEPMlTGorygdMEzbwj40Qs0gXpoIJw36ApDWZC7UElV64Bx+SW5+LBbdqnFsnW/gaaeLKtMVJX9g0RtsUSk6HKiXO92LQUFk8KoBuUUzyRRlv+FQTBBL6E2c2wRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949213; c=relaxed/simple;
	bh=wp7t+Q8hMzJxuLFaAjmYAvVUtymY5lTmwvvLeXoSuYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcZXjbD7f/63c9Hzs1zfP2qHTS8w5kz7czpHhp2g6a6ET2YR660Z22M6wQMVK0evSvdyJa1TfDyUMlz2vNFPE2U04N0BE+mIrZgK2fdpU5E6uhFSugQ3IoQWy3yoEAdroYM0NHHuXa+ZCDW6BDPfNYHRiKqUFLKBkxpwgKMdUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 651FA68CFE; Tue,  6 Aug 2024 15:00:04 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:00:03 +0200
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
Message-ID: <20240806130003.GA11766@lst.de>
References: <20240806114118.17198-1-ansuelsmth@gmail.com> <20240806114118.17198-2-ansuelsmth@gmail.com> <20240806124224.GA10156@lst.de> <66b21d35.050a0220.3799b3.7e8c@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b21d35.050a0220.3799b3.7e8c@mx.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I don't see how this works.  There is absolutely nothing nvme specific
in there, and we really should not bring OF into NVMe.

> (alternative is to have in block2mtd all kind of extra logic with switch
> case to check for major block ID that deviates from a common schema)

What common scheme?

