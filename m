From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] mmc: sdhci: Make consistent use of CONFIG_MMC_DEBUG
	for "DEBUG"ging
Date: Fri, 27 Aug 2010 20:16:30 +0100
Message-ID: <20100827191630.GH20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46446 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab0H0TQc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:16:32 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "George G. Davis" <gdavis@mvista.com>, Ben Dooks <ben-linux@fluff.org>, akpm@linux-foundation.org

Hi,

This patch wasn't merged, but still applies -- Andrew, mind taking it?

- Chris.

Date: Thu, 18 Feb 2010 12:32:12 -0500
From: "George G. Davis" <gdavis@mvista.com>

The "6882a8c sdhci: Add better ADMA error reporting" commit added
sdhci_show_adma_error() which is built when DEBUG is defined.
Since we already have CONFIG_MMC_DEBUG used elsewhere in this driver,
may as well make consistent use of that config knob instead.

Signed-off-by: George G. Davis <gdavis@mvista.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c279fbc..6c2978c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1398,7 +1398,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		sdhci_finish_command(host);
 }
 
-#ifdef DEBUG
+#ifdef CONFIG_MMC_DEBUG
 static void sdhci_show_adma_error(struct sdhci_host *host)
 {
 	const char *name = mmc_hostname(host->mmc);
-- 
1.6.3.3.311.g43dd

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
