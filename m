From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Sat, 22 Oct 2011 12:55:01 -0400
Message-ID: <m2vcrh55lm.fsf@bob.laptop.org>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<m24nz171vj.fsf@bob.laptop.org>
	<CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36432 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab1JVQzJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Oct 2011 12:55:09 -0400
In-Reply-To: <CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
	(Linus Walleij's message of "Sat, 22 Oct 2011 18:33:57 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrei Warkentin <awarkentin@vmware.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>, linux-mmc@vger.kernel.org

Hi Linus,

On Sat, Oct 22 2011, Linus Walleij wrote:
> So what about a cmdline approach? That makes it possible
> for people who are willingly recompiling and hacking their kernels
> to tinker with this if they absolutely want to go in on that
> partition, make it rw and change stuff.
>
> ...org have I just got all this backwards...?

Regarding this patch, we're not so worried that someone will take a
read-only boot partition and make it read-write and do something wrong;
sysfs is good enough to protect against that happening (at least by
mistake).

What we're worried about is someone issuing the perm read-only command,
and not realizing that it really means that they can never ever write
any more changes to their eMMC -- it's a one-time fuse -- and perhaps
further not realizing that this may make their expensive cell phone
become a brick of some sort, depending on how much the bootloader or
OS depends on having r/w access.

I don't even know that I'd want to make such an option available via a
boot argument, since boot arguments are often misunderstood.  As Andrei
says, it doesn't sound like something a regular user (as opposed to an
OEM) should ever have reason to do.  I'd rather leave it to specialized
manufacturing equipment.

Does that make sense?  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
