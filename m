From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 15:01:43 -0500
Message-ID: <AANLkTinUyixNuOnEVdwWVKQ6sf=CdwEGTOGd9RQuGTX_@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<m3zkoc2ne4.fsf@pullcord.laptop.org>
	<AANLkTinmVNGpmjLNB31nuBke+LD+jJ8AbwNGp14tH+d2@mail.gmail.com>
	<201103311301.12053.arnd@arndb.de>
	<AANLkTinQts_R5RaWw=ZkREQaVbAD8A4NxDj0o9+EaBGQ@mail.gmail.com>
	<m3fwq3ulnj.fsf@pullcord.laptop.org>
	<m3bp0rukeq.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:56053 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759298Ab1CaUBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 16:01:46 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2VK07ma025235
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 16:00:07 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2VJQ5X7007045
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 16:00:07 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so3017871wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 13:01:44 -0700 (PDT)
In-Reply-To: <m3bp0rukeq.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

On Thu, Mar 31, 2011 at 3:03 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Mar 31 2011, Chris Ball wrote:
>> But I'm still concerned after your Kconfig options are added, becaus=
e
>> I'm just not reassured by Kconfig options in principle, because of t=
he
>> case where *the person who built the kernel* is not the same as the
>> *user who is running commands*. =A0Imagine that CyanogenMod (or even
>> Qualcomm!) distributes a kernel with this Kconfig option turned on -=
-
>> because they don't realize how dangerous it is, perhaps, or because =
they
>> had a use for it during development -- to see where I'm coming from.
>
> Another strawman, after brainstorming a bit on IRC -- how about
> the block device itself comes up read-only, until you use a module
> parameter/sysfs entry to make it read-write. =A0As a strawman:
>
> echo 1 > /sys/module/mmc_block/boot_partitions_are_writeable
>
> (That way people who write to it regularly can throw the module param=
eter
> in their boot environment, and the rooting enthusiasts who didn't com=
pile
> the kernel are safe until they learn enough to be really dangerous..)

Sure, I like this, I'll do it.

A
