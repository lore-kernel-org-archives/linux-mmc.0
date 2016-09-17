From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.8 rc7
Date: Sat, 17 Sep 2016 12:40:24 +0200
Message-ID: <CAPDyKFrYK_dfUFDwi1cZcfdO_YKG5uXZzV1qEBcd2wAnb3_v5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38838 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761524AbcIQKk1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Sep 2016 06:40:27 -0400
Received: by mail-wm0-f42.google.com with SMTP id 1so81395807wmz.1
        for <linux-mmc@vger.kernel.org>; Sat, 17 Sep 2016 03:40:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here are some mmc fixes intended for v4.8 rc7. They are based on v4.8-rc6.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9395452b4aab7bc2475ef8935b4a4fb99d778d70:

  Linux 4.8-rc6 (2016-09-11 20:02:25 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.8-rc6

for you to fetch changes up to df804d5e27490151da1ce9f216031a31352203e6:

  mmc: omap: Initialize dma_slave_config to avoid random data in it's
fields (2016-09-14 13:59:33 +0200)

----------------------------------------------------------------
MMC host:
 - omap/omap_hsmmc: Initialize dma_slave_config to avoid random data
 - sdhci-st: Handle interconnect clock

----------------------------------------------------------------
Lee Jones (2):
      dt-bindings: mmc: sdhci-st: Mention the discretionary "icn" clock
      mmc: sdhci-st: Handle interconnect clock

Peter Ujfalusi (2):
      mmc: omap_hsmmc: Initialize dma_slave_config to avoid random data
      mmc: omap: Initialize dma_slave_config to avoid random data in it's fields

 Documentation/devicetree/bindings/mmc/sdhci-st.txt |  2 +-
 drivers/mmc/host/omap.c                            | 18 ++++++++++--------
 drivers/mmc/host/omap_hsmmc.c                      | 16 ++++++++--------
 drivers/mmc/host/sdhci-st.c                        | 15 ++++++++++++++-
 4 files changed, 33 insertions(+), 18 deletions(-)
