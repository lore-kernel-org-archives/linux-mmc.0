From: <wei_wang@realsil.com.cn>
Subject: [PATCH v4 0/8] rtsx patchset for MFD and MMC tree
Date: Tue, 8 Jan 2013 17:57:21 +0800
Message-ID: <cover.1357638064.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

v2:
1. Add commit message for patch 2
2. Move pci_set_dma_mask before the pci_enable_device(pcidev) call

v3:
1. Add commit message for patch 3
2. Add patch 8: Use macro defines to replace some variables

v4:
1. Describe why patch 3 is needed
2. Modify a comment character in patch 7

Wei WANG (8):
  MFD:rtsx: Fix typo in comment
  MFD:rtsx: Remove redundant code
  MFD:rtsx: Declare that the DMA address limitation is 32bit explicitly
  MFD:rtsx: Add callback function switch_output_voltage
  MMC:rtsx: Using callback function to switch output voltage
  MFD:rtsx: Add callback function conv_clk_and_div_n
  MFD:rtsx: Fix checkpatch warning
  MFD:rtsx: Use macro defines to replace some variables

 drivers/mfd/rtl8411.c             |   29 ++++++++++++++++++++++++
 drivers/mfd/rts5209.c             |   21 +++++++++++++++++
 drivers/mfd/rts5229.c             |   21 +++++++++++++++++
 drivers/mfd/rtsx_pcr.c            |   45 +++++++++++++++++++++++++------------
 drivers/mfd/rtsx_pcr.h            |    3 +++
 drivers/mmc/host/rtsx_pci_sdmmc.c |   30 +++++--------------------
 include/linux/mfd/rtsx_common.h   |    3 +++
 include/linux/mfd/rtsx_pci.h      |   27 +++++++++++++++++-----
 8 files changed, 135 insertions(+), 44 deletions(-)

-- 
1.7.9.5
