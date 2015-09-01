From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH 0/2] mmc: sdhci-pxav3: Fix tabbing issue
Date: Wed,  2 Sep 2015 00:54:12 +0530
Message-ID: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Trivial patch-series, which fixes the tabbing issue in the driver
and second patch prints the return value from sdhci_add_host() function


Vaibhav Hiremath (2):
  mmc: sdhci-pxav3: Fix tabbing issue
  mmc: sdhci-pxav3: Print ret value on error from sdhci_add_host() fn

 drivers/mmc/host/sdhci-pxav3.c | 65 ++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

-- 
1.9.1
