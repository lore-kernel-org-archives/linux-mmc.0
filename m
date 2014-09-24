From: Roger Tseng <rogerable@realtek.com>
Subject: [PATCH 0/2] mmc: Add power_mode MMC_POWER_UNDEFINED
Date: Wed, 24 Sep 2014 17:07:12 +0800
Message-ID: <1411549634-28683-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Roger Tseng <rogerable@realtek.com>
List-Id: linux-mmc@vger.kernel.org

Invent MMC_POWER_UNDEFINED to describe the initial host power_mode which
might be either off or turned on by an early driver such as BIOS or UEFI driver.
This lets the later mmc_power_off() do actual power-off things and power_mode
will be in a known state eventually.

Roger Tseng (2):
  mmc: core: Add new power_mode MMC_POWER_UNDEFINED
  mmc: rtsx_pci: Set power related cap2 macros

 drivers/mmc/core/core.c           |    1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c |    1 +
 drivers/mmc/host/rtsx_usb_sdmmc.c |    1 +
 include/linux/mmc/host.h          |    1 +
 4 files changed, 4 insertions(+)

-- 
1.7.10.4
