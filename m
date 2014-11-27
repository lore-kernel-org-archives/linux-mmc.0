From: <micky_ching@realsil.com.cn>
Subject: [PATCH 0/2] mmc: rtsx: add support for sdio card
Date: Thu, 27 Nov 2014 10:53:57 +0800
Message-ID: <cover.1417056337.git.micky_ching@realsil.com.cn>
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
To: sameo@linux.intel.com, lee.jones@linaro.org, chris@printf.net, ulf.hansson@linaro.org
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, devel@linuxdriverproject.org, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

This patch is used to change transfer mode for sdio card support
by SD interface.

Micky Ching (2):
  mfd: rtsx: add func to split u32 into register
  mmc: rtsx: add support for sdio card

 drivers/mmc/host/rtsx_pci_sdmmc.c | 366 ++++++++++++++++++++++----------------
 include/linux/mfd/rtsx_pci.h      |  15 ++
 2 files changed, 224 insertions(+), 157 deletions(-)

-- 
1.9.1
