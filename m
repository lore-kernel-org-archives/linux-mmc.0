From: Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH v3 0/3] mmc: sdhci: Use mmc core regulator infrastucture
Date: Thu, 12 Jun 2014 11:48:52 -0700
Message-ID: <1402598935-3701-1-git-send-email-markus.mayer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tim Kryger <tim.kryger@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>, Andrew Bresticker <abrestic@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

This series switches the common SDHCI code over to use mmc_host's
regulator pointers rather than keeping its own set.

In addition, we can now re-use the newly introduced local "mmc" pointer
in several other function calls in lieu of using host->mmc.

The first patch in the series has been posted before
(https://lkml.org/lkml/2014/4/24/947). The two follow-on patches have
not. Patches 2 & 3 could be squashed together if the maintainers were
so inclined.

This series is based on mainline (commit 16b9057804).

Changes from v2:

  - Replaced a few more host->mmc references with mmc in
    sdhci_add_host(). This change affects PATCH 3/3 only. The other two
    patches are unchanged from v2.
  - Rebased the series on mainline (rather than mmc-next). Doing so did
    not affect the patches themselves. They applied cleanly as-is.

Changes from v1:
  - Resolved merge conflicts resulting from RMK's MMC series. The most
    significant conflict was the move of regulator code from
    sdhci_do_set_ios() to sdhci_set_power().
  - Added follow-on patches 2 & 3 of the series.
  - Updated Tim Kryger's e-mail address.

Markus Mayer (2):
  mmc: sdhci: Use existing mmc pointer calling mmc_regulator_set_ocr()
  mmc: sdhci: Replace host->mmc with mmc where possible

Tim Kryger (1):
  mmc: sdhci: Use mmc core regulator infrastucture

 drivers/mmc/host/sdhci.c  | 123 ++++++++++++++++++----------------------------
 include/linux/mmc/sdhci.h |   3 --
 2 files changed, 49 insertions(+), 77 deletions(-)

-- 
1.9.1
