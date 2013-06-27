From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap: remove unnecessary #if 0's
Date: Thu, 27 Jun 2013 11:57:17 -0400
Message-ID: <87hagjmtr6.fsf@octavius.laptop.org>
References: <1371137155-15318-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52973 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab3F0P5U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:57:20 -0400
In-Reply-To: <1371137155-15318-1-git-send-email-coelho@ti.com> (Luciano
	Coelho's message of "Thu, 13 Jun 2013 18:25:55 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, tony@atomide.com

Hi Luciano,

On Thu, Jun 13 2013, Luciano Coelho wrote:
> In commit 3451c067 (mmc: omap: add DMA engine support), some #if 0's
> were used to comment out parts of the code.  This has been in the code
> for over a year and are not needed anymore (and the commented-out code
> doesn't even compile).  Remove them.
>
> Signed-off-by: Luciano Coelho <coelho@ti.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
