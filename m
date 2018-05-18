From: Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/3] mmc: sdhci-iproc: UHS and 32bit access fixes
Date: Fri, 18 May 2018 15:03:54 -0700
Message-ID: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

Collection of bug fixes for sdhci-iproc driver.
- fix for 32bit writes for TRANSFER_MODE register by correcting shadow
register logic
- fix for deep sleep mode by adding SDHCI_QUIRK2_HOST_OFF_CARD_ON
- remove hard coded mmc capability of 1.8V to allow boards to be supported
that do support 1.8V.


Corneliu Doban (2):
  mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register
  mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Srinath Mannam (1):
  mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

 drivers/mmc/host/sdhci-iproc.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

-- 
2.5.0
