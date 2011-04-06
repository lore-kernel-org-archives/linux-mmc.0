From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: pre-defined multiple block read/write vs. open ended multiple
 block read/write
Date: Wed, 6 Apr 2011 12:46:28 -0500
Message-ID: <BANLkTimhUjiuz8tMShONsNKdJNSWT=11FQ@mail.gmail.com>
References: <CE761E84DADF2947A4AF22FB8D97A473570B05A3@shsmsx501.ccr.corp.intel.com>
	<BANLkTi=+bJ60JeOed6E6DF4u8YAtngJOKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:35777 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab1DFRqb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 13:46:31 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p36HkpKf012987
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 13:46:51 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p36HZG6Q007948
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 13:46:51 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so2288534wyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 10:46:29 -0700 (PDT)
In-Reply-To: <BANLkTi=+bJ60JeOed6E6DF4u8YAtngJOKA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Apr 6, 2011 at 10:33 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Wed, Apr 6, 2011 at 8:54 AM, Gao, Yunpeng <yunpeng.gao@intel.com> wrote:
>> Currently, the mmc driver uses open ended multiple block read/write (CMD18/25+CMD12) commands and not use pre-defined multiple block read/write (CMD23+CMD18/25) commands.
>>
>> According to the feedback from some MMC/SD device vendors, they prefer the pre-defined multiple block read/write commands since it gives the device a chance to do some internal optimization.
>>
>> Also I found on the latest eMMC 4.5 Spec, quite a few new features requires using of CMD23. That means, these new features can not be implemented with the open ended multiple block read/write commands.
>>
>> So, the question is, why the current mmc driver does not use the pre-defined multiple block read/write commands? Any comments?
>>
>
> While I really don't know, I would guess becase the SD spec has a
> different definition of ACMD23 than MMC, so perhaps avoiding
> ACMD/CMD23 that was chosen as the simpler more common alternative.
> Alternatively, the difference might imply that at one time it was an
> optional feature. I'll try digging up an early MMCA spec to confirm...

Ok let me correct myself.

For SD:
ACMD23 - SET_WR_BLK_ERASE_COUNT might speed to the multiple write
block, but still need CMD12 after the write.
CMD23 - optional and mandatory on UHS104 cards. CMD23 support is noted
in SCR register.

>
> At least one new MMC feature now (reliable writes) requires CMD23, and
> at the very least using SET_BLOCK_COUNT instead of STOP_TRANSMISSION
> would make that code path more homogenous. Certainly the overhead is
> the same for MMC - either send an extra command before or after the
> transfer. For SD you do get an extra CMD55 before CMD23, since it's
> ACMD23 we're talking about.
>
> I am actually working on a patch to do just that...
>

Which I will send shortly.

A
