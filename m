From: <micky_ching@realsil.com.cn>
Subject: [PATCH 0/2] mmc: rtsx: add check before sending request
Date: Wed, 14 Jan 2015 11:09:10 +0800
Message-ID: <cover.1421204431.git.micky_ching@realsil.com.cn>
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

Add check before sending request can make request return faster.
- finish request if no card exist
  This can make request finish faster, especial for some sdio card,
  when card removed, there still a lot of command pending,
  if we check card exist and stop request, the card will disappear
  faster in user space.

- check sg_count before long data xfer
  modify sg_count type unsigned -> int, because dma_map_sg() return
  int, and this value can be negative to indicate some error occurs.

Micky Ching (2):
  mmc: rtsx: finish request if no card exist
  mmc: rtsx: check sg_count before long data xfer

 drivers/mmc/host/rtsx_pci_sdmmc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
1.9.1
