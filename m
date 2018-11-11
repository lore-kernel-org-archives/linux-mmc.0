From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/7] mmc: Several fixes for bcm2835 driver
Date: Sun, 11 Nov 2018 14:45:23 +0100
Message-ID: <1541943930-23873-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch series fixes several issues which has been discovered after
submission.

Michal Suchanek (1):
  mmc: bcm2835: reset host on timeout

Phil Elwell (1):
  mmc: bcm2835: Recover from MMC_SEND_EXT_CSD

Stefan Wahren (5):
  mmc: bcm2835: Release DMA channel on driver unload
  mmc: bcm2835: Avoid possible races on data requests
  mmc: bcm2835: Terminate timeout work synchronously
  mmc: bcm2835: Refactor dma_map_sg handling
  mmc: bcm2835: Properly handle dmaengine_prep_slave_sg

 drivers/mmc/host/bcm2835.c | 58 ++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 20 deletions(-)

-- 
2.7.4
