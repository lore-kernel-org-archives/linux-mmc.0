From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] MMC:mmc_spi: Recover from CRC error for SD read/write
 operation over SPI.
Date: Sat, 16 Oct 2010 19:11:21 -0400
Message-ID: <AANLkTikpjGaz9vuw8Sp+zGSiihmHHYyvxxS031xH3KMH@mail.gmail.com>
References: <20100827203639.GT23079@void.printf.net> <1287263976-9578-1-git-send-email-vapier@gentoo.org>
 <20101016230129.GA21304@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43862 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab0JPXLv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Oct 2010 19:11:51 -0400
In-Reply-To: <20101016230129.GA21304@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Anton Vorontsov <avorontsov@mvista.com>, Ernst Schwab <eschwab@online.de>, Sonic Zhang <sonic.zhang@analog.com>

On Sat, Oct 16, 2010 at 19:01, Chris Ball wrote:
> On Sat, Oct 16, 2010 at 05:19:36PM -0400, Mike Frysinger wrote:
>> Andrew: we posted this months ago with no feedback ... could you pick it up ?
>
> Sorry, my fault for missing this -- I've pushed it to mmc-next now,
> with minor language changes.

np.  thanks !
-mike
