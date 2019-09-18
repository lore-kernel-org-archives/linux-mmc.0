From: Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] dma-mapping updates for 5.4
Date: Wed, 18 Sep 2019 08:27:48 -0700
Message-ID: <20190918152748.GA21241@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

please pull the dma-mapping updates for 5.4.

In addition to the usual Kconfig conflics where you just want to keep
both edits there are a few more interesting merge issues this time:
 
 - most importanly powerpc and microblaze add new callers of
   dma_atomic_pool_init, while this tree marks the function static
   and calls it from a common postcore_initcall().  The trivial
   functions added in powerpc and microblaze adding the calls
   need to be removed for the code to compile.  This will not show up
   as a merge conflict and needs to be dealt with manually!
 - the csky tree has edits close to edits from this tree in
   arch/csky/mm/dma-mapping.c, keep both edits as there are no
   functional conflicts.
 - for ia64 keep the removal of arch/ia64/sn/pci/pci_dma.c from the
   ia64 tree.  The ia64 tree moves sba_dma_ops around a bit.  Keep
   the move and the wiring up of ->mmap and ->get_sgtable from this
   tree.
 - the -mm tree adds a new compound_nr helper that some of the Xen
   code removed in this pull request removes.  Keep the removal from
   this tree.
 - the block tree adds a new helper next to the new block helpers from
   this tree, keep both
 - the arm64 tree removes a __KERNEL__ ifdef from
   arch/arm64/include/asm/dma-mapping.h, which is removed in this tree.
   Keep the removal.

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4

for you to fetch changes up to c7d9eccb3c1e802c5cbb2a764eb0eb9807d9f12e:

  mmc: renesas_sdhi_internal_dmac: Add MMC_CAP2_MERGE_CAPABLE (2019-09-12 13:14:09 +0100)

----------------------------------------------------------------
dma-mapping updates for 5.4:

 - add dma-mapping and block layer helpers to take care of IOMMU
   merging for mmc plus subsequent fixups (Yoshihiro Shimoda)
 - rework handling of the pgprot bits for remapping (me)
 - take care of the dma direct infrastructure for swiotlb-xen (me)
 - improve the dma noncoherent remapping infrastructure (me)
 - better defaults for ->mmap, ->get_sgtable and ->get_required_mask (me)
 - cleanup mmaping of coherent DMA allocations (me)
 - various misc cleanups (Andy Shevchenko, me)

----------------------------------------------------------------
Andy Shevchenko (1):
      dma-mapping: fix filename references

Christoph Hellwig (34):
      unicore32: remove the unused pgprot_dmacoherent define
      arm-nommu: remove the unused pgprot_dmacoherent define
      dma-mapping: remove arch_dma_mmap_pgprot
      dma-mapping: make dma_atomic_pool_init self-contained
      arm64: document the choice of page attributes for pgprot_dmacoherent
      MIPS: document mixing "slightly different CCAs"
      dma-mapping: move the dma_get_sgtable API comments from arm to common code
      dma-mapping: explicitly wire up ->mmap and ->get_sgtable
      dma-mapping: add a dma_can_mmap helper
      ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
      arm-nommu: call dma_mmap_from_dev_coherent directly
      parisc: don't set ARCH_NO_COHERENT_DMA_MMAP
      dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP
      dma-mapping: remove dma_{alloc,free,mmap}_writecombine
      dma-mapping: remove dma_release_declared_memory
      dma-mapping: remove the dma_mmap_from_dev_coherent export
      remoteproc: don't allow modular build
      dma-mapping: remove the dma_declare_coherent_memory export
      dma-mapping: provide a better default ->get_required_mask
      vmalloc: lift the arm flag for coherent mappings to common code
      dma-mapping: always use VM_DMA_COHERENT for generic DMA remap
      dma-mapping: introduce a dma_common_find_pages helper
      arm: remove wrappers for the generic dma remap helpers
      xen/arm: use dma-noncoherent.h calls for xen-swiotlb cache maintainance
      xen/arm: consolidate page-coherent.h
      xen/arm: use dev_is_dma_coherent
      xen/arm: simplify dma_cache_maint
      xen/arm: remove xen_dma_ops
      xen: remove the exports for xen_{create,destroy}_contiguous_region
      swiotlb-xen: remove xen_swiotlb_dma_mmap and xen_swiotlb_dma_get_sgtable
      swiotlb-xen: use the same foreign page check everywhere
      swiotlb-xen: simplify cache maintainance
      swiotlb-xen: merge xen_unmap_single into xen_swiotlb_unmap_page
      arm64: use asm-generic/dma-mapping.h

