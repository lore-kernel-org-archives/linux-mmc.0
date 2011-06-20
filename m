From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
 support for mx5
Date: Mon, 20 Jun 2011 18:41:04 +0800
Message-ID: <20110620104102.GB23757@S2100-06.ap.freescale.net>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <20110614064841.GB30295@S2100-06.ap.freescale.net>
 <87lix1hbjy.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:9813
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753692Ab1FTKf3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 06:35:29 -0400
Content-Disposition: inline
In-Reply-To: <87lix1hbjy.fsf@lebrac.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, patches@linaro.org, linux-mmc@vger.kernel.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

Hi Arnaud,

Sorry for the late replying.  Somehow I missed the message.

On Thu, Jun 16, 2011 at 08:32:33PM +0200, Arnaud Patard wrote:
> Shawn Guo <shawn.guo@freescale.com> writes:
> 
> Hi,
> 
> > On Fri, Jun 10, 2011 at 06:42:48PM +0800, Shawn Guo wrote:
> >> The card-present polling within sdhci based driver is very expensive
> >> in terms of the impact to system performance.  We observe a few
> >> system performance issues from Freescale and Linaro on mx5 platforms,
> >> which have been proved card polling related.
> >> 
> >> The patch set extends the current sdhci-esdhc-imx card_detect and
> >> write_protect support to cover mx5 platforms, and solves above
> >> performance issues.
> >> 
> >> Shawn Guo (4):
> >>       mmc: sdhci: fix interrupt storm from card detection
> >>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
> >>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
> >>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
> >> 
> > Hi Arnaud,
> >
> > Any chance to play with it yet?
> 
> Finally managed to build a kernel with this version of the
> patchset. While I'm not polling anymore, I'm getting a lot of interrupts
> if the card is not inserted. Theses interrupts are not happening if the
> card is inserted. I can see things like this in the logs :
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000080
> 
> [ of course, the bit of the present state register indicating card
> presence is equal to 0 ]
> 
> I've tested the SIGNAL case only. Don't know if switch to GPIO may help.
> Do you have same kind of issue on your side ?
> 
I reproduced the issue on my side with turn on debug switch (I should
do so from the beginning).

GPIO mode does not have this issue.  But you do not have to switch to
GPIO, as I have got it fixed in the v3 of the patch set (posted out
a few minutes ago).  It can apply on linux-next cleanly.  You need
to note that naming 'SIGNAL' has been changed to 'CONTROLLER' per
Wolfram's comment.

Thanks for testing.

-- 
Regards,
Shawn

