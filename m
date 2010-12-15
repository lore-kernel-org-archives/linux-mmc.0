From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Wed, 15 Dec 2010 05:24:54 -0600
Message-ID: <20101215112454.GA2086@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-3-git-send-email-olof@lixom.net> <AANLkTint+ObCy3Mak4E1Cj+2TS_4vbpZm57tXK_-CJ+K@mail.gmail.com> <20101215105443.GA32297@lixom.net> <20101215110312.GE3515@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:33618 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab0LOLYz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 06:24:55 -0500
Content-Disposition: inline
In-Reply-To: <20101215110312.GE3515@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On Wed, Dec 15, 2010 at 12:03:12PM +0100, Wolfram Sang wrote:
> 
> > > Really appreciate if not using the valuable quirk resource, which is u32.
> > 
> > No big deal. Next person that needs a quirk bit gets to bump the data
> > type to u64.
> 
> That won't scale for long, I fear (and will make sdhci.c an unreadable
> mess). We need less quirks and more flexible means to handle flawed
> controllers, I'd think.

It won't scale for long, but it'll give a buffer while a cleaned up
quirk structure can be hashed out and implemented.

There are already a handful of quirks in there that can be trivially
moved into their respective drivers by overriding the register read/write
functions (like I already have for a couple on sdhci-tegra). Some of
the others are not obvious to me how they can be easily abstracted out
without adding even more callbacks up and down the stack for adding hooks.


-Olof

