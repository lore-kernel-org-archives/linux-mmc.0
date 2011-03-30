From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Wed, 30 Mar 2011 19:34:43 -0400
Message-ID: <m3zkoc2ne4.fsf@pullcord.laptop.org>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<1300828300-8677-2-git-send-email-andreiw@motorola.com>
	<AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
	<201103301403.20779.arnd@arndb.de>
	<AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
	<m3ipv044c6.fsf@pullcord.laptop.org>
	<m3ei5o446f.fsf@pullcord.laptop.org>
	<AANLkTimDp0yRgf-PLVcmd8Y6wdHJ3GNn-U37CytY3Eov@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56786 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756257Ab1C3X2t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Mar 2011 19:28:49 -0400
In-Reply-To: <AANLkTimDp0yRgf-PLVcmd8Y6wdHJ3GNn-U37CytY3Eov@mail.gmail.com>
	(Andrei Warkentin's message of "Wed, 30 Mar 2011 18:18:11 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 30 2011, Andrei Warkentin wrote:
> The argument against turning it on by default is that someone might
> figure that mke2fs-ing the boot partitions is a good way to reclaim
> 4MB on their rooted device,
> and if they didn't realize the data was necessary for boot-up, they
> will brick the device.

Ah.  Ugh, that sucks; I can totally see that happening.  Now I'm
wondering if we should just be hardcoding boot devices as always
read-only and just refusing to write to them.

What do others think?  Is there an acceptable tradeoff somewhere?
It's not clear to me that Kconfig entries are sufficient to obtain
consent to present r/w mounts of the boot partitions; the user
writing the "dd" line usually isn't the person who made the Kconfig
selection, and the person who made the Kconfig selection is often a
distro maintainer who just turns on new Kconfig symbols without
reading closely.

> That and people might freak out when they see
> more mmcblk entries than they expected :-).

I'm not worried about this one, as long as they have the postfixes.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
