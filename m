From: Alexander Elbs <alex@segv.de>
Subject: Re: regression: sd cards no longer recognized
Date: Tue, 3 Jan 2012 10:53:12 +0100
Message-ID: <20120103095312.GG16096@segv.de>
References: <20120101115146.GE16096@segv.de>
 <m2vcotoch5.fsf@bob.laptop.org>
 <EDCB5254-AA5F-4082-9565-C389399E5893@marvell.com>
 <m2k459o9w8.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from siggy.segv.de ([88.198.14.238]:51742 "EHLO siggy.segv.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2ACJxR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jan 2012 04:53:17 -0500
Content-Disposition: inline
In-Reply-To: <m2k459o9w8.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, Arindam Nath <arindam.nath@amd.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Jan 02, 2012 at 08:24:55PM -0500, Chris Ball wrote:
> Hi,
> 
> On Mon, Jan 02 2012, Philip Rakity wrote:
> > Ack-by: Philip Rakity <prakity@marvell.com>
> 
> Thanks.  Alexander, could you give me a "Signed-off-by:" for the record?
> 


Signed-off-by: Alexander Elbs <alex@segv.de>
---
 drivers/mmc/host/sdhci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 19ed580..5e0de61 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1364,8 +1364,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host,
struct mmc_ios *ios)
                if ((ios->timing == MMC_TIMING_UHS_SDR50) ||
                    (ios->timing == MMC_TIMING_UHS_SDR104) ||
                    (ios->timing == MMC_TIMING_UHS_DDR50) ||
-                   (ios->timing == MMC_TIMING_UHS_SDR25) ||
-                   (ios->timing == MMC_TIMING_UHS_SDR12))
+                   (ios->timing == MMC_TIMING_UHS_SDR25))
                        ctrl |= SDHCI_CTRL_HISPD;
 
                ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-- 
1.7.8.rc3
