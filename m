From: Greg KH <gregkh@suse.de>
Subject: Re: Patch "mmc: fix all hangs related to mmc/sd card
	insert/removal during suspend/resume" has been added to the
	2.6.35-stable tree
Date: Thu, 16 Sep 2010 07:06:23 -0700
Message-ID: <20100916140623.GA3750@suse.de>
References: <12845889002548@site> <4C91C575.5070500@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40917 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686Ab0IPOJU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Sep 2010 10:09:20 -0400
Content-Disposition: inline
In-Reply-To: <4C91C575.5070500@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@canonical.com>
Cc: maximlevitsky@gmail.com, akpm@linux-foundation.org, david-b@pacbell.net, linux-mmc@vger.kernel.org, stern@rowland.harvard.edu, torvalds@linux-foundation.org, stable@kernel.org, stable-commits@vger.kernel.org

On Thu, Sep 16, 2010 at 08:21:25AM +0100, Lee Jones wrote:
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@kernel.org> know about it.
> 
> I actually intended this patch go on into .32-stable, but I see no solid
> reason why it can't go into .35-stable too.

Patches need to go in _all_ older kernels if possible, I don't want to
only apply ones to .32 that could also go into .35, as that wouldn't
make much sense, right?

> There is one issue though. If you add this patch and leave out the one
> below you will break stable when CONFIG_PM == !y.
> 
> mmc: build fix: mmc_pm_notify is only available with CONFIG_PM=y
>   81ca03a0e2ea0207b2df80e0edcf4c775c07a505

I got that one as well for .35.

thanks,

greg k-h
