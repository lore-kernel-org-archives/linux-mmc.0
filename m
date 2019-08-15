From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] mmc: tegra: Implement enable_dma() to set dma_mask
Date: Thu, 15 Aug 2019 16:16:46 -0700
Message-ID: <20190815231646.GA15635@Asurada-Nvidia.nvidia.com>
References: <20190814005741.13331-1-nicoleotsuka@gmail.com>
 <09d9ba41-f4cd-e515-cd2d-0b4134648059@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <09d9ba41-f4cd-e515-cd2d-0b4134648059@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 15, 2019 at 02:48:20PM +0300, Adrian Hunter wrote:
> On 14/08/19 3:57 AM, Nicolin Chen wrote:
> > [ Integrated the change and commit message made by Thierry Reding ]
> > 
> > The SDHCI controller found in early Tegra SoCs (from Tegra20 through
> > Tegra114) used an AHB interface to the memory controller, which allowed
> > only 32 bits of memory to be addressed.
> > 
> > Starting with Tegra124, this limitation was removed by making the SDHCI
> > controllers native MCCIF clients, which means that they got increased
> > bandwidth and better arbitration to the memory controller as well as an
> > address range extended to 40 bits, out of which only 34 were actually
> > used (bits 34-39 are tied to 0 in the controller).
> > 
> > For Tegra186, all of the 40 bits can be used; For Tegra194, 39-bit can
> > be used.
> > 
> > So far, sdhci-tegra driver has been relying on sdhci core to configure
> > the DMA_BIT_MASK between 32-bit or 64-bit, using one of quirks2 flags:
> > SDHCI_QUIRK2_BROKEN_64_BIT_DMA. However, there is a common way, being
> > mentioned in sdhci.c file, to set dma_mask via enable_dma() callback in
> > the device driver directly.
> > 
> > So this patch implements an enable_dma() callback in the sdhci-tegra,
> > in order to set an accurate DMA_BIT_MASK, other than just 32/64 bits.
> 
> Is there a reason this cannot be done at probe time?

It's supposed to be done at probe() time. But sdhci_setup_host()
does both 32-bit/64-bit dma_mask setting and dma_alloc(), so if
the dma_mask isn't correctly set inside sdhci_setup_host(), the
allocation would fall to a 64-bit IOVA range that hardware does
not support -- smmu error would happen and crash the system. On
the other hand, ->enable_dma() is called in that function right
after 32-bit/64-bit dma_mask setting. Or is there any other way
of adding to probe() that I am missing here?

Thanks
Nicolin
