From: Chris Ball <cjb@laptop.org>
Subject: Re: sdhci clock gating support
Date: Fri, 02 Jul 2010 10:10:14 -0400
Message-ID: <m3r5jmvut5.fsf@pullcord.laptop.org>
References: <3E72735B0D1743D885A83B33679415E8@sisodomain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35139 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757257Ab0GBOIN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Jul 2010 10:08:13 -0400
In-Reply-To: <3E72735B0D1743D885A83B33679415E8@sisodomain.com> (Madhav's
	message of "Fri, 02 Jul 2010 18:20:10 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhav <singh.madhav@samsung.com>
Cc: linux-mmc@vger.kernel.org, kyungmin.park@samsung.com

Hi Madhav,

The patch is extremely whitespace-damaged, and your code is also
formatted incorrectly.

Some general points:
 * have you measured whether there's a performance impact from
   bringing the clock up and down for every request?

 * I'd expect this to be implemented as an MMC capability, so
   that it can be avoided on specific controllers.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
