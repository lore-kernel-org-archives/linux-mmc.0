From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
Date: Tue, 19 Jul 2011 10:10:27 +0200
Message-ID: <20110719081027.GM20587@pengutronix.de>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
 <m2pqljje3w.fsf@bob.laptop.org>
 <20110710013708.GA14492@S2100-06.ap.freescale.net>
 <m262mzavhb.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56644 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab1GSIKb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2011 04:10:31 -0400
Content-Disposition: inline
In-Reply-To: <m262mzavhb.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Mon, Jul 18, 2011 at 09:51:28PM -0400, Chris Ball wrote:
> Hi Shawn, Sascha,
> 
> On Sat, Jul 09 2011, Shawn Guo wrote:
> >> > Shawn Guo (4):
> >> >       mmc: sdhci-esdhc-imx: do not reference platform data after probe
> >> >       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
> >> >       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
> >> >       mmc: sdhci-esdhc-imx: add device tree probe support
> >> 
> >> These don't apply against mmc-next -- what is your tree based on?
> >> 
> > It's based on linux-next with following patch applied.
> >
> > [PATCH v4 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
> > write_protect support for mx5
> > http://permalink.gmane.org/gmane.linux.kernel.mmc/8748
> >
> > You applied the 3 of 4 patches in that series, and expect Sascha to
> > send this one through his tree after you send those 3.

Shawn, please ping me once all dependencies have been merged. I have no
influence when my patches get merged since my patches go via Arnd.

> 
> I see.  In that case, either Sascha can send this new series with my:
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
> or I'll send it as a second pull request after Sascha sends [4/4].
> 
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
