From: <wei_wang@realsil.com.cn>
Subject: [PATCH v2 0/2] Add modules to support realtek PCIE card reader
Date: Tue, 14 Aug 2012 18:40:36 +0800
Message-ID: <cover.1344939464.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:53457 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab2HNKlN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Aug 2012 06:41:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@linuxfoundation.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, arnd@arndb.de, sameo@linux.intel.com
Cc: bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>

From: Wei WANG <wei_wang@realsil.com.cn>

Support for Realtek PCI-Express driver-based card readers including rts5209 and rts5229.

Wei WANG (2):
  drivers/mfd: Add realtek pcie card reader driver
  drivers/mmc: Add realtek pcie sdmmc host driver

 drivers/mfd/Kconfig               |    9 +
 drivers/mfd/Makefile              |    4 +
 drivers/mfd/rts5209.c             |  102 +++
 drivers/mfd/rts5229.c             |  117 +++
 drivers/mfd/rtsx_pcr.c            | 1464 +++++++++++++++++++++++++++++++++++++
 drivers/mfd/rtsx_pcr.h            |   31 +
 drivers/mmc/host/Kconfig          |    7 +
 drivers/mmc/host/Makefile         |    2 +
 drivers/mmc/host/rtsx_pci_sdmmc.c | 1348 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/rtsx_common.h   |   47 ++
 include/linux/mfd/rtsx_pci.h      |  692 ++++++++++++++++++
 11 files changed, 3823 insertions(+)
 create mode 100644 drivers/mfd/rts5209.c
 create mode 100644 drivers/mfd/rts5229.c
 create mode 100644 drivers/mfd/rtsx_pcr.c
 create mode 100644 drivers/mfd/rtsx_pcr.h
 create mode 100644 drivers/mmc/host/rtsx_pci_sdmmc.c
 create mode 100644 include/linux/mfd/rtsx_common.h
 create mode 100644 include/linux/mfd/rtsx_pci.h

-- 
1.7.9.5

