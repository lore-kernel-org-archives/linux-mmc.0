From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely registering when a new sd card is inserted
Date: Mon, 20 Sep 2010 20:50:21 -0700 (PDT)
Message-ID: <731551.27747.qm@web37608.mail.mud.yahoo.com>
References: <20100920232517.4299f662@aether.home.pioto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web37608.mail.mud.yahoo.com ([209.191.87.91]:29161 "HELO
	web37608.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754654Ab0IUDuW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Sep 2010 23:50:22 -0400
In-Reply-To: <20100920232517.4299f662@aether.home.pioto.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Kelly <pioto@pioto.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

> > Can you confirm that the socket and media are good, by
> trying them out
> > under windows or something?
> 
> The same SD card and reader work fine under Windows Vista
> on this same
> machine. Ditto other SD cards in this reader. The fact that
> I am
> occasionally able to get this reader to work under Linux,
> though does
> make it seem like some timing or race issue that I'm
> hitting, though.
> 

It does not look like a pure software issue from the debug trace.
Host issues initialisation commands to the media (8, 5, 55), each is retried 3 times. For all of them, command execution fails with
hardware error flag set (and those are cleaned in between).

I still tend to blame improper hardware initialisation, but I'll try
to look and see if there can be something else.



      
