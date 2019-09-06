From: Pradeep P V K <ppvk@codeaurora.org>
Subject: [RFC 0/2] Add Support for SDHC bus bandwidth voting
Date: Fri,  6 Sep 2019 18:17:15 +0530
Message-ID: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Cc: asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Pradeep P V K <ppvk@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Vote for the MSM bus bandwidth required by SDHC driver
based on the clock speed and bus width of the card. Otherwise,
the system clocks may run at minimum clock speed and
thus affecting the performance.

Adapt to the new ICB framework for bus bandwidth voting.

This requires the source/destination port ids.
Also this requires a tuple of values.

The tuple is for two different paths - from SDHC master
to BIMC slave. The other is from CPU master to SDHC slave.
This tuple consists of the average and peak bandwidth.

This change is based on Georgi Djakov [RFC]
(https://lkml.org/lkml/2018/10/11/499)

Pradeep P V K (2):
  mmc: sdhci-msm: Add support for bus bandwidth voting
  dt-bindings: mmc: sdhci-msm: Add Bus BW vote supported strings

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  32 ++
 drivers/mmc/host/sdhci-msm.c                       | 393 ++++++++++++++++++++-
 2 files changed, 422 insertions(+), 3 deletions(-)

-- 
1.9.1
