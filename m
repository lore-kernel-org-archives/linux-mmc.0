From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: remove block layer bounce buffering for MMC
Date: Mon, 14 Jan 2019 16:52:40 +0000
Message-ID: <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
References: <20190114095804.27978-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 14/01/2019 09:57, Christoph Hellwig wrote:
> Hi everyone,
> 
> this series converts the remaining MMC host drivers to properly kmap the
> scatterlist entries it does PIO operations on, and then goes on to
> remove the usage of block layer bounce buffering (which I plan to remove
> eventually) from the MMC layer.
> 
> As a bonus I've converted various drivers to the proper scatterlist
> helpers so that at least in theory they are ready for chained
> scatterlists.
> 
> All the changes are compile tested only as I don't have any of the
> hardware, so a careful review would be appreciated.

One general point for the kmap() conversions - it's not obvious (to me 
at least) whether or how that would work for a segment where sg->length 
 > PAGE_SIZE. Or is there some cast-iron guarantee from the MMC 
mid-layer that it will never let the block layer generate such things in 
the first place?

Robin.
