From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v5 0/8] treewide: improve R-Car SDHI performance
Date: Wed,  5 Jun 2019 20:11:46 +0900
Message-ID: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This patch series is based on iommu.git / next branch.

Since SDHI host internal DMAC of the R-Car Gen3 cannot handle two or
more segments, the performance rate (especially, eMMC HS400 reading)
is not good. However, if IOMMU is enabled on the DMAC, since IOMMU will
map multiple scatter gather buffers as one contignous iova, the DMAC can
handle the iova as well and then the performance rate is possible to
improve. In fact, I have measured the performance by using bonnie++,
"Sequential Input - block" rate was improved on r8a7795.

To achieve this, this patch series modifies DMA MAPPING and IOMMU
subsystem at first. Since I'd like to get any feedback from each
subsystem whether this way is acceptable for upstream, I submit it
to treewide with RFC.

Changes from v4:
 - [DMA MAPPING] Add a new device_dma_parameters for iova contiguous.
 - [IOMMU] Add a new capable for "merging" segments.
 - [IOMMU] Add a capable ops into the ipmmu-vmsa driver.
 - [MMC] Sort headers in renesas_sdhi_core.c.
 - [MMC] Remove the following codes that made on v3 that can be achieved by
	 DMA MAPPING and IOMMU subsystem:
 -- Check if R-Car Gen3 IPMMU is used or not on patch 3.
 -- Check if all multiple segment buffers are aligned to PAGE_SIZE on patch 3.
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=125593

Changes from v3:
 - Use a helper function device_iommu_mapped on patch 1 and 3.
 - Check if R-Car Gen3 IPMMU is used or not on patch 3.
 - Check if all multiple segment buffers are aligned to PAGE_SIZE on patch 3.
 - Add Reviewed-by Wolfram-san on patch 1 and 2. Note that I also got his
   Reviewed-by on patch 3, but I changed it from v2. So, I didn't add
   his Reviewed-by at this time.
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=120985

Changes from v2:
 - Add some conditions in the init_card().
 - Add a comment in the init_card().
 - Add definitions for some "MAX_SEGS".
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=116729

Changes from v1:
 - Remove adding init_card ops into struct tmio_mmc_dma_ops and
   tmio_mmc_host and just set init_card on renesas_sdhi_core.c.
 - Revise typos on "mmc: tmio: No memory size limitation if runs on IOMMU".
 - Add Simon-san's Reviewed-by on a tmio patch.
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=110485

*** BLURB HERE ***

Yoshihiro Shimoda (8):
  dma-mapping: add a device driver helper for iova contiguous
  iommu/dma: move iommu_dma_unmap_sg() place
  iommu: add a new capable IOMMU_CAP_MERGING
  iommu/ipmmu-vmsa: add capable ops
  mmc: tmio: No memory size limitation if runs on IOMMU
  mmc: tmio: Add a definition for default max_segs
  mmc: renesas_sdhi: sort headers
  mmc: renesas_sdhi: use multiple segments if possible

 drivers/iommu/dma-iommu.c                     | 74 +++++++++++++++++----------
 drivers/iommu/ipmmu-vmsa.c                    | 13 +++++
 drivers/mmc/host/renesas_sdhi_core.c          | 43 +++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  4 ++
 drivers/mmc/host/tmio_mmc.h                   |  1 +
 drivers/mmc/host/tmio_mmc_core.c              |  7 +--
 include/linux/device.h                        |  1 +
 include/linux/dma-mapping.h                   | 16 ++++++
 include/linux/iommu.h                         |  1 +
 9 files changed, 123 insertions(+), 37 deletions(-)

-- 
2.7.4
