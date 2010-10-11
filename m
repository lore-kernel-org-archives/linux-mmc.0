From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Mon, 11 Oct 2010 17:59:29 +0100
Message-ID: <20101011165929.GB21335@void.printf.net>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de> <20101011163255.GA21335@void.printf.net> <20101011164459.GB476@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42409 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486Ab0JKQ7a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Oct 2010 12:59:30 -0400
Content-Disposition: inline
In-Reply-To: <20101011164459.GB476@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>

Hi Wolfram,

On Mon, Oct 11, 2010 at 06:44:59PM +0200, Wolfram Sang wrote:
> > Mind fixing up the >80 char lines in the last two patches?  It's just:
> 
> Sigh, I don't think it will help the readability of the code, but if it can't
> be helped...

Okay.  Perhaps as a compromise, just reflow the two lines in 5/6 and
leave the long prototypes in 6/6 as they are?  (For the second hunk
in 5/6, you could just pull the start of the line back two cols.)

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
