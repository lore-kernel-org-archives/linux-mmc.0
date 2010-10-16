From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC:mmc_spi: Recover from CRC error for SD read/write
	operation over SPI.
Date: Sun, 17 Oct 2010 00:01:30 +0100
Message-ID: <20101016230129.GA21304@void.printf.net>
References: <20100827203639.GT23079@void.printf.net> <1287263976-9578-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56212 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755980Ab0JPXBs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 16 Oct 2010 19:01:48 -0400
Content-Disposition: inline
In-Reply-To: <1287263976-9578-1-git-send-email-vapier@gentoo.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Anton Vorontsov <avorontsov@mvista.com>, Ernst Schwab <eschwab@online.de>, Sonic Zhang <sonic.zhang@analog.com>

On Sat, Oct 16, 2010 at 05:19:36PM -0400, Mike Frysinger wrote:
> Andrew: we posted this months ago with no feedback ... could you pick it up ?

Sorry, my fault for missing this -- I've pushed it to mmc-next now,
with minor language changes.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
