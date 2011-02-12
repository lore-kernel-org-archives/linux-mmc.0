From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: sdhci: Replace SDHCI_QUIRK_NO_MULTIBLOCK with
 a platform hook.
Date: Sat, 12 Feb 2011 21:43:50 +0100
Message-ID: <20110212204350.GA23657@pengutronix.de>
References: <m3zkq9n115.fsf@pullcord.laptop.org>
 <20110207174839.GF3123@pengutronix.de>
 <20110212202212.GA11375@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37931 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab1BLUnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 15:43:52 -0500
Content-Disposition: inline
In-Reply-To: <20110212202212.GA11375@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

On Sat, Feb 12, 2011 at 08:22:12PM +0000, Chris Ball wrote:
> Hi Wolfram,
> 
> On Mon, Feb 07, 2011 at 06:48:39PM +0100, Wolfram Sang wrote:
> > Hmm, for now I don't have a better alternative, but I somehow hink there must
> > be a better solution than to add one hook per [...]
> 
> If there still isn't a better alternative in mind, I'm thinking about
> going ahead and taking this patch, and then reusing the quirk bit for
> Chuanxiao's "mmc: set a suitable max_discard_sectors value for HC"
> patchset.

What about using the SZ_2048 quirk instead which could be done via
io-accessors? That being said, I have a train travel tomorrow and will try to
see if a fixup() function would make sense for this one. Can you wait one more
day?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
