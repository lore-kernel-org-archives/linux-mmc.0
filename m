From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Sun, 13 Mar 2011 08:00:04 -0500
Message-ID: <AANLkTinYmXrn=UmJDcr-2aAN5jChfTTX9EebCu9xbibc@mail.gmail.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
	<201103102254.02041.arnd@arndb.de>
	<AANLkTim1RUmDj_KooR3jXuZ2uTS6ajFyG9eGK7dQiijM@mail.gmail.com>
	<201103111123.21063.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:33220 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333Ab1CMNAI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 09:00:08 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2DD0NGR010580
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 09:00:23 -0400 (EDT)
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com [209.85.210.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2DD0MRR010577
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 09:00:22 -0400 (EDT)
Received: by iyb12 with SMTP id 12so5230110iyb.15
        for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 06:00:04 -0700 (PDT)
In-Reply-To: <201103111123.21063.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Fri, Mar 11, 2011 at 4:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 March 2011, Andrei Warkentin wrote:
>> > I also don't know what the effect of setting physical_block_size
>> > and/or io_min is, possibly it no longer works if they are larger
>> > than the MMU page size. Need to try this.
>>
>> The other thing is figuring out the default size limit for when the
>> page align should be performed. I suppose it's safe enough to
>> set it to 1.5 size the super_page_size. But that number came from the
>> Toshiba card tests. Or it could be unbounded by default. I'd rather do
>> the later.
>
> You mean always splitting (multiples of) full super-pages from partial
> super-pages when the quirk flag is enabled?
>
> I think it depends on the performance numbers. Do you have any
> meaningful measurements without the quirk, with the current implementation
> and with the unbounded case?
>
> If the latter two are not much different on the toshiba card, that
> would be a simpler implementation, and more likely to be useful on
> other cards.
>

Revalidating the data now, along with some more tests, to get a better
picture. It seems the more data I get, the less it makes sense :(.

> I think we should also do measurements to see if the same quirk
> actually has any negative effects on other cards, or if there
> are even cases where it helps.

Going to test on Sandisk eMMC as well.

Thanks,
A
