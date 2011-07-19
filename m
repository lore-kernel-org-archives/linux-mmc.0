From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
Date: Tue, 19 Jul 2011 16:59:45 +0800
Message-ID: <20110719085944.GJ3838@S2100-06.ap.freescale.net>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
 <m2pqljje3w.fsf@bob.laptop.org>
 <20110710013708.GA14492@S2100-06.ap.freescale.net>
 <m262mzavhb.fsf@bob.laptop.org>
 <20110719081027.GM20587@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:27711
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752531Ab1GSIwt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2011 04:52:49 -0400
Content-Disposition: inline
In-Reply-To: <20110719081027.GM20587@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jul 19, 2011 at 10:10:27AM +0200, Sascha Hauer wrote:
> On Mon, Jul 18, 2011 at 09:51:28PM -0400, Chris Ball wrote:
> > Hi Shawn, Sascha,
> > 
> > On Sat, Jul 09 2011, Shawn Guo wrote:
> > >> > Shawn Guo (4):
> > >> >       mmc: sdhci-esdhc-imx: do not reference platform data after probe
> > >> >       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
> > >> >       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
> > >> >       mmc: sdhci-esdhc-imx: add device tree probe support
> > >> 
> > >> These don't apply against mmc-next -- what is your tree based on?
> > >> 
> > > It's based on linux-next with following patch applied.
> > >
> > > [PATCH v4 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
> > > write_protect support for mx5
> > > http://permalink.gmane.org/gmane.linux.kernel.mmc/8748
> > >
> > > You applied the 3 of 4 patches in that series, and expect Sascha to
> > > send this one through his tree after you send those 3.
> 
> Shawn, please ping me once all dependencies have been merged. I have no
> influence when my patches get merged since my patches go via Arnd.
> 
Ok, will do.

-- 
Regards,
Shawn

