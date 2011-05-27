From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Standardize header file multiple inclusion checks.
Date: Fri, 27 May 2011 12:48:33 -0400
Message-ID: <m3aae8rswu.fsf@pullcord.laptop.org>
References: <alpine.DEB.2.00.1105270803340.3939@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39244 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab1E0Qr0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 May 2011 12:47:26 -0400
In-Reply-To: <alpine.DEB.2.00.1105270803340.3939@localhost6.localdomain6>
	(Robert P. J. Day's message of "Fri, 27 May 2011 08:07:07 -0400
	(EDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-mmc@vger.kernel.org

Hi,

On Fri, May 27 2011, Robert P. J. Day wrote:
> Standardize the form of MMC header file inclusion checks, add missing
> comments at end, fix one incorrect comment at end of file.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   obviously just aesthetic changes but they do conform to the norm for
> header file inclusion checks.  someone here can decide whether or not
> to apply them.  not compile-tested as they are all fairly
> self-evident.

Thanks, works for me.  Your two-spaces-after-endif style is not the
norm, though -- want to resubmit with that changed to one space?

~/git/mmc/include/linux% git grep "endif /*" | wc -l
1497
~/git/mmc/include/linux% git grep "endif  /*" | wc -l
24
  
- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
