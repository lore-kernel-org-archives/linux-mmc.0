From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 12:34:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104201226510.28361@peruna>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com> <alpine.DEB.2.00.1104201131080.28361@peruna> <201104202117.14463.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:35996 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755656Ab1DTTe3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 15:34:29 -0400
In-Reply-To: <201104202117.14463.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

Hi Arnd,

On Wed, 20 Apr 2011, Arnd Bergmann wrote:
> 
> No need for a union or a ptr_size member in the struct. Just use
> a single __u64 and let the user cast the pointer to that. This
> will work on all architectures.
>  
> > However, I still think it should be implemented in compat_ioctl()
> > because compat_blkdev_ioctl() expects it.  Either that, or I add to the
> > big switch in compat_blkdev_driver_ioctl(), and spreading this change
> > out to block/compat_ioctl.c does not seem like The Right Thing to me.
> 

In the non-compat use case with a 32-bit kernel + 32-bit userspace (e.g.
ARM), the casting of the __u64 to a pointer causes a compiler warning.
It works as intended, so it's not an error, but it does not feel right
to just silence the compiler.  That's why I used a memcpy with with
explicit pointer size directly in the struct.  How else would you
recommend I handle this?

John
