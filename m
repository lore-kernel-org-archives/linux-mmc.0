Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEC18638;
	Thu, 26 Sep 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336116; cv=none; b=cv+LfkZutPrU0820qfV/KGhlhjKFiUIFPIVXfIuClXBcpWo171kSdJY28CqTmg35fjL6/zqXsYCa7O7mzy4r6nr1tAne1F32Q4hKNM4a7eKVNuWLNjOHyQ4gLnTil1956YR1PVTZl+qmFb0oew0Fjzr02FRNNcyyIlawS/++80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336116; c=relaxed/simple;
	bh=Np/IssSIx7kQU0ZuA2JdSRPJsJzqV3YSNHsiccZa0WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbC/7rfWDRnPcZ9Ck+uTOFBWQyo+CwRi7rGLoNfT4mIMtVCbdyAZpsYaKoLSS7mQnP8iaAG9dvN1fEKxk6a81oVPR9Xh6js5Pp2Jzj5mPxJXqa7yjEOHqmVBBGWXrpJDZ0M03GvHnccOMSo4QL+MJAFbrJWW3lYIPIWAE8dqrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69CBE68B05; Thu, 26 Sep 2024 09:35:02 +0200 (CEST)
Date: Thu, 26 Sep 2024 09:35:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mmc: core: Only set maximum DMA segment size if DMA is
 supported
Message-ID: <20240926073501.GA25149@lst.de>
References: <20240924210123.2288529-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924210123.2288529-1-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 24, 2024 at 02:01:23PM -0700, Guenter Roeck wrote:
> Since upstream commit 334304ac2bac ("dma-mapping: don't return errors
> from dma_set_max_seg_size") calling dma_set_max_seg_size() on a device
> not supporting DMA results in a warning traceback. This is seen when
> booting the sifive_u machine from SD. The underlying SPI controller
> (sifive,spi0 compatible) explicitly sets dma_mask to NULL.
> 
> Avoid the backtrace by only calling dma_set_max_seg_size() if DMA is
> supported.

Technicall this looks fine, although it would be nice avoid the overly
long line.

Reviewed-by: Christoph Hellwig <hch@lst.de>

