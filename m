From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdio: fix nasty oops in mmc_sdio_detect
Date: Fri, 19 Nov 2010 22:06:39 +0000
Message-ID: <20101119220639.GC19272@void.printf.net>
References: <1289731233-19996-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47096 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754918Ab0KSWGl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Nov 2010 17:06:41 -0500
Content-Disposition: inline
In-Reply-To: <1289731233-19996-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>

Hi Ohad,

On Sun, Nov 14, 2010 at 12:40:33PM +0200, Ohad Ben-Cohen wrote:
> Power off the card in mmc_sdio_detect __before__ a potential error
> handler, which completely removes the card, executes, and only if the
> card was successfully powered on beforehand.
> 
> While we're at it, use the _sync variant of the runtime PM put API, in
> order to ensure that the card is left powered off in case an error
> occurred, and the card is going to be removed.
> 
> Reproduced and tested on the XO-1.5.
> 
> Reported-by: Daniel Drake <dsd@laptop.org>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks, pushed to for-linus/mmc-next for 2.6.37.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
