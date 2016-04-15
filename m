From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 00/23] a few sdhci/imx clean up and fix patches
Date: Sat, 16 Apr 2016 01:29:24 +0800
Message-ID: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
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
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Patch 1~10 are mainly sdhci cleanup patches while patch 7,9,10
are fixes which seems needed for stable tree as well.

The main work is:
1) a few minor cleanups
2) re-factor sdhci_start_signal_voltage()
3) fix not checking SDHCI_QUIRK2_NO_1_8_V when do voltage switch
4) fix get wrong data interrupt during no data transfer
5) fix unneeded retuning during card remove

Patch 17 added sdhci auto retune support (TUNING_MODE_3)
Many controller support hw auto retune, with it we do not
need do the frequent retuning after each runtime suspend/resume.

Patch 11~23 are imx esdhc driver clean up and fixes.
1) remove SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
I also tried clean up all SDHCI_QUIRK_BROKEN_TIMEOUT_VAL in the tree,
seems a lot work that many controllers are affected, planned to do it later.
2) support setting tuning start point
This can make us bypass a few meaningless tuning commands at the start
3) add hw state restore function after system resume for low
power mode like LPSR on IMX7D which the controller state got lost.
Without it, the controller may not work after resume.
4) Patch 17~19 added hw auto retune support
5) fix strobe DLL lock wrong clock issue
This makes the eMMC HS400 mode strobe locks the correct clock rate
6) a few other reorgnization to make code more concentrate and maintainable

Dong Aisheng (23):
  mmc: sdhci: removed unneeded function wrappers
  mmc: sdhci: move sdhci_get_cd() forward to avoid declaration
  mmc: core: fix a comment typo
  mmc: sdhci: re-factor sdhci_start_signal_voltage()
  mmc: core: mmc_regulator_set_vqmmc not return error if vqmmc/vmmc not
    exist
  mmc: sdhci: using common mmc_regulator_set_vqmmc()
  mmc: sdhci: check SDHCI_QUIRK2_NO_1_8_V when do voltage switch
  mmc: sdhci: rename quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12
  mmc: sdhci: fix incorrect get data interrupt during no data transfer
  mmc: core: disable auto retune during card detection process
  mmc: sdhci-esdhci-imx: remove SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
  mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback
  mmc: sdhci-esdhc-imx: restore watermark level setting after resume
  mmc: sdhci-esdhci-imx: disable DLL delay line settings explicitly
  mmc: sdhci-esdhc-imx: support setting tuning start point
  doc: dt: fsl-imx-esdhc: add set tuning start point binding
  mmc: sdhci: add standard hw auto retuning support
  mmc: sdhci-esdhc-imx: enable hw auto retuning for STD_TUNING
  mmc: sdhci-esdhc-imx: enable hw auto retuning for MAN_TUNING
  mmc: sdhci-esdhc-imx: fix strobe DLL lock wrong clock issue
  mmc: sdhci-esdhc-imx: factor out hw related intialization into
    function
  mmc: sdhci-esdhc-imx: move tuning static configuration into hwinit
    function
  mmc: sdhci-esdhc-imx: clear tuning bits during hwinit

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 +
 drivers/mmc/core/core.c                            |   3 +-
 drivers/mmc/core/mmc_ops.c                         |   2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 150 +++++++++++------
 drivers/mmc/host/sdhci-pci-o2micro.c               |   2 +-
 drivers/mmc/host/sdhci-pltfm.c                     |   2 +-
 drivers/mmc/host/sdhci-s3c.c                       |   2 +-
 drivers/mmc/host/sdhci.c                           | 186 +++++++++------------
 drivers/mmc/host/sdhci.h                           |   5 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 10 files changed, 194 insertions(+), 161 deletions(-)

-- 
1.9.1
