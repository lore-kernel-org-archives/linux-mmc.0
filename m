From: Pradeep P V K <ppvk@codeaurora.org>
Subject: [RFC-v2 0/2] Add Support for SDHC bus bandwidth voting
Date: Fri,  8 Nov 2019 19:08:37 +0530
Message-ID: <1573220319-4287-1-git-send-email-ppvk@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, georgi.djakov@linaro.org, robh+dt@kernel.org, ulf.hansson@linaro.org, asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, sboyd@kernel.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, agross@kernel.org, linux-mmc-owner@vger.kernel.org, Pradeep P V K <ppvk@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Vote for the MSM bus bandwidth required by SDHC driver
based on the clock speed and bus width of the card.
Otherwise, the system clocks may run at minimum clock
speed and thus affecting the performance.

Adapt to the new ICB framework for bus bandwidth voting.

This requires the source/destination port ids.
Also this requires a tuple of values.

The tuple is for two different paths - from SDHC master
to BIMC slave. The other is from CPU master to SDHC slave.
This tuple consists of the average and peak bandwidth.

This change is based on Georgi Djakov [RFC]
(https://lkml.org/lkml/2018/10/11/499)

---
changed since v1:
* Addressed all the Review comments.
* Minor code rebasing.

Pradeep P V K (2):
  dt-bindings: mmc: sdhci-msm: Add Bus BW vote supported strings
  mmc: sdhci-msm: Add support for bus bandwidth voting

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  32 ++
 drivers/mmc/host/sdhci-msm.c                       | 366 ++++++++++++++++++++-
 2 files changed, 395 insertions(+), 3 deletions(-)

-- 
1.9.1
