From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Mon, 14 Mar 2011 02:40:00 -0500
Message-ID: <AANLkTimV-no9Wk4wbS4gQGdSgq-2L=ims6SXDFrdEZAe@mail.gmail.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
	<201103111123.21063.arnd@arndb.de>
	<AANLkTinYmXrn=UmJDcr-2aAN5jChfTTX9EebCu9xbibc@mail.gmail.com>
	<201103131554.38028.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:33985 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab1CNHkC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 03:40:02 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2E7cb6c028820
	for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2011 03:38:37 -0400 (EDT)
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com [209.85.214.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2E7cHG1028701
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2011 03:38:37 -0400 (EDT)
Received: by mail-iw0-f170.google.com with SMTP id 3so5988323iwn.15
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2011 00:40:00 -0700 (PDT)
In-Reply-To: <201103131554.38028.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Sun, Mar 13, 2011 at 9:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 13 March 2011 14:00:04 Andrei Warkentin wrote:
>> > If the latter two are not much different on the toshiba card, that
>> > would be a simpler implementation, and more likely to be useful on
>> > other cards.
>> >
>>
>> Revalidating the data now, along with some more tests, to get a better
>> picture. It seems the more data I get, the less it makes sense :(.
>
> I was already fearing that the change would only benefit low-level
> benchmarks. It certainly helps writing small chunks to the buffer
> that is meant for FAT32 directories, but at some point, the card
> will have to write back the entire logical erase block, so you
> might not be able to gain much in real-world workloads.
>

Original data was collected by someone else on a 16G eMMC device. The
data I have collected now for a 32G device of seemingly similar
technology doesn't quite match the original data in terms of
performance characteristics, so I am trying to collect the data on the
16G device and figure out what the difference is. The align change may
only benefit certain types of accesses, but it for sure must not hurt
the general case, otherwise there is really no point behind even
considering it...

It takes forever to get a good amount of data to see past the noise,
too. My last set of tests has already been running for 10 hours...

> Of course, I also have only a very limited understanding of the
> algorithm used in the Toshiba chip.
>

Unfortunately, so do I. As far as manufacturer suggestions, we get a
very controlled and limited view of things :).

Thanks,
A
