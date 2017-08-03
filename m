From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 0/2] mmc: sdhci: Add sdma_boundary to sdhci_host
Date: Thu,  3 Aug 2017 14:46:12 +0200
Message-ID: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds fix to support sdhci controller which have issues
when sdma boundary buffer bits are programmed in Block Size Register (0x04)
when using ADMA.

First patch adds member to struct sdhci_host to allow drivers to
specify sdma_buffer_boundary value that it can support and second
one sets sdma_boundary to zero in msm sdhci driver.

Tested on DB410c with WLAN SDIO card.

thanks,
srini

Changes since v2:
	- Chanaged local variable to fix line wrap.
	- Changed sdma_buffer_boundary_arg to sdma_boundary suggested by Adrian

Srinivas Kandagatla (2):
  mmc: sdhci: add sdma_boundary member to struct sdhci_host
  mmc: sdhci-msm: set sdma_boundary to zero

 drivers/mmc/host/sdhci-msm.c |  1 +
 drivers/mmc/host/sdhci.c     | 13 ++++++++-----
 drivers/mmc/host/sdhci.h     |  3 +++
 3 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.9.3
