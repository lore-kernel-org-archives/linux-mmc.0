From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not
 get cleared
Date: Tue, 21 Jun 2011 22:10:34 +0800
Message-ID: <20110621141033.GC9228@S2101-09.ap.freescale.net>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
 <1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
 <20110621115236.GA14004@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:41710 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1FUOAX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 10:00:23 -0400
Content-Disposition: inline
In-Reply-To: <20110621115236.GA14004@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jun 21, 2011 at 01:52:36PM +0200, Wolfram Sang wrote:
> On Mon, Jun 20, 2011 at 06:38:43PM +0800, Shawn Guo wrote:
> > The function esdhc_readl_le intends to clear bit SDHCI_CARD_PRESENT,
> > when the card detect gpio tells there is no card.  But it does not
> > clear the bit actually.  The patch gives a fix on that.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> For the third time ;)
> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> 
Sorry, my bad.  Will add in v4.

> Should go to stable.
> 
I suppose that Chris will take care of it, otherwise please let me
know what I should do.  (I'm still new to the process)

-- 
Regards,
Shawn

