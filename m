From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [RFC 2/3] MMC: Add block quirks support.
Date: Wed, 2 Mar 2011 15:19:05 -0600
Message-ID: <AANLkTi=g=DQL6Fd19kM2NG1WktTHEyJS64Nx+E=hNPGR@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<201103021819.52837.arnd@arndb.de>
	<AANLkTimYf01Y6FLYGdyeozvxVO0mxX_QOn2XQ5AHGEFk@mail.gmail.com>
	<201103022204.15235.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:57706 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757818Ab1CBVTJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 16:19:09 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p22LHsbQ007546
	for <linux-mmc@vger.kernel.org>; Wed, 2 Mar 2011 16:17:54 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p22LDSOr005688
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 2 Mar 2011 16:17:53 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 39so465730vxb.15
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2011 13:19:06 -0800 (PST)
In-Reply-To: <201103022204.15235.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Wed, Mar 2, 2011 at 3:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 March 2011 21:48:25 Andrei Warkentin wrote:
>
>> >
>> > Instead of the dynamic registration, I'd just put all quirks into
>> > one file and have an array of them:
>>
>> Ideally, you'd have the most important workarounds always built in, to
>> deal with important problems like out-of-spec devices. The eMMC ones
>> you would select, but the external device ones would be "by default".
>> This could potentially explode in the amount of quirks, so maybe
>> linear search isn't the best?
>>
>> Or you think that there will be sufficiently small number that doesn't
>> justify the complexity?
>
> I think we will start with a small number, and a linear search once
> at insertion time is good for a significant amount of quirks. We do this
> for all PCI and USB devices, see drivers/usb/storage/usual-tables.c.
>
> I would certainly not do anything more complex than this unless we
> get into scalability problems with the simple approach.

Alright, good point, no need to over-complicate :)

A
