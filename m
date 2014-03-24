From: <micky_ching@realsil.com.cn>
Subject: mmc: rtsx: add new cmd type handle and modify error handle
Date: Mon, 24 Mar 2014 09:43:26 +0800
Message-ID: <cover.1395624929.git.micky_ching@realsil.com.cn>
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
To: chris@printf.net, sameo@linux.intel.com
Cc: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, devel@linuxdriverproject.org, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

Add new command type(R1 without CRC) handle, without this
patch mmc card initialize will be failed.

Using a more careful handle in request timeout, this would
improve error recover capability. Debug info is printed
using non DMA mode, this would help print more accurately
for DMA command failed. Smatch warning was removed.

Micky Ching (2):
  mmc: rtsx: add R1-no-CRC mmc command type handle
  mmc: rtsx: modify error handle and remove smatch warnings

 drivers/mmc/host/rtsx_pci_sdmmc.c |  121 ++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 54 deletions(-)

--
1.7.9.5
