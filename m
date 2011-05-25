From: Chris Ball <cjb@laptop.org>
Subject: Re: how to unbind current mmc driver to bind mmc-test driver?
Date: Thu, 26 May 2011 00:11:32 +0100
Message-ID: <20110525231132.GA30458@void.printf.net>
References: <alpine.DEB.2.00.1105251346490.12045@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34571 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230Ab1EYXLe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 May 2011 19:11:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105251346490.12045@localhost6.localdomain6>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-mmc@vger.kernel.org

Hi Robert,

On Wed, May 25, 2011 at 01:58:13PM -0400, Robert P. J. Day wrote:
> 
>   ever willing to embarrass myself in public, i'm going to ask how to
> load and invoke the mmc_test driver on my ubuntu laptop, which is
> currently running my hand-rolled super-recent, 2.6.39+ kernel.
> 
>   i'm following along in the script here:
> 
> http://www.spinics.net/lists/linux-mmc/msg05835.html
> 
> and it seems pretty straightforward -- i interpret all of that as that
> one needs first to find the driver that is currently bound to the
> device (mmc-block?), unbind it, then bind to the mmc test driver.
> that seems easy enough except that this loop in the script:
> 
> ...
> 
> is clearly looking for the *current* driver but, on my system, there
> is none.  on this laptop, the MMC card slot appears to be managed by
> the SCSI driver and USB storage, so there is no symlink there; hence,
> the script fails in the next check:

You don't actually have a drivers/mmc device, then -- a controller
somewhere is making your SD slot look like a mass storage device,
in hardware.  The drivers/mmc stack is for devices that aren't
being mediated in this way.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
