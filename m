From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v4 0/3] solve SDHCI DWC MSHC 128MB DMA boundary limitation
Date: Thu, 23 Aug 2018 18:05:49 +0800
Message-ID: <20180823180549.78e508db@xhacker.debian>
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

patch1 adds adma_table_num to struct sdhci_host so that driver can
control the ADMA table number.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

since v3:
  - s/adma_table_num/adma_table_cnt
  - add comment to adma_table_cnt
  - make the exported function name without the _
  - let sdhci_adma_write_desc() accept &desc param and set the new desc
    value

since v2:
  - make use of "likely" to check (!len || BOUNDARY_OK(addr, len))
  - explictly include <linux/sizes.h> for SZ_128M

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