Yoshihiro Shimoda (6):
      block: add a helper function to merge the segments
      mmc: queue: use bigger segments if DMA MAP layer can merge the segments
      dma-mapping: introduce dma_get_merge_boundary()
      iommu/dma: add a new dma_map_ops of get_merge_boundary()
      mmc: queue: Fix bigger segments usage
      mmc: renesas_sdhi_internal_dmac: Add MMC_CAP2_MERGE_CAPABLE

 Documentation/DMA-API.txt                     |  19 ++--
 Documentation/x86/x86_64/boot-options.rst     |   2 +-
 arch/Kconfig                                  |   3 -
 arch/alpha/kernel/pci_iommu.c                 |   2 +
 arch/arc/mm/dma.c                             |   6 --
 arch/arm/Kconfig                              |   2 +-
 arch/arm/include/asm/device.h                 |   3 -
 arch/arm/include/asm/dma-mapping.h            |   6 --
 arch/arm/include/asm/pgtable-nommu.h          |   1 -
 arch/arm/include/asm/xen/page-coherent.h      |  93 -------------------
 arch/arm/mm/dma-mapping-nommu.c               |   5 +-
 arch/arm/mm/dma-mapping.c                     |  84 +++--------------
 arch/arm/mm/mm.h                              |   3 -
 arch/arm/xen/mm.c                             | 129 ++++++++------------------
 arch/arm64/Kconfig                            |   1 -
 arch/arm64/include/asm/Kbuild                 |   1 +
 arch/arm64/include/asm/dma-mapping.h          |  31 -------
 arch/arm64/include/asm/pgtable.h              |  12 +++
 arch/arm64/include/asm/xen/page-coherent.h    |  75 ---------------
 arch/arm64/mm/dma-mapping.c                   |  16 +---
 arch/c6x/Kconfig                              |   1 -
 arch/csky/mm/dma-mapping.c                    |   6 --
 arch/ia64/hp/common/sba_iommu.c               |   2 +
 arch/ia64/kernel/setup.c                      |   2 +-
 arch/ia64/sn/pci/pci_dma.c                    |   2 +
 arch/m68k/Kconfig                             |   2 -
 arch/m68k/include/asm/pgtable_mm.h            |   3 +
 arch/m68k/kernel/dma.c                        |   3 +-
 arch/microblaze/Kconfig                       |   1 -
 arch/mips/Kconfig                             |   9 +-
 arch/mips/jazz/jazzdma.c                      |   2 +
 arch/mips/mm/dma-noncoherent.c                |   8 --
 arch/nds32/kernel/dma.c                       |   6 --
 arch/parisc/Kconfig                           |   1 -
 arch/powerpc/kernel/dma-iommu.c               |   2 +
 arch/powerpc/platforms/ps3/system-bus.c       |  11 +--
 arch/powerpc/platforms/pseries/vio.c          |   2 +
 arch/s390/pci/pci_dma.c                       |   2 +
 arch/sh/Kconfig                               |   1 -
 arch/unicore32/include/asm/pgtable.h          |   2 -
 arch/x86/include/asm/xen/page-coherent.h      |  14 ---
 arch/x86/kernel/amd_gart_64.c                 |   3 +
 arch/x86/kernel/pci-calgary_64.c              |   2 +
 arch/x86/kernel/pci-swiotlb.c                 |   1 -
 arch/x86/kernel/setup.c                       |   2 +-
 arch/x86/pci/sta2x11-fixup.c                  |   4 +-
 arch/x86/xen/mmu_pv.c                         |   2 -
 arch/xtensa/Kconfig                           |   1 -
 arch/xtensa/kernel/pci-dma.c                  |   4 +-
 block/blk-settings.c                          |  23 +++++
 drivers/gpu/drm/omapdrm/dss/dispc.c           |  11 +--
 drivers/iommu/amd_iommu.c                     |   2 +
 drivers/iommu/dma-iommu.c                     |  29 +++---
 drivers/iommu/intel-iommu.c                   |   2 +
 drivers/mmc/core/queue.c                      |  41 +++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   2 +-
 drivers/parisc/ccio-dma.c                     |   1 +
 drivers/parisc/sba_iommu.c                    |   1 +
 drivers/remoteproc/Kconfig                    |   2 +-
 drivers/xen/swiotlb-xen.c                     |  84 ++++-------------
 include/linux/blkdev.h                        |   2 +
 include/linux/dma-mapping.h                   |  34 +++----
 include/linux/dma-noncoherent.h               |  13 ++-
 include/linux/mmc/host.h                      |   2 +
 include/linux/vmalloc.h                       |   2 +
 include/xen/arm/hypervisor.h                  |   2 -
 include/xen/arm/page-coherent.h               |  24 +++--
 include/xen/swiotlb-xen.h                     |   5 +
 kernel/dma/Kconfig                            |  12 ++-
 kernel/dma/coherent.c                         |  13 ---
 kernel/dma/mapping.c                          | 105 ++++++++++++++-------
 kernel/dma/remap.c                            |  51 ++++++----
 mm/vmalloc.c                                  |   5 +-
 sound/core/pcm_native.c                       |  13 ++-
 74 files changed, 399 insertions(+), 677 deletions(-)
 delete mode 100644 arch/arm64/include/asm/dma-mapping.h
