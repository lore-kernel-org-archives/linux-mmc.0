From: <rogerable@realtek.com>
Subject: [PATCH v5 0/3] Add modules for realtek USB card reader
Date: Tue, 25 Mar 2014 18:44:50 +0800
Message-ID: <1395744293-24398-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com
List-Id: linux-mmc@vger.kernel.org

From: Roger Tseng <rogerable@realtek.com>

This patchset adds modules to support Realtek USB vendor specific class flash
card reader: one base module in MFD subsystem and two host modules in both mmc
and memstick subsystems. The architecture is similar to rtsx_pci.

This work is done primarily to replace the staging driver: staging/rts5139,
which doesn't utilize mmc nor memstick subsystems. Once the patchset or its
revision is applied, we may need Greg's help to remove the staging one.

v2:
1. Fix potential buffer overflow in rtsx_usb_seq_write_register()
2. Remove unnecessary casting and messages
3. Revise coding style and white spaces

v3:
1. Fix MMC detection fail when under xhci
2. Minor change of pm_runtime behavior in rtsx_usb_ms to prevent some rare
   freeze due to erroneous Memstick card(not MS-Pro)
3. Further revise coding style as suggested in the thread of v2
4. Using managed resources: devm_*
5. Change license from "GPL v2 and later" to "GPL v2"

v4:
1. Remove invocations to deprecated/removed mmc_suspend|resume_host APIs and
   unnecessary platform device pm routines
2. Support CRC-ignored R1 response for CMD13 in response to commit:
   a27fbf2f067b0cd6f172c8b696b9a44c58bfaa7a: mmc: add ignorance case for 
   CMD13 CRC error
3. Remove unnecessary #ifdef CONFIG_PM_RUNTIME

v5:
1. rtsx_usb_ms.c: adding header inclusion, removing unnecessary NULL checking,
   and add cancel_work_sync in removal handler to wait possible pending
   works.
(Changes only rtsx_usb_ms. Other files remain the same to v4)

Roger Tseng (3):
  mfd: Add realtek USB card reader driver
  mmc: Add realtek USB sdmmc host driver
  memstick: Add realtek USB memstick host driver

 drivers/memstick/host/Kconfig       |   10 +
 drivers/memstick/host/Makefile      |    1 +
 drivers/memstick/host/rtsx_usb_ms.c |  839 ++++++++++++++++++++
 drivers/mfd/Kconfig                 |   10 +
 drivers/mfd/Makefile                |    1 +
 drivers/mfd/rtsx_usb.c              |  760 ++++++++++++++++++
 drivers/mmc/host/Kconfig            |    7 +
 drivers/mmc/host/Makefile           |    1 +
 drivers/mmc/host/rtsx_usb_sdmmc.c   | 1462 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/rtsx_usb.h        |  628 +++++++++++++++
 10 files changed, 3719 insertions(+)
 create mode 100644 drivers/memstick/host/rtsx_usb_ms.c
 create mode 100644 drivers/mfd/rtsx_usb.c
 create mode 100644 drivers/mmc/host/rtsx_usb_sdmmc.c
 create mode 100644 include/linux/mfd/rtsx_usb.h

-- 
1.8.2
