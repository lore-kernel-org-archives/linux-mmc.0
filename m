From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller
Date: Sat, 29 Mar 2014 16:19:20 +0000
Message-ID: <86k3bdugdz.fsf@void.printf.net>
References: <1392736109-3981-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140329161440.2c39440f@skate>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34881 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbaC2QT1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 29 Mar 2014 12:19:27 -0400
In-Reply-To: <20140329161440.2c39440f@skate> (Thomas Petazzoni's message of
	"Sat, 29 Mar 2014 16:14:40 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Device Tree <devicetree@vger.kernel.org>

Hi Thomas,

On Sat, Mar 29 2014, Thomas Petazzoni wrote:
> The below patch was originally sent on February, 18th. On February
> 25th, I sent a reply to get some news. Then, again on March, 20th, I
> sent again a reply to get some news. I have never heard back from you
> about this patch since a month and a half. The patch is fairly simple,
> and not having it merged prevents from enabling SDHCI on a new platform
> we're working.

I'm sorry about this.  I didn't see either of your previous pings --
they were both marked as spam by SpamAssassin due to a failing
RCVD_ILLEGAL_IP test.  That test is supposed to signify that there is
an invalid IP in a Received: header, but I don't see such an IP, so
I'm suspecting it might be a SpamAssassin bug.  It looks like between
the first two pings and this one, free-electrons.com moved from
Hetzner to OVH, and that stopped the test failing.  Just letting you
know in case it's widespread.  I should try upgrading SpamAssassin.

(Still, I should have noticed your pings on the list too.)

> Could you consider applying the patch for 3.15, or at least, give some
> review comments if any?

Yes, looks good, pushed to mmc-next for 3.15, thanks.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
