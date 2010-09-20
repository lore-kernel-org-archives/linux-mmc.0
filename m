From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely registering when a new sd card is inserted
Date: Sun, 19 Sep 2010 17:50:30 -0700 (PDT)
Message-ID: <513651.95215.qm@web37608.mail.mud.yahoo.com>
References: <20100919105632.6fb34fa5@aether.home.pioto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web37608.mail.mud.yahoo.com ([209.191.87.91]:25395 "HELO
	web37608.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754408Ab0ITAuc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 19 Sep 2010 20:50:32 -0400
In-Reply-To: <20100919105632.6fb34fa5@aether.home.pioto.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Kelly <pioto@pioto.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

> 
> Unfortunately, it doesn't seem to make a difference here.
> When I plug
> in my sd card, it looks like tifm_sd gets loaded, lots of
> debugging
> output. But, no /dev/mmcblk0 shows up, and mmc_block does
> not get
> loaded.
> 

It's not created, because media times out. Why it happens is a different
question. It may be that clock parameters or something similar are not
properly configured (I don't have any datasheets for these devices).
There can also be a mechanical failure of the SD socket (these things do
happen).

Can you confirm that the socket and media are good, by trying them out
under windows or something?

Additional approach you can follow is to try and enable SDHCI interface
if it's available on your chip (xx21 have it and can be made to use it)
and then try it with sdhci.ko driver.

If you want to experiment with sdhci (a tricky exercise), some information
is available here:
http://www.gentoo-wiki.info/Acer_Ferrari_4005WLMi#SDHCI



      
