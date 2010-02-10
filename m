From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 5/5] SDIO: put active devices into 1-bit mode during suspend
Date: Wed, 10 Feb 2010 11:32:23 -0500
Message-ID: <m31vgt127c.fsf@pullcord.laptop.org>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
	<1265747366-6676-6-git-send-email-nico@fluxnic.net>
	<4B7298EF.4070604@csr.com> <m38wb115nk.fsf@pullcord.laptop.org>
	<4B72D8CC.9030605@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45749 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540Ab0BJQeZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2010 11:34:25 -0500
In-Reply-To: <4B72D8CC.9030605@csr.com> (David Vrabel's message of "Wed, 10
	Feb 2010 16:03:24 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Hi David,

   > I couldn't find anything in the SDIO specification (you know the
   > section number?).  Part A2 has a requirement that the controller
   > be placed into 1-bit mode but this doesn't mean that the card has
   > to be.

I think it's part E1 section 8, and does specify that it's necessary
for both host and card.

   > Maybe it's not really a big deal, a single command only costs a
   > few 10s of microseconds anyway.

Yeah, and it's only being sent on a powered-suspend, which so far OLPC
is the only user of -- I'd rather have the next user tell us it isn't
necessary than break it for them by introducing an incorrect quirk.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
