From: <micky_ching@realsil.com.cn>
Subject: [PATCH v4 0/6] mmc: rtsx: add support for sdio card
Date: Fri, 5 Dec 2014 13:54:25 +0800
Message-ID: <cover.1417758564.git.micky_ching@realsil.com.cn>
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

v4:
  split patch in more detailed patches. no code changes diff v3.

v3:
  rtsx_pci_sdmmc.c:
    - dump_reg_range
      - remove unused pointer check
      - fix start index
v2:
  rtsx_pci.h:
    - remove unused rtsx_pci_write_le32
    - add SD_CMD_START
  rtsx_pci_sdmmc.c:
    - dump_reg_range
      - alloc data on stack
    - remove forward declaration
    - use SD_CMD_START replace magic number 0x40
    - move initialize assignment to error handling

This patch is used to change transfer mode for sdio card support
by SD interface.



Micky Ching (6):
  mfd: rtsx: add func to split u32 into register
  mmc: rtsx: add dump_reg_range to simplify dump register
  mmc: rtsx: init cookie at probe/card_event
  mmc: rtsx: add helper function to simplify code
  mmc: rtsx: add support for sdio card
  mmc: rtsx: swap function position to avoid pre declaration

 drivers/mmc/host/rtsx_pci_sdmmc.c | 522 +++++++++++++++++++++-----------------
 include/linux/mfd/rtsx_pci.h      |   9 +
 2 files changed, 296 insertions(+), 235 deletions(-)

-- 
1.9.1
