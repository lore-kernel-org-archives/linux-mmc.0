From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Wed, 30 Mar 2011 18:18:11 -0500
Message-ID: <AANLkTimDp0yRgf-PLVcmd8Y6wdHJ3GNn-U37CytY3Eov@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<1300828300-8677-2-git-send-email-andreiw@motorola.com>
	<AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
	<201103301403.20779.arnd@arndb.de>
	<AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
	<m3ipv044c6.fsf@pullcord.laptop.org>
	<m3ei5o446f.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:34014 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab1C3XSP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 19:18:15 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2UNIWpM000923
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 19:18:33 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2UNCrQj029444
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 19:18:32 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1951853wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 16:18:11 -0700 (PDT)
In-Reply-To: <m3ei5o446f.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

On Wed, Mar 30, 2011 at 5:46 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Mar 30 2011, Chris Ball wrote:
>> Hi Andrei,
>>
>> On Wed, Mar 30 2011, Andrei Warkentin wrote:
>>> Unfortunately yes, although I am open for suggestions. An idea I
>>> considered is to add a postfix for device partitions. So, for card =
0,
>>> the user area will remain mmcblk0, while boot partitions will be
>>> mmcblk0b0 and mmcblk0b1, generic partitions will be mmcblk0g0, and =
so
>>> on.
>>
>> Like Arnd, my main concern was around naming, breaking boot setups, =
and
>> freaking people out by telling them that their cards have block devi=
ces
>> that they can't usually see and not making it obvious where they cam=
e
>> from. =A0:)
>>
>> Your "b/g" postfix solution appears to fix all of these, so I like i=
t.
>> We still have to think about where we expect users wondering what th=
e
>> "b" and "g" mean to go in order to find out..
>

Ok, I'll add that in. I'll add the documentation changes as well.

> Oh, one more thing -- if we go with the b/g postfix, what's the
> intuition for requiring a Kconfig entry to turn this on? =A0Is there
> any good argument against just turning it on for everyone, as long
> as it's not affecting mmcblk*p* naming?
>

The boot partition support (and any other XYZ partition support in the
future) so far in the patch is a Kconfig entry. So you have to want it
to get it.

The argument against turning it on by default is that someone might
figure that mke2fs-ing the boot partitions is a good way to reclaim
4MB on their rooted device,
and if they didn't realize the data was necessary for boot-up, they
will brick the device. That and people might freak out when they see
more mmcblk entries than they expected :-).

A
