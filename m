From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Mon, 18 Apr 2011 16:39:48 +0200
Message-ID: <201104181639.48730.arnd@arndb.de>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <201104130100.39810.arnd@arndb.de> <alpine.DEB.2.00.1104121604220.8483@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab1DROkA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 10:40:00 -0400
In-Reply-To: <alpine.DEB.2.00.1104121604220.8483@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

On Wednesday 13 April 2011, John Calixto wrote:
> Gah!  OK, so much for the v5 I just sent then.  What do you think about
> the compat_ioctl that I sent in v2?  It means having the extra 32-bit
> compat structure, but at least all the compat overhead is conditional
> upon CONFIG_COMPAT.  If you're not using CONFIG_COMPAT, you don't get
> any compat cruft.
> 

A single __u64 is sufficient, because the user space will do the correct
conversion from pointer to 64-bit integer then. The only conversion
you need to worry about is the actual pointer to the main structure,
which needs the compat_ptr() magic.

	Arnd
