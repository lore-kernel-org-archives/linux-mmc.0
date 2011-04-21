From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Thu, 21 Apr 2011 00:31:09 -0500
Message-ID: <BANLkTik9s49HDYzmmeeFuaWU8bLYf67Cbg@mail.gmail.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m31v0wcson.fsf@pullcord.laptop.org>
	<m3tydsbdd0.fsf@pullcord.laptop.org>
	<3C4AA76A-EBCA-47D2-B1BA-DF98DCB105FE@marvell.com>
	<m3tyds9o0u.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:51049 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1DUFbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 01:31:12 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L5VZR3018467
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 01:31:36 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L5TPd6017461
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 01:31:35 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so1572497wwb.3
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 22:31:10 -0700 (PDT)
In-Reply-To: <m3tyds9o0u.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>

On Thu, Apr 21, 2011 at 12:22 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Apr 21 2011, Philip Rakity wrote:
>> Aren't these the "hidden" partitions ? =A0Only available at boot tim=
e?
>
> Yes, it's the previously-hidden boot partitions -- Andrei's patch
> exposes them to Linux.
>
>> I need to apply my patch to reset the boot partition -- or is that n=
ow
>> in mmc-next
>
> Your patch is in mmc-next.
>
>> to see if the problem still happens.
>
> Well, there isn't a problem per se, the system still boots fine -- th=
e
> boot partitions are being exposed as the patch intends them to. =A0I'=
m
> just curious whether it's normal for two 1MiB partitions to be create=
d
> as a factory default.
>

Chris, the partitions are always present and are a feature of the card.

I ptofusely apologize for the dev_idx issue, I should have caught that
immediately. A dev_idx is till assigned even though the name doesn't
reflect the actual assigned dev_idx for hardware partitions. That
effectively means you need to track a name_idx per main mmc_blk_data
that is only used to form the naming for the device.

I will send a patch in about 30 mins...

A
