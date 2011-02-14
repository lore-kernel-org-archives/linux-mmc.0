From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Mon, 14 Feb 2011 00:25:24 +0000
Message-ID: <20110214002524.GA24047@void.printf.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com> <1297650746-12841-2-git-send-email-shawn.guo@freescale.com> <20110213192609.GA21429@void.printf.net> <201102132335.54868.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41526 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225Ab1BNAZr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Feb 2011 19:25:47 -0500
Content-Disposition: inline
In-Reply-To: <201102132335.54868.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@freescale.com>, s.hauer@pengutronix.de, LW@karo-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Sun, Feb 13, 2011 at 11:35:54PM +0100, Arnd Bergmann wrote:
> > Please add a Reviewed-by: from Arnd and a Tested-by: from Lothar.
> > Could you add a MODULE_AUTHOR() field, too?
> 
> In general, these tags should not simply be added by the author without
> having the person who did the reviewing or testing specifically provide
> them!
> 
> In this particular case, I'm happy with the driver in version 2, good job!
> Please do add my
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Ah, okay, sorry.  I do behave that way with S-o-b, but in this case I
wanted to make sure people who put effort into reviewing/testing didn't
go uncredited -- next time I'll send mail to the reviewer/tester
reminding them to add a tag if they're happy.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
