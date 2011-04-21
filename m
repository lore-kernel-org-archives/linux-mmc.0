From: Chris Ball <cjb@laptop.org>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Thu, 21 Apr 2011 01:22:41 -0400
Message-ID: <m3tyds9o0u.fsf@pullcord.laptop.org>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m31v0wcson.fsf@pullcord.laptop.org>
	<m3tydsbdd0.fsf@pullcord.laptop.org>
	<3C4AA76A-EBCA-47D2-B1BA-DF98DCB105FE@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60747 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab1DUFSf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 01:18:35 -0400
In-Reply-To: <3C4AA76A-EBCA-47D2-B1BA-DF98DCB105FE@marvell.com> (Philip
	Rakity's message of "Wed, 20 Apr 2011 22:09:07 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>

Hi,

On Thu, Apr 21 2011, Philip Rakity wrote:
> Aren't these the "hidden" partitions ?  Only available at boot time?

Yes, it's the previously-hidden boot partitions -- Andrei's patch
exposes them to Linux.

> I need to apply my patch to reset the boot partition -- or is that now
> in mmc-next

Your patch is in mmc-next.

> to see if the problem still happens.

Well, there isn't a problem per se, the system still boots fine -- the
boot partitions are being exposed as the patch intends them to.  I'm
just curious whether it's normal for two 1MiB partitions to be created
as a factory default.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
