From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 18:28:48 -0400
Message-ID: <m3ei4wd0bj.fsf@pullcord.laptop.org>
References: <alpine.DEB.2.00.1104131713570.15392@peruna>
	<BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com>
	<alpine.DEB.2.00.1104201131080.28361@peruna>
	<201104202117.14463.arnd@arndb.de>
	<BANLkTim4V9J1VahxynPQp_hv+r5j2-yK6w@mail.gmail.com>
	<alpine.DEB.2.00.1104201341430.28361@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37105 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab1DTWYm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2011 18:24:42 -0400
In-Reply-To: <alpine.DEB.2.00.1104201341430.28361@peruna> (John Calixto's
	message of "Wed, 20 Apr 2011 13:47:16 -0700 (PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>

Hi John,

On Wed, Apr 20 2011, John Calixto wrote:
> Do you have a preference here?  I do not have a preference.  On the one
> hand, not having the union makes for a cleaner-to-read struct.  On the
> other hand, not having to cast the pointer in 32-bit userspace is nice
> especially since I foresee using this ioctl on a lot of ARM SoCs.

I'll defer to Arnd, which I guess suggests using the __u64 unless he
comes around to the union idea.  :)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
