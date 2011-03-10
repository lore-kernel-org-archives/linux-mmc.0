From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Thu, 10 Mar 2011 17:06:35 -0600
Message-ID: <AANLkTim1RUmDj_KooR3jXuZ2uTS6ajFyG9eGK7dQiijM@mail.gmail.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
	<201103101705.45230.arnd@arndb.de>
	<AANLkTi=bUEtNKtqvHbq63q2=Jnzc2aD6nE2cgZ2F-RKY@mail.gmail.com>
	<201103102254.02041.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:43634 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab1CJXGh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 18:06:37 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2AN5GiK026262
	for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 18:05:16 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2AMAhTA002714
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 18:05:16 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 6so55650vws.15
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 15:06:35 -0800 (PST)
In-Reply-To: <201103102254.02041.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Thu, Mar 10, 2011 at 3:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 March 2011 21:45:07 Andrei Warkentin wrote:
>> > We can pre-initialize the page size to some common value
>> > (e.g. 16 KB for 4GB or larger cards, 4 KB for smaller than
>> > 4 GB), and use quirks to override it for cards where we
>> > know it's different.
>> >
>>
>> Even better. We have the "super page size" in the EXT_CSD. For example
>> for Sandisk it's 16KB, Toshiba is reporting 32KB, but we know that's
>> not right...
>
> Ok, that sounds good. I don't think we have anything like this
> for SD cards though, so we'd still need to make some reasonable
> assumption there.
>
> The one thing we know is that all SD cards should support writes of
> 32KB alignment, because that is the largest cluster size supported
> by FAT16 and FAT32. I have experimentally shown that most cards
> can reasonably do 16KB, and only few modern cards can do smaller
> than that.
>
> I also don't know what the effect of setting physical_block_size
> and/or io_min is, possibly it no longer works if they are larger
> than the MMU page size. Need to try this.

The other thing is figuring out the default size limit for when the
page align should be performed. I suppose it's safe enough to
set it to 1.5 size the super_page_size. But that number came from the
Toshiba card tests. Or it could be unbounded by default. I'd rather do
the later.

A
