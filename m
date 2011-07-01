From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and write_protect support for mx5
Date: Fri, 01 Jul 2011 19:06:54 -0400
Message-ID: <m2liwh4n3l.fsf@bob.laptop.org>
References: <1308667311-1855-1-git-send-email-shawn.guo@linaro.org>
	<20110627013826.GB21415@S2100-06.ap.freescale.net>
	<m27h88djf6.fsf@bob.laptop.org>
	<20110627042345.GA21757@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35189 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757657Ab1GAXHT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jul 2011 19:07:19 -0400
In-Reply-To: <20110627042345.GA21757@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Mon, 27 Jun 2011 12:23:46 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: patches@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Eric Benard <eric@eukrea.com>, Philip Rakity <prakity@marvell.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

Hi,

On Mon, Jun 27 2011, Shawn Guo wrote:
>> I'll need to rebase mmc-next onto linux-next before I can merge it,
>> because the mach-imx/ board files you're modifying do not exist in
>> Linus' tree.  (I don't mind doing that, but it might be easier if
>> you had the ARM patches go in via a different tree instead.)
> 
> I can ask Sascha to pick up patch #4 with your ack.  But the problem
> is patch #4 has to work with #1 applied first, otherwise the CD
> interrupt storm will freeze the system.

Let's do that, please.  I've merged #1-#3 to mmc-next, and for #4:

Acked-by: Chris Ball <cjb@laptop.org>

(Sascha, please note that you'll have to send #4 to Linus after I send
the MMC pull request, as Shawn explains above.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
