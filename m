From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
Date: Tue, 21 Jun 2011 10:08:11 -0400
Message-ID: <m2ei2ntgz8.fsf@bob.laptop.org>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
	<1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
	<20110621115236.GA14004@pengutronix.de>
	<20110621141033.GC9228@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51404 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab1FUOIa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jun 2011 10:08:30 -0400
In-Reply-To: <20110621141033.GC9228@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Tue, 21 Jun 2011 22:10:34 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi Shawn,

On Tue, Jun 21 2011, Shawn Guo wrote:
>> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
>> 
> Sorry, my bad.  Will add in v4.
>
>> Should go to stable.
>> 
> I suppose that Chris will take care of it, otherwise please let me
> know what I should do.  (I'm still new to the process)

Just add:

Cc: <stable@kernel.org>

to the commit message, please.  (That's all that's necessary to get a
patch seen by the stable@ maintainers.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
