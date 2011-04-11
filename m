From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: Extends card quicks with MMC/SD quirks matching the CID.
Date: Mon, 11 Apr 2011 16:47:54 -0500
Message-ID: <BANLkTi=UidLARN6G9WLv7v+8i7KObcAztQ@mail.gmail.com>
References: <m339lobj8j.fsf@pullcord.laptop.org>
	<1302559335-9998-1-git-send-email-andreiw@motorola.com>
	<m3sjto8nks.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:53600 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab1DKVsA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:48:00 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BLmHT4021318
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:48:17 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BLgL5o019030
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:48:17 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so8519202wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 14:47:54 -0700 (PDT)
In-Reply-To: <m3sjto8nks.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>

On Mon, Apr 11, 2011 at 4:50 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Apr 11 2011, Andrei Warkentin wrote:
>> From: Chris Ball <cjb@laptop.org>
>>
>> The current mechanism is SDIO-only. This allows us to create
>> function-specific quirks, without creating messy Kconfig dependencie=
s,
>> or polluting core/ with function-specific code.
>>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>
> Thanks, pushed to mmc-next for .40 with Arnd's ACK. =A0(And with you =
as
> patch author, not me.)
>
> I made a mistake in not noticing that your later RFC patchset include=
s
> (the same version of) this patch -- are you happy with adding block
> quirks on top of this later, and merging this patch for now?
>

Thanks! Yes, no problem, I've just sent a block quirk which uses this
(SanDisk), and that includes a re-send of the block quirks support.

A
