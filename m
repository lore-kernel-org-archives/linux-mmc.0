Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F114AD3B
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126528; cv=none; b=Ht8dOwtNPQXyHl6e1xOw+7/j3AZuc6U1KX8sVNtg3WFZkjETpu0Vud46SC2YOdCUSiHy1BhqwdP/JkLcIY4/cbjXUv7mKxNpvELo1ZcSYAvVs6YRk5hU49zlhxNJfJ5u+sSgTEsQy0VvG1/04F1ibRwZpMBqIbeXvjEIfXjNsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126528; c=relaxed/simple;
	bh=yaCCKgJ4vW60UPTKzFp0mD6/Q3Wrp8vucBnVlSA/Ezk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzRzp+JC3HQajsInu+vgWc1suhnmmjfkuD096gv0PpcdQotCuYZI9FvBkEoUGAaMgXVOFRoYlmBqsfProBA9ZQWgkvS0RppUpc3+UFnxP3YBowvUYpsBPdR0dq3fKUHh07eTEz1KVrKY19euAw5ouSDAYref1O8lAzMd4vG/i5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C77FD68D05; Wed, 28 Feb 2024 14:22:00 +0100 (CET)
Date: Wed, 28 Feb 2024 14:22:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Christoph Hellwig <hch@lst.de>,
	Angelo Dureghello <angelo.dureghello@timesys.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-esdhc-mcf: Flag if the sg_miter is atomic
Message-ID: <20240228132200.GA11438@lst.de>
References: <20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org> <5c88e3f7-22e7-44d1-bf2e-5440e4de3b12@intel.com> <CACRpkdaRHz5LE_TpD7xkitX5ohafEvqOACx8PrEUuD-6oz-pUg@mail.gmail.com> <ce6709b3-b87a-4823-b4c8-b36f82195191@intel.com> <CACRpkdZwF1PYuaxDS5HTCPT==wyz=2K0t0Am_MXRF6KoXaVkMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZwF1PYuaxDS5HTCPT==wyz=2K0t0Am_MXRF6KoXaVkMg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 28, 2024 at 09:59:12AM +0100, Linus Walleij wrote:
> Aha, I'll send a simple patch just making the iteration atomic
> so we don't overwork this.
> 
> > As an aside, gotta wonder why there is not:
> >
> > #define SG_MITER_LOCAL_PAGE    (1 << 3)        /* use kmap_local_page */
> 
> That beats me, but Christoph probably has a good answer.

Probably just because no one got to it yet.

