From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH v3 0/4] Extend sdhci-esdhc-imx card_detect and write_protect support for mx5
Date: Tue, 21 Jun 2011 11:44:00 +0200
Message-ID: <87oc1ra59b.fsf@lebrac.rtp-net.org>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
	<20110621013905.GB6294@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:44239 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab1FUJoP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 05:44:15 -0400
In-Reply-To: <20110621013905.GB6294@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Tue, 21 Jun 2011 09:39:06 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Shawn Guo <shawn.guo@freescale.com> writes:

> Hi Arnaud,

Hi,

>
> Would you please give a test on the series, as it fixed the issue
> you reported?  TIA.

I've tested it yesterday on my efika platforms and the issue is
gone. Moreover, the differents card slot on theses platforms are using
each card detect type (internally connected, gpio, no card detect) and
they are all working as expected. I'm a little bit annoyed by the
polling on the slot without card detect but this has nothing to do with
this patchset.

Side note: turns out that the driver is using dev_warn when failing to
get cd gpio/irq. Given that in theses cases, it jumps to
no_card_detect_pin and makes the probe fail, maybe a dev_err would be
better ? 

Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Thanks,
Arnaud
