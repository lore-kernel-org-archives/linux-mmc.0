From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: CMD23 plumbing and support patchset.
Date: Thu, 21 Apr 2011 22:53:00 -0500
Message-ID: <BANLkTi=Vj0p-=d0YLR=vk2CdSxH2GVz1+A@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<m3pqogbcoa.fsf@pullcord.laptop.org>
	<BANLkTik99XdFSsb7cjX0YoYHRA2d+Vn_yg@mail.gmail.com>
	<BANLkTikDNNso=TBF-BiewTFTFeHqe1WDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:60299 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1DVDxE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 23:53:04 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3M3p438000478
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 23:51:05 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3M3oq1x000423
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 23:51:04 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so333417wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 20:53:00 -0700 (PDT)
In-Reply-To: <BANLkTikDNNso=TBF-BiewTFTFeHqe1WDhw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com

On Thu, Apr 21, 2011 at 1:30 AM, Andrei Warkentin <andreiw@motorola.com=
> wrote:
> On Thu, Apr 21, 2011 at 1:29 AM, Andrei Warkentin <andreiw@motorola.c=
om> wrote:
>> Hi Chris,
>>
>> On Wed, Apr 20, 2011 at 8:44 PM, Chris Ball <cjb@laptop.org> wrote:
>>> Hi,
>>>
>>> On Sat, Apr 16 2011, Andrei Warkentin wrote:
>>>> This is the third version of the CMD23 plumbing and host driver su=
pport
>>>> patch set.
>>>>
>>>> Changes:
>>>> 1) CMD23 support (used for features such as reliable writes) is de=
coupled
>>>> =A0 =A0from general multiblock trans through use of a quirk for af=
fected cards.
>>>> 2) Newer Sandisk MMC products are whitelisted along with some know=
n good ones. All other
>>>> =A0 =A0MMC products do not use CMD23 for general transfers (seems =
like safest choice for now).
>>>> =A0 =A0SD products unaffected.
>>>
>>> Just gave this a try on SEM04G, which is in the whitelist, but didn=
't
>>> see a performance increase (or decrease). =A0What are you using for=
 a
>>> testcase? =A0I'm a little wary of running mmc_test on it. =A0:)
>>>
>>
>> Can you give me the manufacturing date? This is pretty interesting.
>>
>> You can see an improvement even if you do something like time block
>> writes (O_DIRECT | O_SYNC, of course). But after all synthetic tests=
 I
>> measured the time it took to do 40000 SQLite insertions and saw
>> something like 30% improvement.
>>
>
> And you're trying this on SDHCI I presume, right?

Is this on the same board as the other log you sent? Controller is
SDHCI-PXA? If you give me  /sys/block/mmcblk0/device/date,
I'll investigate why this improvement isn't helping you out.

A
