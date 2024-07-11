Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FA374CB;
	Thu, 11 Jul 2024 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680490; cv=none; b=oRZj/qBOr4pnDQ+DFVGLajXY5js0y6aqKyR0+fxOHqLArlK7FLg+l+eGyetupPcMO4mr0HdmHJGcBSgtToA5dWpU6mgKyLo0oc/7j8WBsOL5r1UKyvXeRb4upS0UqjDtG3i2eX+l7LQPmLtiO78Iryz4OuPyIqaVkYzZJ6nAK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680490; c=relaxed/simple;
	bh=eyHqnoYpZ27ALrk4B1zAXQaAgOCz4+kg1dODV+2Ro9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsktT3z8sW9WIb1SxK3DkT6h2pwK0gIZd3uEYqNNqlNk5tChWq/0mf3UFxWQF8KtC1VJgc9FvW+90usN0S8uLixeC9eWd9oGwiWtrvpX3fpMc41Rj4uCOtcypkscF5Np/nqS6PQU+D0kBTvJ+KKKuXWa8Hi0UVidD1GEa8Tlk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D30D368AA6; Thu, 11 Jul 2024 08:48:03 +0200 (CEST)
Date: Thu, 11 Jul 2024 08:48:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE
Message-ID: <20240711064803.GA6313@lst.de>
References: <20240710180737.142504-1-adrian.hunter@intel.com> <20240711040133.GB2556@lst.de> <44a4c774-c312-48d7-a627-19a7b86a3bf5@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a4c774-c312-48d7-a627-19a7b86a3bf5@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 11, 2024 at 08:17:47AM +0300, Adrian Hunter wrote:
> On 11/07/24 07:01, Christoph Hellwig wrote:
> > On Wed, Jul 10, 2024 at 09:07:37PM +0300, Adrian Hunter wrote:
> >> blk_queue_max_segment_size() ensured:
> >>
> >> 	if (max_size < PAGE_SIZE)
> >> 		max_size = PAGE_SIZE;
> > 
> > This is a bit misleading, as it also warned about it and papered over it
> > with the above as it had no way to return errors.  Any everyone seeing
> > these problems now ignored the warnings before, probably for years..
> 
> Was there a warning, since the message in blk_queue_max_segment_size()
> was:
> 
> 		pr_info("%s: set to minimum %u\n", __func__, max_size);

It stated out as a plain printk and became an info later, but yes,
not the big warning sign it was supposed to be.

