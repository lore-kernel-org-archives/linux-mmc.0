From: Chris Ball <cjb@laptop.org>
Subject: Re: how to unbind current mmc driver to bind mmc-test driver?
Date: Thu, 26 May 2011 00:44:16 +0100
Message-ID: <20110525234416.GA31518@void.printf.net>
References: <alpine.DEB.2.00.1105251346490.12045@localhost6.localdomain6> <20110525231132.GA30458@void.printf.net> <alpine.DEB.2.00.1105251935170.4225@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36224 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650Ab1EYXoV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 May 2011 19:44:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105251935170.4225@localhost6.localdomain6>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, May 25, 2011 at 07:35:56PM -0400, Robert P. J. Day wrote:
> > You don't actually have a drivers/mmc device, then -- a controller
> > somewhere is making your SD slot look like a mass storage device,
> > in hardware.  The drivers/mmc stack is for devices that aren't
> > being mediated in this way.
> 
>   i should ask, of course, whether there's a way to still use the
> mmc_test module in this situation, but i'm guessing there isn't.

Correct, it's not possible.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
