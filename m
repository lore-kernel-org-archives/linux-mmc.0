From: Alex Dubov <oakad@yahoo.com>
Subject: Re: direct dependencies (MISC_DEVICES && EXPERIMENTAL && PCI)
Date: Mon, 27 Dec 2010 18:31:22 -0800 (PST)
Message-ID: <43226.74878.qm@web37604.mail.mud.yahoo.com>
References: <201012271346.51610.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web37604.mail.mud.yahoo.com ([209.191.87.87]:33116 "HELO
	web37604.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753054Ab0L1CiG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Dec 2010 21:38:06 -0500
In-Reply-To: <201012271346.51610.toralf.foerster@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-mmc@vger.kernel.org

> Hello,
> 
> a "make randconfig 1>/dev/null" gave today :
> 
> warning: (MMC_TIFM_SD && MMC &&
> EXPERIMENTAL && PCI || MEMSTICK_TIFM_MS &&
> MEMSTICK && EXPERIMENTAL && PCI) selects
> TIFM_CORE which 
> has unmet direct dependencies (MISC_DEVICES &&
> EXPERIMENTAL && PCI)
> 
> for the current git kernel sources.
> Is this an already known issue ?

For some reason, all drivers in drivers/misc have this recently added
pseudo-dependency that groups them together.
Probably it can be propagated to the mmc/memstick Kconfig files, even
though I don't quite understand why this grouping was added in the first
place.




      
