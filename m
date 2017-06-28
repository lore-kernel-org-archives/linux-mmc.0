From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 0/2] mmc: sdhci: Add SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
Date: Wed, 28 Jun 2017 15:35:02 +0200
Message-ID: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34895 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbdF1NfO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jun 2017 09:35:14 -0400
Received: by mail-io0-f169.google.com with SMTP id h134so35636390iof.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Jun 2017 06:35:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds quirk to support cards which have issues when sdma
boundary buffer bits are programmed in Block Size Register (0x04)
when using ADMA.

First patch adds quirk and second one uses that quirk in msm sdhci driver.

Tested on DB410c with WLAN SDIO card.

thanks,
srini

Srinivas Kandagatla (2):
  mmc: sdhci: add quirk SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
  mmc: sdhci-msm: enable SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER

 drivers/mmc/host/sdhci-msm.c |  3 ++-
 drivers/mmc/host/sdhci.c     | 24 ++++++++++++++++++------
 drivers/mmc/host/sdhci.h     |  2 ++
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.11.0

