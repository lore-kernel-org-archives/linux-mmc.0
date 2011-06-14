From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
 support for mx5
Date: Tue, 14 Jun 2011 21:12:24 +0800
Message-ID: <20110614131223.GI30295@S2100-06.ap.freescale.net>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <20110614064841.GB30295@S2100-06.ap.freescale.net>
 <87ei2wk6na.fsf@lebrac.rtp-net.org>
 <20110614113902.GD30295@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:53070
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824Ab1FNNI1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 09:08:27 -0400
Content-Disposition: inline
In-Reply-To: <20110614113902.GD30295@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 14, 2011 at 07:39:03PM +0800, Shawn Guo wrote:
> On Tue, Jun 14, 2011 at 01:13:29PM +0200, Arnaud Patard wrote:
> > Shawn Guo <shawn.guo@freescale.com> writes:
> > 
> > Hi,
> > 
> > > On Fri, Jun 10, 2011 at 06:42:48PM +0800, Shawn Guo wrote:
> > >> The card-present polling within sdhci based driver is very expensive
> > >> in terms of the impact to system performance.  We observe a few
> > >> system performance issues from Freescale and Linaro on mx5 platforms,
> > >> which have been proved card polling related.
> > >> 
> > >> The patch set extends the current sdhci-esdhc-imx card_detect and
> > >> write_protect support to cover mx5 platforms, and solves above
> > >> performance issues.
> > >> 
> > >> Shawn Guo (4):
> > >>       mmc: sdhci: fix interrupt storm from card detection
> > >>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
> > >>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
> > >>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
> > >> 
> > > Hi Arnaud,
> > >
> > > Any chance to play with it yet?
> > 
> > I tried applying the patch 4 (v2) on mmc git and Sascha Hauer's for-next
> > branch and failed. Can you please tell me on which tree should I apply
> > it ?
> > 
> Sascha really should not picked up the following 3 patches.  They are
> nonsense when driver is not even ready for the support.  These 3
> patches have conflict with my patch set.  You should be able to
> apply with these 3 removed.
> 
> commit 954548c68c2d478bf8ec0ca9d9eea2a7c45a4fcd
> Author: Andre Silva <andre.silva@freescale.com>
> 
>     ARM:mach-mx5/board-mx51_babbage: Add CD and WP GPIOs
> 
> commit ba0c5064cb55aaac4cb5202ecad5afe9385139fc
> Author: Andre Silva <andre.silva@freescale.com>
> 
>     ARM:mach-mx5/board-mx53_loco: Add CD and WP GPIOs
> 
> commit fabef7b7c62ba58604da22b6f79b7e9ad5ae8d74
> Author: Andre Silva <andre.silva@freescale.com>
> 
>     ARM: mach-mx5/mx53_ard: Add support for i.MX53 ARD board
> 
Sascha,

Since these 3 patches are still sitting on top of your tree, would
you mind backing out them?  Or you want me to do a rebase on your
tree?  I'm fine with either one.

-- 
Regards,
Shawn

