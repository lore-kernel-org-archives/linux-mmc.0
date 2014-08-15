From: <rogerable@realtek.com>
Subject: [PATCH 0/2] mmc: rtsx: fix incorrect last byte in R2 response
Date: Fri, 15 Aug 2014 14:05:59 +0800
Message-ID: <1408082761-15333-1-git-send-email-rogerable@realtek.com>
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
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

From: Roger Tseng <rogerable@realtek.com>

(The original patch for PCI and USB was splitted here to make it easier for
stable tree.)

Current code erroneously fill the last byte of R2 response with an undefined
value. In addition, the controller actually 'offloads' the last byte
(CRC7, end bit) while receiving R2 response and thus it's impossible to get the
actual value. This could cause mmc stack to obtain inconsistent CID from the
same card after resume and misidentify it as a different card.

Fix by assigning dummy CRC and end bit: {7'b0, 1} = 0x1 to the last byte of R2.

Roger Tseng (2):
  mmc: rtsx_pci_sdmmc: fix incorrect last byte in R2 response
  mmc: rtsx_usb_sdmmc: fix incorrect last byte in R2 response

 drivers/mmc/host/rtsx_pci_sdmmc.c |    7 +++++++
 drivers/mmc/host/rtsx_usb_sdmmc.c |    7 +++++++
 2 files changed, 14 insertions(+)

-- 
1.7.10.4
