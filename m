From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 0/2] Support SDHCI on 8974pro devices
Date: Fri, 18 Aug 2017 10:55:04 -0700
Message-ID: <20170818175506.5035-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

The calibration clocks for the delay circut should be enabled, as done in the
downstream kernel, in order for reset of the SDHCI not to fail on some Qualcomm
platforms (e.g. 8974pro). These patches makes it possible to reference these
clocks.

Bjorn Andersson (2):
  mmc: sdhci-msm: Utilize bulk clock API
  mmc: sdhci-msm: Enable delay circuit calibration clocks

 drivers/mmc/host/sdhci-msm.c | 53 +++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

-- 
2.12.0
