From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/6] mmc: Fix error handling for mmc_of_parse()
Date: Thu, 18 Dec 2014 10:41:38 +0100
Message-ID: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:63852 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLRJl4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:41:56 -0500
Received: by mail-wg0-f51.google.com with SMTP id x12so1091371wgg.10
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 01:41:55 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Some mmc host drivers don't deal with errors from mmc_of_parse(). Patch 1 -> 5
fix these drivers.

Patch 6, make mmc_of_parse() to return errors at failures instead of ignoring
them. This patch indirectly also fixes a bug for the internal error handling in
mmc_of_parse().


Ulf Hansson (6):
  mmc: moxart: Handle error from mmc_of_parse()
  mmc: sdhci-bcm-kona: Handle error from mmc_of_parse()
  mmc: sdhci-of-esdhc: Handle error from mmc_of_parse()
  mmc: sdhci-s3c: Handle error from mmc_of_parse()
  mmc: sdhci-st: Do cleanup while mmc_of_parse() return an error
  mmc: core: Return error at failure of request CD/WP in mmc_of_parse()

 drivers/mmc/core/host.c           | 28 ++++++----------------------
 drivers/mmc/host/moxart-mmc.c     |  4 +++-
 drivers/mmc/host/sdhci-bcm-kona.c |  4 +++-
 drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++--
 drivers/mmc/host/sdhci-s3c.c      |  4 +++-
 drivers/mmc/host/sdhci-st.c       |  4 ++--
 6 files changed, 25 insertions(+), 29 deletions(-)

-- 
1.9.1

