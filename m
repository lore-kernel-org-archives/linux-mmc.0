From: Chris Ball <cjb@laptop.org>
Subject: Re: [comments] MMC: Reliable write support.
Date: Thu, 31 Mar 2011 16:58:07 -0400
Message-ID: <m3r59nt3c0.fsf@pullcord.laptop.org>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
	<201103290901.31680.arnd@arndb.de>
	<AANLkTinDdEJ0bwH3Kj_QmhD=Z=07eaRvpA=sASn+DmkJ@mail.gmail.com>
	<201103301405.21047.arnd@arndb.de>
	<m3mxkc44jm.fsf@pullcord.laptop.org>
	<AANLkTimQgeenQNzPK5oFNPj-dGygdJY1S8gXZWdKAZUU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38670 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab1CaUwR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 Mar 2011 16:52:17 -0400
In-Reply-To: <AANLkTimQgeenQNzPK5oFNPj-dGygdJY1S8gXZWdKAZUU@mail.gmail.com>
	(Andrei Warkentin's message of "Thu, 31 Mar 2011 15:39:39 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 31 2011, Andrei Warkentin wrote:
> I took a look at mmc_test. It seems like it was meant more to test
> cards, rather than block.c functionality, as it issues all MMC
> requests by itself, instead of submitting via block layer. It would be
> separately an interesting an idea to implement an MMC reliable write
> test to mmc_test, but it wouldn't help much with bugs in block.c.
> What do you think?

Ah, that's right.  I guess this is just calling for a userspace test
suite, and there's nothing more to be done in the kernel..

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
