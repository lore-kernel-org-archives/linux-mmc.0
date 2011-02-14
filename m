From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_rescan failure in case of CONFIG_MMC_UNSAFE_RESUME
Date: Mon, 14 Feb 2011 19:40:13 +0000
Message-ID: <20110214194013.GA3145@void.printf.net>
References: <loom.20110212T012758-658@post.gmane.org> <20110212172205.GA9608@void.printf.net> <AANLkTimkW0JDUT-8ERrGTimLUpqWvgNd5jYLfuXodL==@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57509 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab1BNTkO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 14:40:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimkW0JDUT-8ERrGTimLUpqWvgNd5jYLfuXodL==@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

Hi Dmitry,

[Cc += Nico]

On Mon, Feb 14, 2011 at 11:04:13AM -0800, Dmitry Shmidt wrote:
> MMC_UNSAFE_RESUME is affecting mmc_sdio_resume() sequence. If it is
> not defined then sdio card will be considered
> "removable" and on resume mmc_sdio_init_card() will be always called.
> 
> static int mmc_sdio_resume(struct mmc_host *host)
> {
>      ...
>      if (mmc_card_is_removable(host) || !mmc_card_is_powered_resumed(host))
>           err = mmc_sdio_init_card(host, host->ocr, host->card,
>                         (host->pm_flags & MMC_PM_KEEP_POWER));

mmc_sdio_init_card() is supposed to be called if your card is removable,
because the card might have changed.  It has a fast path that's enabled
by MMC_PM_KEEP_POWER.  (Nicolas explained this back in October.)

You absolutely should not enable MMC_UNSAFE_RESUME if your host has a
removable card.  It's an awful hack, and you just found an example of
where it breaks.

If you need mmc_sdio_resume() to have an even faster path for you, we can
talk about that and see if it makes sense.  Misusing MMC_UNSAFE_RESUME to
get a powered SDIO resume is just wrong.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
