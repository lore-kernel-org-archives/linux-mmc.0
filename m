From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/4] sdhci: key 8BITBUS bit off MMC_CAP_8_BIT_DATA
Date: Wed, 09 Aug 2017 22:36:04 +0200
Message-ID: <96ece1eb7b8f6e188e3975f75754aeaf195f3dc0.1502310654.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:60478
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752061AbdHIUgG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2017 16:36:06 -0400
In-Reply-To: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


Hosts supporting 8-bit bus are marked accordingly. If MMC_CAP_8_BIT_DATA
is not among host capabilities, 8BITBUS bit will never be set and it
is not cleared in case some non-SDHCI3 host uses it for something else.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d4350e8a..cca21246cf61 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1544,10 +1544,9 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width)
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 	if (width == MMC_BUS_WIDTH_8) {
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
-		if (host->version >= SDHCI_SPEC_300)
-			ctrl |= SDHCI_CTRL_8BITBUS;
+		ctrl |= SDHCI_CTRL_8BITBUS;
 	} else {
-		if (host->version >= SDHCI_SPEC_300)
+		if (host->mmc->caps & MMC_CAP_8_BIT_DATA)
 			ctrl &= ~SDHCI_CTRL_8BITBUS;
 		if (width == MMC_BUS_WIDTH_4)
 			ctrl |= SDHCI_CTRL_4BITBUS;
-- 
2.11.0

