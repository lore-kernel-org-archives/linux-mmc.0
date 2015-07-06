From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v2 0/3] mmc: sdhci: Card detection fixes
Date: Mon,  6 Jul 2015 15:16:18 +0300
Message-ID: <1436184981-16719-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Following changes aimed to fix some aspects of card detection, when
BROKEN_CARD_DETECTION quirk is set.

Changes since first version [1]:

* Patch 1/3 is a modified to first check for MMC_CAP_NONREMOVABLE
  and then check for a valid value in "gpio_cd"

[1] http://permalink.gmane.org/gmane.linux.kernel.mmc/32875

Ivan T. Ivanov (3):
  mmc: sdhci: let GPIO based card detection have higher precedence
  mmc: sdhci: don't use card state polling when CD GPIO is defined
  mmc: sdhci: properly check card present state when quirk
    NO_CARD_NO_RESET is set

 drivers/mmc/host/sdhci.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--
1.9.1
