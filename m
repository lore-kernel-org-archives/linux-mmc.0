From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
 and card detection
Date: Fri, 25 Feb 2011 00:03:01 +0800
Message-ID: <20110224160300.GA1483@S2100-06.ap.freescale.net>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
 <20110224081803.GA29530@S2100-06.ap.freescale.net>
 <20110224155126.GA1466@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:29896
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752306Ab1BXQD6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 11:03:58 -0500
Received: from mail56-db3 (localhost.localdomain [127.0.0.1])	by
 mail56-db3-R.bigfish.com (Postfix) with ESMTP id CCB0216900BF	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 16:03:51 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.248])	by
 mail56-db3.bigfish.com (Postfix) with ESMTP id 52E8BB1804D	for
 <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 16:03:51 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1OG3M9e020330	for <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 09:03:24
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1OG3LkN010422	for <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 10:03:22
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110224155126.GA1466@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 24, 2011 at 11:51:28PM +0800, Shawn Guo wrote:
> On Thu, Feb 24, 2011 at 04:18:05PM +0800, Shawn Guo wrote:
> > Hi Wolfram,
> > 
> > On Wed, Feb 23, 2011 at 02:51:53PM +0100, Wolfram Sang wrote:
> > > Take #3, changes:
> > > 
> > > * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> > > * remove unconditional BROKEN_CARD_DETECTION (leftover)
> > > * improved kernel-doc about unused GPIO
> > > * added tags from Eric
> > > 
> > > Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> > > chance to retest on mx51? What about the FSL guys? :)
> > > 
> > I'm testing it on mx25 3ds and mx51 babbage. Both card-detect and
> > write-protect are working on mx25 3ds, but write-protect has some
> > problem on babbage, and I need some time to figure it out.
> > 
> I just figured out why wp_gpio does not work on mx51.
> 
> +       if (cpu_is_mx25() || cpu_is_mx35()) {
> +               /* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
>                 host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
> +               /* write_protect can't be routed to controller, use gpio */
> +               sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
> +       }
> 
> Would it make sense to do the same for mx51?  On babbage board,
> SD1_WP is routed to controller, but SD2_WP is not, so we have to use
> gpio for SD2 write_protect.
> 
We should probably have esdhc_pltfm_get_ro whenever platform provides
a wp_gpio, and fall on controller SD_WP only when platform does not
provide the wp_gpio.

-- 
Regards,
Shawn

