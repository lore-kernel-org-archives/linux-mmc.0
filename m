From: <wei_wang@realsil.com.cn>
Subject: [PATCH 0/3] Fix two bugs in rtl8411
Date: Wed, 23 Jan 2013 09:51:03 +0800
Message-ID: <cover.1358905022.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

1. The method to switch output voltage is different in rtl8411
2. Fix the formula to calculate N from SD clock if clock divider is more than 1

Wei WANG (3):
  MFD:rtsx: Add callback function switch_output_voltage
  MMC:rtsx: Using callback function to switch output voltage
  MFD:rtsx: Add callback function conv_clk_and_div_n

 drivers/mfd/rtl8411.c             |   29 +++++++++++++++++++++++++++++
 drivers/mfd/rts5209.c             |   21 +++++++++++++++++++++
 drivers/mfd/rts5229.c             |   21 +++++++++++++++++++++
 drivers/mfd/rtsx_pcr.c            |   23 +++++++++++++++++++++--
 drivers/mmc/host/rtsx_pci_sdmmc.c |   30 +++++-------------------------
 include/linux/mfd/rtsx_common.h   |    3 +++
 include/linux/mfd/rtsx_pci.h      |   25 +++++++++++++++++++++----
 7 files changed, 121 insertions(+), 31 deletions(-)

-- 
1.7.9.5
