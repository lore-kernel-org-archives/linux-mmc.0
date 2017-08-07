From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/5] constify sdhci_pltfm_data and sdhci_ops structures
Date: Mon,  7 Aug 2017 11:50:39 +0200
Message-ID: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-mmc@vger.kernel.org

The sdhci_pltfm_data structures are only passed as the second
argument of sdhci_pltfm_init, which is const, while the sdhci_ops
structures are only stored in the ops field of a sdhci_pltfm_data
structure, which is also const.  Thus both kinds of structures can
be const as well.

Done with the help of Coccinelle.

---

 drivers/mmc/host/sdhci-bcm-kona.c  |    4 ++--
 drivers/mmc/host/sdhci-brcmstb.c   |    2 +-
 drivers/mmc/host/sdhci-of-arasan.c |    4 ++--
 drivers/mmc/host/sdhci-pic32.c     |    2 +-
 drivers/mmc/host/sdhci-pxav3.c     |    2 +-
 drivers/mmc/host/sdhci-sirf.c      |    4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)
