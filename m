From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 21:38:53 +0200
Message-ID: <201104202138.53981.arnd@arndb.de>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <201104202117.14463.arnd@arndb.de> <alpine.DEB.2.00.1104201226510.28361@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52003 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab1DTTi6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 15:38:58 -0400
In-Reply-To: <alpine.DEB.2.00.1104201226510.28361@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

On Wednesday 20 April 2011 21:34:20 John Calixto wrote:
> On Wed, 20 Apr 2011, Arnd Bergmann wrote:
> > 
> > No need for a union or a ptr_size member in the struct. Just use
> > a single __u64 and let the user cast the pointer to that. This
> > will work on all architectures.
> >  
> > > However, I still think it should be implemented in compat_ioctl()
> > > because compat_blkdev_ioctl() expects it.  Either that, or I add to the
> > > big switch in compat_blkdev_driver_ioctl(), and spreading this change
> > > out to block/compat_ioctl.c does not seem like The Right Thing to me.
> > 
> 
> In the non-compat use case with a 32-bit kernel + 32-bit userspace (e.g.
> ARM), the casting of the __u64 to a pointer causes a compiler warning.
> It works as intended, so it's not an error, but it does not feel right
> to just silence the compiler.  That's why I used a memcpy with with
> explicit pointer size directly in the struct.  How else would you
> recommend I handle this?

Just cast to unsigned long and then to pointer.

	Arnd
