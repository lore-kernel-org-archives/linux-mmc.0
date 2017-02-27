From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 0/4] fix some incorrect timeout clock getting from sdhci variant drivers
Date: Mon, 27 Feb 2017 16:29:00 +0800
Message-ID: <1488184144-122285-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:60286 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdB0IgJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 03:36:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Masahiro Yamada <yamada.masahiro@socionext.com>, Shawn Lin <shawn.lin@rock-chips.com>


This was found by Anssi Hannula that the the timeout clock actually
should be in KHz from the .get_timeout_clock callback. So patch 4
is a slighlt improvement based on Anssi's patch[1].

As for the fact that the only three users of this callback(arasan, bcm,
and cadence) get the timeout value from the common clock framework and
more precisely they use the pltfm_host->clk for the timeout clock case,
so we are prone to believe that the potential coming users would follow
the same case here that it's worth slightly some improvment to make the
code better. Firstly we expect the variant drivers to return the timeout
clock in Hz unit and explicitly make comment there. Then we fix the
sdhci core and the corrsponding three users.

Please review and comment.

[1]: https://patchwork.kernel.org/patch/9569431/

Changes in v2:
- fix the comment and make it return in Hz

Anssi Hannula (1):
  mmc: sdhci-of-arasan: fix incorrect timeout clock

Shawn Lin (3):
  mmc: sdhci: add comment for get_timeout_clock callback
  mmc: sdhci: get the timeout_clk from callback in Hz
  mmc: sdhci-cadence: fix the return value of
    sdhci_cdns_get_timeout_clock

 drivers/mmc/host/sdhci-cadence.c   |  5 +++--
 drivers/mmc/host/sdhci-of-arasan.c | 23 +----------------------
 drivers/mmc/host/sdhci.c           |  7 +++++--
 drivers/mmc/host/sdhci.h           |  1 +
 4 files changed, 10 insertions(+), 26 deletions(-)

-- 
1.9.1


