From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 0/2] mmc: sdhci: Add sdma_buffer_boundary_arg to sdhci_host
Date: Wed,  2 Aug 2017 10:38:05 +0200
Message-ID: <20170802083807.26280-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds fix to support sdhci controller which have issues
when sdma boundary buffer bits are programmed in Block Size Register (0x04)
when using ADMA.

First patch adds member to struct sdhci_host to allow drivers to
specify sdma_buffer_boundary value that it can support and second
one sets sdma_buffer_boundary_arg to zero in msm sdhci driver.

Tested on DB410c with WLAN SDIO card.

thanks,
srini

Changes since RFC(https://lkml.org/lkml/2017/6/28/321)
	- Removed Quirk and added member to sdhci_host as suggested by Adrian

Srinivas Kandagatla (2):
  mmc: sdhci: add sdma_buffer_boundary_arg member to sdhci_host
  mmc: sdhci-msm: set sdma_buffer_boundary_arg to zero

 drivers/mmc/host/sdhci-msm.c |  1 +
 drivers/mmc/host/sdhci.c     | 14 ++++++++++----
 drivers/mmc/host/sdhci.h     |  3 +++
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.11.0
