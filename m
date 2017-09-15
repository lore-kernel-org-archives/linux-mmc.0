From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 0/2] Support SDHCI on 8974pro devices
Date: Fri, 15 Sep 2017 16:35:22 -0700
Message-ID: <20170915233524.1375-1-bjorn.andersson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:44462 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdIOXf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Sep 2017 19:35:29 -0400
Received: by mail-pg0-f47.google.com with SMTP id j16so2324024pga.1
        for <linux-mmc@vger.kernel.org>; Fri, 15 Sep 2017 16:35:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, devicetree@vger.kernel.org

The calibration clocks for the delay circut should be enabled, as done in the
downstream kernel, in order for reset of the SDHCI not to fail on some Qualcomm
platforms (e.g. 8974pro). These patches makes it possible to reference these
clocks.

Bjorn Andersson (2):
  mmc: sdhci-msm: Utilize bulk clock API
  mmc: sdhci-msm: Enable delay circuit calibration clocks

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  2 +
 drivers/mmc/host/sdhci-msm.c                       | 90 +++++++++++-----------
 2 files changed, 46 insertions(+), 46 deletions(-)

-- 
2.12.0

