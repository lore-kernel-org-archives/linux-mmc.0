Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A211366;
	Thu, 11 Jul 2024 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670499; cv=none; b=oXWtoEZtrx2fnuMYNHKtpz6Aw4c0xyQiUmegGXYGLtIj+gcQDoWCTbK2G4Fi7sSmYHL00ClIpU7iO1juVll5PEhjHAVDkMznrkF1n8ZgQsDIPmEmrEtHTJOE9gSlxZr7jwUrr97OP4wY3t3nBpRlpFOsb2G52IZuzZEOvoJVJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670499; c=relaxed/simple;
	bh=wZpAc7Oz/vMchZ1sVB2mR1hJC3BX/VfHFy1RdSy4/bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es2adI8p71pSShkPq9FBZR5SBXMggz3dGRZePhwtGIW/FsMiyDnnY2AWSg1hKIGxughnbGuKM6h90Ep1PRUor5s9ysK5MZVmkp5TS9SnBB7IAl11p8MU7TLkT3SAnIhZiNZPCqN6qXj+3Pr8W/8HSHLTR9RzrpfR/vKpYJZbHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 219BC68AA6; Thu, 11 Jul 2024 06:01:34 +0200 (CEST)
Date: Thu, 11 Jul 2024 06:01:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jon Hunter <jonathanh@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE
Message-ID: <20240711040133.GB2556@lst.de>
References: <20240710180737.142504-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710180737.142504-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 10, 2024 at 09:07:37PM +0300, Adrian Hunter wrote:
> blk_queue_max_segment_size() ensured:
> 
> 	if (max_size < PAGE_SIZE)
> 		max_size = PAGE_SIZE;

This is a bit misleading, as it also warned about it and papered over it
with the above as it had no way to return errors.  Any everyone seeing
these problems now ignored the warnings before, probably for years..

Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>

