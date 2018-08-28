From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v6 0/3] solve SDHCI DWC MSHC 128MB DMA boundary limitation
Date: Tue, 28 Aug 2018 17:45:34 +0800
Message-ID: <20180828174534.00fb5e24@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

patch1 adds adma_table_cnt to struct sdhci_host so that driver can
control the ADMA table count.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

since v5:
  - use dma_get_required_mask() to calculate the extra adma_table_cnt

since v4:
  - add Adrian's ack to patch 1 and patch 2
  - address Adrian's comment -- if the boundary is fine, we have to
    return after writing dma desc once; adma_table_cnt updating could
    make use of the fact that it's already initialized by the common
    sdhci code, we just need to tune.

since v3:
  - s/adma_table_num/adma_table_cnt
  - add comment to adma_table_cnt
  - make the exported function name without the _
  - let sdhci_adma_write_desc() accept &desc param and set the new desc
    value

since v2:
  - make use of "likely" to check (!len || BOUNDARY_OK(addr, len))
  - explicitly include <linux/sizes.h> for SZ_128M

since v1:
  - fix BOUNDARY_OK macro if addr+len is aligned to 128MB
  - use DIV_ROUND_UP to cal extra desc num
  - fix !len for dwcmshc_adma_write_desc()



Jisheng Zhang (3):
  mmc: sdhci: add adma_table_cnt member to struct sdhci_host
  mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
  mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation

 drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 54 +++++++++++++++++------------
 drivers/mmc/host/sdhci.h            |  7 ++++
 3 files changed, 78 insertions(+), 22 deletions(-)

-- 
2.18.0
