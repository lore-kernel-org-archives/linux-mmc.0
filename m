From: Christoph Hellwig <hch@lst.de>
Subject: Re: remove block layer bounce buffering for MMC
Date: Mon, 14 Jan 2019 17:57:55 +0100
Message-ID: <20190114165755.GA7456@lst.de>
References: <20190114095804.27978-1-hch@lst.de> <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 14, 2019 at 04:52:40PM +0000, Robin Murphy wrote:
> One general point for the kmap() conversions - it's not obvious (to me at 
> least) whether or how that would work for a segment where sg->length > 
> PAGE_SIZE. Or is there some cast-iron guarantee from the MMC mid-layer that 
> it will never let the block layer generate such things in the first place?

None of this will with such segments.  But yes, I guess the old case
could have worked as long as any physical contigous ranges are also
virtually contigous.  So we might have to throw in a page size segment
boundary here.
