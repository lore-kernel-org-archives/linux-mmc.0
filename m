From: <wei_wang@realsil.com.cn>
Subject: [PATCH v3 0/2] rtsx patch for for-next branch in MFD tree
Date: Tue, 20 Nov 2012 11:24:29 +0800
Message-ID: <cover.1353381810.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

Wei WANG (2):
  mmc/host/rtsx: Configure SD_CFG2 register in sd_rw_multi
  mmc/host/rtsx: Explicitely include slab.h in rtsx_pci_sdmmc.c

 drivers/mmc/host/rtsx_pci_sdmmc.c |    2 ++
 1 file changed, 2 insertions(+)

-- 
1.7.9.5
