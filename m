From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 0/4] Extend sdhci-esdhc-imx card_detect and
 write_protect support for mx5
Date: Tue, 21 Jun 2011 22:12:25 +0800
Message-ID: <20110621141223.GD9228@S2101-09.ap.freescale.net>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
 <20110621013905.GB6294@S2101-09.ap.freescale.net>
 <87oc1ra59b.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:20724 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab1FUOCO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 10:02:14 -0400
Content-Disposition: inline
In-Reply-To: <87oc1ra59b.fsf@lebrac.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Tue, Jun 21, 2011 at 11:44:00AM +0200, Arnaud Patard wrote:
> Shawn Guo <shawn.guo@freescale.com> writes:
> 
> > Hi Arnaud,
> 
> Hi,
> 
> >
> > Would you please give a test on the series, as it fixed the issue
> > you reported?  TIA.
> 
> I've tested it yesterday on my efika platforms and the issue is
> gone. Moreover, the differents card slot on theses platforms are using
> each card detect type (internally connected, gpio, no card detect) and
> they are all working as expected. I'm a little bit annoyed by the
> polling on the slot without card detect but this has nothing to do with
> this patchset.
> 
That's great.

> Side note: turns out that the driver is using dev_warn when failing to
> get cd gpio/irq. Given that in theses cases, it jumps to
> no_card_detect_pin and makes the probe fail, maybe a dev_err would be
> better ? 
> 
Though it's the existing code, I respect the comment and will make the
change in the v4.

> Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
Thanks for testing.

-- 
Regards,
Shawn

