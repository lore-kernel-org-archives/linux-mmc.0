From: <micky_ching@realsil.com.cn>
Subject: [PATCH 0/2] mmc: rtsx: revert support for mmc async request
Date: Tue, 29 Apr 2014 09:54:52 +0800
Message-ID: <cover.1398735435.git.micky_ching@realsil.com.cn>
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
To: chris@printf.net, ulf.hansson@linaro.org, lee.jones@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

The commit <mmc: rtsx: add support for pre_req and post_req> have some problem,
using mutex_unlock() in atomic context, spinlock deadlock, it is hard to fix
these problem, and better to use a new method. So just remove it.

The commit <mmc: rtsx: modify error handle and remove smatch warnings> depends
on the previous patch. And mainly fix some problem for the previous patch. So
need remove.

Micky Ching (2):
  mmc: rtsx: Revert "mmc: rtsx: modify error handle and remove smatch
    warnings"
  mmc: rtsx: Revert "mmc: rtsx: add support for pre_req and post_req"

 drivers/mfd/rtsx_pcr.c            |  132 ++++-------
 drivers/mmc/host/rtsx_pci_sdmmc.c |  459 +++++++------------------------------
 include/linux/mfd/rtsx_common.h   |    1 -
 include/linux/mfd/rtsx_pci.h      |    6 -
 4 files changed, 124 insertions(+), 474 deletions(-)

--
1.7.9.5
