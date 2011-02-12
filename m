From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_rescan failure in case of CONFIG_MMC_UNSAFE_RESUME
Date: Sat, 12 Feb 2011 17:22:05 +0000
Message-ID: <20110212172205.GA9608@void.printf.net>
References: <loom.20110212T012758-658@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39608 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530Ab1BLRWH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 Feb 2011 12:22:07 -0500
Content-Disposition: inline
In-Reply-To: <loom.20110212T012758-658@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

Hi Dmitry,

On Sat, Feb 12, 2011 at 12:33:33AM +0000, Dmitry Shmidt wrote:
> Recently new check was added to core.c function mmc_rescan():
>     if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
>         && mmc_card_is_removable(host)) <<<< This one
>         host->bus_ops->detect(host);
> mmc_card_is_removable() is checking
>  !(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable;
> 
> If we use CONFIG_MMC_UNSAFE_RESUME then
>   mmc_assume_removable will be 0 and any card will be always considered
> as non-removable. And host->bus_ops->detect() will not be called on card
> removal.

I agree that we've changed the behavior to avoid running ->detect
in this case, but that was intentional -- you should not be using
CONFIG_MMC_UNSAFE_RESUME on a card that is physically removable.
Why are you trying to?

config MMC_UNSAFE_RESUME
        bool "Assume MMC/SD cards are non-removable (DANGEROUS)"
        ...

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
