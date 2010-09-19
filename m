From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely registering when a new sd card is inserted
Date: Sat, 18 Sep 2010 22:19:42 -0700 (PDT)
Message-ID: <929512.43617.qm@web37607.mail.mud.yahoo.com>
References: <20100918050127.39ab1e8b@aether.home.pioto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web37607.mail.mud.yahoo.com ([209.191.87.90]:28759 "HELO
	web37607.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751450Ab0ISFTp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 19 Sep 2010 01:19:45 -0400
In-Reply-To: <20100918050127.39ab1e8b@aether.home.pioto.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Kelly <pioto@pioto.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

> Log is attached. It seems that this time, no entry shows up
> in /dev at
> all, even if I modprobe mmc_block manually.
> 
> -- 

The driver appears to do everything right. The problem is that your media
timeouts on the initialization commands, so driver decides it's not worth
operating.

There's a module option of tifm_sd called "fixed_timeout" (check it out with
modinfo). It will preclude setting of hardware timeout register. Lets see
what it does on your setup.




      
