From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Wed, 30 Mar 2011 18:46:48 -0400
Message-ID: <m3ei5o446f.fsf@pullcord.laptop.org>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<1300828300-8677-2-git-send-email-andreiw@motorola.com>
	<AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
	<201103301403.20779.arnd@arndb.de>
	<AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
	<m3ipv044c6.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52829 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab1C3Wkx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Mar 2011 18:40:53 -0400
In-Reply-To: <m3ipv044c6.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Wed, 30 Mar 2011 18:43:21 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 30 2011, Chris Ball wrote:
> Hi Andrei,
>
> On Wed, Mar 30 2011, Andrei Warkentin wrote:
>> Unfortunately yes, although I am open for suggestions. An idea I
>> considered is to add a postfix for device partitions. So, for card 0,
>> the user area will remain mmcblk0, while boot partitions will be
>> mmcblk0b0 and mmcblk0b1, generic partitions will be mmcblk0g0, and so
>> on.
>
> Like Arnd, my main concern was around naming, breaking boot setups, and
> freaking people out by telling them that their cards have block devices
> that they can't usually see and not making it obvious where they came
> from.  :)
>
> Your "b/g" postfix solution appears to fix all of these, so I like it.
> We still have to think about where we expect users wondering what the
> "b" and "g" mean to go in order to find out..

Oh, one more thing -- if we go with the b/g postfix, what's the
intuition for requiring a Kconfig entry to turn this on?  Is there
any good argument against just turning it on for everyone, as long
as it's not affecting mmcblk*p* naming?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
