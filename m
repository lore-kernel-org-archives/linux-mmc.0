From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] Fix sd/sdio/mmc initialization frequency retries
Date: Tue, 4 Jan 2011 01:29:02 +0000
Message-ID: <20110104012901.GA8788@void.printf.net>
References: <4D1A1B19.8000902@windriver.com> <20101231044942.GC19122@void.printf.net> <4D221748.5040701@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35440 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab1ADB3I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Jan 2011 20:29:08 -0500
Content-Disposition: inline
In-Reply-To: <4D221748.5040701@windriver.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: linux-mmc@vger.kernel.org, Hein Tibosch <hein_tibosch@yahoo.es>, Pierre Ossman <pierre@ossman.eu>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, Matt Fleming <matt@console-pimps.org>

Hi Andy,

On Mon, Jan 03, 2011 at 10:36:56AM -0800, Andy Ross wrote:
> Subject: [PATCH] Fix sd/sdio/mmc initialization frequency retries
> 
> Rewrite and clean up mmc_rescan() to properly retry frequencies lower
> than 400kHz.  Failures can happen both in sd_send_* calls and
> mmc_attach_*.  Break out "mmc_rescan_try_freq" from the frequency
> selection loop.  Symmetrize claim/release logic in mmc_attach_* API,
> and move the sd_send_* calls there to make mmc_rescan easier to read.
> 
> Signed-off-by: Andy Ross <andy.ross@windriver.com>

Thanks!  Pushed to mmc-next for .38, after adding Reviewed-by: tags and
removing the mmc_bus_{put,get}() comment, since I'll take care of that
separately.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
