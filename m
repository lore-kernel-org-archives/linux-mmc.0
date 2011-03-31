From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 15:01:10 -0500
Message-ID: <AANLkTi=B0RFjNoG_yctAu994QKo9f_qyRt2VQcg94ui2@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<m3zkoc2ne4.fsf@pullcord.laptop.org>
	<AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
	<201103311301.12053.arnd@arndb.de>
	<AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
	<m3fwq3ulnj.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:42890 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759298Ab1CaUBN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 16:01:13 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2VK1Wwq019478
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 16:01:32 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2VJxa9D018498
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 16:01:32 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so3130293wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 13:01:10 -0700 (PDT)
In-Reply-To: <m3fwq3ulnj.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

On Thu, Mar 31, 2011 at 2:37 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Mar 31 2011, Andrei Warkentin wrote:
>> Plus what if you do intend to have a file system there? Other than
>> complexity and non-obvious usage, I don't see
>> anything gained by this. I wouldn't worry about ways of misusing thi=
s.
>> As I've said, in the only case it matters (some embedded device
>> booting from the boot partition), the user would have to gain root
>> access, build a kernel giving access to the boot partitions and be
>> able to boot into it. So a warning in Kconfig is sufficient.
>>
>> If you guys feel concerned, then we can add another Kconfig option
>> that will allow write access to the boot partitions.
>
> I'm willing to come around to saying that the risk is acceptable, and
> that people who overwrite /dev/mmcblk0b0 on their rooted Android phon=
es
> won't blame us (at least, not deservedly) for it.
>
> But I'm still concerned after your Kconfig options are added, because
> I'm just not reassured by Kconfig options in principle, because of th=
e
> case where *the person who built the kernel* is not the same as the
> *user who is running commands*. =A0Imagine that CyanogenMod (or even
> Qualcomm!) distributes a kernel with this Kconfig option turned on --
> because they don't realize how dangerous it is, perhaps, or because t=
hey
> had a use for it during development -- to see where I'm coming from.
>
> Now, the presence of block devices that brick machines when overwritt=
en
> isn't a new phenomenon, so we've got a fair amount of precedence behi=
nd
> us if we simply expose what we see and expect that users won't do
> something unrecoverable. =A0But I'm trying to think about if there's
> anything we can do to *minimize* that risk, and have people know what=
's
> going on before they do something they shouldn't. =A0(I think I like =
Arnd's
> suggestion of explicitly having "boot" in the device name rather than
> just "b", because that does lend a feeling of "this partition is real=
ly
> important".)

Yup I think having 'boot' in there (as in mmcblk0boot0) is a good
idea. I also think having boot write support as a separate
configuration option is also a good idea,
so I'll add that in. I think that should help minimize the risk.

A
