From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 0/4] mmc: sdhci: refactor PM in sdhci-pltfm add support PM
 for cadence port
Date: Wed, 23 Aug 2017 13:14:59 +0900
Message-ID: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-mmc@vger.kernel.org
Cc: Barry Song <baohua@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hao <haokexin@gmail.com>, Scott Branden <sbranden@broadcom.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Christian Daudt <csd@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Hu Ziji <huziji@marvell.com>, bcm-kernel-feedback-list@broadcom.com, Zhangfei Gao <zhangfei.gao@marvell.com>, Gregory Fong <gregory.0xf0@gmail.com>, Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org


[1] implements suspend / resume for sdhci-cadence.c

[2] refactor sdhci-pxav2

[3] add clk handling for suspend/resume hooks of sdhci-pltfm.
    This also cleans up sdhci-brcmstb.c and sdhci-sirf.c

[4] export sdhci_pltfm_suspend/resume to reduce code duplication


Masahiro Yamada (4):
  mmc: sdhci-cadence: add suspend / resume support
  mmc: sdhci-pxav2: switch to managed clk and sdhci_pltfm_unregister()
  mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
  mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume

 drivers/mmc/host/sdhci-brcmstb.c | 37 +----------------
 drivers/mmc/host/sdhci-cadence.c | 88 ++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci-pltfm.c   | 28 +++++++++++--
 drivers/mmc/host/sdhci-pltfm.h   |  2 +
 drivers/mmc/host/sdhci-pxav2.c   | 30 ++++----------
 drivers/mmc/host/sdhci-sirf.c    | 39 +-----------------
 6 files changed, 114 insertions(+), 110 deletions(-)

-- 
2.7.4
