From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: Replace SDHCI_QUIRK_NO_MULTIBLOCK with
	a platform hook.
Date: Sat, 12 Feb 2011 20:22:12 +0000
Message-ID: <20110212202212.GA11375@void.printf.net>
References: <m3zkq9n115.fsf@pullcord.laptop.org> <20110207174839.GF3123@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49656 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab1BLUWO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 Feb 2011 15:22:14 -0500
Content-Disposition: inline
In-Reply-To: <20110207174839.GF3123@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

Hi Wolfram,

On Mon, Feb 07, 2011 at 06:48:39PM +0100, Wolfram Sang wrote:
> Hmm, for now I don't have a better alternative, but I somehow hink there must
> be a better solution than to add one hook per [...]

If there still isn't a better alternative in mind, I'm thinking about
going ahead and taking this patch, and then reusing the quirk bit for
Chuanxiao's "mmc: set a suitable max_discard_sectors value for HC"
patchset.

(Anton, please speak up if this quirk removal isn't okay with you.)

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
