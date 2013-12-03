From: <micky_ching@realsil.com.cn>
Subject: [PATCH v3 0/2] fix sd power bug and modify phase-searching method
Date: Tue, 3 Dec 2013 10:34:11 +0800
Message-ID: <cover.1385947736.git.micky_ching@realsil.com.cn>
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
To: cjb@laptop.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

If the driver removed while sd card still in the slot, the card power
will not power down correctly, if we insert the driver module again,
UHS card will not switch to UHS mode. This bug is fix in this patch.

We use another phase search method for tuning, which looks more
simple, and reduce some source code.

Micky Ching (2):
  mmc: rtsx: fix card poweroff bug
  mmc: rtsx: modify phase searching method for tuning

 drivers/mmc/host/rtsx_pci_sdmmc.c |  115 +++++++++++--------------------------
 include/linux/mfd/rtsx_pci.h      |    2 +-
 2 files changed, 35 insertions(+), 82 deletions(-)

--
1.7.9.5
