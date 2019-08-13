From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] mmc: tegra: Implement enable_dma() to set dma_mask
Date: Tue, 13 Aug 2019 14:13:38 -0700
Message-ID: <20190813211337.GA18501@Asurada-Nvidia.nvidia.com>
References: <20190812224217.12423-1-nicoleotsuka@gmail.com>
 <20190813093651.GE1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190813093651.GE1137@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, jonathanh@nvidia.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 13, 2019 at 11:36:51AM +0200, Thierry Reding wrote:
> On Mon, Aug 12, 2019 at 03:42:17PM -0700, Nicolin Chen wrote:
> > Commit 68481a7e1c84 ("mmc: tegra: Mark 64 bit dma broken on Tegra186")
> > added a SDHCI_QUIRK2_BROKEN_64_BIT_DMA flag to let sdhci core fallback
> > to 32-bit DMA so as to fit the 40-bit addressing on Tegra186. However,
> > there's a common way, being mentioned in sdhci.c file, to set dma_mask
> > via enable_dma() callback in the device driver directly.
> > 
> > So this patch implements an enable_dma() callback in the sdhci-tegra,
> > in order to set an accurate DMA_BIT_MASK, other than 32-bit or 64-bit.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> I like this. However, I'd prefer if we set the DMA mask explicitly for
> each generation. A while ago, I had done a similar patch which relied on
> some core changes that no longer seem necessary with this enable_dma()
> hook. You can find the DMA masks for each generation in that patch:
> 	http://patchwork.ozlabs.org/patch/1020678/

Thank you for the reference patch. I will add those masks in v2.
