From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/3] Add driver Support for MMCSD on AM654x.
Date: Thu, 29 Nov 2018 21:45:10 +0530
Message-ID: <20181129161513.31734-1-faiz_abbas@ti.com>
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
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, kishon@ti.com, robh+dt@kernel.org, faiz_abbas@ti.com, michal.simek@xilinx.com
List-Id: linux-mmc@vger.kernel.org

The following patches add driver support for MMCSD on TI's AM654
platforms.

Previously I had added the support to sdhci-of-arasan driver with
a separate phy driver[1]. Since then it has turned out that tuning
operation (for HS200, HS400 and SDR104 speed modes) will require
configuration of phy registers. This completely breaks the model of
the sdhci-of-arasan driver which relies on a separate driver to
configure the phy register space.

Because of this, I am creating a new driver with both the sdhci and
phy register spaces. This helps me use the phy registers in a future
patch that adds tuning support.

DT patches will be posted in a separate series.

[1] driver and phy patches posted before
    https://patchwork.kernel.org/project/linux-mmc/list/?series=26623

Faiz Abbas (3):
  dt-bindings: mmc: sdhci-am654: Document bindings for the host
    controllers on TI's AM654 SOCs
  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am654
  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
 .../devicetree/bindings/mmc/sdhci-am654.txt   |  23 ++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
 drivers/mmc/host/sdhci_am654.c                | 366 ++++++++++++++++++
 6 files changed, 406 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 drivers/mmc/host/sdhci_am654.c

-- 
2.19.2
