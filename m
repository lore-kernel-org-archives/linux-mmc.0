From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Date: Fri, 4 Jan 2019 09:43:54 -0800
Message-ID: <20190104174354.GA18110@infradead.org>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190104104753.3383-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

> +	u64 dma_mask = dma_get_mask(dev);

This is not a driver API.  I think what you want is
dma_get_required_mask to query the mask.  But in that case
you still need to always actually set a mask in the driver as well.

Something like this patch:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a22e11a65658..36c61778d8f3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3500,6 +3500,13 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 	struct device *dev = mmc_dev(mmc);
 	int ret = -EINVAL;
 
+	/*
+	 * Systems that can't address more than 32-bits do not need to use
+	 * 64-bit addressing mode, even if the device supports it.
+	 */
+	if (dma_get_required_mask(dev) <= DMA_BIT_MASK(32))
+		host->flags &= ~SDHCI_USE_64_BIT_DMA;
+
 	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
 		host->flags &= ~SDHCI_USE_64_BIT_DMA;
 
