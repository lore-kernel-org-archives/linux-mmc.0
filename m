From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: tegra: Implement enable_dma() to set dma_mask
Date: Wed, 4 Sep 2019 11:31:56 +0300
Message-ID: <4a9c5d15-5f33-4275-8cf0-24cf374ad86b@intel.com>
References: <20190814005741.13331-1-nicoleotsuka@gmail.com>
 <09d9ba41-f4cd-e515-cd2d-0b4134648059@intel.com>
 <20190815231646.GA15635@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815231646.GA15635@Asurada-Nvidia.nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, vdumpa@nvidia.com
List-Id: linux-mmc@vger.kernel.org

On 16/08/19 2:16 AM, Nicolin Chen wrote:
> On Thu, Aug 15, 2019 at 02:48:20PM +0300, Adrian Hunter wrote:
>> On 14/08/19 3:57 AM, Nicolin Chen wrote:
>>> [ Integrated the change and commit message made by Thierry Reding ]
>>>
>>> The SDHCI controller found in early Tegra SoCs (from Tegra20 through
>>> Tegra114) used an AHB interface to the memory controller, which allowed
>>> only 32 bits of memory to be addressed.
>>>
>>> Starting with Tegra124, this limitation was removed by making the SDHCI
>>> controllers native MCCIF clients, which means that they got increased
>>> bandwidth and better arbitration to the memory controller as well as an
>>> address range extended to 40 bits, out of which only 34 were actually
>>> used (bits 34-39 are tied to 0 in the controller).
>>>
>>> For Tegra186, all of the 40 bits can be used; For Tegra194, 39-bit can
>>> be used.
>>>
>>> So far, sdhci-tegra driver has been relying on sdhci core to configure
>>> the DMA_BIT_MASK between 32-bit or 64-bit, using one of quirks2 flags:
>>> SDHCI_QUIRK2_BROKEN_64_BIT_DMA. However, there is a common way, being
>>> mentioned in sdhci.c file, to set dma_mask via enable_dma() callback in
>>> the device driver directly.
>>>
>>> So this patch implements an enable_dma() callback in the sdhci-tegra,
>>> in order to set an accurate DMA_BIT_MASK, other than just 32/64 bits.
>>
>> Is there a reason this cannot be done at probe time?
> 
> It's supposed to be done at probe() time. But sdhci_setup_host()
> does both 32-bit/64-bit dma_mask setting and dma_alloc(), so if
> the dma_mask isn't correctly set inside sdhci_setup_host(), the
> allocation would fall to a 64-bit IOVA range that hardware does
> not support -- smmu error would happen and crash the system. On
> the other hand, ->enable_dma() is called in that function right
> after 32-bit/64-bit dma_mask setting. Or is there any other way
> of adding to probe() that I am missing here?

Hmmm.  Maybe we should clean that up a bit.  What do about this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 4 Sep 2019 11:28:51 +0300
Subject: [PATCH] mmc: sdhci: Let drivers define their DMA mask

Add host operation ->set_dma_mask() so that drivers can define their own
DMA masks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++--------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 66c2cf89ee22..43d32ba63ff5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3756,18 +3756,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_ADMA;
 	}
 
-	/*
-	 * It is assumed that a 64-bit capable device has set a 64-bit DMA mask
-	 * and *must* do 64-bit DMA.  A driver has the opportunity to change
-	 * that during the first call to ->enable_dma().  Similarly
-	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
-	 * implement.
-	 */
 	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
-		ret = sdhci_set_dma_mask(host);
+		if (host->ops->set_dma_mask)
+			ret = host->ops->set_dma_mask(host);
+		else
+			ret = sdhci_set_dma_mask(host);
 
 		if (!ret && host->ops->enable_dma)
 			ret = host->ops->enable_dma(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 81e23784475a..a9ab2deaeb45 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -623,6 +623,7 @@ struct sdhci_ops {
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
 	int		(*enable_dma)(struct sdhci_host *host);
+	int		(*set_dma_mask)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	/* get_timeout_clock should return clk rate in unit of Hz */
-- 
2.17.1
