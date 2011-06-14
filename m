From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/4] mmc: sdhci: fix interrupt storm from card detection
Date: Tue, 14 Jun 2011 19:55:58 +0800
Message-ID: <20110614115557.GF30295@S2100-06.ap.freescale.net>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
 <20110614092410.GB5043@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:40035
	"EHLO CH1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756289Ab1FNLvZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 07:51:25 -0400
Content-Disposition: inline
In-Reply-To: <20110614092410.GB5043@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Tue, Jun 14, 2011 at 11:24:10AM +0200, Wolfram Sang wrote:
> On Fri, Jun 10, 2011 at 06:42:49PM +0800, Shawn Guo wrote:
> > The issue was initially found by Eric Benard as below.
> > 
> > http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031
> > 
> > Not sure about other SDHCI based controller, but on Freescale eSDHC,
> > the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
> > gets cleared, if a card is inserted. The driver need to mask the irq
> > to prevent interrupt storm which will freeze the system.  And the
> > SDHCI_INT_CARD_REMOVE gets the same situation.
> > 
> > The patch fixes the problem based on the initial idea from
> > Eric Benard.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Eric Benard <eric@eukrea.com>
> 
> Hmm, that should get enough testing on non-imx (and even non-ARM)
> devices. And a comment describing the situation.
> 
Agreed.  Will add something in commit message to mention the
situation.  That's why I hope we can get the patch on mmc-next at
early stage of the cycle, so everyone can start testing it and
report problems, if any.

-- 
Regards,
Shawn

