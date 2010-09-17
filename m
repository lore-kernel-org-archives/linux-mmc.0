From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] sdhci: add MMC_CAP_8_BIT_DATA in the Host
	capabilities
Date: Fri, 17 Sep 2010 23:19:08 +0100
Message-ID: <20100917221907.GB19979@void.printf.net>
References: <4C7CE075.8060309@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57924 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946Ab0IQWTK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Sep 2010 18:19:10 -0400
Content-Disposition: inline
In-Reply-To: <4C7CE075.8060309@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Date: Tue, 31 Aug 2010 05:43:45 +0200
Subject: [PATCH (sh-2.6.32.y)] sdhci: add MMC_CAP_8_BIT_DATA in the Host capabilities

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 955cad9..1c49326 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1799,7 +1799,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->caps = MMC_CAP_SDIO_IRQ;
 
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
 
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
