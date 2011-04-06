From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Dynamic MMC device naming vs. bootloaders
Date: Wed, 6 Apr 2011 12:40:38 -0500
Message-ID: <BANLkTimZtSsHE3VkxwCAH1SnNuhEz46oSg@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
	<BANLkTik7fbz+QLZY8RH9wCkGQdU3hUNfNA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB3599@HQMAIL01.nvidia.com>
	<BANLkTimDbPkgHDuERqJ-qRe9Ji2RyzAvXA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB36C7@HQMAIL01.nvidia.com>
	<BANLkTik8fti=o1+NRCUALFGYMiFzbRy+Jg@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0493EB36DB@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:54856 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab1DFRkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 13:40:42 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p36Hcv09014710
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 13:38:57 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p36HZn2r013288
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 13:38:57 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so2291960wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 10:40:40 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0493EB36DB@HQMAIL01.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Apr 6, 2011 at 12:32 PM, Stephen Warren <swarren@nvidia.com> wr=
ote:
> Andrei Warkentin wrote at Wednesday, April 06, 2011 11:19 AM:
>> On Wed, Apr 6, 2011 at 11:59 AM, Stephen Warren <swarren@nvidia.com>=
 wrote:
>> > However, isn't it just a fluke that this will work; registering th=
e internal
>> > host controller first will I assume start probing of any attached =
devices on
>> > that controller first, but does it actually guarantee that such pr=
obing will
>> > also complete first, which I believe is the necessary condition fo=
r the mmcblk
>> > device to be assigned ID 0?
>> >
>>
>> The device index is only assigned if the mmc block driver is started
>> on a detected card. ...
>>
>> > Equally, if there were two controllers with fixed/internal MMC and=
/or two
>> > controllers which supported pluggable SD cards, the race issue wou=
ld still
>> > exist?
>>
>> I think if you had two controllers and you plugged two cards in at t=
he
>> "same time", then you would have =A0a race condition, as both would
>> mmc_detect_change (effectively schedule_work to an ordered wq), and =
it
>> would depend on which card change IRQ occured first. It seems like
>> different hosts use different delays for when the work will be done,
>> so if you have different hosts, you can make this even more obvious.
>> You'd have to really try, though, I think. I guess if you are never
>> going to support multiple cards on one host, you might as well tie t=
he
>> block index to host index.
>
> The case I care about most right now is a cold kernel boot. This is
> basically the same as plugging two SD cards in at (exactly) the same =
time;
> the time being when the SD platform driver is registered. The fact th=
at
> that on my board, one is actually eMMC and one really an SD card that=
's
> already plugged in pre-boot isn't really that relevant.
>
> So, if I interpret your statements correctly, you're agreeing that si=
mply
> registering the host controller for eMMC first doesn't guarantee that
> the eMMC will be block device ID 0, albeit in practice that does seem=
 to
> be true a large enough percentage of the time not to notice any probl=
em.
>

The call path is:

mmc_add_host
mmc_start_host
mmc_detect_change schedules mmc_rescan work with no delay

So two consecutive mmc_add_host-s for two different hosts implies that
the first mmc_rescan will happen for the first added host. So the
answer to your question is no - you seem to have that guarantee.

A
