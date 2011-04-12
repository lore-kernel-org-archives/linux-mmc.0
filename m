From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: SanDisk 4.3+ iNAND eMMC devices TRIM bug workaround.
Date: Tue, 12 Apr 2011 13:06:48 -0500
Message-ID: <BANLkTi=N75ATcXHqbjDMpCMJ1bGnJggqog@mail.gmail.com>
References: <1302560441-10565-1-git-send-email-andreiw@motorola.com>
	<m34o631k6t.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:44318 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788Ab1DLSIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 14:08:19 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CI6TAa006065
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 14:06:29 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CHoQKB027164
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 14:06:29 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so7786480wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 11:08:17 -0700 (PDT)
In-Reply-To: <m34o631k6t.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Apr 12, 2011 at 11:57 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andrei,
>
> On Mon, Apr 11 2011, Andrei Warkentin wrote:
>> This fixes the out-of-spec erase/trim support. CMD38 argument
>> is passed through an EXT_CSD byte instead of as the command
>> argument. This has the effect that trims act as group erases,
>> erasing more data than necessary. Secure trims/erases were also affe=
cted.
>>
>> N.B. This depends on the mmc_switch patch from the earlier boot part=
ition
>> patchset (MMC: Allow setting CMD timeout for CMD6 (SWITCH)). This al=
so
>> depends on the update core/quirks.c code.
>>
>> ToC:
>> [PATCH 1/2] MMC: Support for block quirks.
>> [PATCH 2/2] MMC: Fix erase/trim for certain SanDisk cards.
>
> Looks like these are missing your new timeout arg to mmc_switch():
>
> drivers/mmc/card/block.c: In function =91mmc_blk_issue_discard_rq=92:
> drivers/mmc/card/block.c:371:6: error: too few arguments to function =
=91mmc_switch=92
> include/linux/mmc/core.h:138:12: note: declared here
> drivers/mmc/card/block.c: In function =91mmc_blk_issue_secdiscard_rq=92=
:
> drivers/mmc/card/block.c:410:6: error: too few arguments to function =
=91mmc_switch=92
> include/linux/mmc/core.h:138:12: note: declared here
> drivers/mmc/card/block.c:419:7: error: too few arguments to function =
=91mmc_switch=92
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>

I'm sorry about that. I was sure I had rebased it appropriately, but I
had not. I will repush it.

A
