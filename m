From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] mmc: sdio: don't reinitialize nonremovable
	powered-resumed cards
Date: Fri, 17 Dec 2010 00:53:44 +0000
Message-ID: <20101217005344.GE17239@void.printf.net>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com> <1290921690-6133-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37487 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab0LQAxp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Dec 2010 19:53:45 -0500
Content-Disposition: inline
In-Reply-To: <1290921690-6133-3-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi Ohad,

On Sun, Nov 28, 2010 at 07:21:29AM +0200, Ohad Ben-Cohen wrote:
> Upon system resume, SDIO core must reinitialize cards that were
> powered off during suspend.
> 
> If the card had its power kept during suspend (and thus it
> is 'powered-resumed'), SDIO core performs only a limited reinitializing,
> mainly needed to make sure that the card wasn't removed/replaced.
> 
> If a __nonremovable__ card is powered-resumed, we can safely skip the
> reinitializing phase.
> 
> Note: 9b966aa removed the bus width reconfiguration since
> mmc_sdio_init_card already does it. It is brought back now in case
> mmc_sdio_init_card is skipped.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks, pushed to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
