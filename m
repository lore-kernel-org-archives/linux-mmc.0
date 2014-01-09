From: <micky_ching@realsil.com.cn>
Subject: [PATCH 0/3] mmc: rtsx: fix bug and support nonblocking request
Date: Thu, 9 Jan 2014 09:40:45 +0800
Message-ID: <cover.1389230226.git.micky_ching@realsil.com.cn>
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
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, devel@linuxdriverproject.org
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

First we fix the card poweroff bug: the card power is not shutdown when sd/mmc
card removed, this will make UHS-card failed to running in high speed mode if we
insert the card again.

We offer a concise tuning searching method, it is much easier to read.

At last we add support for nonblocking request, which will improve card read
speed at about 10% write speed about 5% normally.

Micky Ching (3):
  mmc: rtsx: fix card poweroff bug
  mmc: rtsx: modify phase searching method for tuning
  mmc: rtsx: add support for pre_req and post_req

 drivers/mfd/rtsx_pcr.c            |  132 ++++++---
 drivers/mmc/host/rtsx_pci_sdmmc.c |  537 ++++++++++++++++++++++++++-----------
 include/linux/mfd/rtsx_common.h   |    1 +
 include/linux/mfd/rtsx_pci.h      |    8 +-
 4 files changed, 481 insertions(+), 197 deletions(-)

--
1.7.9.5
