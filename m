From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH v1 0/5] mmc: sdhci-msm: Corrections to implementation of power
 irq
Date: Wed, 30 Aug 2017 18:21:44 +0530
Message-ID: <1504097509-58983-1-git-send-email-vviswana@codeaurora.org>
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
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: riteshh@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Vijay Viswanath <vviswana@codeaurora.org>, stummala@codeaurora.org, subhashj@codeaurora.org, linux-arm-kernel@lists.infradead.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Register writes which change voltage of IO lines or turn the IO bus on/off
require sdhc controller to be ready before progressing further. Once a
register write which affects IO lines is done, the driver should wait for
power irq from controller. Once the irq comes, the driver should acknowledge
the irq by writing to power control register. If the acknowledgement is not
given to controller, the controller may not complete the corresponding
register write action and this can mess up the controller if drivers proceeds
without power irq completing.

Changes since RFC:
	wait_for_completion_timeout replaced with wait_event_timeout when
	waiting for power irq.
	Removed the spinlock within power irq handler and API which waits
	for power irq.
	Added comments to sdhci msm register write functions, warning that they
	can sleep.
	Sdhci msm register write functions will do a memory barrier before
	writing to the register if the particular register can trigger
	power irq.
	Instead of enabling SDHCI IO ACCESSORS config in arm64/defconfig, it
	will be selected in mmc/host/Kconfig if the platform is MMC_SDHCI_MSM.


Sahitya Tummala (2):
  mmc: sdhci-msm: Fix HW issue with power IRQ handling during reset
  mmc: sdhci-msm: Add support to wait for power irq

Subhash Jadavani (1):
  mmc: sdhci-msm: fix issue with power irq

Vijay Viswanath (2):
  mmc: sdhci-msm: Add ops to do sdhc register write
  mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS

 drivers/mmc/host/Kconfig     |   1 +
 drivers/mmc/host/sdhci-msm.c | 253 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 249 insertions(+), 5 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
