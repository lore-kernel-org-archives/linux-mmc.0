From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver Re-Re-Re-Resubmission
Date: Sat, 14 May 2011 17:37:25 -0400
Message-ID: <m3tycxklpm.fsf@pullcord.laptop.org>
References: <1303231971.1622.33.camel@apple-mac>
	<1305117866.1722.14.camel@apple-mac>
	<1305120723.1722.61.camel@apple-mac>
	<m3zkmrv9ll.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38443 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758885Ab1ENVfT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 14 May 2011 17:35:19 -0400
In-Reply-To: <m3zkmrv9ll.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Thu, 12 May 2011 18:26:46 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Thu, May 12 2011, Chris Ball wrote:
> Since the remaining objections are minor style issues, I think it makes
> sense to merge this to mmc-next now and deal with further improvements
> as patches on top of this one (which could get rebased into the original
> patch later, or not).  Would any reviewers like to provide their
> Reviewed-by before I do so?

I've pushed the vub300 patch to mmc-next now for testing, and will
continue accepting Reviewed-bys to add to it.  I'm also going to make
some small further style changes and send them to Tony to ACK, and
then fold them into the original patch before sending it to mainline.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
