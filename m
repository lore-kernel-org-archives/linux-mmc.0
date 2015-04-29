From: <micky_ching@realsil.com.cn>
Subject: [PATCH 00/12] mmc: core: add SD4.0 support
Date: Wed, 29 Apr 2015 09:23:32 +0800
Message-ID: <cover.1429845922.git.micky_ching@realsil.com.cn>
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
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

Add support for SD4.0 card, which introduce UHSII mode and tlp transfer.

Micky Ching (12):
  mmc: core: add data structure define for SD4.0
  mmc: core: modify mmc_app_cmd interface for SD4.0
  mmc: core: add SD4.0 operation function
  mmc: core: add tlp request handler for SD4.0
  mmc: core: disable full power cycle for SD4.0
  mmc: core: init SD4.0 mode before legacy mode
  mmc: sdhci: add data structure for SD4.0
  mmc: sdhci: add SD4.0 operations
  mmc: sdhci: add tlp handler for SD4.0
  mmc: sdhci: disable clock control for SD4.0 mode
  mmc: sdhci: set DMA configure for SD4.0 mode
  mmc: sdhci: add SD4.0 support

 drivers/mmc/card/block.c  |   2 +-
 drivers/mmc/core/core.c   | 174 ++++++++++++--
 drivers/mmc/core/mmc.c    |  63 +++--
 drivers/mmc/core/sd.c     | 282 ++++++++++++++++++----
 drivers/mmc/core/sd.h     |   1 +
 drivers/mmc/core/sd_ops.c | 227 +++++++++++++++++-
 drivers/mmc/core/sd_ops.h |   7 +
 drivers/mmc/core/sdio.c   | 103 ++++-----
 drivers/mmc/host/sdhci.c  | 579 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h  | 136 ++++++++++-
 include/linux/mmc/card.h  |  13 ++
 include/linux/mmc/core.h  |  91 +++++++-
 include/linux/mmc/host.h  |  33 +++
 include/linux/mmc/sd.h    |  73 ++++++
 14 files changed, 1572 insertions(+), 212 deletions(-)

-- 
1.9.1
