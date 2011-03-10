From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Thu, 10 Mar 2011 14:45:07 -0600
Message-ID: <AANLkTi=bUEtNKtqvHbq63q2=Jnzc2aD6nE2cgZ2F-RKY@mail.gmail.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
	<1299718449-15172-5-git-send-email-andreiw@motorola.com>
	<201103101705.45230.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:50579 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab1CJUpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 15:45:10 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2AKjOX4002371
	for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 15:45:25 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2AKbUj8028524
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 15:45:24 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 39so2433488vxb.15
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2011 12:45:08 -0800 (PST)
In-Reply-To: <201103101705.45230.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Thu, Mar 10, 2011 at 10:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Sorry for repeating myself, but I'm not sure if you didn't understand
> me or if I missed your arguments against the more generic approach.
>
> Instead of encoding specific parameters for this quirk, I would
> much prefer to have the values be meaningful, and have the
> code deal with the interpretation.
>
>> @@ -63,6 +63,8 @@ struct mmc_blk_data {
>>
>> =A0 =A0 =A0 unsigned int =A0 =A0usage;
>> =A0 =A0 =A0 unsigned int =A0 =A0read_only;
>> + =A0 =A0 unsigned int =A0 =A0write_align_size;
>> + =A0 =A0 unsigned int =A0 =A0write_align_limit;
>> =A0};
>
> These numbers are generally speaking useless, except for the
> one quirk. What I was trying to suggest here is to have
> a page_size field that reflects the underlying page size
> of the NAND flash, and a flag that says "please split all
> requests under 1.5 times the page size along page boundaries".

Ah ok, I really did just misinterpret. Sorry. Will refactor.

>
> We can pre-initialize the page size to some common value
> (e.g. 16 KB for 4GB or larger cards, 4 KB for smaller than
> 4 GB), and use quirks to override it for cards where we
> know it's different.
>

Even better. We have the "super page size" in the EXT_CSD. For example
for Sandisk it's 16KB, Toshiba is reporting 32KB, but we know that's
not right...

Thanks again,
A
