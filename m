From: <wei_wang@realsil.com.cn>
Subject: [PATCH v6 0/3] Add modules to support realtek PCIE card reader
Date: Tue, 11 Sep 2012 12:54:18 +0800
Message-ID: <cover.1347330871.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: cjb@laptop.org, sameo@linux.intel.com
Cc: arnd@arndb.de, oakad@yahoo.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

From: Wei WANG <wei_wang@realsil.com.cn>

Support for Realtek PCI-Express driver-based card readers including rts5209 and rts5229.

v2:
1. Using platform device to replace realtek slot bus

v3:
1. Fix a bug that DMA out of SW-IOMMU space in Lenovo Thinkpad x121e
2. Tested by Borislav Petkov <bp@alien8.de>

v4:
1. Fulfill power management callbacks

v5:
1. Support Memstick card

v6:
1. Fix some coding style

Wei WANG (3):
  drivers/mfd: Add realtek pcie card reader driver
  drivers/mmc: Add realtek pcie sdmmc host driver
  drivers/memstick: Add realtek pcie memstick host driver

 drivers/memstick/host/Kconfig       |   10 +
 drivers/memstick/host/Makefile      |    1 +
 drivers/memstick/host/rtsx_pci_ms.c |  637 ++++++++++++++++
 drivers/mfd/Kconfig                 |    9 +
 drivers/mfd/Makefile                |    4 +
 drivers/mfd/rts5209.c               |  188 +++++
 drivers/mfd/rts5229.c               |  179 +++++
 drivers/mfd/rtsx_pcr.c              | 1345 ++++++++++++++++++++++++++++++++++
 drivers/mfd/rtsx_pcr.h              |   31 +
 drivers/mmc/host/Kconfig            |    7 +
 drivers/mmc/host/Makefile           |    2 +
 drivers/mmc/host/rtsx_pci_sdmmc.c   | 1372 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/rtsx_common.h     |   47 ++
 include/linux/mfd/rtsx_pci.h        |  773 ++++++++++++++++++++
 14 files changed, 4605 insertions(+)
 create mode 100644 drivers/memstick/host/rtsx_pci_ms.c
 create mode 100644 drivers/mfd/rts5209.c
 create mode 100644 drivers/mfd/rts5229.c
 create mode 100644 drivers/mfd/rtsx_pcr.c
 create mode 100644 drivers/mfd/rtsx_pcr.h
 create mode 100644 drivers/mmc/host/rtsx_pci_sdmmc.c
 create mode 100644 include/linux/mfd/rtsx_common.h
 create mode 100644 include/linux/mfd/rtsx_pci.h

-- 
1.7.9.5
