From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/8] mmc: omap_hsmmc: release correct resource
Date: Sun, 22 Apr 2012 11:20:18 -0400
Message-ID: <87obqjg5e5.fsf@laptop.org>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
	<E1SKRrh-0004bL-3j@rmk-PC.arm.linux.org.uk>
	<20120420222305.GI21106@atomide.com> <878vhqggbc.fsf@laptop.org>
	<871unhhkvk.fsf@laptop.org>
	<20120421094849.GZ25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47874 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab2DVPUK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 22 Apr 2012 11:20:10 -0400
In-Reply-To: <20120421094849.GZ25053@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 21 Apr 2012 10:48:49 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

On Sat, Apr 21 2012, Russell King - ARM Linux wrote:
>> > Thanks, pushed to mmc-next for 3.4.
>> 
>> (Actually, that's premature of me, sorry -- just noticed that this
>> is part of an RFC patchset.  I'll wait for the rest of the patches.)
>
> It was previously posted as an entirely separate patch - the reason its
> part of this RFC is because I needed the patch while developing this
> series.  So please go ahead and take _this_ patch.

Okay, thanks.  It's back in mmc-next.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
