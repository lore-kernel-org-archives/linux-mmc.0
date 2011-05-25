From: Chris Ball <cjb@laptop.org>
Subject: Re: CMD23 plumbing patchset.
Date: Tue, 24 May 2011 22:51:10 -0400
Message-ID: <m3fwo3wl0h.fsf@pullcord.laptop.org>
References: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
	<1306181199-13915-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44966 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab1EYCtu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 May 2011 22:49:50 -0400
In-Reply-To: <1306181199-13915-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Mon, 23 May 2011 15:06:34 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Andrei,

On Mon, May 23 2011, Andrei Warkentin wrote:
> This is the 6th version of the patchset. Made sure that Auto-CMD(12|23)
> is called *_AUTO_CMD* instead of *_ACMD*.
>
> Also removed an unnecessary check for v3 spec, since one is already in place
> after Arindam's patches.
>
> ToC:
> [v6 1/5] MMC: Add/remove quirks conditional support.
> [v6 2/5] MMC: Use CMD23 for multiblock transfers when we can.
> [v6 3/5] MMC: Implement MMC_CAP_CMD23 for SDHCI.
> [v6 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
> [v6 5/5] MMC: SDHCI AutoCMD23 support.

Thanks, I'll merge this for .40 with the following printk level change --
I don't think we should bother KERN_INFO with CMD23 availability:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c29e067..62d1bba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2500,9 +2500,9 @@ int sdhci_add_host(struct sdhci_host *host)
            ((host->flags & SDHCI_USE_ADMA) ||
             !(host->flags & SDHCI_REQ_USE_DMA))) {
                host->flags |= SDHCI_AUTO_CMD23;
-               printk(KERN_INFO "%s: Auto-CMD23 available\n", mmc_hostname(mmc));
+               DBG("%s: Auto-CMD23 available\n", mmc_hostname(mmc));
        } else
-               printk(KERN_INFO "%s: Auto-CMD23 unavailable\n", mmc_hostname(mmc);
+               DBG("%s: Auto-CMD23 unavailable\n", mmc_hostname(mmc));
 
        /*
         * A controller may support 8-bit width, but the board itself

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
