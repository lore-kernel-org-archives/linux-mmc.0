From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/2] Add ACPI support to IPROC SDHCI
Date: Mon, 30 Jul 2018 11:45:41 +0530
Message-ID: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, vikram.prakash@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

This patch series adds
  - Feature to get generic device properties in the
    place of DT properties.
  - ACPI support to IPROC SDHCI varients

This patch series is based off v4.18-rc3

Changes from v2:
  - Added patch "Convert DT properties to generic device properties"
    given by Adrian Hunter to this patch series because
    "Add ACPI support to IPROC SDHCI" patch is depends on this.

Changes from v1:
  - Removed sdhci_iproc_data array change and add directly
    into of and acpi id tables.
  - Add a change to get match data directly.
  - Removed clock-frequency property read change.
  - Used sdhci_get_property to get properties.
  - Verified with patch given by Adrian Hunter
    mmc: sdhci-pltfm: Convert DT properties to generic device properties

Adrian Hunter (1):
  mmc: sdhci-pltfm: Convert DT properties to generic device properties

Srinath Mannam (1):
  mmc: host: iproc: Add ACPI support to IPROC SDHCI

 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci-iproc.c | 63 ++++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
 4 files changed, 91 insertions(+), 48 deletions(-)

-- 
2.7.4
