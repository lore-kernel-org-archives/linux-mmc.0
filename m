From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH mmc-next v2 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Date: Tue, 31 Jul 2018 13:52:57 +0800
Message-ID: <20180731135257.268924f3@xhacker.debian>
References: <20180726151017.4da1e336@xhacker.debian>
        <20180726151424.4bcecf41@xhacker.debian>
        <edaa7605-e0e0-b17a-8403-c3d7d60d7989@arm.com>
        <20180731112924.6a1e8388@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731112924.6a1e8388@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 31 Jul 2018 11:29:24 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Hi Robin,
> 
> On Mon, 30 Jul 2018 12:06:08 +0100 Robin Murphy wrote:
> 
> > Hi Jisheng,
> > 
> > On 26/07/18 08:14, Jisheng Zhang wrote:  
> > > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > > the DMA transfer into two so that each one doesn't exceed the boundary.    
> > 
> > Out of interest, is the driver already setting its segment boundary mask 
> > appropriately? This sounds like the exact kind of hardware restriction 
> > that dma_parms is intended to describe, which scatterlist-generating 
> > code is *supposed* to already respect.  
> 
> Thanks for the nice input. It may provide an elegant solution for this
> limitation. 
> 
> To simplify the situation, let's assume no iommu, only swiotlb. And
> the DDR is less than 4GB so swiotlb on arm64 doesn't init.
> 
> There's no dma range limitation with the HW, the only limitation
> is boundary, while dma_capable() doesn't check the boundary mask, so if
> we taking this solution, we need to teach dma_capable() about the boundary
> mask, I'm not sure whether this is acceptable.
> 
> Another problem is swiotlb initialization. When to init swiotlb, we dunno
> there's such boundary limitation HW. Is there any elegant solution for
> this problem?
> 

One more problem is: swiotlb isn't available on all platforms, e.g arm?
How to solve this SDHCI HW's limitation on arm soc w/o iommu?

Thanks
