From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/38] mmc: sdhci: hack up driver to make it more
	compliant with UHS-1
Date: Fri, 25 Apr 2014 13:49:45 +0100
Message-ID: <20140425124945.GM26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <E1Wd2WT-0003vg-Ke@rmk-PC.arm.linux.org.uk> <20140425123820.GA15179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50525 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751196AbaDYMuh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 08:50:37 -0400
Content-Disposition: inline
In-Reply-To: <20140425123820.GA15179@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org

On Fri, Apr 25, 2014 at 02:38:20PM +0200, Markus Pargmann wrote:
> Hi,
> 
> On Wed, Apr 23, 2014 at 08:07:57PM +0100, Russell King wrote:
> > Patch suggested by Dong Aisheng <dongas86@gmail.com>, this avoids
> > additional clock start/stop cycles during the transition to 1.8V
> > signalling mode.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I tested the series on imx6s with a RIoT board. With this patch applied
> the RIoT board emmc does not work. Here is the output of the board:

Unfortunately, I don't have any emmc sdhci using devices, so this is
a combination I can't test myself.

What would be useful is to find out which of the two changes in there
is the cause - can you try with just the change to
sdhci_do_start_signal_voltage_switch applied, iow just this change:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 748333ba6e96..0bcef2d42da4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1757,9 +1748,6 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		ctrl |= SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		/* Wait for 5ms */
-		usleep_range(5000, 5500);
-
 		/* 1.8V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (ctrl & SDHCI_CTRL_VDD_180)

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
