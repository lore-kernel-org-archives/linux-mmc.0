From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Fri, 1 Apr 2011 13:42:36 -0500
Message-ID: <AANLkTimHGAWvXgPaTEzi4taYcHwrwNhyGa1heZ8QN82R@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<201103311317.22110.arnd@arndb.de>
	<AANLkTik-TJxfUJdOUJUjFy1ej8tjKNKfRft6QiA4JWx3@mail.gmail.com>
	<201104011238.02551.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:46414 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852Ab1DASmj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 14:42:39 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p31IexUT015378
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 14:40:59 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p31IJQUq004939
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 14:40:59 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so4202394wyb.15
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2011 11:42:37 -0700 (PDT)
In-Reply-To: <201104011238.02551.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Fri, Apr 1, 2011 at 5:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Even if they are write-once, wouldn't we still need to provide an
> interface to write them once?
>

True. I first wanted to provide access to them. It would have to be a
special ioctl. There are a number of interesting MMC operations that
don't fit any other way - for example, password protection.

> The question if GP should be used together or instead of MS-DOS
> partitions depends on the possible use cases. If you don't want
> to partition a GP any further in software, exposing them directly
> as mmcblk0pX would be a very nice and simple interface, but
> it completely prevents you from creating subpartitions.
>
> The other alternative is to allow each GP to contain a partition
> table, but then you need a either a three-level naming (mmcblk0gp1p2)
> or make each GP a device by itself (mmcblk0, mmcblk1) that can in
> turn be partitioned.
>

Right now they are exposed as separate devices. This lets the user
pick whatever usage they
see fit (can format it directly, or can partition it), while the
naming (mmcblk0boot0, mmcblk0boot1, mmcblkgp0p1 for first partition on
gp0, for example) conveys that the entries are for device partitions.

>> > Regarding the naming, I would not use a trailing zero, but it's probably
>> > a subjective thing. The other names I could imagine for the boot partition
>> > of mmc 0 are mmcboot0, mmcblk0b or mmcblk0boot.
>> >
>>
>> Since we have two boot partitions and 4 GP ones, for mmcblk0 I'd stick
>> with something like
>> mmcblk0boot0, mmcblk0boot1, mmcblk0gp0-mmcblk0gp4. I'd want to keep
>> the first mmcblk0, so that
>> a user can easily associate the actual card the device partitions are for.
>
> I would find it rather confusing if the device can be partitioned in
> software but the GP devices could not be.
>

Right now you can partition the device partitions, because
effectively, they are separate devices.

A
