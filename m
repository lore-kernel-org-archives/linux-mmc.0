From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: CMD23 plumbing and support patchset.
Date: Tue, 26 Apr 2011 18:30:39 -0500
Message-ID: <BANLkTimBJQJekHnK2MpCtZ5gHhM5LaBWhA@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<m3pqogbcoa.fsf@pullcord.laptop.org>
	<BANLkTik99XdFSsb7cjX0YoYHRA2d+Vn_yg@mail.gmail.com>
	<BANLkTikDNNso=TBF-BiewTFTFeHqe1WDhw@mail.gmail.com>
	<BANLkTi=Vj0p-=d0YLR=vk2CdSxH2GVz1+A@mail.gmail.com>
	<m3y631wuh7.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:51285 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab1DZXay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 19:30:54 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3QNVH6o009730
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 19:31:17 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3QNVGr7009722
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 19:31:17 -0400 (EDT)
Received: by wyb34 with SMTP id 34so1130921wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 16:30:50 -0700 (PDT)
In-Reply-To: <m3y631wuh7.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com

On Fri, Apr 22, 2011 at 9:51 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Apr 21 2011, Andrei Warkentin wrote:
>>>> Can you give me the manufacturing date? This is pretty interesting=
=2E
>>>>
>>>> You can see an improvement even if you do something like time bloc=
k
>>>> writes (O_DIRECT | O_SYNC, of course). But after all synthetic tes=
ts I
>>>> measured the time it took to do 40000 SQLite insertions and saw
>>>> something like 30% improvement.
>>>>
>>>
>>> And you're trying this on SDHCI I presume, right?
>>
>> Is this on the same board as the other log you sent? Controller is
>> SDHCI-PXA? If you give me =A0/sys/block/mmcblk0/device/date,
>> I'll investigate why this improvement isn't helping you out.
>
> Yeah, sdhci-pxa:
>
> [root@localhost olpc]# cat /sys/block/mmcblk0/device/date
> 10/2010
>
> Want to give me a benchmark script so that we can compare speeds
> directly?
>

One more thing to check - is this an eMMC 4.3+ card? (you're going to
have to plumb something in mmc.c to print it). Sandisk says
improvement going to be seen only on 4.3+ cards. Sandisk releases
different generation cards concurrently, and there is no way to tell
from manfid/oemid/date/hwref/fwrev. Ugh.

I'll send another email (in a bit) with test script and a patch to
enable/disable cmd23 use at runtime so you can get better tests than
across
reboot.

A
