From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Tue, 26 Apr 2011 18:36:49 -0400
Message-ID: <m3aafcod1a.fsf@pullcord.laptop.org>
References: <alpine.DEB.2.00.1104211735290.3919@peruna>
	<alpine.DEB.2.00.1104211743210.3919@peruna>
	<201104261614.35455.arnd@arndb.de>
	<alpine.DEB.2.00.1104261524030.6706@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43464 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab1DZWdS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2011 18:33:18 -0400
In-Reply-To: <alpine.DEB.2.00.1104261524030.6706@peruna> (John Calixto's
	message of "Tue, 26 Apr 2011 15:28:02 -0700 (PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>

Hi John,

On Tue, Apr 26 2011, John Calixto wrote:
> Arnd - Thanks a lot for the review and your help getting the
> implementation right!
>
> Chris - What do you think?  How should I proceed here?

I think I'll merge it, since I'm not going to work on abstracting the
security feature either.  I'll send another mail once it's in my tree.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
