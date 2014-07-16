From: Markus Niebel <list-09_linux_arm@tqsc.de>
Subject: [PATCH 0/2] mmc: add driver stage register handling
Date: Wed, 16 Jul 2014 16:19:47 +0200
Message-ID: <1405520389-32649-1-git-send-email-list-09_linux_arm@tqsc.de>
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
To: linux-arm-kernel@lists.infradead.org
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

From: Markus Niebel <Markus.Niebel@tq-group.com>

The first patch is taken from Sascha Hauers patch from 25/05/2014
and tries to follow comments from Ulf Hansson. Second patch
adds this feature to the sdhci-esdhc-imx driver which has an own
device tree probe routine. 

Markus Niebel (2):
  mmc: implement driver stage register handling
  mmc: sdhci-esdhc-imx: implement DSR support

 Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++++
 drivers/mmc/core/host.c                       |    8 ++++++++
 drivers/mmc/core/mmc.c                        |    8 ++++++++
 drivers/mmc/core/mmc_ops.c                    |   17 +++++++++++++++++
 drivers/mmc/core/mmc_ops.h                    |    1 +
 drivers/mmc/core/sd.c                         |    8 ++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c            |   15 +++++++++++++++
 include/linux/mmc/card.h                      |    3 ++-
 include/linux/mmc/host.h                      |    3 +++
 include/linux/platform_data/mmc-esdhc-imx.h   |    4 ++++
 10 files changed, 73 insertions(+), 1 deletion(-)

-- 
1.7.9.5
