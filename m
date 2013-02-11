From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH REPOST] mmc: bcm2835: set SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
Date: Mon, 11 Feb 2013 11:36:24 -0500
Message-ID: <87k3qest87.fsf@octavius.laptop.org>
References: <1360382187-26296-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36050 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757854Ab3BKQg2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 11:36:28 -0500
In-Reply-To: <1360382187-26296-1-git-send-email-swarren@wwwdotorg.org>
	(Stephen Warren's message of "Fri, 8 Feb 2013 20:56:27 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Stephen,

On Fri, Feb 08 2013, Stephen Warren wrote:
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK does basically the same as
> implementing struct sdhci_ops .get_timeout_clock, so simply set that
> quirk and remove the custom code to simplify the driver.
>
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

This conflicts with Lars-Peter's larger patch, which I just merged --
I could merge the changes from both, which reduces your patch to this:

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 1e97b89..8ffea05 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -133,11 +133,11 @@ static struct sdhci_ops bcm2835_sdhci_ops = {
 	.read_b = bcm2835_sdhci_readb,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
-	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 };
 
 static struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.ops = &bcm2835_sdhci_ops,
 };


Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
