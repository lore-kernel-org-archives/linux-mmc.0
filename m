From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdio: fix runtime PM anomalies by introducing
	MMC_CAP_POWER_OFF_CARD
Date: Fri, 19 Nov 2010 22:08:46 +0000
Message-ID: <20101119220846.GD19272@void.printf.net>
References: <1290151749-21308-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50479 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758122Ab0KSWIr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Nov 2010 17:08:47 -0500
Content-Disposition: inline
In-Reply-To: <1290151749-21308-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Arnd Hannemann <arnd@arndnet.de>

Hi Ohad,

On Fri, Nov 19, 2010 at 09:29:09AM +0200, Ohad Ben-Cohen wrote:
> Some board/card/host configurations are not capable of powering off the
> card after boot.
> 
> To support such configurations, and to allow smoother transition to
> runtime PM behavior, MMC_CAP_POWER_OFF_CARD is added, so hosts need to
> explicitly indicate whether it's OK to power off their cards after boot.
> 
> SDIO core will enable runtime PM for a card only if that cap is set.
> As a result, the card will be powered down after boot, and will only
> be powered up again when a driver is loaded (and then it's up to the
> driver to decide whether power will be kept or not).
> 
> This will prevent sdio_bus_probe() failures with setups that do not
> support powering off the card.
> 
> Reported-and-tested-by: Daniel Drake <dsd@laptop.org>
> Reported-and-tested-by: Arnd Hannemann <arnd@arndnet.de>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks for doing this.  Pushed to for-linus/mmc-next for 2.6.37; I'll
send a pull request once we have the fix for the 8-bit MMC regression
lined up too.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
