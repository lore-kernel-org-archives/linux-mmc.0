From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Date: Mon, 14 Jan 2019 03:09:47 -0800
Message-ID: <20190114110947.GA30778@infradead.org>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
 <20190104174354.GA18110@infradead.org>
 <20190110105911.GA32301@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110105911.GA32301@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 10, 2019 at 11:59:11AM +0100, Thierry Reding wrote:
> On Fri, Jan 04, 2019 at 09:43:54AM -0800, Christoph Hellwig wrote:
> > > +	u64 dma_mask = dma_get_mask(dev);
> > 
> > This is not a driver API.  I think what you want is
> > dma_get_required_mask to query the mask.  But in that case
> > you still need to always actually set a mask in the driver as well.
> 
> That's slightly different from what I want to do here. The purpose of
> this part of the patch is that when the SDHCI hardware supports only 32
> bits of address space, then we want to prevent 64-bit addressing mode
> from being used because it isn't useful.
> 
> So what we do want to check here is the DMA mask configured by the
> driver (or the default set by the bus, or wherever it came from).
> dma_get_required_mask() returns the DMA mask required to address all of
> system memory. That would perhaps be a useful additional check, but it's
> orthogonal to what I'm trying to do here.
> 
> Is there something else appropriate that I could use to query the DMA
> mask set for a device?

I think the problem is that you try to mix up responsibility of who
needs to set the DMA mask.  Either we want the core sdhci code set
it as we do, or we move it to the driver, probably optionally.

So instead of trying to read something back you should either:

 - add a set_dma_mask to override it
 - add a 64bit_mode_dma_mask field to strct mmc_host, initialize
   that to 64-bit by default and let host drivers override it

While the first one creates a little more boilerplate code it actually
looks cleaner to me.  The added benefit is that it can also replace the
usage of SDHCI_QUIRK2_BROKEN_64_BIT_DMA.
